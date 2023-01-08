Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BACC54EBC
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 00:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAHAmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 19:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHAmW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 19:42:22 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96ACE73
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673138526; bh=ugedjb98sWfFcZ9athIf87fbnXSJFV1yKt1tVyGq8w4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h7A1dN8mhSjZfZXfmVb0PaxRdLmUNWPtfym8VEq5DsZ/zl2PDo3IjJ2jiDhfS/Wr7
         UP7xaUSaJ9JPOXJhp8g0xCez/Wt+nDgXCCsvFLkEnmVbHthFkLXq7VjaZNtArxCcpt
         OhGSFKT9P4LGZafMYhd0Kt/lHDo41XL1aEugXNAcLEx2O5S5EFk40ZPuoN1fKqmUpT
         l4QbYGlSVOYNpawh5Ftt8IQOPQGyO9JBAFaas2ixkEajEJWcq41Rfk7P1xCuZ79+Mz
         G3gEcsdCVpklJmXHAZXmxDowkkBMBFHOOxR6BKcbeZX6fslRq2P4FZ4ncp7CQPqqAx
         3rfw90kefPIeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJFhX-1pTWIH0NSd-00Kjs7; Sun, 08
 Jan 2023 01:42:06 +0100
Message-ID: <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
Date:   Sun, 8 Jan 2023 01:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EyTBF6o50aRYKBVEYt3aKt7qIV4Mr3F09tRBqOezyvkpbmCxYzh
 6OgdOwtmnafMgnZrZrYSkpoeR3TWawIzAWL//0V7Eeo0IyVrn+sMU21FpR06kq1qc8OaHGu
 ByRPXXp7XLhXks6+E8qsVEpiVSm3NELe6XFUpWPIxTRMNJpE22Aw0yXpk3LqHNB7p3/F+so
 3Q/tJgb+seE+9rjbSvqNA==
UI-OutboundReport: notjunk:1;M01:P0:rXSCVEE4wM0=;eNhRuYdqNxW0vOzJ/PaSKPKYO1Z
 MgAAFMJUCJwEpN4WYPaRVTXGpuIsRpQmowrWc7c7z/fH9k/FpjIQOtT3AuO7kU8Ur+IMbZLyC
 u3jOGrYRvE7Mb6+JlCmM79C+ROMGlkRA2tCSDRy2CMwDVn2kxN6SgjK3FQmPMF+yjxcTmzhTy
 djrEkVCRHw378lwdfquju7QeXNU7hu63GaLbaL5rMc6/+sC4ZybuWi3UC2e4YFM8iSNXo7apr
 vTv3xEAI798W24hlZOKYe4pgXK+uW8q9IDnjcwHt87LuO6kkSa3qY6V83lk8llTQmFxuR9D8h
 A0/Boodxib1GJMqLtMLrS0ACKs6S0bs38P8Lyxc7tuL4XJjHczxuJTIEsodFCgyjQUAPkiUl2
 sz2gc+52hWsEKVm3MgVRrjK6oanBSzy0WeJ/dccxrzpTj4SevZx7mfMdtxvLIKnnrPsF82C3D
 0By2OjXh3/PrkQppVd7oTyOBlLcJ4Tfp/nsWoFKVXZfA5aVvwloVAPiE8IlTgP46d5fSvSmiP
 yQmA3ezToQ2cP5Dq1hzy7UlBcwR/Ak2YJxS5U38cnzBOZl83nEJIW9qwCz6YG25aJ/NKWywqD
 rdozZf7wt7odil1mhS5eTyfh6y/crBuftkPtbwH8CWjbYv9pBMGlfz+n4ORd1hjYv+G7RhlYi
 PjVPqbX3REN8DnYEhnpcjZ6KjSrmbbYZvXwt0BVswTLzjjODgf4pGlA3meW8RnxCGhBn9BD75
 NfvmucoLW6LKgJkGmJ16FPsJRXzsvG21/0GivV6F25oSdhDwXexbIPfgMvG356aszYyT7HvLr
 nE/3zPaRyuqBzzkEQnYUPl5MA6puPApUTGyoHq/h3E99D1yfD52TSVFDEMMg6vVwzz0DOG80X
 5S6ofWNCmqlf0+SuvOPJQUJOIgTZKKn/OzuGlKLCGo3ZAT9HxhgVPnod+KxtLfIW8wdJgUnGE
 PZvQiaZE6S61t+ahilUM/uyFu/o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.01.23 um 10:09 schrieb Jeff King:
