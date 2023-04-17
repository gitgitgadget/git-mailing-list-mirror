Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CECC77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 06:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDQGVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDQGVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 02:21:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0114F3A99
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 23:20:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A957D5C0103;
        Mon, 17 Apr 2023 02:20:50 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 02:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681712450; x=1681798850; bh=B2nfCjcozdu4ZfGvWKO0IF3t2
        W/M8138JEroyaHR+IQ=; b=j3MkEnF32+/l9yZixqnWs1hQY5NylzFzaCVoZBXO1
        j9tF+YIhcHG4pRero1dZ2wHyTFNBYBchQIf2jgh2SiCmpDGEZmoNKI3kv+ubWNHu
        Jxv5csrZ6ljrtNSCR2Bj+9rUZuLQukBD4pa+gVB8KFCTRUCk+OMKbESEDhojwDLC
        nBmP+zmtY7JHfxMopk4VvESpmjWGbdeNBIgMYOS7cny6fOTD1a17foucS1I5wClM
        SNSBZiEnterurszNQGNvT5PlxtAAF23WOd/rPSLWiIOh/X5Is9Qe5forzNki5d1N
        m25XKT8vrVex1wrU+8sTy/Cs8aF4ILQZey4ohgGcWHoPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681712450; x=1681798850; bh=B2nfCjcozdu4ZfGvWKO0IF3t2W/M8138JEr
        oyaHR+IQ=; b=UwHUPICVkp/PiKgZCTPHVFoOWsnEhfs3KD371fF2K374Ig4OJi8
        53ExSDm8OQ3ffgNJzOPwe5DmVycxOys+Zjo47OIbNqku5y+9WIyvpo865bZcgoxG
        P+9gB/dkm6WMyqOT5J6Xhav9jRMNvxpH3QNBGL14WXQ0UliSpSwipOLBxzzRp8ME
        MbXxYKYpv/IpbVcbYninEUBVa7b3cgCrNB1RjCp8ydOlPTvbRF8NK7SeqZrCHUTL
        k+ZOnFCKEnJQp/kZ+dIsa2Ba5xvJQhrb4IXtzBiUv1KdWvM9F08bp+MgA8zHPzln
        8sSPlBfy5/el9s0a7bw52YMaryjPCcqGToQ==
X-ME-Sender: <xms:QuU8ZPadRAbxKOiyzeqw-uyp2qgbvvVd4WSaQwJ_8ysegBpS9pmFZLw>
    <xme:QuU8ZOZh4Is2z0OJmLwJSjBLDdhT-8NAWUq9TlKmPTkhD7STDXaEkwmjfUMVId__A
    gnxVkPu4usSpLzUFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelhedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:QuU8ZB-r5tH_2S4eNUEHQiGdkaTuejqEGaYVR2ZmDx4jrMvKgTR8HQ>
    <xmx:QuU8ZFoibITYUtu5Aaj3c2MrPT99pr9anembEeneHiH4VIv2xvjDfQ>
    <xmx:QuU8ZKpAI3xY4umcBt_QaaA0kHbnq1sVIN1Lk-uK75JNrjIAWx4QIw>
    <xmx:QuU8ZIGrvNQwkBUqzOpIzh60dBepCrdI1HQ5cnmhf1gFb7w6FTYK2A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 744BD15A008E; Mon, 17 Apr 2023 02:20:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <b517d7ca-4b8f-487b-8836-8966a2a9d9ee@app.fastmail.com>
In-Reply-To: <20230417054032.GA26997@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <141f0f6b-ef5e-4470-b86f-7ebd6c2be3ab@app.fastmail.com>
 <20230417054032.GA26997@coredump.intra.peff.net>
Date:   Mon, 17 Apr 2023 08:20:30 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order': Commits
 from 2011 are treated to be before 1980
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023, at 07:40, Jeff King wrote:
> I don't know if git-repair will fix syntactic problems in commits like
> this, or if it's just looking for broken links between objects. But
> regardless, it would be possible to fix these using filter-repo or oth=
er
> tools.

Makes sense, thanks.

I gave up since the program never seemed to finish.

> The problem with repairing them is that it rewrites history, changing
> the object id of every commit which comes after.  So you'd want to do =
it
> once centrally for the project, and declare a flag day that everybody =
is
> moving over to the new, fixed history.

I wasn=E2=80=99t interested in fixing the repo for future development. J=
ust to
see if that weird git-log(1) behavior went away. It=E2=80=99s like the i=
nverse
of a minimal example to reproduce a bug; repair the corrupt object so
that future askers can be convinced that it=E2=80=99s not a bug. ;)

I=E2=80=99m not affiliated with the project.

--=20
Kristoffer Haugsbakk
