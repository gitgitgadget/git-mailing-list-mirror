Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63361C7EE23
	for <git@archiver.kernel.org>; Fri, 26 May 2023 14:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbjEZOtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjEZOtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 10:49:16 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95721B7
        for <git@vger.kernel.org>; Fri, 26 May 2023 07:48:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 661FC320089C;
        Fri, 26 May 2023 10:48:15 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 26 May 2023 10:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685112495; x=
        1685198895; bh=gQOVI0eTDCHVvR3pkaCJm+GzxHX6F6W1kAla09lCWe8=; b=u
        XLmNKFfSoQABhECOof5gesrNV8W3zdffJYm6phgAdviFoQBjmVN76ptvHoFgVcUl
        jeGcLYca7piGpzUUuDuO5HCJeG/KKpqKTeLz/ZWYpR1IaNEtqBrGHDosyrcDQ19N
        CbehYtsvouD4LcTcuKNE95Bc6R01656Dd4zcGbPkzgdYDeZXQ3SX6P58Zt3RAyDF
        +DsXsIULASg0OhzldKFBsiNm5blaG2Wonzls44Z2k/FhCTdaOTxXzKIDFzeiWswE
        cYlZy7MUwZu4mFqDl8idFfeQFL5jvVA5lc9t1LbRDwlnEZtYj1hlkx2psH+KDbfv
        /TSr1y0hU/Qz3l31Z6Xdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685112495; x=1685198895; bh=gQOVI0eTDCHVv
        R3pkaCJm+GzxHX6F6W1kAla09lCWe8=; b=icpYjQnunr1HJJHtvW5aGFwRfbmbx
        0a+Noiike2dq2+QgLZ9eEVwB9cV1MzbwglCWavcxmTG/gM96gxndqfW0S7H9Q1yA
        Oggli4V84E2DZpSm2PIjlIcOkTsymWKRlRRWOOPxFlXkZILRyhnKXCRVMHslnLri
        Kvf7l0lxnH2t2u3MKDfYb+jnDhR+c+8tfgarYMPtRGbJRh7Mgpl1afoJ9qDW81dU
        5J524ltKhE7Fye1vEXBcgrLv+vuSRG7UiR/exMF+Os7QSVfIRGBJbOM1LylogQ8T
        zMqQHrpMKIrWK5JDT3+i8LWe8fiZMPezLWMB0alE2XAeN9uhU5MTqLL0Q==
X-ME-Sender: <xms:rsZwZBytNppgwnp6OmVYj4-P5TKqGDGgrhDWGlVplQFPv2zaYz9lHVE>
    <xme:rsZwZBT5lO6UjJ5j5LJoFzg7Ulil_lss3AD-qESPXox1slhNy2klKzgFrE0vzIllT
    aksA2fFj8FCMKLOEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dugedvfeevgedtgfegieekfeegffeiudeiudfgfeehheeivdeftdevvedtueeuueenucff
    ohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:rsZwZLVdBlsUNE6qqwNc5qUEWLLW9v2PtRxgEJU2Y0mUsyDzLdWfIg>
    <xmx:rsZwZDjwpRcSR6U4sIqdFAITPCxNU0m-oIhzkHfrS2ua3DRT54JIGA>
    <xmx:rsZwZDBcXWdeAczkn3mhoxR6Yqavy_J_KVOhghA_5w7SrI1UdcL2ow>
    <xmx:r8ZwZG-6jyMcUVaBoeag2XBjSxtdIwF_uEoARJtd7GsserKROHh-Iw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C6A8415A0092; Fri, 26 May 2023 10:48:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <0322337d-0833-4f07-b59b-4575367600c7@app.fastmail.com>
In-Reply-To: <JidrZpGp3x0BxdI7N_zQs1bEVFiTzuNPBSsBbYXnWEM9Vz5ohNoZIWRcEm9Nl7FHzpH14gox5lG7WoWM7TUXqVTEH0qijlKux3VmeFpHkX8=@protonmail.com>
References: <JidrZpGp3x0BxdI7N_zQs1bEVFiTzuNPBSsBbYXnWEM9Vz5ohNoZIWRcEm9Nl7FHzpH14gox5lG7WoWM7TUXqVTEH0qijlKux3VmeFpHkX8=@protonmail.com>
Date:   Fri, 26 May 2023 16:47:24 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     allyriah <allyriah@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Documentation for Git Gui
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, May 26, 2023, at 16:29, allyriah wrote:
> Greetings:
> Please, I need to know if there's an official documentation for Git Gui.
>
>
> Many thanks in advance,
> Kind regards.

https://git-scm.com/docs/git-gui

-- 
Kristoffer Haugsbakk
