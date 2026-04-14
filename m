Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046853B2FD1
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182204; cv=none; b=OKqNsKkBEyupO9rGbmfy4faQDjG6Obi3szLJKNZQ6ewVUyZ2iA3WJiwJ7pQQ79EbF+i17Fr4X07e3Pp2nEp8CK6w9Txn35vhFkmWTkEnUAyyQcefLQcrFwRA1/5ROBc9f5HqcMM9E6VX95TCS8DQa1CxpKp0CxfOQ+Czq6sm2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182204; c=relaxed/simple;
	bh=ttw1LbJ3sbj0P6fw7JdoIYqPswuWzjdvTGs+kiNWuXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHHzgSRX+CpoWNpSaVJqaJRMpVB5SlIf/bFCvsoBgNcdl0Fyrh6RQgTO1eyuY0N4hE5uFdVlbt+HcCxHo33mfHMdpHstp3MVru1lH+Hi6FbeXtMuHWylQAbJwqpEKEndr22pt4BtwweVVzKkgRS8qGT/bHmxBYtQJLLTXu2k/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KfIAVCX/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuDc1Sw5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KfIAVCX/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuDc1Sw5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CE311D00124;
	Tue, 14 Apr 2026 11:56:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 14 Apr 2026 11:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776182201; x=1776268601; bh=kUCgqbrZAf
	/27fnKmh12k5VXMAY9+lax0DL2vd+W1EE=; b=KfIAVCX/Z5nPgqR6Z0c3IV6bDI
	rinQ10+AXc3THKdo8naFVbwwMT552Uw2iTFTa7Vazounvpxy6pXNbQAydmNKlQTK
	OV78wmru+Ik9CYk1a49ABOgzbbFs2ohwQB8D8u+ivry4cJT5HbRy2DW2HaO+qvl5
	n8zYT4J/ahh6+n/v40DE7Bau7Q4eHf0LnMb6EI5ClMW21THrRh+evFEtruiK8VIV
	b7IOlOxrlLJSkIfuh6zddhRfvmCdIL765SNceFDljdB2e5dGr6E7ZTfN7oN3ddWf
	A1bVplpqHlQ4djVpBW63truxFu/Hatn6qrVVl/CIN3Z7RRwSZ90hjzsMAIhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776182201; x=1776268601; bh=kUCgqbrZAf/27fnKmh12k5VXMAY9+lax0DL
	2vd+W1EE=; b=IuDc1Sw5yY6McZmfjvWTph7DjIB34eg5LHCA0B2VGo8gYzpBpv4
	qzV/fJpQKDptzjDGWhnFO+FDLJMXAyCp6Va2u9JrA4gip16NTJjeoZT1mbMeRGQY
	08blHONnxrTXPuTMkzO19aPD/M7MK/VcHWarEFTjfXmAUWc6WbLXf4Q5Lc+GUttg
	gkYdwKpOA9jr7Fdg9aUL2uSv3bDPowb53BKAkGtxguWUY8u5XSso+E9i+IK44Kdl
	qUPuoUHNJcpZmBYfapwpN3RMl9mRNmN0OOVdHJi1KLuVLO1uQIKMXp96aAMJh0Q9
	wZ/yd6XnKWe5GmBWoX7ApZgc0T97kDtjgpQ==
X-ME-Sender: <xms:uWPeaUPhLHBRVF9CITgTbgrg11VEd-_3HoSzzz4D_a2-GWz4dQ_aMA>
    <xme:uWPeadMfENg209gnpADss8ubgGlJgAAxw1JzE1mp1cZMWd7BXLpLJdgwiv-fVVJhz
    o3H76r9pAE8BWgX1va305eiDfRscW3NfVTqTz49sMteRgIZ4H0c8w>
X-ME-Received: <xmr:uWPeadj6PLer4oK44dvNQhMBCsaEPjamtdskz3fQ6eSfyIOpuzSMlrAQ5BqyZ2_eDNlXir8rCuYlKOaLjbZ48cUKe0sEjZ-f_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevffejleegueevjedtveehuddtueffhfevkeekfefhfeffgeehheeluefhvdef
    veenucffohhmrghinhepghhithhhuhgsrdgtohhmpdguvghsihhgnhdrmhgunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthho
    rhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uWPeaStMJOy5tvQ3zjxPz21lDsnwDBJuodHm-z9LRgOJn9rp6ecTdQ>
    <xmx:uWPeabTkO_GaKOYnBL7kBiw0x9MWkwYwFGayz4u01F2bASVLQDbASw>
    <xmx:uWPeaW14N8Yc1P5eHNQ05QtaZTzWMOpilnhiNNK6Qt4EbSrzdBGf7w>
    <xmx:uWPeaQuQJjrokAbwqRMjOWoTS-h7VmxiDlKjhlMP_gXuURlJoUIJHg>
    <xmx:uWPeacQtiCFI-qDgtG1QWoeqOI8xO2QxmTEZoB5BSgUoru3VklXI5lBW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 11:56:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Jeff King <peff@peff.net>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v12 0/4] checkout: 'autostash' for branch switching
