Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3826BC77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjETQNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETQNl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:13:41 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D42C4
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:13:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9DA4E320090B;
        Sat, 20 May 2023 12:13:39 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 20 May 2023 12:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684599219; x=1684685619; bh=BEU5sS7/hkZ/PQC5D7L+N2wdq
        380LU0yKxd6wpe6j00=; b=rIliyxUgkaPtIWdED5TfqAPD8FYMLr/nl7BhA54cd
        xHuxeW8/AN3l4XacA/rhMUXbCbV542/cTeq/SkJDDbLP8A3Z6J7BmhFnKkuOUazq
        QMiw65zdTTqfYwEi8lSJ1RFEO1qwuJxx+ZvuAlyw078G9iEd2c99GjPBtNOe71Mi
        9Q8qAF0TZJRVqsBWCLqEe9ZQejTOyI8q+hDQzn1ZlkaizQ29g8AuuzkE6B78XwO9
        X7tsDSMKJxzo6EQ20fZ75kWkY1aLpp0m/SQ+zLPpaWw2i/eIQvlUqxqhjmY8Y0V8
        8sZampWzNZaWUiUikOvQmdbn0ZLukIjeyERynbQesiepA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684599219; x=1684685619; bh=BEU5sS7/hkZ/PQC5D7L+N2wdq380LU0yKxd
        6wpe6j00=; b=Pv5W3FNsvr6JTm4bfLg195wuKCoCgBHpzEIHF3uiBpxQxr9TBE0
        4/izubg5Vnt2bl/Q70KcqqVBF+0KYqPAr2vLvAlVvKBeViA4qM1vJGH3SNTe3qYL
        kNfPniEKvJIUOJuprUe4NZ5apVjLBwVQrUqYqxjlRNxQ9QtY/4Nt+77SdUkithOX
        eK2VK96j0fk+wkY1KrfpGIVGQ5kKKiEFVMFQGIfcNBW05KIbDXz2Xhxw0ja6HLU7
        eaIV9s2eFcoKzVst3ZFamivUojNIN7u/iL1lxbYCrQzIZNQf350AxIaiJvTw2puA
        gSjJ1lhYdpQglcuXvXP2CwEv67FSBhJ9tOg==
X-ME-Sender: <xms:svFoZGSjjM6as-V7jd32VT8zGavsPB_3xyGQ1ShiiXRuhsKR8NpnstQ>
    <xme:svFoZLyF0-wpwdGciiUymnCmgDDqyBG38dhnstK3-HzrJbTFU-Tn0xsx_r_BSxb4U
    EpdzgXL_8hrn_irOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeijedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:svFoZD0x5yh4APxvqEF7xm9nb0UWPJj4kY2EL3ZgOlPPsZ-_SMp8AA>
    <xmx:svFoZCAxzK-tS3P5PcMCTo0wCLyPmz_jh3Wv7MyM-zBJBAogFyoReA>
    <xmx:svFoZPhu15OTJMhNJ0OFZfzpsN9f9N-CxpN73sWsjoguKB1GIXPnXA>
    <xmx:s_FoZMvkqYjDPuahBeUstdmRMODbo-3do1PVDUtgTQvK58fqnJzh4w>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B715E15A008E; Sat, 20 May 2023 12:13:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <e82748ad-e73f-4c67-9bc8-16107eeaf058@app.fastmail.com>
In-Reply-To: <20230520104159.53670-1-tenglong.tl@alibaba-inc.com>
References: <51690df7-1788-469f-aabe-84fc7a576951@app.fastmail.com>
 <20230520104159.53670-1-tenglong.tl@alibaba-inc.com>
Date:   Sat, 20 May 2023 18:12:53 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Teng Long" <dyroneteng@gmail.com>
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce
 '[--[no-]separator|--separator=<paragraph-break>]' option
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng Long

On Sat, May 20, 2023, at 12:41, Teng Long wrote:
> Yes, I noticed it too, but I'm not sure whether there exists the same
> requirement in `git commit -m <message> -F <file> ...`, `git commit` is
> usually a more frequently used subcommand, firstly introduced it to
> `git notes` maybe is a good idea, but I'm not going to touch `git comm=
it`
> yet, unless we find someone who has a strong need.

Yep, you=E2=80=99re correct. My intention wasn=E2=80=99t to imply that g=
it-commit(1)
needed something like this, rather to explain (mostly to myself) why
git-notes(1) learned a sort of git-commit(1) option in the first place.

`git commit -m` with its multiple paragraphs behavior makes perfect
sense, since you are writing paragraphs of text, anyway. However, Git
notes are used for other things than that=E2=80=94like line-delimited da=
ta=E2=80=94so a
`--[no-]-separator[=3D]` option makes great sense for git-notes(1) and
complements it well.

I wanted to figure out why `git notes append -m` works like it does
since I=E2=80=99ve been idly wondering about it, and I have seen others =
around
the Web who have been a little puzzled as well.

Cheers

--=20
Kristoffer Haugsbakk
