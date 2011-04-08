From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 08 Apr 2011 16:18:46 -0700
Message-ID: <7vaag01gdl.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 01:19:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KxL-0003z1-Nh
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 01:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab1DHXTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 19:19:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355Ab1DHXTE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 19:19:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2CD942D4;
	Fri,  8 Apr 2011 19:20:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GrJa87cVskVQ
	zCuFWsUb81QsTKU=; b=hV+mRwtzXgfQe68z1swBi6vcyjDqK7PCF3SBThK13rfg
	WP0jHCpLpzwKU/+GfH+VtunnKz4p9vR+sgVcautAdIQeoJvBxI7biacQVBHZGdI2
	jKDmwjir97bVM0vGZEVjNxtG+mfaYeWwCANdWciyQvOofc4vLARWTFlRJjdwvcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TwiHJh
	N2kfbrmXa+PdjB8b1OAllmrv4rsF2mmjlOeDY5uxNGAKAw77yLYxOwgab86oKxWq
	KVJsSGZ/apnyHL5tEnJJTQebyfQMdw3MLrZhDBft/NgY+M4wEckaaGoU1uXE1aJ7
	vGhQ+xirrxuEcH6+/gVKPs5baGT4qZIpHuIZE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7503842D2;
	Fri,  8 Apr 2011 19:20:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C414342CD; Fri,  8 Apr 2011
 19:20:43 -0400 (EDT)
In-Reply-To: <7vei5c1iat.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Apr 2011 15:37:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6E19C12-6236-11E0-802F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171174>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> ... I thought there was interest in full-tree grep
>> (OK, _I_ had some interst in it).  But the same transition pain
>> arguments apply there, and we should be able to do "git grep pattern=
 :/"
>> soon, right?
>
> I never tested it myself, but the earlier "support :/ at a wrong leve=
l
> get_pathspec()" patch should take care of "git grep" as well.  It is
> equivalent to the "alternative approach" Michael posted as RFC as a
> follow-up to his earlier "grep --full-tree" thread.

It appears that we might want to further tweak the code that tries to
disambiguate between revs and paths (we error out when argv[i] does not
name a rev and lstat(argv[i]) fails), but other than that, this command
sequence

    $ cd Documentation
    $ git grep -e purple -- :

seems to hit ../contrib/emacs/git.el and ../gitk-git/gitk correctly.

Of course, from the same directory:

    $ git grep -e purple -- :/*.el

hits ../contrib/emacs/git.el as expected.

The following patch will apply on top of 8a42c98 (magic pathspec: add
tentative ":/path/from/top/level" pathspec support, 2011-04-06).

Per our discussion, I think 'add -u' migration topics should be scrappe=
d
for now, and rethought after giving time for people to get familiar wit=
h
the new :/ facility.

Thanks.

-- >8 --
Subject: [PATCH] magic pathspec: futureproof shorthand form

The earlier design was to take whatever non-alnum that the short format
parser happens to support, leaving the rest as part of the pattern, so =
a
version of git that knows '*' magic and a version that does not would h=
ave
behaved differently when given ":*Makefile".  The former would have
applied the '*' magic to the pattern "Makefile", while the latter would
used no magic to the pattern "*Makefile".

Instead, just reserve all non-alnum ASCII letters that are neither glob
nor regexp special as potential magic signature, and when we see a magi=
c
that is not supported, die with an error message, just like the longhan=
d
codepath does.

With this, ":%#!*Makefile" will always mean "%#!" magic applied to the
pattern "*Makefile", no matter what version of git is used (it is a
different matter if the version of git supports all of these three magi=
c
matching rules).

Also make ':' without anything else to mean "there is no pathspec".  Th=
is
would allow differences between "git log" and "git log ." run from the =
top
level of the working tree (the latter simplifies no-op commits away fro=
m
the history) to be expressed from a subdirectory by saying "git log :".

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ctype.c           |   15 ++++++++-------
 git-compat-util.h |    2 ++
 setup.c           |    9 ++++++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/ctype.c b/ctype.c
index de60027..b5d856f 100644
--- a/ctype.c
+++ b/ctype.c
@@ -10,17 +10,18 @@ enum {
 	A =3D GIT_ALPHA,
 	D =3D GIT_DIGIT,
 	G =3D GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
-	R =3D GIT_REGEX_SPECIAL	/* $, (, ), +, ., ^, {, | */
+	R =3D GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
+	P =3D GIT_PATHSPEC_MAGIC  /* other non-alnum, except for ] and } */
 };
=20
 unsigned char sane_ctype[256] =3D {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
-	S, 0, 0, 0, R, 0, 0, 0, R, R, G, R, 0, 0, R, 0,		/*  32.. 47 */
-	D, D, D, D, D, D, D, D, D, D, 0, 0, 0, 0, 0, G,		/*  48.. 63 */
-	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
-	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, 0,		/*  80.. 95 */
-	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, 0, 0,		/* 112..127 */
+	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
+	D, D, D, D, D, D, D, D, D, D, P, P, P, P, P, G,		/*  48.. 63 */
+	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
+	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, P,		/*  80.. 95 */
+	P, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
+	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, P, 0,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
diff --git a/git-compat-util.h b/git-compat-util.h
index 49b50ee..d88cf8a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -462,6 +462,7 @@ extern unsigned char sane_ctype[256];
 #define GIT_ALPHA 0x04
 #define GIT_GLOB_SPECIAL 0x08
 #define GIT_REGEX_SPECIAL 0x10
+#define GIT_PATHSPEC_MAGIC 0x20
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
@@ -472,6 +473,7 @@ extern unsigned char sane_ctype[256];
 #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX=
_SPECIAL)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
+#define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
=20
 static inline int sane_case(int x, int high)
 {
diff --git a/setup.c b/setup.c
index 820ed05..5048252 100644
--- a/setup.c
+++ b/setup.c
@@ -197,19 +197,26 @@ const char *prefix_pathspec(const char *prefix, i=
nt prefixlen, const char *elt)
 		}
 		if (*copyfrom =3D=3D ')')
 			copyfrom++;
+	} else if (!elt[1]) {
+		/* Just ':' -- no element! */
+		return NULL;
 	} else {
 		/* shorthand */
 		for (copyfrom =3D elt + 1;
 		     *copyfrom && *copyfrom !=3D ':';
 		     copyfrom++) {
 			char ch =3D *copyfrom;
+
+			if (!is_pathspec_magic(ch))
+				break;
 			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
 				if (pathspec_magic[i].mnemonic =3D=3D ch) {
 					magic |=3D pathspec_magic[i].bit;
 					break;
 				}
 			if (ARRAY_SIZE(pathspec_magic) <=3D i)
-				break;
+				die("Unimplemented pathspec magic '%c' in '%s'",
+				    ch, elt);
 		}
 		if (*copyfrom =3D=3D ':')
 			copyfrom++;
--=20
1.7.5.rc1