In-Reply-To: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 14 Apr 2026 12:59:41
	+0000")
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
	<pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 08:56:39 -0700
Message-ID: <xmqqfr4xcz7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Harald Nordgren (4):
>   stash: add --label-ours, --label-theirs, --label-base for apply
>   sequencer: allow create_autostash to run silently
>   sequencer: teach autostash apply to take optional conflict marker
>     labels
>   checkout: -m (--merge) uses autostash when switching branches
>
>  Documentation/git-checkout.adoc |  58 ++++-----
>  Documentation/git-stash.adoc    |  11 +-
>  Documentation/git-switch.adoc   |  33 ++---
>  builtin/checkout.c              | 147 ++++++++++------------
>  builtin/stash.c                 |  32 +++--
>  sequencer.c                     |  81 ++++++++++---
>  sequencer.h                     |   6 +
>  t/t3420-rebase-autostash.sh     |  24 +++-
>  t/t3903-stash.sh                |  29 +++++
>  t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
>  t/t7600-merge.sh                |   2 +-
>  xdiff-interface.c               |  12 ++
>  xdiff-interface.h               |   1 +
>  xdiff/xmerge.c                  |   6 +-
>  14 files changed, 491 insertions(+), 159 deletions(-)

I am not taking v11 and v12 today, as v10 is already in 'next', but
for future reference, I have to say that this cover letter is not
very helpful.

It shows 350+ lines of range-diff to show mostly irrelevant noise,
when the true difference between v11 and v12 is only that two helper
functions create_autostash_ref_silent{,_with_msg}() are merged into
one create_autostash_ref_with_msg_silent() helper function.

It is much easier to read that read from the diff between the
results of applying v11 and v12 on the same base commit, which is a
mere 55 lines (shown at the end).

I would not expect you to teach GGG to produce a better range-diff
or add an option to instead show an interdiff, but doesn't GGG
already have a way to add some human-written comment, e.g.,

    Changes since v11:

        Two helper functions create_autostash_ref_silent{,_with_msg}()
        are merged into one create_autostash_ref_with_msg_silent().

to the cover letter?  Such a comment, even a very short one like I
showed above, would be a lot more effective way to help human
readers to decide what is the point of this iteration is, especially
when you are sending v11 and v12 almost back-to-back, and to decide
if it is easier to understand to read both or if v11 can be skipped
and reading v12 alone (with the understanding of the difference
explained in the comment) should be enough to tell if v12 is an
improvement over v11 or not.

https://github.com/gitgitgadget/gitgitgadget/blob/main/DESIGN.md#patch-submissions

says that

    The description of the Pull Request will be used as cover
    letter, ...

so perhaps your pull-request comment should have something more than
just the list of CC: recipients?

Thanks.


diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2adfefa085..a7a93e1c6b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1155,9 +1155,9 @@ static int switch_branches(const struct checkout_opts *opts,
 			strbuf_addf(&autostash_msg,
 				    "autostash while switching to '%s'",
 				    new_branch_info->name);
-			create_autostash_ref_silent_with_msg(the_repository,
-							    "CHECKOUT_AUTOSTASH_HEAD",
-							    autostash_msg.buf);
+			create_autostash_ref_with_msg_silent(the_repository,
+						   "CHECKOUT_AUTOSTASH_HEAD",
+						   autostash_msg.buf);
 			created_autostash = 1;
 			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		}
diff --git a/sequencer.c b/sequencer.c
index febdb5b20a..b78a8ff092 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4726,14 +4726,8 @@ void create_autostash_ref(struct repository *r, const char *refname)
 	create_autostash_internal(r, NULL, refname, NULL, false);
 }
 
-void create_autostash_ref_silent(struct repository *r, const char *refname)
-{
-	create_autostash_internal(r, NULL, refname, NULL, true);
-}
-
-void create_autostash_ref_silent_with_msg(struct repository *r,
-					  const char *refname,
-					  const char *message)
+void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
+				 const char *message)
 {
 	create_autostash_internal(r, NULL, refname, message, true);
 }
