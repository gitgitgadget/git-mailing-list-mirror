Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A361F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436794AbfHIRBP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:01:15 -0400
Received: from mout.web.de ([212.227.15.4]:54317 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407439AbfHIRBO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565370068;
        bh=ZlatQ5/N4EZ/4Y16EkAyfz9nuE7c38uhsCc/QUyRkHQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VOR5XB2PFiJIlUVW4VeyqIeNbDcjf9LrrpVgWzoWb9m7E1fGRh4kRTdfPZn5+P0YD
         J33Bv5bpy5VHdxxZquJH59OwueD/ANMXnIG/G4otxoPI5yxeUnUKrZVFx9kF0L4782
         N+1aVJvwFpsXioRj06HqETb76bU5ys3DSyfVZMYY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lgpcs-1ihokk0Rx0-00oD1d; Fri, 09
 Aug 2019 19:01:08 +0200
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no
 crashes
To:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        michal.kiedrowicz@gmail.com
References: <20190807213945.10464-1-carenas@gmail.com>
 <20190809030210.18353-1-carenas@gmail.com>
 <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d239326e-11c3-5875-13a8-f4123baea6eb@web.de>
Date:   Fri, 9 Aug 2019 19:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QGPH/I/rQRsMK/EU1CjaAskutiJJcz9YHrJSNTmmrpqPwyQvfAn
 JUMCeJK1ofRCBQM6xIGm6LStRuoDmYMr3ktcSyBXIn7luyPEADQUuSNuSZ41I2TlZDWqAVh
 2sz6ABo8OL4zHOVQN4cbpqLaJ1DiKQeLoPsLY0+H5qniF8G66eYpNdla8VtPnwqxKB9Qs9J
 23i2P4wzdrGUD40F8HlIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B1kpaVGU9qc=:sO2zdeNqTJGaP2QTNpbM/n
 pWiZ8xO/WbyHlGuJS+08Db8MYjOwHbkCpLjw+aiXfzB0YtiOBOasYv3rUQPGN+8nsQrpr2l3P
 c85zyQDlLxq6pNiC3q/ES3zYlC/UXxFl/3wae8ufOkenD2chRpPcPbKUEnKWJMMnDU5f/Yc2s
 4OxqFmpsogrQyxujICZYYT7ZX6FBN3AQhgbrK8qs4Im41BBMfjqaVIRzqAkv1k3rMxa8aBMcv
 zSflHjMP3M1YU4t5jKUhJR6RiruOg3BOXg/nw4otPFeFYN5V6th+E8VdF84XPWBceyZlPAd3b
 W4tXuYY/3Vhz2pa0iISeBf3kCacwgywR3ilGbmUpDrErjUHvPC1WLs60N64OFYiKQKUyfINgI
 Ap3OCjHgypF6VmrlmzfJvoFDjpAOsSOYNNi2s9q98Wy+ZsrAxnjshhBvBsyL1Ol903XM/EAPI
 eU5i3gfdwfkv9DwbjkwzET79wacOG9eA9ZZ7PUHHr9qdyt6Z+Ny1Yt3aW65+oDljni9Ysl1aV
 3mxOSEiv57DE1hDMan5lvY5g3Kjozd10k7H174cPujF4zAsa7fTBKUdwWdzp2jzmRUN0s+ihg
 TXWYwyAlGOc+Jjlxq3NvY7tzkbRFjohPvTwtHeFp5OLmTDfRqOPrunyVhdwTBYyxfRLOhBZpG
 VE+bK0rurY/xeZy9jZz7ebok2L1BOEo228a3u6uZRY41Gj6MKqJ5TtPrp7QhRlj7f5a2zO+QE
 iX1TOisogaieQLzZsc38GDfzkBzDEDUYapWEqcgn7lOi+UpK0Xn66i6XrYlNv99TgmG+V1ct2
 QrNX6aAycQZWTn/CqRXNPwril/luIEv7/J5WEyLrT6P+o0mz0M4RTJkcni1TTCMunWQ9LVDwZ
 MZSILGq87sXpWa+nD2gevPR1jL0HImGrzQeGkTG1yeFMIBU3aw84ZRaUivi+q4pUk/N1/cOBW
 MXaFr7YaF+kj91gTaGcC4y9+R3bkK1HwwNCp0h1uPjpgrAwszREdKd3Ue8TsqVYqbqQEKINYZ
 U7Hg8l9NO1GWVVIhWjcG5RwGKlDkHKWsP1WjzUrpft1m0oQnA03EZdcwjtkYxXKMKy7zyTVzB
 Nzg1HyLfYCNgHkcbfo/9F/zeqdrDhSePfu2JwVZEUOPt6daY2Ihv6TPXQhXYqFiyqjaPsWgZ/
 NLv8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.19 um 13:24 schrieb Carlo Arenas:
> disregard this version, it still broken (and wouldn't even build on
> some cases), the reasons why are still unclear though but at least it
> might
> seem from the last known run in windows that segfaults were prevented
> at last and something was still off enough to trigger a BUG (shouldn't
> be a concern with V6 or later that do PCRE2 migration to NED fully, as
> agreed)

So how about starting stupidly simple?  You can test it everywhere, it
just needs libpcre2.  It works without that library as well (tested with
"make USE_LIBPCRE=3D USE_LIBPCRE2=3D test"), but doesn't allocate anything
in that case, of course.  The character tables leak fix should be safe
on top.  If you detect performance issues then we can address them in
additional patches.

=2D- >8 --
Subject: [PATCH] grep: use xmalloc() for all PCRE2 allocations

Build a PCRE2 global custom context when compiling a pattern and use it
to tell the library to use xmalloc() for allocations.  This provides
consistent out-of-memory handling and makes sure it uses a custom
allocator, e.g. with USE_NED_ALLOCATOR.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
The function names are ridiculously long, I tried to stay within 80
characters per line but gave up in the end and just kept going without
line breaks.  Fits the "stupidly simple" approach..

 grep.c | 23 +++++++++++++++++------
 grep.h |  2 ++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index cd952ef5d3..44f4e38657 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -482,6 +482,16 @@ static void free_pcre1_regexp(struct grep_pat *p)
 #endif /* !USE_LIBPCRE1 */

 #ifdef USE_LIBPCRE2
+static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data=
)
+{
+	return xmalloc(size);
+}
+
+static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+{
+	free(pointer);
+}
+
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_o=
pt *opt)
 {
 	int error;
@@ -495,12 +505,12 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt

 	assert(opt->pcre2);

-	p->pcre2_compile_context =3D NULL;
+	p->pcre2_general_context =3D pcre2_general_context_create(pcre2_malloc, =
pcre2_free, NULL);
+	p->pcre2_compile_context =3D pcre2_compile_context_create(p->pcre2_gener=
al_context);

 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables =3D pcre2_maketables(NULL);
-			p->pcre2_compile_context =3D pcre2_compile_context_create(NULL);
+			character_tables =3D pcre2_maketables(p->pcre2_general_context);
 			pcre2_set_character_tables(p->pcre2_compile_context, character_tables)=
;
 		}
 		options |=3D PCRE2_CASELESS;
