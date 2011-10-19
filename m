From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 19 Oct 2011 12:29:18 -0700
Message-ID: <7vaa8wdbld.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
 <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu>
 <7v39epft32.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 21:30:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGbpy-0006LZ-4r
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 21:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab1JST3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 15:29:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab1JST3W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 15:29:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 214E25871;
	Wed, 19 Oct 2011 15:29:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R18s+pUqo3I0
	1ieblNPXTkGrX2Q=; b=LCAVxYzG0KY07Q7Uwya6rL4dlTuecQ6HWIwmpo4bOxA3
	dhj4gPlRnV2ZOjDCMLhLp42rdHCdlTVrJH+1jqPIBeoCj3TIieGyCMBqkk1LL+7B
	3DfoSPjgM6DMtgJfEnH0og33b43Rlsny+egnKtus8qR1P+yAEpW8h/e9TMtaL/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vu9Ykk
	jJJTvZqPj6VfTZgQlD/ad8ZJ4SiFL+mEcm3PiiUTtUn0jmagSaE6E9vpHeDhkWJD
	oWEVneARaVA9wRQRmXfTATIRtJNPxFurOWPpUyl1/WqJEzZRtQZa3YBoPaCCe7fL
	IzZEUNMcWU21VIiHFyHtg4AEWEOLwqs9mJ1B0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 179C25870;
	Wed, 19 Oct 2011 15:29:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14FC7586F; Wed, 19 Oct 2011
 15:29:19 -0400 (EDT)
In-Reply-To: <7v39epft32.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 22:28:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A45A279C-FA88-11E0-83EA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183942>

Junio C Hamano <gitster@pobox.com> writes:

> I was trying to summarize this topic for Release Notes.
>
>   Possibly incompatible changes
>   -----------------------------
>
>    * Special refs such as "HEAD", "MERGE_HEAD", and "FETCH_HEAD" are =
now
>      restricted to names with only uppercase letters and underscore. =
All
>      other refs must live under refs/ namespace. Earlier, you could
>      confuse git by storing an object name in $GIT_DIR/tmp/junk and s=
ay
>      "git show tmp/junk", but this will no longer work.
>
> But noticed that "git update-ref tmp/junk HEAD" does create such a re=
f
> that won't be recognized, and "git check-ref-format tmp/junk" is happ=
y.
>
> I think we would need to restrict check_ref_format() so that these
> commands (and possibly others, but I think that single function will =
cover
> pretty much everything) also reject "tmp/junk" immediately below $GIT=
_DIR
> as a bad string. Otherwise we cannot merge these fixups, which would =
mean
> we would have to revert the "Clean up refname checks and normalizatio=
n"
> series, at least the part that started emitting the "warning", which =
is a
> mess I would rather want to avoid.
>
> Opinions on how to get us out of this mess?

Let me step back a bit to avoid making hasty decisions that may cause
negative effect on the end users only because a single topic with a
possible fallout has been merged to 'master' already (a sane position f=
or
such a situation always has been to revert the merge of the topic so fa=
r,
but I ended up being hasty, only because the merge was deliberately mad=
e
early in the cycle to give us enough time to deal with fallouts).

In general, the "Hey that file that appears in our dwimmed ref namespac=
e
does not store correct [0-9a-f]{40} contents" warning message is a good
thing to have. When we try the dwimmery and disambiguation, we however
look at the potential refs and warn disambiguity only when two or more
such files have good contents. E.g. if I do this:

    $ git rev-parse HEAD >.git/refs/heads/frotz
    $ echo hello >.git/refs/tags/frotz
    $ git show frotz

we have never paid attention to the broken tag and showed the 'frotz'
branch without complaining. Once tags/frotz gets a real object name,
however, we start giving ambiguity warnings.

Perhaps that is what we should be fixing instead.

Right now, dwim_ref() classifies candidates into two categories, ones t=
hat
resolve_ref() succeeds, and others that resolve_ref() does not. And whe=
n
we have two or more candidates that successfully resolves, there is an
ambiguity.

Perhaps we need the third kind: ones that exist on the filesystem but
are ill-formed.

When na=C3=AFvely looked at, the code in 'master' may seem to be doing =
just
that, but it does _not_ have any way to affect the ambiguity detection
logic even if the caller wanted to. The warning is issued at a wrong
level.

Perhaps resolve_ref() should return in its *flag parameter that "a file
exists there but incorrectly formatted", and dwim_ref() should notice a=
nd
use that information to warn about ambiguity and also illformed-ness.

A patch is attached at the end of this message to minimally fix what is=
 in
