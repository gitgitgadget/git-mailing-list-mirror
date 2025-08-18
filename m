Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B33451BE
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547013; cv=none; b=WgJ1ZIX+VjoP5VaD9INALC4RGA4uz59Ef2+WSApHTqEcfACA8MqzwcVK/lirvZtclyTnQYcgRHgKY4OII01iy+xX3+z4RTOTrx0r3G5+FPzS6FJk3tDt2Nneph1Ie1Ygg26Z8oniMHZ2DilPyW3cHqL/QqcvAzhsZ1Df9if6Eco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547013; c=relaxed/simple;
	bh=nQ/OjjjZlx4hdBXYs+WRIIslAnnEwWNqPMB4Nav9AKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaI0lNyZ7pb8OruFHPO8kxJ/WadfFFToK68jsIgfj0p2jvqWp6QSzwhX2S2mnfT4oh8CXNk9Rdf10MyLUHlSjyWRQf+E+VqOODEgOcfg3lDfp2SlrXv5E0DTIGlQs0KSQIBhJZlWLeKO4ykddxHEI9uz6yFPzdfOoximbdb/X/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YpV6kAwg; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YpV6kAwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755546997; x=1756151797; i=l.s.r@web.de;
	bh=9y7tjbJIK4tNqQxC5u9xeKQiGvNuwcWuE7T65ykliiA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YpV6kAwgVJsxJnY4rqWchKCSsgYRubjsDbPbV9WuziulYLIl+mIMRAmVb6MkIfYe
	 DUpe3ZJu2J+CEW8LC55hHWNYjGqX403gSNPPHaG7/ZqMjJkJfwrkG39PXqgE0nfCR
	 bTT3dcSTC624/maMkaeMt3ZDkFjjjnjSAxO8thAjZNsJirsF3WBq/F9vEJovBRNle
	 MDnMTKM45EzjI2APE/isouvFmQhGBeCCb+jpcmNT2X2VdbZgcsxuFozKYKPueym2g
	 BiQA14bMVjONbHcONYNr2Q2h//cxGrK34SyCy3BEyfVNPpKYuy2OM9gpBinyOKs0U
	 KImhkvLt8oLFIObLjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzeZ-1uMCng0HxF-00j0WL; Mon, 18
 Aug 2025 21:56:37 +0200
Message-ID: <194415e5-2adc-4b3f-98d3-0fde4a288b5c@web.de>
Date: Mon, 18 Aug 2025 21:56:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
 git@vger.kernel.org
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
 <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
 <20250818044807.GA51803@coredump.intra.peff.net>
 <20250818050545.GA62231@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250818050545.GA62231@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s5Me6CDX0Qp3dkVOUFgygcPKKs3231KdzfIe2+z/ea6ki88drEI
 6ovd6wjm+wRGtM4BbBSl6zR1vHYUaqpQIv4M75UTci8g+mHqmxhRqmI8etAtA1l/3nVDI5D
 PJUkB69fb78tLwPyzHR8thCDaoCyo5USdz9ZDxJ0gWl4IX8fjybivy/iJvsZQlLWxM9dzcT
 ZLhWuFMy7HgkXQHSkCYow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:szsIQItnBaI=;hKEdSGf9O3pVcEo0bRBO5Oi9qNv
 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
 SYGG0Co=

On 8/18/25 7:05 AM, Jeff King wrote:
> On Mon, Aug 18, 2025 at 12:48:07AM -0400, Jeff King wrote:
>=20
>> And indeed, the current code does then segfault on "git describe foo" a=
t
>> the spot I mentioned. Even though the repository state here is
>> unexpected and corrupt, I do think we should probably be more defensive
>> and avoid the segfault.
>=20
> So you almost nerd-sniped me into making a series. But the more I dug
> into the rabbit-hole, the more I turned away in disgust. :)
>=20
> The set of problems I found are:
>=20
>   1. What should happen when traversing from HEAD does not find the blob
>      in question? Right now we print a blank line, which is...weird.

Weird indeed.

>      Probably we should either print nothing, or return an error.

The latter, consistent with "git describe <commit-ish>".

> If we return an error, should we respect --always?

The documentation says "git describe <blob>" takes no options.  It could
learn some, of course.  But does it have to?  Perhaps better keep that
thing contained.

> Are we stuck with the
>      current dumb behavior because it's a plumbing command?

git describe is a porcelain command.

The documentation doesn't say what happens when the blob is not found
in HEAD's ancestry.

I can't imagine why someone would use "git describe <blob>" to check
whether a particular blob is linked to, but it _is_ slightly faster than
"git rev-list --objects --no-object-names HEAD | grep <blob>" for me,
and of course easier to type.  "git log --find-object <blob>" is slower
than either.

>   2. When we are on an unborn branch, we print a confusing message:
>=20
>        $ git init
>        $ git commit --allow-empty -m foo
>        $ git tag foo
>        $ git symbolic-ref HEAD refs/heads/unborn
>        $ git describe $(echo blob | git hash-object -w --stdin)
>        fatal: ambiguous argument 'HEAD': unknown revision or path not in=
 the working tree.
>        Use '--' to separate paths from revisions, like this:
>        'git <command> [<revision>...] -- [<file>...]'
>=20
>      We should probably resolve HEAD ourselves and either bail with an
>      empty output or an error (depending on what we do for (1) above).

It already is an error, just needs a better message.  It should still
report an error even if we were to stick with showing blank lines for
unrelated blobs.

>   3. When we do traverse, if process_object() sees that we didn't find a
>      commit, we should detect that and either return an empty result or
>      an error (again, depending on the behavior of (2) above). This is
>      done by checking is_null_oid(&pcd->current_commit) there.

OK, ending the search right there might be the best option.  Traversing
deeper into the forest that we then know to be cursed would be the
unappealing alternative.

>   4. Then we can teach describe_commit() to take a commit rather than an
>      oid (and the is_null_oid() check becomes a NULL check).

  5. When process_object() has a commit, but it is indescribable, it
     shows an error:

     $ git describe 5afbe6da1d6ab0b8939343166636b828e561bf35
     fatal: No tags can describe '3b681e255cd8577a77983958ef7f566b05806cd0=
'.
     Try --always, or create some tags.

     It's not immediately clear that the reported hash belongs to the
     found commit.  And that suggestion to try --always is misleading,
     as "git describe <blob>" takes no options according to the
     documentation.  I'm not sure I like it in general -- can't tell
     if the command is being snarky with me.

> So it all depends on what to do with (1), and for a feature that IMHO
> should not even exist in the first place, I had trouble summoning the
> will-power to make this 4-patch series.

644eb60bd0 (builtin/describe.c: describe a blob, 2017-11-15) and
15af58c1ad (diffcore: add a pickaxe option to find a specific blob,
2018-01-04) confuse me; the latter's commit message sounds like the
former wasn't (supposed to be?) merged.

I think the issues you listed are independent, though.  Or what's wrong
with this demo that addresses point 3 in process_object() and 1 in
describe_blob().  If we want a blank line for 1 then we apply only
the first hunk.  Or am I missing something?

Ren=C3=A9


diff --git a/builtin/describe.c b/builtin/describe.c
index d7dd8139de..9e485240aa 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -507,8 +507,10 @@ static void process_object(struct object *obj, const =
char *path, void *data)
=20
 	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
-		describe_commit(&pcd->current_commit, pcd->dst);
-		strbuf_addf(pcd->dst, ":%s", path);
+		if (!is_null_oid(&pcd->current_commit)) {
+			describe_commit(&pcd->current_commit, pcd->dst);
+			strbuf_addf(pcd->dst, ":%s", path);
+		}
 		free_commit_list(pcd->revs->commits);
 		pcd->revs->commits =3D NULL;
 	}
@@ -519,6 +521,7 @@ static void describe_blob(struct object_id oid, struct=
 strbuf *dst)
 	struct rev_info revs;
 	struct strvec args =3D STRVEC_INIT;
 	struct process_commit_data pcd =3D { *null_oid(the_hash_algo), oid, dst,=
 &revs};
+	size_t orig_len =3D dst->len;
=20
 	strvec_pushl(&args, "internal: The first arg is not parsed",
 		     "--objects", "--in-commit-order", "--reverse", "HEAD",
@@ -532,6 +535,8 @@ static void describe_blob(struct object_id oid, struct=
 strbuf *dst)
 		die("revision walk setup failed");
=20
 	traverse_commit_list(&revs, process_commit, process_object, &pcd);
+	if (dst->len =3D=3D orig_len)
+		die(_("unable to describe blob '%s'"), oid_to_hex(&oid));
 	reset_revision_walk();
 	release_revisions(&revs);
 	strvec_clear(&args);

