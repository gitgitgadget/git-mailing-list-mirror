From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Fri, 26 Feb 2016 10:29:40 -0800
Message-ID: <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
	<56D078F3.9070905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 26 19:29:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZN9A-0005PP-EB
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 19:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbcBZS3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 13:29:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753981AbcBZS3n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 13:29:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 854144666F;
	Fri, 26 Feb 2016 13:29:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4974ra8QnosU
	V4X88EsMTW+bYy0=; b=HUnJ2smfOf9rps9q6NWH3jdTPkT48ODDhw1Ok8GG6H10
	AWhlQzar1rQxI2iSR0D1shG0aQVe+u1M7oVoui3ZIkxymisXmb8hw5GoEgYzsXav
	0sUxnDy/SUu+UedH2u24Z0sA4+fT0naMWgPBBws6I5cg02chM5j7esemdpU60Jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R7odn7
	cHFYEWLbXIkGcoSHNSZfmzzESMlNJbL8fqOeqCDB8/m7fN5cUWx/6UR++nOvqa7C
	+8UWudKK5c1xrpxlmSKFKuCtQBkE1+jrXf6L9DVqoyJi4lsxe+2yNiNe9jTYTprZ
	nAATLUsnFB9nKVUSW+091KvQEf/H7w+vhwUm0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D31A4666D;
	Fri, 26 Feb 2016 13:29:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E49B54666C;
	Fri, 26 Feb 2016 13:29:41 -0500 (EST)
In-Reply-To: <56D078F3.9070905@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 26 Feb 2016 17:10:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6D431DE-DCB6-11E5-B68B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287602>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> CC combine-diff.o
> combine-diff.c: In function =E2=80=98diff_tree_combined=E2=80=99:
> combine-diff.c:1391: internal compiler error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://developer.apple.com/bugreporter> for instructions.
> make: *** [combine-diff.o] Error 1
>
> Revert "use st_add and st_mult for allocation size computation" didn'=
t fix it.
> I haven't digged deeper yet.

Hmph, I am not quite sure what you meant by "I haven't digged
deeper"; I do not think you should be debugging Apple's compiler
(unless you have the source to it and that is your job to do so,
that is).

In any case, merging the topic to 'master', and reverting that
commit will leave this only this change between 'master' and the
result.  I do not immediately spot anything trickier in the
postimage compared to the preimage that may trickle a compiler bug,
but what would I know without the source ;-)

Thanks for a report, anyway.

diff --git a/combine-diff.c b/combine-diff.c
index 5571304..be09a2b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -319,7 +319,7 @@ static void append_lost(struct sline *sline, int n,=
 const char *line, int len)
 	if (line[len-1] =3D=3D '\n')
 		len--;
=20
-	lline =3D xmalloc(sizeof(*lline) + len + 1);
+	FLEX_ALLOC_MEM(lline, line, line, len);
 	lline->len =3D len;
 	lline->next =3D NULL;
 	lline->prev =3D sline->plost.lost_tail;
@@ -330,8 +330,6 @@ static void append_lost(struct sline *sline, int n,=
 const char *line, int len)
 	sline->plost.lost_tail =3D lline;
 	sline->plost.len++;
 	lline->parent_map =3D this_mask;
-	memcpy(lline->line, line, len);
-	lline->line[len] =3D 0;
 }
=20
 struct combine_diff_state {
@@ -1043,7 +1041,7 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 				elem->mode =3D canon_mode(S_IFLNK);
=20
 			result_size =3D len;
-			result =3D xmalloc(len + 1);
+			result =3D xmallocz(len);
=20
 			done =3D read_in_full(fd, result, len);
 			if (done < 0)
@@ -1051,8 +1049,6 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			else if (done < len)
 				die("early EOF '%s'", elem->path);
=20
-			result[len] =3D 0;
-
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
 			if (is_file) {
 				struct strbuf buf =3D STRBUF_INIT;
@@ -1372,7 +1368,7 @@ static struct combine_diff_path *find_paths_multi=
tree(
 	struct combine_diff_path paths_head;
 	struct strbuf base;
=20
-	parents_sha1 =3D xmalloc(nparent * sizeof(parents_sha1[0]));
+	ALLOC_ARRAY(parents_sha1, nparent);
 	for (i =3D 0; i < nparent; i++)
 		parents_sha1[i] =3D parents->sha1[i];
=20
@@ -1483,7 +1479,7 @@ void diff_tree_combined(const unsigned char *sha1=
,
 	if (opt->orderfile && num_paths) {
 		struct obj_order *o;
=20
-		o =3D xmalloc(sizeof(*o) * num_paths);
+		ALLOC_ARRAY(o, num_paths);
 		for (i =3D 0, p =3D paths; p; p =3D p->next, i++)
 			o[i].obj =3D p;
 		order_objects(opt->orderfile, path_path, o, num_paths);