diff --git a/sequencer.h b/sequencer.h
index 67de755053..b0c891d3b6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -230,10 +230,8 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
-void create_autostash_ref_silent(struct repository *r, const char *refname);
-void create_autostash_ref_silent_with_msg(struct repository *r,
-					  const char *refname,
-					  const char *message);
+void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
+				 const char *message);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);


> base-commit: 9e8f4e9c04e3efa494e78b710e0c5f6cc77a0a5e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v12
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v12
> Pull-Request: https://github.com/git/git/pull/2234
>
> Range-diff vs v11:
>
>  1:  9ab5431b47 = 1:  9ab5431b47 stash: add --label-ours, --label-theirs, --label-base for apply
>  2:  e7f8328e3c ! 2:  e11a622bdf sequencer: allow create_autostash to run silently
>      @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
>        				      const char *path,
>       -				      const char *refname)
>       +				      const char *refname,
>      ++				      const char *message,
>       +				      bool silent)
>        {
>        	struct strbuf buf = STRBUF_INIT;
>        	struct lock_file lock_file = LOCK_INIT;
>      +@@ sequencer.c: static void create_autostash_internal(struct repository *r,
>      + 		struct object_id oid;
>      + 
>      + 		strvec_pushl(&stash.args,
>      +-			     "stash", "create", "autostash", NULL);
>      ++			     "stash", "create",
>      ++			     message ? message : "autostash", NULL);
>      + 		stash.git_cmd = 1;
>      + 		stash.no_stdin = 1;
>      + 		strbuf_reset(&buf);
>       @@ sequencer.c: static void create_autostash_internal(struct repository *r,
>        					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
>        		}
>      @@ sequencer.c: static void create_autostash_internal(struct repository *r,
>        void create_autostash(struct repository *r, const char *path)
>        {
>       -	create_autostash_internal(r, path, NULL);
>      -+	create_autostash_internal(r, path, NULL, false);
>      ++	create_autostash_internal(r, path, NULL, NULL, false);
>        }
>        
>        void create_autostash_ref(struct repository *r, const char *refname)
>        {
>       -	create_autostash_internal(r, NULL, refname);
>      -+	create_autostash_internal(r, NULL, refname, false);
>      ++	create_autostash_internal(r, NULL, refname, NULL, false);
>       +}
>       +
>      -+void create_autostash_ref_silent(struct repository *r, const char *refname)
>      ++void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
>      ++				 const char *message)
>       +{
>      -+	create_autostash_internal(r, NULL, refname, true);
>      ++	create_autostash_internal(r, NULL, refname, message, true);
>        }
>        
>        static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
>      @@ sequencer.h: void commit_post_rewrite(struct repository *r,
>        
>        void create_autostash(struct repository *r, const char *path);
>        void create_autostash_ref(struct repository *r, const char *refname);
>      -+void create_autostash_ref_silent(struct repository *r, const char *refname);
>      ++void create_autostash_ref_with_msg_silent(struct repository *r, const char *refname,
>      ++				 const char *message);
>        int save_autostash(const char *path);
>        int save_autostash_ref(struct repository *r, const char *refname);
>        int apply_autostash(const char *path);
>  3:  3242fd3261 ! 3:  4593745e90 sequencer: teach autostash apply to take optional conflict marker labels
>      @@ Commit message
>           Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>       
>        ## sequencer.c ##
>      -@@ sequencer.c: void create_autostash_ref_silent(struct repository *r, const char *refname)
>      - 	create_autostash_internal(r, NULL, refname, true);
>      +@@ sequencer.c: void create_autostash_ref_with_msg_silent(struct repository *r, const char *refn
>      + 	create_autostash_internal(r, NULL, refname, message, true);
>        }
>        
>       -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
>       +static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>       +				    const char *label_ours, const char *label_theirs,
>      -+				    const char *label_base)
>      ++				    const char *label_base,
>      ++				    const char *stash_msg)
>        {
>        	struct child_process child = CHILD_PROCESS_INIT;
>        	int ret = 0;
>      @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
>        		strvec_push(&child.args, stash_oid);
>        		ret = run_command(&child);
>        	}
>      +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
>      + 		strvec_push(&store.args, "stash");
>      + 		strvec_push(&store.args, "store");
>      + 		strvec_push(&store.args, "-m");
>      +-		strvec_push(&store.args, "autostash");
>      ++		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
>      + 		strvec_push(&store.args, "-q");
>      + 		strvec_push(&store.args, stash_oid);
>      + 		if (run_command(&store))
>       @@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
>        	}
>        	strbuf_trim(&stash_oid);
>        
>       -	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
>       +	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
>      -+				      NULL, NULL, NULL);
>      ++				      NULL, NULL, NULL, NULL);
>        
>        	unlink(path);
>        	strbuf_release(&stash_oid);
>      @@ sequencer.c: int apply_autostash(const char *path)
>        int apply_autostash_oid(const char *stash_oid)
>        {
>       -	return apply_save_autostash_oid(stash_oid, 1);
>      -+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
>      ++	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
>        }
>        
>        static int apply_save_autostash_ref(struct repository *r, const char *refname,
>       -				    int attempt_apply)
>       +				    int attempt_apply,
>       +				    const char *label_ours, const char *label_theirs,
>      -+				    const char *label_base)
>      ++				    const char *label_base,
>      ++				    const char *stash_msg)
>        {
>        	struct object_id stash_oid;
>        	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
>      @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
>        	oid_to_hex_r(stash_oid_hex, &stash_oid);
>       -	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
>       +	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
>      -+				       label_ours, label_theirs, label_base);
>      ++				       label_ours, label_theirs, label_base,
>      ++				       stash_msg);
>        
>        	refs_delete_ref(get_main_ref_store(r), "", refname,
>        			&stash_oid, REF_NO_DEREF);
>      @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
>        int save_autostash_ref(struct repository *r, const char *refname)
>        {
>       -	return apply_save_autostash_ref(r, refname, 0);
>      -+	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
>      ++	return apply_save_autostash_ref(r, refname, 0,
>      ++					NULL, NULL, NULL, NULL);
>        }
>        
>        int apply_autostash_ref(struct repository *r, const char *refname)
>        {
>       -	return apply_save_autostash_ref(r, refname, 1);
>      -+	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
>      ++	return apply_save_autostash_ref(r, refname, 1,
>      ++					NULL, NULL, NULL, NULL);
>       +}
>       +
>       +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
>       +				    const char *label_ours, const char *label_theirs,
>      -+				    const char *label_base)
>      ++				    const char *label_base,
>      ++				    const char *stash_msg)
>       +{
>       +	return apply_save_autostash_ref(r, refname, 1,
>      -+					label_ours, label_theirs, label_base);
>      ++					label_ours, label_theirs, label_base,
>      ++					stash_msg);
>        }
>        
>        static int checkout_onto(struct repository *r, struct replay_opts *opts,
>      @@ sequencer.h: int save_autostash_ref(struct repository *r, const char *refname);
>        int apply_autostash_ref(struct repository *r, const char *refname);
>       +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
>       +				    const char *label_ours, const char *label_theirs,
>      -+				    const char *label_base);
>      ++				    const char *label_base,
>      ++				    const char *stash_msg);
>        
>        #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>        #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  4:  97a5d87c81 ! 4:  911e520431 checkout: -m (--merge) uses autostash when switching branches
>      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>       +			strbuf_addf(&autostash_msg,
>       +				    "autostash while switching to '%s'",
>       +				    new_branch_info->name);
>      -+			create_autostash_ref_silent_with_msg(the_repository,
>      -+							    "CHECKOUT_AUTOSTASH_HEAD",
>      -+							    autostash_msg.buf);
>      ++			create_autostash_ref_with_msg_silent(the_repository,
>      ++						   "CHECKOUT_AUTOSTASH_HEAD",
>      ++						   autostash_msg.buf);
>       +			created_autostash = 1;
>       +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>       +		}
>      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>        }
>       
>        ## sequencer.c ##
>      -@@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>      - static void create_autostash_internal(struct repository *r,
>      - 				      const char *path,
>      - 				      const char *refname,
>      -+				      const char *message,
>      - 				      bool silent)
>      - {
>      - 	struct strbuf buf = STRBUF_INIT;
>      -@@ sequencer.c: static void create_autostash_internal(struct repository *r,
>      - 		struct object_id oid;
>      - 
>      - 		strvec_pushl(&stash.args,
>      --			     "stash", "create", "autostash", NULL);
>      -+			     "stash", "create",
>      -+			     message ? message : "autostash", NULL);
>      - 		stash.git_cmd = 1;
>      - 		stash.no_stdin = 1;
>      - 		strbuf_reset(&buf);
>      -@@ sequencer.c: static void create_autostash_internal(struct repository *r,
>      - 
>      - void create_autostash(struct repository *r, const char *path)
>      - {
>      --	create_autostash_internal(r, path, NULL, false);
>      -+	create_autostash_internal(r, path, NULL, NULL, false);
>      - }
>      - 
>      - void create_autostash_ref(struct repository *r, const char *refname)
>      - {
>      --	create_autostash_internal(r, NULL, refname, false);
>      -+	create_autostash_internal(r, NULL, refname, NULL, false);
>      - }
>      - 
>      - void create_autostash_ref_silent(struct repository *r, const char *refname)
>      - {
>      --	create_autostash_internal(r, NULL, refname, true);
>      -+	create_autostash_internal(r, NULL, refname, NULL, true);
>      -+}
>      -+
>      -+void create_autostash_ref_silent_with_msg(struct repository *r,
>      -+					  const char *refname,
>      -+					  const char *message)
>      -+{
>      -+	create_autostash_internal(r, NULL, refname, message, true);
>      - }
>      - 
>      - static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>      - 				    const char *label_ours, const char *label_theirs,
>      --				    const char *label_base)
>      -+				    const char *label_base,
>      -+				    const char *stash_msg)
>      - {
>      - 	struct child_process child = CHILD_PROCESS_INIT;
>      - 	int ret = 0;
>       @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>      - 		strvec_push(&store.args, "stash");
>      - 		strvec_push(&store.args, "store");
>      - 		strvec_push(&store.args, "-m");
>      --		strvec_push(&store.args, "autostash");
>      -+		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
>      - 		strvec_push(&store.args, "-q");
>        		strvec_push(&store.args, stash_oid);
>        		if (run_command(&store))
>        			ret = error(_("cannot store %s"), stash_oid);
>      @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
>        	}
>        
>        	return ret;
>      -@@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
>      - 	strbuf_trim(&stash_oid);
>      - 
>      - 	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
>      --				      NULL, NULL, NULL);
>      -+				      NULL, NULL, NULL, NULL);
>      - 
>      - 	unlink(path);
>      - 	strbuf_release(&stash_oid);
>      -@@ sequencer.c: int apply_autostash(const char *path)
>      - 
>      - int apply_autostash_oid(const char *stash_oid)
>      - {
>      --	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
>      -+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
>      - }
>      - 
>      - static int apply_save_autostash_ref(struct repository *r, const char *refname,
>      - 				    int attempt_apply,
>      - 				    const char *label_ours, const char *label_theirs,
>      --				    const char *label_base)
>      -+				    const char *label_base,
>      -+				    const char *stash_msg)
>      - {
>      - 	struct object_id stash_oid;
>      - 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
>      -@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
>      - 
>      - 	oid_to_hex_r(stash_oid_hex, &stash_oid);
>      - 	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
>      --				       label_ours, label_theirs, label_base);
>      -+				       label_ours, label_theirs, label_base,
>      -+				       stash_msg);
>      - 
>      - 	refs_delete_ref(get_main_ref_store(r), "", refname,
>      - 			&stash_oid, REF_NO_DEREF);
>      -@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
>      - 
>      - int save_autostash_ref(struct repository *r, const char *refname)
>      - {
>      --	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
>      -+	return apply_save_autostash_ref(r, refname, 0,
>      -+					NULL, NULL, NULL, NULL);
>      - }
>      - 
>      - int apply_autostash_ref(struct repository *r, const char *refname)
>      - {
>      --	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
>      -+	return apply_save_autostash_ref(r, refname, 1,
>      -+					NULL, NULL, NULL, NULL);
>      - }
>      - 
>      - int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
>      - 				    const char *label_ours, const char *label_theirs,
>      --				    const char *label_base)
>      -+				    const char *label_base,
>      -+				    const char *stash_msg)
>      - {
>      - 	return apply_save_autostash_ref(r, refname, 1,
>      --					label_ours, label_theirs, label_base);
>      -+					label_ours, label_theirs, label_base,
>      -+					stash_msg);
>      - }
>      - 
>      - static int checkout_onto(struct repository *r, struct replay_opts *opts,
>      -
>      - ## sequencer.h ##
>      -@@ sequencer.h: void commit_post_rewrite(struct repository *r,
>      - void create_autostash(struct repository *r, const char *path);
>      - void create_autostash_ref(struct repository *r, const char *refname);
>      - void create_autostash_ref_silent(struct repository *r, const char *refname);
>      -+void create_autostash_ref_silent_with_msg(struct repository *r,
>      -+					  const char *refname,
>      -+					  const char *message);
>      - int save_autostash(const char *path);
>      - int save_autostash_ref(struct repository *r, const char *refname);
>      - int apply_autostash(const char *path);
>      -@@ sequencer.h: int apply_autostash_oid(const char *stash_oid);
>      - int apply_autostash_ref(struct repository *r, const char *refname);
>      - int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
>      - 				    const char *label_ours, const char *label_theirs,
>      --				    const char *label_base);
>      -+				    const char *label_base,
>      -+				    const char *stash_msg);
>      - 
>      - #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>      - #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>       
>        ## t/t3420-rebase-autostash.sh ##
>       @@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {
