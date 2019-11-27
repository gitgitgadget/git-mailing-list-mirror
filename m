Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A74C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F62068E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TPTQTz5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK0Msp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:48:45 -0500
Received: from mout.web.de ([212.227.15.14]:41119 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfK0Msp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574858919;
        bh=qSDKh6f3CNhJfyUGUwX4YYh7fxiSpDZxOgNOkTSUo90=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=TPTQTz5UQ30aONBJWt1hI4Ckb9o6VjTBqnUetHkFPPYkeTGGMJHPlfIbEzpkiYZzr
         5fJ0vqotPx0gOyLOhHbWKjWh5r6fkcYhz3U8up5++S6gU4CYM457p4BLs2GVKOjNtL
         hkPWIg1+SUQ8bLQ0Me1aryo/gDSNrUR7q+lfhD+I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lud4y-1hrz1j2FmK-00zn7J; Wed, 27
 Nov 2019 13:48:39 +0100
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: t7811: don't create unused file
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Message-ID: <1d3997fc-4d3e-fd99-bc8d-14e7db940d7f@web.de>
Date:   Wed, 27 Nov 2019 13:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9XAgMRx7iXoNEqO3HaUIHlNMB7F0NkUCYBIaZRCmwRq6BKUxALh
 yQ1xv51YN0P32SLlC9G1EZtQOPT+NfbkM/M2+F5vkxvzPd1EsCsDPL9UEHtNiiZMtWXUxHu
 MtQ8aszCrdvpvoKi+evii9lSpe4MuWqoGsgGRniiRALMs1GOGGRfnz4ljJFOvzAv/vPeyy4
 nUOoovFR2EI6FtqT2serQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYNfTEGr08I=:TCrhZ44P2+oD+67kZfWL/Y
 ZdvD3uTDhgV3hfv1/GIpcQJQ00ubDGx0GXs4UwCEcd9Ea46Od3CcE01J7E8Giwp9b7rxW69Sx
 tofYEb0Ok37mONTraSxim+dsHVgCI+Ra4+RLR8QGjLNmUC55fdHz5jgZUsMyNQkT2+nxCrl3j
 zl0blQR8CdzyJwIPUI+SJiRoeJQBjFCcWahX5vZYSpiXDpaxVJnS2GnLioXmOB/fIfNU2VSXI
 sfVzignZ7myxAa/8Ee1b6ZhfgqIVyV+QPJcjLeVi7xETsm50Sq/TFvfc+/N3rE0PeCVzS4wTl
 jKyerx1om49PVboq2mpb8fLzg6LhcXxNsCnMVDnnHDILLhYIf4C1rb8spQB7PXPTKbpMjcAep
 yBUXSg0Z7DKMb8ftaZecgzJZywYZ+1cIX/8DSTPQGtpqlYCTcZ9Y1s7KXPFUNcLza8X/eXtq8
 RHhAl2yX+LfQaA4y48ZpjylrGY944CMCON0j/YHzekK7iCDjMG+mzLTLFmVEBExfpDPK+tdxL
 2wPvQmxhw5ZdiHa16PoHInIWRk8Zntk8TqLmvl3Z1M8OzYuthu5HdZRiD/0AlcB6KClo6PFn4
 0+SE3IDF8H7B/ZRZA6iazhyqv8UgsA3ykQKRTcx8cjbqEpGEH3l6084prEnMgnjRb8m7YXekF
 Ro/7cHMqrcdPJIzw1gIVOLOeixKL8UxrhVsawMBIRKm6f+AnFfT3+7oKtC0hKrcUtDPysqWq4
 zrSt722hW0BapE+E0lffAwirVQTSPy+aiEW7e7ozGRoZGHTIy0zzpH9X35cIbCxueYzLQ0dZx
 G0sRzGRYp58o3JQeWK8urtTqgwoGK7qLCD/tapoohaX1fZArMIaKZF+togkxZnYXsEEDIMAGH
 kVviLKfL73lWLUET841Z7Tb9HbqjMkc0yRVUQEDVbDBm+IK049GxTT1qCVbr9nEzHUYueClPA
 PLVaO8dMxfjMyayQhRrJi5MJ48oy4yQ4wrSYbxaJQB5efDvybFr5HGTKyKec1zTx7zjG0ddmG
 U02PuTFwc0Lw9OEEtc0D9gZu1hqd3Q9DULMQHn4qTP8KrNjFnW01wbc9+JA+TPO5k9Kcpq/lF
 ptioNR5qji8z/EI1fCdJrngc6aKj14zwA5fP6rTDJ1PwUVJRRQjivFLseOzhIrroxusp9yGdt
 tQ9n5yu/L6jNEF+UR5lVSisZt8R9wwW1UhEGyzLCxenNs05FOjLLFREhnqYUx6wIkiwmKpNAs
 GDjA67sYIh6HyVau3gDz4BUpr838T3E66v2AFtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file "empty" became unused with 1c5e94f459 (tests: use
'test_must_be_empty' instead of 'test_cmp <empty> <out>', 2018-08-19);
get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t7811-grep-open.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index d1ebfd88c7..a98785da79 100755
=2D-- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -113,7 +113,6 @@ test_expect_success 'modified file' '
 	subdir/grep.c
 	unrelated
 	EOF
-	>empty &&

 	echo "enum grep_pat_token" >unrelated &&
 	test_when_finished "git checkout HEAD unrelated" &&
=2D-
2.24.0
