Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4721EEF9
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929220; cv=none; b=BPm/mn7z2RRYi2nwYGGx+eHwTI1jh9v+430J0fNTIGb6pTEBLQOCiXeBkSkUiR+hGicT0BVJ4qgl3RG3dNy+2zpxdzUf2Kq4drKizXH+kBVQ53UVgumZMW1JsydB+d2bV8OX+jbtRauEip/3Day2vUF2+CnvqspSqmmbZF1qMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929220; c=relaxed/simple;
	bh=tNnU55zQ2HvoLoqcTeQ+/b5EYd8NZH5FoJSAR5pc8Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWoY6f+RgBzgAYO3tvyIW5bWBLoQff0DKsCRFa5mLcuIMLyP+e5M6am6RrzpinNBVFNBOMFUKABPsNj0AXZL/m3YWsTdrB5K0atkjnSO9WWujb5VA/n9P5tdCWcX/hd8rd6QFDQ5VUcoQKL7L3cD6C+rl8qVNAeR8R7mnitqDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dIqkLIRZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6GWEbro; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dIqkLIRZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6GWEbro"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CF4513808DB;
	Tue, 29 Apr 2025 08:20:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 29 Apr 2025 08:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745929216; x=1746015616; bh=T0DYpVw5OT
	aFD/I/WOGxKtw7pW+NpVfT+/5bAk9b0vM=; b=dIqkLIRZciciFezsfa0PjD/Zgq
	Z9GG0dnw/jkOTBJrbfd+vhjvbxg6u6pj9ZmbYvKnOhj83BU6EfHVUlNo1ZgC1LM9
	KiZ/8KagGDOeaWnq941UdZmUfg6XyFaWQR3yqKW172TVoHu06XK5GcbAb3KQNgMx
	KeApks2v1AoQD3E1NnMVb8/PIBFtv2p2EI9qSDZ9ChxbdxpfMgpVZCM2D7/oEIek
	QyrWZnvxMuKDd7x5kOeH12vvrYA0M5XFg9QIFzCNBCKzcgoYWimFD7znsOQDpFJ+
	pleWt2pHKfUC1KD7+ZthUaXqAySX31rCZzahkgH7EL0t3BzqB+yFKRdn0gww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745929216; x=1746015616; bh=T0DYpVw5OTaFD/I/WOGxKtw7pW+NpVfT+/5
	bAk9b0vM=; b=B6GWEbroFbUNweUhmp0+mVi9clHzZpV5Ahas2Y849BSNwwuWrBG
	whUyePr3jxOuj+gh92NTilxT9AL30u4uZClXyUzWy1DQL+tmiYTF4tHvgC1B/jwl
	ZkIDEsG/0YIT2dZxigPfiijSM0jdh6DR6XOBBi9IDHQMQKwKLH5JbR4lkNF+QgfN
	DyyvMTBxnEHHS9YHwepUE5rYkzyhkDw86uQt450EggIhmsGBj3IweQIZqOvkh4pw
	/PnTJptT5TAoBwITT+YAVgFTBsdFeDOhW7Ddbnv1i1FsfXdlt1/PSasbJbDePC74
	Z8Rza0UYD2zuY4WCuBWOkKSvtWJ8rS1Z39Q==
X-ME-Sender: <xms:_8MQaNAYvVwtIGzneUyBxe6IIIlbYP5mTPUn5C7hoKi6VWS11QvFcg>
    <xme:_8MQaLiMhOjtkTwRY_5S3ihvXii2kCRvS5IJf6akpWyL_Jbh8FxbmF3jROnZJXcZc
    IKtGXatJVlDqjE8cg>
X-ME-Received: <xmr:_8MQaImS3Vd9zZ9n5Z5ERKNO2vBSJNierPknwyvQGMG0Dd8NdSg9dpeG43oms0hYBPguF2UcOTsIYub9KlXq7B4UvrbwCxXBj94jsKhN0S0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_8MQaHzmLaRAX_bcLQnJD5GAQxzY10KIY3myP7nJ-Ba3kzkmZi5j8Q>
    <xmx:_8MQaCRPMmOavYRW9BotGIXJW7Zz8qXShoh3JSS0_wPe1CD37WIBCA>
    <xmx:_8MQaKamnB2NET1pf3PJlefiRFfhrF82FgMI_UnrCxLHbgYsRwcR_Q>
    <xmx:_8MQaDSqEWGD-JjIZ1SATV1OYVur-FqHP-nfe_NqA9vw8ZGMsn-Tdg>
    <xmx:AMQQaC-to0yK1lRef1G9fg37e1B0wAgFCnNWM25UU31OP4Rr4BfDnaNr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 08:20:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c404f1b3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 12:20:13 +0000 (UTC)
Date: Tue, 29 Apr 2025 14:20:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
Message-ID: <aBDD-NeN2YoQbU9S@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <xmqqmsc4uv6d.fsf@gitster.g>
 <aA8ymUzWM2t0QkFP@pks.im>
 <xmqq8qnkdxu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qnkdxu9.fsf@gitster.g>

On Mon, Apr 28, 2025 at 10:01:34AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > The reason for this timeout is the test case 'nonsense mv triggers
> >> > assertion failure and partially updated index' in t7001-mv (which is
> >> > not even a regression test, but instead merely demonstrates a bug that
> >> > someone thought someone else should fix at some time). As the name
> >> > suggests, it triggers an assertion. The problem with this is that an
> >> > assertion on Windows, at least when run in Debug mode, will open a modal
> >> > dialog that patiently awaits some buttons to be clicked. Which never
> >> > happens in automated builds.
> >> 
> >> Interesting.
> >> 
> >> So another viable fix (no, I am not suggesting a counter-proposal,
> >> but asking a pure question to see if I understand the issue
> >> correctly) is to rewrite "assert(cond)" to "if (cond) BUG(...)"
> >> or something like that, so that it truly fails?
> >
> > On the surface this sounds like a reasonable thing to do, but I don't
> > have enough context to be really able to tell.
> 
> Interesting again ;-) I didn't realize that it was a fairly recent
> development.  0fcd473f (t7001: add failure test which triggers
> assertion, 2024-10-22) is what adds the questionable test.
> 
> And I do agree with Dscho's assessment that this is "show a bug
> without bothering to fix it", which is not what we usually take
> without first exploring how involved the necessary fix would be.
> 
> I wonder in what bad status would a production build that simply
> disabled the assert() is leaving the resulting repository.
> 
> Quoting from the last part of my response [*] to the initial report
> that eventually turned into the test after 9 months:
> 
>  [*] https://lore.kernel.org/git/xmqqil47obnw.fsf@gitster.g/

Hm. So the issue here is that we're trying to move both a parent
directory as well as a child thereof at the same point in time? I guess
that'd need something like the below patch to restrict such requests.
This leads to:

    $ ./git mv ../builtin/add.c ../builtin ../t
    fatal: cannot move both 'builtin/add.c' and its parent directory 'builtin'

The idea of the patch is that we're tracking all parent directories in a
hashmap. After we have processed all arguments, we then perform a second
pass to check that none of the source files have any of their parent
directories moved at the same time.

I only had a brief look, so this assessment may very well be completely
wrong, and the change doesn't even pass all tests right now. But if this
is indeed the issue then I'm happy to polish this into a proper patch.

Patrick

-- >8 --

diff --git a/builtin/mv.c b/builtin/mv.c
index 54b323fff72..10b2cb56ec7 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -183,6 +183,21 @@ static void remove_empty_src_dirs(const char **src_dir, size_t src_dir_nr)
 	strbuf_release(&a_src_dir);
 }
 
+struct pathmap_entry {
+	struct hashmap_entry ent;
+	const char *path;
+};
+
+static int pathmap_cmp(const void *cmp_data UNUSED,
+		       const struct hashmap_entry *a,
+		       const struct hashmap_entry *b,
+		       const void *key UNUSED)
+{
+	const struct pathmap_entry *e1 = container_of(a, struct pathmap_entry, ent);
+	const struct pathmap_entry *e2 = container_of(b, struct pathmap_entry, ent);
+	return fspathcmp(e1->path, e2->path);
+}
+
 int cmd_mv(int argc,
 	   const char **argv,
 	   const char *prefix,
@@ -213,6 +228,8 @@ int cmd_mv(int argc,
 	struct cache_entry *ce;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_DUP;
 	struct string_list dirty_paths = STRING_LIST_INIT_DUP;
+	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
+	struct strbuf pathbuf = STRBUF_INIT;
 	int ret;
 
 	git_config(git_default_config, NULL);
@@ -331,11 +348,17 @@ int cmd_mv(int argc,
 
 dir_check:
 		if (S_ISDIR(st.st_mode)) {
+			struct pathmap_entry *entry;
 			char *dst_with_slash;
 			size_t dst_with_slash_len;
 			int j, n;
 			int first = index_name_pos(the_repository->index, src, length), last;
 
+			entry = xmalloc(sizeof(*entry));
+			entry->path = src;
+			hashmap_entry_init(&entry->ent, fspathhash(src));
+			hashmap_add(&moved_dirs, &entry->ent);
+
 			if (first >= 0) {
 				const char *path = submodule_gitfile_path(src, first);
 				if (path != SUBMODULE_WITH_GITDIR)
@@ -465,6 +488,40 @@ int cmd_mv(int argc,
 		}
 	}
 
+	for (i = 0; i < argc; i++) {
+		const char *slash_pos;
+
+		strbuf_addstr(&pathbuf, sources.v[i]);
+
+		slash_pos = strrchr(pathbuf.buf, '/');
+		while (slash_pos > pathbuf.buf) {
+			struct pathmap_entry needle;
+
+			strbuf_setlen(&pathbuf, slash_pos - pathbuf.buf);
+
+			needle.path = pathbuf.buf;
+			hashmap_entry_init(&needle.ent, fspathhash(pathbuf.buf));
+
+			if (!hashmap_get_entry(&moved_dirs, &needle, ent, NULL))
+				continue;
+
+			if (!ignore_errors)
+				die(_("cannot move both parent directory '%s' and its child '%s'"),
+				    pathbuf.buf, sources.v[i]);
+
+			if (--argc > 0) {
+				int n = argc - i;
+				strvec_remove(&sources, i);
+				strvec_remove(&destinations, i);
+				MOVE_ARRAY(modes + i, modes + i + 1, n);
+				MOVE_ARRAY(submodule_gitfiles + i,
+					   submodule_gitfiles + i + 1, n);
+				i--;
+				break;
+			}
+		}
+	}
+
 	if (only_match_skip_worktree.nr) {
 		advise_on_updating_sparse_paths(&only_match_skip_worktree);
 		if (!ignore_errors) {
@@ -589,6 +646,8 @@ int cmd_mv(int argc,
 	strvec_clear(&dest_paths);
 	strvec_clear(&destinations);
 	strvec_clear(&submodule_gitfiles_to_free);
+	hashmap_clear(&moved_dirs);
+	strbuf_release(&pathbuf);
 	free(submodule_gitfiles);
 	free(modes);
 	return ret;

