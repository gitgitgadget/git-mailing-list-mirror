Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A1CC3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 20:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjACUwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 15:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjACUwh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 15:52:37 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAC4FCEF
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672779148; bh=rhOkPxGmlmkiZsChjFfCE8HsidqWkH8H2xd9j2oH5UQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
        b=w2LhK0HMkFviasfHKa+1QgEy4HPa2ZXPTXW5wie9D9dtQpoIWNAdCNwcsqOcurhAG
         5PJhOPpsMUyu7gfju9kXWqIZUuQYqIXb9u8+FmSSgX4BhpZCLnsyrcCHXToQ4CJlTX
         71/QHBSHdeF20VQZ2RCUZt1X50eRhlUN4elN94dI0zG78T/YvZyIuWQOdlDH3h115q
         vHZwAE/eIPLFlFaFtKuC1cBJ4HQu0OZKXd3MqlVkyqGoH31zM49oZ2gXrOCLoV07WA
         n6S72vFC6PGNSAKZ332PNVhf0CllH8kJ9D2Aoy7T8nCUiBkCx8EcIJUj18AfzSaS28
         K1VS+kH7/DfOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOlk-1pMoiG0OGi-00U6X9; Tue, 03
 Jan 2023 21:52:28 +0100
Message-ID: <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
Date:   Tue, 3 Jan 2023 21:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
To:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
In-Reply-To: <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I/J9+xGHv5wdg6gOOVcTP+0E9q+e4He15cVTh5lRqoFcSWp5cqs
 00GChkhGo03Vi7TnorJK3f1otD85VQtQvEHec6BX+Wt8FyBKmiaBSdhtwD/mE5DISswXGCP
 jRFsYJjPx5seW0t0mKc+squ7RlRlJoxOAO4Ko2MQXn+Yp0oaWIt95aL+oZGoKOfXG6IrHDn
 +UNKCet8lecT41FUhMCrQ==
UI-OutboundReport: notjunk:1;M01:P0:UNPTYV4THvQ=;d5LG//bZfxVCd9Q+KG3A1EGhzTE
 Gtz70ZGBeNw1LNgaSrt699SB4mco76ETj6zZIJf9+vy+4fXm8YTIM+ERVhgwkENyn3LV1iES/
 tltLiwlD0Ap+di81u8HcsEEOyFxbH7Ipvke2EXPs731XILQxxxV7+74lth+JKej11r/E0IJ+M
 C6qQSfPlfXpvJ6vKfs6tXBDvMp4t5M9ok4S1I2EJ2h/MTxWW+05nRNHzG6wUpqML86PEUfvIZ
 mD0Q+vriJsgwJUkjzjZwbn8WRN48SI2SHs87g2qMK4WiKiYKqc+6Bg4eIvPC59MHUaMJJP3sM
 FX/zBwBMemsarovSsphXemcWvTLxSOIf9KpctY5bFl1RRp3yqTzBAC4Bi9JtDKqNNIXALUMWv
 tXUqZ46fJxQN2B8DM61TuF1ZIy4XN3NWPS9BrkfWqd1Ce0lE8e9+LkvJ2Ev31TN15eq7VzjKq
 uY3E4dFcGICEkRiES5HcK4TtV/0rq/jPa51I9bsMv6aIKGsE6wNISju6yQVVRG1aPXEMGQos7
 bkrmiGk+xkPCVhpsbMNFVqzQKHLOcGXAzFjYupCM8UG3vQABMFPRgV2CJbG5yKdYYdDSniY8N
 lUYPYGYANs8muMW7vAli2jj0Jy3IToBMVYjwQAmlnA2E1jnoyas1IFLLuddNgGWGnHFWs+v6L
 Fx+aQEr8JrxwH7BOwdcegZ/0LE4ItyTQc/kou68zQPUnGKmV4dnRxTub9EMwfv1tXxiJRffBr
 KlF7kMY14i1TCybdJ/LFXIJmiOlprfoJIJyjpqdNlZ5KN0443MwtgNh4FZpuhZqaN6eNfJrHE
 Gl59MSE1PdLEtspimL5c1gED9XbCFH8vWnpTKAeFw6VKeJXeDE5dEGutfJprJueh24qhTt9oU
 fUO5gEOPh7dBm5kTP/hv9bZu1RGhbaJyPI0ETejSW6kRb3EZR26Ab1Kc05JgnHDSREShZIRIm
 NeY9OQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.01.23 um 19:13 schrieb Marco Nenciarini:
> On 03/01/23 17:29, Ren=C3=A9 Scharfe wrote:
>> Am 03.01.23 um 10:53 schrieb Marco Nenciarini:
>>> I've installed latest git from brew and suddenly git grep started beha=
ving oddly when using alternatives.
>>>
>>> ```
>>> $ echo abd > test.file
>>> $ git grep --untracked 'a\(b\|c\)d' test.file
>>> $ git grep --untracked 'a\(b\)d' test.file
>>> test.file:abd
>>> ```
>>>
>>> It should have matched in both cases.
>>>
>>>
>>> If I switch to exented pattern it starts working again
>>>
>>> ```
>>> $ git grep --untracked -E 'a(b|c)d' test.file
>>> test.file:abd
>>> ```
>>
>> This is expected: Basic regular expressions don't support alternation.
>>
>> Under which circumstances did it work for you without -E or -P?
>>
>
> It has always worked until I installed 2.39.0 on my mac. I've also check=
ed with other developers that are using a mac and they reports the same. O=
n Linux it works regardless the git version.
>
> Using grep directly also works, so it is a different behavior between gr=
ep and git grep, that is surprising.

