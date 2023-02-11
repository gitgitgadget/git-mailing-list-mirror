Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B7EC636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBKNsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 08:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBKNsp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 08:48:45 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D342279BE
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 05:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676123307; bh=kDQWNmGmD7OgDhUFuo/cLHyRMbAiqYjb0XgNshzDx+M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oB9IrAcjQ3CMlISNbNN04vB2lyuYQzRUM6e2QC1Ss02Xo2Ht3QYoGgWTT9PvcRRha
         ulvBtWLJXVHr/ZP3785m6Dny4PDTX9eVLlmWlSqQxye9ZL4+ycqZF+V0GT112Rpvqy
         1d8fLX8v8Z66MYgS+kKhZ+k57/7Jd8tKdrgmY9iSLyDlbjLMy6JPi4JKUhEA5/JExL
         byzTravXJIh1IyymfoYhJUdMCP+Z8fnN9rYIpJX7Kd2eS9yor4iVnQ5EzMjjK9FsC/
         kB67qu9ot7MfZyNxhkO0ISrofro+9QYo4wfwAZhAjBT2QUVGEazJenYohTQ1MJsoiJ
         WR8BV2WwgJR0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1oQfA83W1y-010NGq; Sat, 11
 Feb 2023 14:48:26 +0100
Message-ID: <b9406c64-5a0e-83ab-7dfa-8effacc2a7e5@web.de>
Date:   Sat, 11 Feb 2023 14:48:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20230210075939.44949-1-masahiroy@kernel.org>
 <20230210075939.44949-2-masahiroy@kernel.org>
 <654092a2-6d3e-7ab4-a747-1ce36daad03d@web.de>
 <CAK7LNATHnjNe0Bagd4HOkNKXS_-5C5oU0cgQ-rFT6sgF33G+1A@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAK7LNATHnjNe0Bagd4HOkNKXS_-5C5oU0cgQ-rFT6sgF33G+1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NqrZhJiMsiTUgRlHnzW5godIVIS8EnFXTEI9Ip5yR2OgELHnqEX
 f06k0g8z2ErBaad8e5kVD0BFdADUgNDUAMMu+f1YEYz2eGpBSKSHzVYbMzwPaw2V2BHQ5j/
 bKEnFsZlu1K/c4gOej8rsHQlRmgJqL69hi5UMe0PtZSjMYsFzPZ6LxWEuvJlTus+/RVmCC9
 Eydu5zfrPBPmjs9iFou/w==
UI-OutboundReport: notjunk:1;M01:P0:lPvZbL3FrVI=;GW7up/6pHcyrByjhOdWBwMud6pi
 RGzKcXcSZllEpYRNC8APodlJSqh2kLNpaJA2mjea1suGms7kD0osUu4ecXZvzGHllMNhOZddm
 R4V8GWqetRDGXLFWr3jWQpcDIu0Hr7Af0t26PIt9dzFs8GDPSLTzKeiarX3v7FBqWTFL7YROI
 LxQ76rr8Bikcfm0FK1UU3qukfH5IksOcwf9azd06EPFxkG0kgPIlZysh8z6XsNdyXfbBit72j
 6LKZIMl5eZ/Dgrp3+qNdPKq4EAbjhYNg9JizY5H9z7GYbqhs2R2wj9pi70ZWbkgSX69+WHWPv
 jrUAEYg/UTV7zzvoo1hZO4rpftTkSKNu+NyQ4PPSa1igDsupYSJbbbcOSVDLYVyZma7+VEH+0
 D5kk7uTFj0fVogsiA3wTdZ/X+HR0MfN2nqJIceOw5rV3a7Uco96aFbkb8Gky/cKPlstduCBqM
 C8/SUOG2f6XJMO6Grg6YHAVPV2Zuryi/JBmrLWXE7m7r9xDSDRlMKbsrIqROZjYLIGUfNHKms
 hploEf63WBBydTp82+fY2aK7REmO6tUfejHjcJOPbtxQDsbQSyWPVqTPRZMwc3rgrR15GN1H6
 DWH22rbc7MbJ/SXoaOmd9SvjSiuf0Up5EkcQvowk3sn1swL/bIMQw4yQeT2zhQ+vw88W63zEu
 IUhbhHJlFhoRLKH+4jScC/mB+UVzzc6/0d0hf6ZFeUriJexw1BUiYTl57AOeyXXpkbjPin2v5
 FNY/OBvpZbQZZgSTmJEmEt4zPsBxTLDvDFzkiZR2ylsxHvqog6WkzZzVEoBXgehFEiygzKCi7
 nSBLJIa85ulVj9KLVtSHsetn0hxPAYxuvKGMPAPi8RDqA7pqG6HfizjUJLiKkcW6HZYOADHFg
 XyIsV/HGaBEH0fhEwdDdyliJ/LVd4BeLHy7jUPLFpFgtFTrVR0fGcDPVkzJhuIdIdmZ5RM1bw
 ibyZcZg5Jy/EVnl+IjbG52+IZYc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.23 um 08:01 schrieb Masahiro Yamada:
> On Sat, Feb 11, 2023 at 7:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> We already use eight bits for the lookup table values in sane_ctype.
>> Perhaps it's time to move GIT_GLOB_SPECIAL, GIT_REGEX_SPECIAL,
>> GIT_PATHSPEC_MAGIC and GIT_PUNCT to their own table to make room for
>> flags for isprint(), isgraph() and isblank().
>
>
>
> I think that is a good idea.
>
> If we can have more room for isupper() and islower(),
> we will be able to delete sane_iscase().
>
>
> (I was thinking 'unsigned short', but having two tables is OK.)
>
>
>
> So, how can I proceed with this patchset?
>
>
>
> [A] After somebody refactors ctype.c table,
>     I will rebase this series on top of that.
>
> [B] keep isblank() and isgraph() local to wildmatch.c
>     until that happens, so I can proceed without
>     depending on the ctype.c refactoring.
>
>     Apparently, wildmatch.c is not using a pointer
>     increment with isblank() or isgraph().
>
> [C] If 'somebody' in [A] is supposed to me,
>     my v2 will include ctype refactoring.

[D] We need more tests first. :)  I sent patches to test the current
classifiers separately.  A similar test for isblank would have helped
you detect the mismatch quickly.  Full test coverage also gives
confidence when tinkering with the existing classifiers.

1c149ab2dd (ctype: support iscntrl, ispunct, isxdigit and isprint,
2012-10-15) added an implementation of isprint that evaluated its
argument only once, by the way, but the one from 0fcec2ce54
(format-patch: make rfc2047 encoding more strict, 2012-10-18)
replaced it.

Widening the element type of the lookup table would work, but might
impact performance.  I guess it would be slower, but perhaps we'd
have to measure it to be sure.  Splitting the table into unrelated
subsets would avoid that.

Deciding which flags to move requires knowing the full target set,
I think.  The punctuation-related flags looked to me like good
candidates until I saw the original isprint implementation which
uses them and several of the others.  So I'm not so sure anymore,
but here's a patch that moves them out:

=2D--
 ctype.c           | 51 +++++++++++++++++++++++++++++++++++++----------
 git-compat-util.h | 21 ++++++++++---------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/ctype.c b/ctype.c
index fc0225cebd..c7a0dcba13 100644
=2D-- a/ctype.c
+++ b/ctype.c
@@ -9,26 +9,57 @@ enum {
 	S =3D GIT_SPACE,
 	A =3D GIT_ALPHA,
 	D =3D GIT_DIGIT,
-	G =3D GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
-	R =3D GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
-	P =3D GIT_PATHSPEC_MAGIC, /* other non-alnum, except for ] and } */
 	X =3D GIT_CNTRL,
-	U =3D GIT_PUNCT,
 	Z =3D GIT_CNTRL | GIT_SPACE
 };

 const unsigned char sane_ctype[256] =3D {
 	X, X, X, X, X, X, X, X, X, Z, Z, X, X, Z, X, X,		/*   0.. 15 */
 	X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X,		/*  16.. 31 */
-	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
-	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
-	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, U, R, P,		/*  80.. 95 */
-	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
+	S, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  32.. 47 */
+	D, D, D, D, D, D, D, D, D, D, 0, 0, 0, 0, 0, 0,		/*  48.. 63 */
+	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
+	A, A, A, A, A, A, A, A, A, A, A, 0, 0, 0, 0, 0,		/*  80.. 95 */
+	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
+	A, A, A, A, A, A, A, A, A, A, A, 0, 0, 0, 0, X,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };

+const unsigned char sane_ctype2[256] =3D {
+	['*'] =3D GIT_GLOB_SPECIAL,
+	['?'] =3D GIT_GLOB_SPECIAL,
+	['['] =3D GIT_GLOB_SPECIAL,
+	['\\'] =3D GIT_GLOB_SPECIAL,
+	['$'] =3D GIT_REGEX_SPECIAL,
+	['('] =3D GIT_REGEX_SPECIAL,
+	[')'] =3D GIT_REGEX_SPECIAL,
+	['+'] =3D GIT_REGEX_SPECIAL,
+	['.'] =3D GIT_REGEX_SPECIAL,
+	['^'] =3D GIT_REGEX_SPECIAL,
+	['{'] =3D GIT_REGEX_SPECIAL,
+	['|'] =3D GIT_REGEX_SPECIAL,
+	['!'] =3D GIT_PATHSPEC_MAGIC,
+	['"'] =3D GIT_PATHSPEC_MAGIC,
+	['#'] =3D GIT_PATHSPEC_MAGIC,
+	['%'] =3D GIT_PATHSPEC_MAGIC,
+	['&'] =3D GIT_PATHSPEC_MAGIC,
+	['\''] =3D GIT_PATHSPEC_MAGIC,
+	[','] =3D GIT_PATHSPEC_MAGIC,
+	['-'] =3D GIT_PATHSPEC_MAGIC,
+	['/'] =3D GIT_PATHSPEC_MAGIC,
+	[':'] =3D GIT_PATHSPEC_MAGIC,
+	[';'] =3D GIT_PATHSPEC_MAGIC,
+	['<'] =3D GIT_PATHSPEC_MAGIC,
+	['=3D'] =3D GIT_PATHSPEC_MAGIC,
+	['>'] =3D GIT_PATHSPEC_MAGIC,
+	['@'] =3D GIT_PATHSPEC_MAGIC,
+	['_'] =3D GIT_PATHSPEC_MAGIC,
+	['`'] =3D GIT_PATHSPEC_MAGIC,
+	['~'] =3D GIT_PATHSPEC_MAGIC,
+	[']'] =3D GIT_PUNCT,
+	['}'] =3D GIT_PUNCT,
+};
+
 /* For case-insensitive kwset */
 const unsigned char tolower_trans_tbl[256] =3D {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
diff --git a/git-compat-util.h b/git-compat-util.h
index 4f0028ce60..61e71fe702 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1228,11 +1228,7 @@ extern const unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
-#define GIT_GLOB_SPECIAL 0x08
-#define GIT_REGEX_SPECIAL 0x10
-#define GIT_PATHSPEC_MAGIC 0x20
 #define GIT_CNTRL 0x40
-#define GIT_PUNCT 0x80
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) !=
=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
@@ -1242,15 +1238,22 @@ extern const unsigned char sane_ctype[256];
 #define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)
 #define islower(x) sane_iscase(x, 1)
 #define isupper(x) sane_iscase(x, 0)
-#define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
-#define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SP=
ECIAL)
 #define iscntrl(x) (sane_istest(x,GIT_CNTRL))
-#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
-		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
 #define isxdigit(x) (hexval_table[(unsigned char)(x)] !=3D -1)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
-#define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
+
+extern const unsigned char sane_ctype2[256];
+#define GIT_GLOB_SPECIAL 0x01
+#define GIT_REGEX_SPECIAL 0x02
+#define GIT_PATHSPEC_MAGIC 0x04
+#define GIT_PUNCT 0x08
+#define sane_istest2(x,mask) ((sane_ctype2[(unsigned char)(x)] & (mask)) =
!=3D 0)
+#define is_glob_special(x) sane_istest2(x,GIT_GLOB_SPECIAL)
+#define is_regex_special(x) sane_istest2(x,GIT_GLOB_SPECIAL | GIT_REGEX_S=
PECIAL)
+#define ispunct(x) sane_istest2(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
+		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
+#define is_pathspec_magic(x) sane_istest2(x,GIT_PATHSPEC_MAGIC)

 static inline int sane_case(int x, int high)
 {
=2D-
2.39.1