@@ -513,7 +523,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, =
const struct grep_opt *opt
 					 p->pcre2_compile_context);

 	if (p->pcre2_pattern) {
-		p->pcre2_match_data =3D pcre2_match_data_create_from_pattern(p->pcre2_p=
attern, NULL);
+		p->pcre2_match_data =3D pcre2_match_data_create_from_pattern(p->pcre2_p=
attern, p->pcre2_general_context);
 		if (!p->pcre2_match_data)
 			die("Couldn't allocate PCRE2 match data");
 	} else {
@@ -550,10 +560,10 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
 			return;
 		}

-		p->pcre2_jit_stack =3D pcre2_jit_stack_create(1, 1024 * 1024, NULL);
+		p->pcre2_jit_stack =3D pcre2_jit_stack_create(1, 1024 * 1024, p->pcre2_=
general_context);
 		if (!p->pcre2_jit_stack)
 			die("Couldn't allocate PCRE2 JIT stack");
-		p->pcre2_match_context =3D pcre2_match_context_create(NULL);
+		p->pcre2_match_context =3D pcre2_match_context_create(p->pcre2_general_=
context);
 		if (!p->pcre2_match_context)
 			die("Couldn't allocate PCRE2 match context");
 		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack=
);
@@ -605,6 +615,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_match_data_free(p->pcre2_match_data);
 	pcre2_jit_stack_free(p->pcre2_jit_stack);
 	pcre2_match_context_free(p->pcre2_match_context);
+	pcre2_general_context_free(p->pcre2_general_context);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_o=
pt *opt)
diff --git a/grep.h b/grep.h
index 1875880f37..73b8b87a3a 100644
=2D-- a/grep.h
+++ b/grep.h
@@ -28,6 +28,7 @@ typedef int pcre_jit_stack;
 #else
 typedef int pcre2_code;
 typedef int pcre2_match_data;
+typedef int pcre2_general_context;
 typedef int pcre2_compile_context;
 typedef int pcre2_match_context;
 typedef int pcre2_jit_stack;
@@ -93,6 +94,7 @@ struct grep_pat {
 	int pcre1_jit_on;
 	pcre2_code *pcre2_pattern;
 	pcre2_match_data *pcre2_match_data;
+	pcre2_general_context *pcre2_general_context;
 	pcre2_compile_context *pcre2_compile_context;
 	pcre2_match_context *pcre2_match_context;
 	pcre2_jit_stack *pcre2_jit_stack;
=2D-
2.22.0
