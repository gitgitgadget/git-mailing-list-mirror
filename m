Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DBC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjDDUvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjDDUvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:51:20 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E9468E
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:51:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2F652320090F;
        Tue,  4 Apr 2023 16:51:13 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 16:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680641472; x=1680727872; bh=fQ
        t9cq2n0ClHVEEECpCKtL5UPExJQYrrv3soWUYzOLg=; b=Zu9FXAg2E766pmId0M
        jNjJipvwXzuuXPKit74Iy5kEJAibqezPsbUf5gjHOBunbxyM+/JLtGm/61rPpq+K
        oF8o3aL5CB6kN/kxsD9PDan9r8HewkaHt/Zqsett1/Yrs0wUTndWWivfGhO1Hl/9
        0p+qghfnikQkPL6dXEZtamW803hiYM/hfgIq87xMcd88M0Bj/dc1Ibsq33FAHblw
        evBYBiZnNOIO7zy/RHpH6Rb/W2OrahW+4dNbL7vxJjaiPftF0ScBkh4tYV2uCTMK
        iQJ6jX6RhbVYan0ZlpdeI1tnu1vJfV9UJwHAIw2j3nSdVoJJLausIbBpp4HfKPnu
        Jjqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680641472; x=1680727872; bh=fQt9cq2n0ClHV
        EEECpCKtL5UPExJQYrrv3soWUYzOLg=; b=aJ3TnlHfjX44pODrq+lTtzx6UCXRo
        Qi3H7lRcLcnC6p7JapWy/by2h9XO+G2vlLw00jmaBJF2onsYTVPg/YkxYC1ZaVR9
        n7i8xvAV7Gtwb+vgLFsRlEsRcmJ93EQh+w8EAhkCXD2de+QkHc2dQBhXOWmRafa+
        tZZq9BMDQkks/eLhntfnhnuSh+aOoK4kgDLDstjE8CU4PLdepaGpjYAhlTpIrCRc
        VkB/wLYPQpOBch/TXs/EnPJaUEYHcIlflsUs41sODvNachucxUPVZSo1kZvtKuxI
        12cIUBUyYAS2r6aUYUM2t0JffMDujFJAaOfstwtWBijCvrxL1CsmWucTQ==
X-ME-Sender: <xms:wI0sZMRycavF3FEHeD4e1aFqS2BrYKtp6sEsvvSbBa68-WqSgTN8IaE>
    <xme:wI0sZJwREPm6C0-AuCDrUWEj00RM8hqddCUJNoxzYOliNqKGc4n1wC3I_s97zOrBV
    Sr_UTzg21KUDSSpCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeev
    vdetfeetledtieefheetgedugfehtddtledvhfejkefghfelvdegieefueenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:wI0sZJ3_2fYprylVPX5U9E8Oq-kv3A1TYXuC3S4F-laewpowx-Oq3A>
    <xmx:wI0sZABQGAbDPgWmJOuMGeuarO0Aq4NOj_hpfcQafTS8TmN03Sv9BQ>
    <xmx:wI0sZFjUfWy-dzLk6i9Bg0u6GOgKnxVkRs4MxZCiY0Qv4jM7SaEvbA>
    <xmx:wI0sZPdbUvUkbimwhIO201q28kPoMEexmvSNlgx2eohoma8_c7-LkA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9850F15A0091; Tue,  4 Apr 2023 16:51:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
In-Reply-To: <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
Date:   Tue, 04 Apr 2023 22:50:52 +0200
From:   "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To:     "Rohit Ner" <rohitner1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git log causing hang while browsing upstream linux
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023, at 22:27, Kristoffer Haugsbakk wrote:
> FWIW: on my machine:

So my point is: have you given the command a half a minute or so to
output the initial lines? Certain `log` invocations can take a long time
on repositories with rich histories.

-- 
Kristoffer Haugsbakk
