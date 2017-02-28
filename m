Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158DC201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdB1Tfr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 14:35:47 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36650 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdB1Tfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 14:35:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id 25so2675539pgy.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IC9U7/ad6hJYt7sSnC/TtDBfKuCWLCltHqGJWXTMIzo=;
        b=c8aqRs7y0GUR8fJNoj963Qehemcs7JfuWJFboukUXMslBTsTbujcVM3nnGQ500aouP
         /zDjT6OxB2WvO77Fl3Dn7gVBT+tazyb3C9xfgBfgAEA3USRSPuaROQJK6dAzI99IoPXm
         Uyk1xNJggqiO9G+LG+3g9b9hlOuc1mXAEyaplSWNWzalK5zfY2C4zmD8UGQ4Rb6JdVpf
         7UxKeVa7Mq1C6JbXpPrzx6ireh9KmExuSEcOgwL5TM9caclh91es7CH4ZyKPw3TZzsvi
         5p19SB2hPCIm/ShJPi0sNWHibHfYxqnYf3X2Pc2mwgdNvLCY5wAXoweJKT1rxYFzLw/q
         hN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IC9U7/ad6hJYt7sSnC/TtDBfKuCWLCltHqGJWXTMIzo=;
        b=MLqho3SXNI41UAh3PGSnrqPnTX8VxaeUo0Ci33F25iCcrKMvyhdGEEVOPNxZiMJ4ze
         pjAf0u+ywbRVlV9/KsETtMLNY/Nuyk9QguR/xYx15f7QzffXmtncNoGPJLrxU1m95hZK
         dwEtO/0y/auvSAJntsSVc003RDBjXwnyviF3soCfpYsRbjUwU3VnYvtv+3paP77MrCMc
         AWTrQR9qzjBHg9FY86NcGqI63LFB9nQp8RaAtYMw+WDyjrf7OVKOYO2nKeJjDj+mcUXP
         BoXrDpkcPJhg9rQs3IoeCy1ZxTfuAjvRpJiI7JTjqS2AU3oJMsIm+ffVm2bNxNVWru5F
         l4NA==
X-Gm-Message-State: AMke39m/YOU+lwH5lK+x1+1e79C1IGaynE9+vVVbdP5xxjEwcsSMRPVtCahki+yGeZTxHA==
X-Received: by 10.99.174.71 with SMTP id e7mr4272135pgp.3.1488308859224;
        Tue, 28 Feb 2017 11:07:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id q7sm5699399pfb.98.2017.02.28.11.07.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 11:07:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
        <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
        <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
        <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
        <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
        <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
        <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
        <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
        <alpine.LFD.2.20.1702231428540.30435@i7.lan>
        <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
        <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
        <xmqqefyikvin.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 28 Feb 2017 11:07:37 -0800
In-Reply-To: <xmqqefyikvin.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 28 Feb 2017 10:41:52 -0800")
Message-ID: <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>   [1/3]: add collision-detecting sha1 implementation
>>   [2/3]: sha1dc: adjust header includes for git
>>   [3/3]: Makefile: add USE_SHA1DC knob
>
> I was lazy so I fetched the above and then added this on top before
> I start to play with it.
>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Tue, 28 Feb 2017 10:39:25 -0800
> Subject: [PATCH] sha1dc: resurrect LICENSE file

In a way similar to 8415558f55 ("sha1dc: avoid c99
declaration-after-statement", 2017-02-24), we would want this on
top.

-- >8 --
Subject: sha1dc: avoid 'for' loop initial decl

We write this:

	type i;
	for (i = initial; i < limit; i++)

instead of this:

	for (type i = initial; i < limit; i++)

the latter of which is from c99.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1dc/sha1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index f4e261ae7a..6569b403e9 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -41,7 +41,8 @@
 
 void sha1_message_expansion(uint32_t W[80])
 {
-	for (unsigned i = 16; i < 80; ++i)
+	unsigned i;
+	for (i = 16; i < 80; ++i)
 		W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1);
 }
 
@@ -49,9 +50,10 @@ void sha1_compression(uint32_t ihv[5], const uint32_t m[16])
 {
 	uint32_t W[80];
 	uint32_t a, b, c, d, e;
+	unsigned i;
 
 	memcpy(W, m, 16 * 4);
-	for (unsigned i = 16; i < 80; ++i)
+	for (i = 16; i < 80; ++i)
 		W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1);
 
 	a = ihv[0];
