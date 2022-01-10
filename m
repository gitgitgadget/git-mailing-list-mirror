Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F5C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiAJJbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:31:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46793 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242962AbiAJJbP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jan 2022 04:31:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE7885C0093;
        Mon, 10 Jan 2022 04:31:13 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 10 Jan 2022 04:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:date:from:to:cc:subject:content-type
        :content-transfer-encoding; s=fm1; bh=xeFEbt2x+fNkpdGgM3IB21Ju/L
        CnUhsJnTGV1VrlRuU=; b=ImqiXQZKx8Jwco9S+mRbb+n4GZpGRWjmRvVg1Lvb63
        KobhcFXwh429vMjBTMkJ5v4f4PyNjqeNH2K24F5lNO+0WPpPlxb+Z6iZ+KIHMGyA
        MzFJ5d6RQqE2GC4fXU5JbHaMiwv6FdspwD5zPutFtTAzLJUgWK8cymwPH0oeXen8
        GnhlhM2i/tpjZba0IScA3GQLnjX2Cm4HsLv28oZhtdKGsbtxbTZ6lDu1MQI9ceRb
        t2guGXYQi0uoS92V+T0Tgadmc+iPUWKYYUk3plG/0r1F9B78U3G3Pnhm6HZnyLqa
        6gukN3NhQk36+2Mo8kgAtDgySg9wGoM54Ztfi/bYIH5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xeFEbt
        2x+fNkpdGgM3IB21Ju/LCnUhsJnTGV1VrlRuU=; b=njDttvzPIh9eIYtmXmudsy
        xvpbIW7UGzhS15zhC2RXLBlO/FIHJCcy0xwGBx+krBtLkuadP5Mey3fILaRyanJT
        IREJz4wC5zJRYenJT8mIHkJ7YTOy0rddnXN79BNnW1KfbpNPVv7xP4rO51weG9G/
        GT7wgR9eG+5c75Pz6sg6CXRZNFvFgv+uCJ6UrcHrVdYqrdAWd+ISU/GmS0skjdgi
        yzNpvnNJNurWsRGTKP0OIde7e+K41IsiACqj0wCvrXVrXRlOOCUhgaPnQIwb1vJy
        eCzI0oABKclM3YYCHSfXtzW0vqE0VqvqLK1QbGfEwTBnAtokCqAYMF5lR8vnT1zQ
        ==
X-ME-Sender: <xms:4fzbYWDE4WtImq7Sz0SQ3IojjQv-QIT8Or3BVtsQKm16vb79Ed-d5g>
    <xme:4fzbYQj5BFZW6sUCnIo_8bSX0DUF16z5-fdLds5R2X4-zOrKyebFnl6e6SszZa3s4
    EhxlIsyi3K_3mFyk4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehtddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdftrghmkhhumhgrrhcutfgrmhgrtghhrghnughrrgdfuceo
    rhesrghrthgrghhnohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekkefhtdfgjeejte
    duuefgheeggeehffeftefhueevudejieeftdeutdevhffhhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:4fzbYZmQm5J57aTmY3LtL78WeX7qrwKUOZrL2Qo-OZoNY0Po27iZOg>
    <xmx:4fzbYUxzFXC-qhKI9-WV--oPw7KbPzzKUree-Yebf1qS1Gh1e8xN9A>
    <xmx:4fzbYbQjDG38b-B1SmWsrZTJMB7kEMPT7xB7YLma2aZzdl1bBm92jQ>
    <xmx:4fzbYeNEPJPdEhR9GyNC2Hu5aNihTz5jkdpIwwNnmg418N2pCTk7-Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9D541EE007B; Mon, 10 Jan 2022 04:31:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4527-g032417b6d6-fm-20220109.002-g032417b6
Mime-Version: 1.0
Message-Id: <35431755-130d-447a-8287-520f728b8e23@www.fastmail.com>
Date:   Mon, 10 Jan 2022 10:30:53 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     "Git List" <git@vger.kernel.org>
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: gettext Icelandic tests fail on macOS with locale FR
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was thinking of contributing a patch, and noticed the following test b=
reakages on master, macOS with locale FR:

*** t0204-gettext-reencode-sanity.sh ***
# lib-gettext: Found 'is_IS.UTF-8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.ISO8859-1' as an is_IS ISO-8859-1 locale
ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
not ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Icel=
andic
#
#     printf "TILRAUN: Hall=C3=B3 Heimur!" | iconv -f UTF-8 -t ISO8859-1=
 >expect &&
#     LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Hello Wo=
rld!" >actual &&
#     test_cmp expect actual
#
ok 4 - gettext: impossible ISO-8859-1 output
ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
not ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
#
#     LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: =E2=80=98=
single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quotes" >actual &&
#     grep "einfaldar" actual &&
#     grep "$(echo tv=C3=B6faldar | iconv -f UTF-8 -t ISO8859-1)" actual
#
ok 7 - gettext.c: git init UTF-8 -> UTF-8
ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
# failed 2 among 8 test(s)

Warm regards,
Ram