'master' (without the jc/check-ref-format-fixup topic). This update all=
ows
us to make dwim_ref() notice such "exists but broken" candidates and la=
ter
take them into consideration when deciding if a name is ambiguous, but =
I
did not want to change the semantics from the traditional implementatio=
n,
so it only uses this information to warn ref breakages. Also this squel=
ches
the phony "index is not well formed" warning against "git show index --=
"
by knowing that many files directly under $GIT_DIR are not ref-like thi=
ngs.
Michaels's "when taken as a full refname, is this string valid?" update
mentioned in the thread may be used to replace the strchr(fullref, '/')=
 check
that can be seen in this patch.

 refs.c      |   22 +++++++++++-----------
 refs.h      |    5 +++--
 sha1_name.c |    5 ++++-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index cab4394..0f58e46 100644
--- a/refs.c
+++ b/refs.c
@@ -4,9 +4,8 @@
 #include "tag.h"
 #include "dir.h"
=20
-/* ISSYMREF=3D01 and ISPACKED=3D02 are public interfaces */
-#define REF_KNOWS_PEELED 04
-#define REF_BROKEN 010
+/* ISSYMREF=3D0x01, ISPACKED=3D0x02 and ISBROKEN=3D0x04 are public int=
erfaces */
+#define REF_KNOWS_PEELED 0x10
=20
 struct ref_entry {
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
@@ -329,12 +328,12 @@ static void get_ref_dir(const char *submodule, co=
nst char *base,
 				flag =3D 0;
 				if (resolve_gitlink_ref(submodule, ref, sha1) < 0) {
 					hashclr(sha1);
-					flag |=3D REF_BROKEN;
+					flag |=3D REF_ISBROKEN;
 				}
 			} else
 				if (!resolve_ref(ref, sha1, 1, &flag)) {
 					hashclr(sha1);
-					flag |=3D REF_BROKEN;
+					flag |=3D REF_ISBROKEN;
 				}
 			add_ref(ref, sha1, flag, array, NULL);
 		}
@@ -501,7 +500,6 @@ const char *resolve_ref(const char *ref, unsigned c=
har *sha1, int reading, int *
 	ssize_t len;
 	char buffer[256];
 	static char ref_buffer[256];
-	char path[PATH_MAX];
=20
 	if (flag)
 		*flag =3D 0;
@@ -510,6 +508,7 @@ const char *resolve_ref(const char *ref, unsigned c=
har *sha1, int reading, int *
 		return NULL;
=20
 	for (;;) {
+		char path[PATH_MAX];
 		struct stat st;
 		char *buf;
 		int fd;
@@ -586,8 +585,8 @@ const char *resolve_ref(const char *ref, unsigned c=
har *sha1, int reading, int *
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			warning("symbolic reference in %s is formatted incorrectly",
-				path);
+			if (flag)
+				*flag |=3D REF_ISBROKEN;
 			return NULL;
 		}
 		ref =3D strcpy(ref_buffer, buf);
@@ -596,7 +595,8 @@ const char *resolve_ref(const char *ref, unsigned c=
har *sha1, int reading, int *
 	}
 	/* Please note that FETCH_HEAD has a second line containing other dat=
a. */
 	if (get_sha1_hex(buffer, sha1) || (buffer[40] !=3D '\0' && !isspace(b=
uffer[40]))) {
-		warning("reference in %s is formatted incorrectly", path);
+		if (flag)
+			*flag |=3D REF_ISBROKEN;
 		return NULL;
 	}
 	return ref;
@@ -624,8 +624,8 @@ static int do_one_ref(const char *base, each_ref_fn=
 fn, int trim,
 		return 0;
=20
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
-		if (entry->flag & REF_BROKEN)
-			return 0; /* ignore dangling symref */
+		if (entry->flag & REF_ISBROKEN)
+			return 0; /* ignore dangling symref and corrupt ref */
 		if (!has_sha1_file(entry->sha1)) {
 			error("%s does not point to a valid object!", entry->name);
 			return 0;
diff --git a/refs.h b/refs.h
index 0229c57..7442b29 100644
--- a/refs.h
+++ b/refs.h
@@ -10,8 +10,9 @@ struct ref_lock {
 	int force_write;
 };
=20
-#define REF_ISSYMREF 01
-#define REF_ISPACKED 02
+#define REF_ISSYMREF 0x01
+#define REF_ISPACKED 0x02
+#define REF_ISBROKEN 0x04
=20
 /*
  * Calls the specified function for each ref file until it returns non=
zero,
diff --git a/sha1_name.c b/sha1_name.c
index ba976b4..1fe37c6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -282,8 +282,11 @@ int dwim_ref(const char *str, int len, unsigned ch=
ar *sha1, char **ref)
 				*ref =3D xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD"))
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
 			warning("ignoring dangling symref %s.", fullref);
+		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
+			warning("ignoring broken ref %s.", fullref);
+		}
 	}
 	free(last_branch);
 	return refs_found;
