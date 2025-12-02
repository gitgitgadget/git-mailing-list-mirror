Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6422FB098
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713568; cv=none; b=KLYrg+YV/ZoURNrK6AnR4oYJEjC5Iex2DJhsiLPmmX4q9aG2P1/6OJrWmbYrP1OvHg/Az5hHRm/VSMNYq2/kpgDP8VezsmTI+LGkfsz5puOkEwj6T4bx+oTRoejqS9IEDI6aeKAYz7YfQCI3b8dA7ASNTA+pl79/z/8zvxmJ/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713568; c=relaxed/simple;
	bh=T+8PPq8nkK5hxvD4KKGtetbYL4gCRC70GP7KaP9VPKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0n0+NWmVCgDyrcwZtGTVOtG4xStxtZcJQ1wIPRvFFA7EUvJmKQjictqTSUy+oAU55Sv3ZrpfotLy/V1XQd1w6tKCAgZxeTPbWNWMgKblnxtrafDZFbHaZuNxnNztSuugn0L0B6YiTAEKG2NkCc/PFKkdJhotS3lRntrfrirUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NS+S13L5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NS+S13L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764713563; x=1765318363; i=l.s.r@web.de;
	bh=e2rSmiJzI/7IF4N651gpUd8CIWSxe6ZsSNwcRA+OAMU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NS+S13L5JoLmTO2yisQsdI+Dlx4JEdpd2EapFPuGY/dURw8Pitv0t5JhXlmx/o1b
	 Ct7I/DZgCjeM5TnnjZ2ZYgXGYKv28Rem3272POAtO5A8pT+KKrETfySYz2wp6LCeH
	 xdR3DujyUuesIXXUSLb159Ohsv8Ld4Jn/uY+m0KFSTs1paNUlUH+HewWdgyXeoKST
	 I6H/CQQqk7BxTD4L6uO+QBuO2Fxi4DSlXe6RNc1SJ8gzdHoWmDgM+Ar0lRpoqtsRR
	 tg0viU+2LPWDjO/wtSBAZvs2b3XYNxJBAGv8+N/5vGx4etDisABsyLGA+5zKv5/sO
	 KL5jwgBDSQHBQk57Bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.23.3]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1vX3rq34IK-00INL8; Tue, 02
 Dec 2025 23:07:18 +0100
Message-ID: <9a253514-376f-49fd-99fe-f076ecb180b6@web.de>
Date: Tue, 2 Dec 2025 23:07:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] diff-index: don't queue unchanged filepairs with
 diff_change()
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <aa28974b-ec73-4562-bfc8-4745ad58b55a@web.de>
 <xmqq5xarcsb8.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5xarcsb8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6QBIIu/V3nijiEevOlbPwZbpHKG27bwT5P4wHu38ZnAeUWyv5jT
 q2gRxwM/TYnEodN1DXn2kunUFFgBT/9olpUuVeeLsoyn/Muwdi9m38pMyIibFMheSO78SCn
 42HYmiWe8A5LLiQ/hN1dfa6jiK91eOFhdDKAoIYjq1BS+R+bw3I68UziUnCG/OI4Qvzapo8
 4Ig/zECo0Y6vL8VVllhKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Po9csroUFe0=;QOocZNecC7cR34gGNoQ5vrdXLzH
 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

On 11/30/25 7:02 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Add a new streamlined function for queuing unchanged filepairs and
>> use it in show_modified(), which is called by diff_cache() via
>> oneway_diff() and do_oneway_diff().  It allocates only a single filespe=
c
>> for each filepair and uses it twice with reference counting.  This has =
a
>> measurable effect if there are a lot of them, like in the Linux repo:
>>
>> Benchmark 1: ./git_v2.52.0 -C ../linux diff --cached --find-copies-hard=
er
>>   Time (mean =C2=B1 =CF=83):      31.8 ms =C2=B1   0.2 ms    [User: 24.=
2 ms, System: 6.3 ms]
>>   Range (min =E2=80=A6 max):    31.5 ms =E2=80=A6  32.3 ms    85 runs
>>
>> Benchmark 2: ./git -C ../linux diff --cached --find-copies-harder
>>   Time (mean =C2=B1 =CF=83):      23.9 ms =C2=B1   0.2 ms    [User: 18.=
1 ms, System: 4.6 ms]
>>   Range (min =E2=80=A6 max):    23.5 ms =E2=80=A6  24.4 ms    111 runs
>>
>> Summary
>>   ./git -C ../linux diff --cached --find-copies-harder ran
>>     1.33 =C2=B1 0.01 times faster than ./git_v2.52.0 -C ../linux diff -=
-cached --find-copies-harder
>=20
> Nice.  Is this technique only applicable to diff-index among the
> three diff plumbing siblings?

> [...] it would apply to diff-tree, wouldn't it?
Yes, but its diff_change() call is behind two layers of callbacks, which
complicates things.

And I don't know how to avoid adding an object ID comparison.  Do we
perhaps have that bit somewhere in tree-diff.c already and can pass it
along the pathchange call?

And I wonder now if diff_same() is the right name.  Shouldn't it be
diff_keep() or a similar verb to match the siblings diff_change(),
diff_addremove() and diff_unmerge()?

Performance looks mixed.  E.g. memory usage is reduced slightly here:

$ for git in ./git_v2.52.0 ./git
  do
    for i in $(seq 5)
    do
      /usr/bin/time -l $git diff-tree --find-copies-harder -r v2.51.0 v2.5=
1.1 2>&1 >/dev/null
    done
  done | grep peak
            36111744  peak memory footprint
            36291968  peak memory footprint
            36177280  peak memory footprint
            36177280  peak memory footprint
            36291968  peak memory footprint
            35456384  peak memory footprint
            35489152  peak memory footprint
            35505536  peak memory footprint
            35636608  peak memory footprint
            35505536  peak memory footprint

But diff-tree needs 1% more time with the patch:

Benchmark 1: ./git_v2.52.0 diff-tree --find-copies-harder -r v2.51.0 v2.51=
.1
  Time (mean =C2=B1 =CF=83):      78.3 ms =C2=B1   0.2 ms    [User: 57.4 m=
s, System: 19.8 ms]
  Range (min =E2=80=A6 max):    77.9 ms =E2=80=A6  78.7 ms    36 runs

Benchmark 2: ./git diff-tree --find-copies-harder -r v2.51.0 v2.51.1
  Time (mean =C2=B1 =CF=83):      78.8 ms =C2=B1   0.2 ms    [User: 57.9 m=
s, System: 19.8 ms]
  Range (min =E2=80=A6 max):    78.4 ms =E2=80=A6  79.2 ms    36 runs

Summary
  ./git_v2.52.0 diff-tree --find-copies-harder -r v2.51.0 v2.51.1 ran
    1.01 =C2=B1 0.00 times faster than ./git diff-tree --find-copies-harde=
r -r v2.51.0 v2.51.1

Other examples look better:

Benchmark 1: ./git_v2.52.0 -C ../linux diff-tree --find-copies-harder -r v=
6.8 v6.9
  Time (mean =C2=B1 =CF=83):     110.7 ms =C2=B1   0.2 ms    [User: 83.1 m=
s, System: 26.8 ms]
  Range (min =E2=80=A6 max):   110.2 ms =E2=80=A6 111.4 ms    26 runs

Benchmark 2: ./git -C ../linux diff-tree --find-copies-harder -r v6.8 v6.9
  Time (mean =C2=B1 =CF=83):     105.3 ms =C2=B1   0.4 ms    [User: 78.9 m=
s, System: 24.0 ms]
  Range (min =E2=80=A6 max):   104.7 ms =E2=80=A6 106.0 ms    27 runs

Summary
  ./git -C ../linux diff-tree --find-copies-harder -r v6.8 v6.9 ran
    1.05 =C2=B1 0.00 times faster than ./git_v2.52.0 -C ../linux diff-tree=
 --find-copies-harder -r v6.8 v6.9

But overall I'm not impressed. :-|

Ren=C3=A9


