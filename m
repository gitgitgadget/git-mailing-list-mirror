Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6731BC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 20:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjEJUfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJUfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 16:35:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9EE64
        for <git@vger.kernel.org>; Wed, 10 May 2023 13:35:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 09ACC5C0677;
        Wed, 10 May 2023 16:35:34 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 10 May 2023 16:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683750934; x=
        1683837334; bh=N+wZuTLIiU0lPmSCh0nFOQhEigN+O4N2bTwZVU/A6Aw=; b=z
        EXDTeCKO6GA7Zwr4Li/JO1aqB7n5cUrLgGx4/nPtThJJCDycXkIDA45j27aWmDUS
        8/TAeGmvKryap+y3Fo+nXy/oVQuXRiy1zP7czX4+JixtYUA9udPs29rTzlYU077C
        DdnLcCCs7X6jtxRiKvoi2vjsmxzZ7bw1Ys0RJGEptQDbkMvbd07Je+ApOLsbIiSN
        4S+b5U6M1sMtuUDszLzVhprEayZrbOHOqi0pRYZEnWhT3/ztHyLOSpXmqfxD8PS6
        TYRp5nD7pZx9s2cARkz8qns3bMVVrlQPhT308K2bkZc0G0d2V9sq7v2VaJ23lzws
        +Fc0H1y1w6ZavjN6PGA8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683750934; x=1683837334; bh=N+wZuTLIiU0lP
        mSCh0nFOQhEigN+O4N2bTwZVU/A6Aw=; b=SFfJg2z1MbVfQLnKM1CJbLaISwndX
        p6nM8G88NP+6SY6g6+sOdEXMLg38Io7ai+1koFZYew/7efCM66hWq0GJSVwc2YXI
        oz9HQ4lJyEU9+dtqpXOu4Hxx6/Nqq5ryrm/LoGgpIfjUEHDvuKS2tdkrK5vv0N7q
        VSrBOax2WdRh/A+a6lpJ4clOmQVgM3bAbRD2Q1yAgl0imoaFHPHw8c8VT4EmCS0N
        ZlOTKqtU3am0X3yqDnr7TUT6YkoRxcDHoxZTJybKJp1J1Dxca4SukGCy7eg9jsSL
        CTk8ZKe7ImxmYE7wIVrVRwRt+tQ93VPLcLsnocMJjd0KXzBrv4gdpTQfA==
X-ME-Sender: <xms:FQBcZMHuE5N_xdzbQm2WNjBoNMYNmFaNP05JvrLNewh6D6gk-vj_SGg>
    <xme:FQBcZFUq4Ef-AtejWhUnD6nnIsxc652vdWREfOD5x6Ez6h3JlGw4Qp7rmSWxBCwxd
    pXHwmu3a2pJujJjdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:FQBcZGK8NrRKyKKNpW9fwSBdzFRAP7VNd7O7UIWOD_ZCKtpO3E9EZA>
    <xmx:FQBcZOGtydPCBHjrZyic3xcEZ582Ue6g7bPfL6NvwnCGzupKMkJTOQ>
    <xmx:FQBcZCXzxgTMpLlIHFRS9ao6EO_G_biZ7bHohm7LSEFeEsiQZZF_cA>
    <xmx:FgBcZNByPddJrONPViGvspKisGuqSqdcxDc3qD-meGhlGhvzDbZnDA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C86D815A008E; Wed, 10 May 2023 16:35:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <1efe92ee-6ae0-4588-ba67-b7632c7ea97e@app.fastmail.com>
In-Reply-To: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
References: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
Date:   Wed, 10 May 2023 22:35:13 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Christopher Fretz" <cfretz@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: git rebase --root bug
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023, at 22:08, Christopher Fretz wrote:
> Thank you for filling out a Git bug report!

I get a more generic error:

    $ git rebase --continue
    fatal: No rebase in progress?

[System Info]
git version:
git version 2.40.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-148-generic #165~18.04.1-Ubuntu SMP Thu Apr 20 01:14:06 UTC 2023 x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.27
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
Kristoffer Haugsbakk
