Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72EDC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 18:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjDDSDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDDSDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 14:03:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D913C3D
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:03:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 226C432009F7;
        Tue,  4 Apr 2023 14:03:14 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 14:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680631393; x=1680717793; bh=X/f/RvSjtOrdE0ThGQk3udd3S
        xOD+t63q7xOUYpFcH0=; b=anUw+IUmeI1kOWjRBl8OB4FPRIPzyY1nSOhD7K+Qo
        T3rAbgox8Uk7lvPLqrlxoLjTRAPlB/880k7TftJbI218GuHXeCOVBpYX+8L6k+4z
        xaivZrCojBPM/mphygl3fWjPP/VF/D7rscPlEyjLpvhXabR+teuPT24WbRLbihWK
        HOPsE2qWEno2yGgak/NQZgjmrUgVtJ/l8pljtohW3dNrvb7HiHrwYDOx1Ttf4tiC
        WOlVXUR/ftpBsrFYt9bI4VVlU4oKq5PDpS6D13C6fekJIIToFJydHcUpzob1jx89
        +R7UcjlT5yWliZRNFvh/cFt+7DlFFRcIeWqz8UpqID9/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680631393; x=1680717793; bh=X/f/RvSjtOrdE0ThGQk3udd3SxOD+t63q7x
        OUYpFcH0=; b=hXqGFhFnaKhD+v0G4rBCIH5T0tR7W3VxM4lQdkLtpWbQX3NB+Mq
        lqZsrDWaIw3CZldc4yLIDn+92Xs8bub6Wf9aztbl4CNpKHP1uhk0D6GJwBip0Eue
        D1PZoFos/naTA5vT4fHReqHfbbbL/xav/AxXb5O5r60H3Hunrz9Vw5y9jy+XtvBD
        2lTqWHLMbriyFRI6/Rk7FHEMtyNx5mwBtUI2DUNACCBIG1XgYbHQv8KHJdnoNBw2
        fuU7zR/oAMPKeBzGPentPkhQRbkkfdB2t6ybjBXpU/JawXQcu+c7bK036WqddeiU
        wVEX5e69ivS86pZn4JFb7nvJD29cdEPR5AQ==
X-ME-Sender: <xms:YWYsZEpCJVuTjz1MLQWIBgx0u-Uvwo3YOWF5MsnpriRu2LElIBPIBFw>
    <xme:YWYsZKrRmdj18wggOdlyIMojOXzBLwLQ3ouU56yphUIfYD3OEBueTgQ0vzKNGdS4d
    Atk9bEfUXQsgV_5MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:YWYsZJNZ9RcvC4rsveYS0Ht6MD6sv0cR8b6eqKMJDIZE2rvK2shekQ>
    <xmx:YWYsZL6hWPRj_c-wHV9na6NZ1g1KzZDCx0gtwxudDl1XFBgk3A556g>
    <xmx:YWYsZD5WecZhzf7CsSXhEerUlOMfmGiSNtuFdUG844ZsLCi7ffHd9Q>
    <xmx:YWYsZNTmrgkjn-8Kze_ZeTNbul_zpZlmgfrPzkK6bFWVaX7AzkXE6A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79FF815A0092; Tue,  4 Apr 2023 14:03:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <bbdd2746-cfb6-4841-8314-4bdad5493f72@app.fastmail.com>
In-Reply-To: <xmqqbkk44qbo.fsf@gitster.g>
References: <20230331181229.15255-1-code@khaugsbakk.name>
 <cover.1680548650.git.code@khaugsbakk.name>
 <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
 <xmqqbkk44qbo.fsf@gitster.g>
Date:   Tue, 04 Apr 2023 20:02:53 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com,
        "ZheNing Hu" <adlternative@gmail.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/3]_doc:_interpret-trailers:_don=E2=80=99t_use_?=
 =?UTF-8?Q?deprecated_config?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2023, at 23:18, Junio C Hamano wrote:
> Perhaps we should do that as a preliminary clean-up before these
> updates?

I think updating to use `<msg.txt` for existing (on `master`) examples
would fit in as patch number 2, since I rewrite heredocs to use files in
patch 1. The commit message for patch 2 would then say, =E2=80=9Cand let=
=E2=80=99s make
things consistent for the other examples as well=E2=80=9D.

Thanks for spotting that. :)

--=20
Kristoffer Haugsbakk