=2D--
 builtin/reset.c | 1 +
 diff.c          | 1 +
 diff.h          | 7 ++++++-
 diffcore.h      | 4 ++--
 tree-diff.c     | 8 ++++++--
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index ed35802af1..ec674694dd 100644
=2D-- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -210,6 +210,7 @@ static int read_from_tree(const struct pathspec *paths=
pec,
 	opt.repo =3D the_repository;
 	opt.change =3D diff_change;
 	opt.add_remove =3D diff_addremove;
+	opt.keep =3D diff_same;
=20
 	if (pathspec->nr && pathspec_needs_expanded_index(the_repository->index,=
 pathspec))
 		ensure_full_index(the_repository->index);
diff --git a/diff.c b/diff.c
index 436da250eb..9671524d2b 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4847,6 +4847,7 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)
 	/* pathchange left =3DNULL by default */
 	options->change =3D diff_change;
 	options->add_remove =3D diff_addremove;
+	options->keep =3D diff_same;
 	options->use_color =3D diff_use_color_default;
 	options->detect_rename =3D diff_detect_rename_default;
 	options->xdl_opts |=3D diff_algorithm;
diff --git a/diff.h b/diff.h
index 7eb84aadf4..6dfec55039 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -43,7 +43,8 @@ struct oidset;
  * set_default in diff_options can be used to tweak this more.
  *
  * - As you find different pairs of files, call `diff_change()` to feed
- * modified files, `diff_addremove()` to feed created or deleted files, o=
r
+ * modified files, `diff_addremove()` to feed created or deleted files,
+ * `diff_same()` to feed unmodified files if needed for copy detection, o=
r
  * `diff_unmerge()` to feed a file whose state is 'unmerged' to the API.
  * These are thin wrappers to a lower-level `diff_queue()` function that =
is
  * flexible enough to record any of these kinds of changes.
@@ -92,6 +93,9 @@ typedef void (*add_remove_fn_t)(struct diff_options *opt=
ions,
 		    int oid_valid,
 		    const char *fullpath, unsigned dirty_submodule);
=20
+typedef void (*keep_fn_t)(struct diff_options *options, unsigned mode,
+			  const struct object_id *oid, const char *fullpath);
+
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
=20
@@ -384,6 +388,7 @@ struct diff_options {
 	pathchange_fn_t pathchange;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	keep_fn_t keep;
 	void *change_fn_data;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
diff --git a/diffcore.h b/diffcore.h
index 9c0a0e7aaf..64b419b33f 100644
=2D-- a/diffcore.h
+++ b/diffcore.h
@@ -35,8 +35,8 @@ struct userdiff_driver;
 /**
  * the internal representation for a single file (blob).  It records the =
blob
  * object name (if known -- for a work tree file it typically is a NUL SH=
A-1),
- * filemode and pathname.  This is what the `diff_addremove()`, `diff_cha=
nge()`
- * and `diff_unmerge()` synthesize and feed `diff_queue()` function with.
+ * filemode and pathname.  This is what `diff_addremove()`, `diff_change(=
)`,
+ * `diff_same()` and `diff_unmerge()` synthesize and feed `diff_queue()`.
  */
 struct diff_filespec {
 	struct object_id oid;
diff --git a/tree-diff.c b/tree-diff.c
index 5988148b60..c5e2cf6a69 100644
=2D-- a/tree-diff.c
+++ b/tree-diff.c
@@ -167,8 +167,12 @@ static int emit_diff_first_parent_only(struct diff_op=
tions *opt, struct combine_
 {
 	struct combine_diff_parent *p0 =3D &p->parent[0];
 	if (p->mode && p0->mode) {
-		opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
-			1, 1, p->path, 0, 0);
+		if (opt->flags.find_copies_harder && opt->keep &&
+		    p0->mode =3D=3D p->mode && oideq(&p0->oid, &p->oid))
+			opt->keep(opt, p->mode, &p->oid, p->path);
+		else
+			opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
+				    1, 1, p->path, 0, 0);
 	}
 	else {
 		const struct object_id *oid;
=2D-=20
2.52.0