> On Wed, Jan 04, 2023 at 05:36:21PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>> I didn't test, but just from looking at the patch I'd expect this to
>>> affect other parts of Git besides git-grep. E.g., "git log --grep".
>>> Which raises two questions:
>>>
>>>  - would a more generalized name be better? USE_REG_ENHANCED or
>>>    something? That might be _too_ general, but see below.
>>>
>>>  - should this cover other cases? Grepping for "regcomp", would people
>>>    want this to behave consistently for "git config --get-regexp", or
>>>    diff funcnames, and so on?
>>>
>>> If so, then I could envision a USE_REG_ENHANCED which just wraps the
>>> system regcomp and adds the REG_ENHANCED flag when REG_EXTENDED is not
>>> set?
>>
>> Good point.  I don't know what people want, though.  re_format(7) on
>> macOS/BSD and regex(7) on Linux call basic REs "obsolete" and extended
>> REs "modern", so they seem to push people away from the old kind,
>> enhanced or not.
>
> Oh, good point. I was just grepping for regcomp(), but of course any
> case which is already passing REG_EXTENDED would not be affected anyway.
> And most places are already using that. E.g., the config code always
> does so, and it looks like pickaxe "-G" does so.
>
> For diffs, we have diff.*.xfuncname, which uses EREs. We do still
> support regular "funcname" for backwards compatibility, but we only
> document the extended version. Ironically, that option was introduced
> because BREs did not portably support things like alternation, even with
> the "enhanced" syntax. ;) See 45d9414fa5 (diff.*.xfuncname which uses
> "extended" regex's for hunk header selection, 2008-09-18).
>
> So I think we are embracing the "everyone should use EREs" mentality
> already. The only spots I see that use BREs are:
>
>   - grep.c, which handles "git grep" and "git log --grep"
>
>   - line-range.c, presumably for "-L" function matching
>
>   - deprecated non-ERE funcname patterns
>
> Your patch is handling the first, which is by the far most important. I
> would be OK leaving the others as-is, but I also wouldn't mind a patch
> that works at the regcomp() level to make things automatically
> consistent.

There's also the code handling "git log -i -S non=C3=A4scii" in
diffcore_pickaxe(), but it quotes special characters and thus
effectively does a fixed-string search, so you're right in omitting it
above.

REG_ENHANCED on macOS affects REG_EXTENDED as well.  It unlocks e.g.
non-greedy repetitions and inline comments.  Sounds nice, but also
potentially surprising.  I was unable to find a current version of
the re_format(7) manpage online, unfortunately.

Apple's latest version of Git sets NO_REGEX and thus uses
compat/regex, if I read their source correctly:

https://github.com/apple-oss-distributions/Git/blob/Git-128/src/git/Makefi=
le#L1302

The easiest and most consistent option would be to do the same.  But
we can't do that, because it would break multibyte support, which was
fixed by 1819ad327b (grep: fix multibyte regex handling under macOS,
2022-08-26), which started to use the system regex functions again.

Which begs the question: Isn't that a problem for the platforms that
still have to use NO_REGEX?  Shouldn't we fix compat/regex?

Anyway, here's an attempt at a more general, but still targeted fix
for macOS:

=2D-- >8 ---
Subject: [PATCH] use enhanced basic regular expressions on macOS

When 1819ad327b (grep: fix multibyte regex handling under macOS,
2022-08-26) started to use the native regex library instead of Git's
own (compat/regex/), it lost support for alternation in basic
regular expressions.

Bring it back by enabling the flag REG_ENHANCED on macOS when
compiling basic regular expressions.

Reported-by: Marco Nenciarini <marco.nenciarini@enterprisedb.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile                  | 9 +++++++++
 compat/regcomp_enhanced.c | 9 +++++++++
 config.mak.uname          | 1 +
 git-compat-util.h         | 5 +++++
 4 files changed, 24 insertions(+)
 create mode 100644 compat/regcomp_enhanced.c

diff --git a/Makefile b/Makefile
index db447d0738..46e30be673 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -289,6 +289,10 @@ include shared.mak
 # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
 # feature.
 #
+# Define USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS if your C library provide=
s
+# the flag REG_ENHANCED and you'd like to use it to enable enhanced basic
+# regular expressions.
+#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with t=
he
 # user.
 #
@@ -2037,6 +2041,11 @@ endif
 ifdef NO_REGEX
 	COMPAT_CFLAGS +=3D -Icompat/regex
 	COMPAT_OBJS +=3D compat/regex/regex.o
+else
+ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
+	COMPAT_CFLAGS +=3D -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
+	COMPAT_OBJS +=3D compat/regcomp_enhanced.o
+endif
 endif
 ifdef NATIVE_CRLF
 	BASIC_CFLAGS +=3D -DNATIVE_CRLF
diff --git a/compat/regcomp_enhanced.c b/compat/regcomp_enhanced.c
new file mode 100644
index 0000000000..84193ce53b
=2D-- /dev/null
+++ b/compat/regcomp_enhanced.c
@@ -0,0 +1,9 @@
+#include "../git-compat-util.h"
+#undef regcomp
+
+int git_regcomp(regex_t *preg, const char *pattern, int cflags)
+{
+	if (!(cflags & REG_EXTENDED))
+		cflags |=3D REG_ENHANCED;
+	return regcomp(preg, pattern, cflags);
+}
diff --git a/config.mak.uname b/config.mak.uname
index d63629fe80..7d25995265 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -147,6 +147,7 @@ ifeq ($(uname_S),Darwin)
 	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH =3D YesPlease
 	CSPRNG_METHOD =3D arc4random
+	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS =3D YesPlease

 	# Workaround for `gettext` being keg-only and not even being linked via
 	# `brew link --force gettext`, should be obsolete as of
diff --git a/git-compat-util.h b/git-compat-util.h
index 76e4b11131..1efa834089 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1338,6 +1338,11 @@ static inline int regexec_buf(const regex_t *preg, =
const char *buf, size_t size,
 	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
 }

+#ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
+int git_regcomp(regex_t *preg, const char *pattern, int cflags);
+#define regcomp git_regcomp
+#endif
+
 #ifndef DIR_HAS_BSD_GROUP_SEMANTICS
 # define FORCE_DIR_SET_GID S_ISGID
 #else
=2D-
2.39.0