Meaning you used Apple's version of git before?

   $ echo abd > test.file
   $ /usr/bin/git grep --untracked 'b\|c' test.file
   test.file:abd
   $ /usr/bin/git version
   git version 2.37.1 (Apple Git-137.1)

   $ git grep --untracked 'b\|c' test.file
   $ git version
   git version 2.39.0

So I can reproduce your findings on macOS Ventura.  Same with grep:

   $ grep 'b\|c' test.file
   abd
   $ grep --version
   grep (BSD grep, GNU compatible) 2.6.0-FreeBSD

re_format(7) says:

   "Obsolete (=E2=80=9Cbasic=E2=80=9D) regular expressions differ in sever=
al respects.
    =E2=80=98|=E2=80=99 is an ordinary character and there is no equivalen=
t for its
    functionality.".

Under the headline "ENHANCED FEATURES" it continues, however:

   "When the REG_ENHANCED flag is passed to one of the regcomp()
    variants, additional features are activated."

And:

   "For enhanced basic REs, =E2=80=98+=E2=80=99, =E2=80=98?=E2=80=99 and =
=E2=80=98|=E2=80=99 remain regular characters,
    but =E2=80=98\+=E2=80=99, =E2=80=98\?=E2=80=99 and =E2=80=98\|=E2=80=
=99 have the same special meaning as the
    unescaped characters do for extended REs, i.e., one or more
    matches, zero or one matches and alteration, respectively."

So apparently Apple chose a middle ground between basic and extended
regular expressions for its grep and git grep.

Under "IMPLEMENTATION CHOICES" it says:

   "The regex implementation in Mac OS X 10.8 and later is based on a
    heavily modified subset of TRE (http://laurikari.net/tre/)."

The manpage of GNU grep says:

   "grep understands three different versions of regular expression
    syntax: =E2=80=9Cbasic=E2=80=9D (BRE), =E2=80=9Cextended=E2=80=9D (ERE=
) and =E2=80=9Cperl=E2=80=9D (PCRE).  In
    GNU grep there is no difference in available functionality
    between basic and extended syntax.  In other implementations,
    basic regular expressions are less powerful."

And under the headline "Basic vs Extended Regular Expressions":

   "In basic regular expressions the meta-characters ?, +, {, |, (,
    and ) lose their special meaning; instead use the backslashed
    versions \?, \+, \{, \|, \(, and \)."

So GNU grep apparently made the same choice as Apple, probably far
earlier.

When I compile git with NO_REGEX and thus with the fallback in
compat/regex/, the result supports alternation as well:

   $ ./git grep --untracked 'b\|c' test.file
   test.file:abd
   $ nm ./git | grep regcomp
   0000000100255978 T _git_regcomp

Based on that I suggest:

=2D-- >8 ---
Subject: grep: use REG_ENHANCED on macOS

GNU grep(1) and regcomp(3) use enhanced basic regular expressions by
default, which means that it e.g. supports alternation, e.g. "a\|b"
matches both "a" and "b".  The same is true for our compat/regex/
implementation.

On macOS Ventura (and possibly earlier) grep(1) also uses enhanced BREs,
but regcomp(3) requires the flag REG_ENHANCED to turn them on.  Do that
for git grep if possible, for consistency with the platform's grep(1)
and our fallback library.

It would be simpler to use REG_ENHANCED everywhere it is defined instead
of adding a Makefile setting, but it's a non-standard extension and
might mean something else on other platforms.

Reported-by: Marco Nenciarini <marco.nenciarini@enterprisedb.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile         | 8 ++++++++
 config.mak.uname | 1 +
 grep.c           | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index db447d0738..15e7edc9d2 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -289,6 +289,10 @@ include shared.mak
 # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
 # feature.
 #
+# Define GIT_GREP_USES_REG_ENHANCED if your C library provides the flag
+# REG_ENHANCED to enable enhanced basic regular expressions and you'd
+# like to use it in git grep.
+#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with t=
he
 # user.
 #
@@ -2037,6 +2041,10 @@ endif
 ifdef NO_REGEX
 	COMPAT_CFLAGS +=3D -Icompat/regex
 	COMPAT_OBJS +=3D compat/regex/regex.o
+else
+ifdef GIT_GREP_USES_REG_ENHANCED
+	COMPAT_CFLAGS +=3D -DGIT_GREP_USES_REG_ENHANCED
+endif
 endif
 ifdef NATIVE_CRLF
 	BASIC_CFLAGS +=3D -DNATIVE_CRLF
diff --git a/config.mak.uname b/config.mak.uname
index d63629fe80..14c145ae42 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -147,6 +147,7 @@ ifeq ($(uname_S),Darwin)
 	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH =3D YesPlease
 	CSPRNG_METHOD =3D arc4random
+	GIT_GREP_USES_REG_ENHANCED =3D YesPlease

 	# Workaround for `gettext` being keg-only and not even being linked via
 	# `brew link --force gettext`, should be obsolete as of
diff --git a/grep.c b/grep.c
index 06eed69493..a8430daaba 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -502,6 +502,10 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
 		regflags |=3D REG_ICASE;
 	if (opt->pattern_type_option =3D=3D GREP_PATTERN_TYPE_ERE)
 		regflags |=3D REG_EXTENDED;
+#if defined(GIT_GREP_USES_REG_ENHANCED) && defined(REG_ENHANCED)
+	else
+		regflags |=3D REG_ENHANCED;
+#endif
 	err =3D regcomp(&p->regexp, p->pattern, regflags);
 	if (err) {
 		char errbuf[1024];
=2D-
2.39.0
