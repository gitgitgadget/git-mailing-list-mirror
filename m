Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756932692D
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763071642; cv=none; b=iTKUqSKqvb4q0Bu8EdrWW9oUhLMyR2l89J2hNtJ3+uYJhuKRSylzBgbr1U0WL+nOdgsa/53/YijFaQqLNV/NiYNLjBdHXjD9CMHAkvHC67/+UjNFgwdBpX0Fk1SLPG2N8sBtNd7Y9m7mn1kLLtDPMYfC2Ng/n58zBtHRNyZyZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763071642; c=relaxed/simple;
	bh=AuFlP1LdTs2fuvlQyXb/O5iwfBj5sDEsVuFnWJPsylQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gv+TXPNof9jWcL8JpiL91u2rnS4gF7JXu2jRgJQlLcljYniUdV5VVE7rRBdO7KvG3khERZh1XgN3IM2z8hFnOJG81NBvDjnupRAHmPygC3RwwczcVPCziAgN15o7NZIbTBTZrSPitp1QpDpqBa2dOMW0SmPAYzQaYoQGXuEoXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZL+Q4tau; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAg+L6i/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZL+Q4tau";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAg+L6i/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 916581400134;
	Thu, 13 Nov 2025 17:07:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 13 Nov 2025 17:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763071638; x=1763158038; bh=HIrfvsY1Zc
	CK+aNqLT08OUtjor/TNcxOP0GiYLPxTdg=; b=ZL+Q4tauToLZu/VvBljdVj1TPP
	0v1j43S1OXKxe/Lr/wA0Uhwqe3MLKCxGWTaJ3XALefDXFucjRY9y1lMuBUwPzkKV
	xugLXgvgQK4gBGUSBRlastqShmx0UqrHSocJzyOhQx2rzbmHGdupmWNXdsTXjiuX
	vTTJq67SJDWrre0PHKQU32eoUsLqCB+um4Mm7zNMUxxOcLSC8O+DVz6jixlM5u8U
	c3yg2mnWwjKCyMz4gfn+ak3dnDEMh+XbRMTC38J0nbkGyfzasBWY74v/D4TWFNhZ
	YdZwJNEBUwTp4KWTZRIm4Rqfz9HU5jig5baqyT4LUhQ9chMVA6Rq/E65V7sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763071638; x=1763158038; bh=HIrfvsY1ZcCK+aNqLT08OUtjor/TNcxOP0G
	iYLPxTdg=; b=VAg+L6i/HLO2sT/P5ztfjE/LjvLzsyyP9KUiz7fEROosZU6X06Z
	P98czr1zQeNlA8ykelIMYgdrrl3qPZP2QluD2TO0EsGey+IoT8gjaYyM2GmCz6kV
	dbUVwLKgIbQ6ioCkvc/2Zqv6nchSFchYzIytVxjCLFZMgYQZjakEbpkje2eco8t0
	9b6DVfKqdDwZbWL900E+cHMUnvIoRvRvquiIge/8/gNWWwHnv19BbPSOSqXBXl2z
	vYUXu0etxfi5yKEg9RTeqxZ/Vh9b8Lid5tClY4imgK3QQ+OdkxCuGeOEYW3UQ1Zb
	BS/uQmQCN/ZztpAacSBqDbI0NN3bcDgpJBw==
X-ME-Sender: <xms:llYWaWl6n7ccD24TjLvNxciZZmzA-nWLgMfjSwdwGvOBpxF0YJa4EA>
    <xme:llYWaQF5e1zZkhh6q1w-Be09X--HiZHCtqNKXbaN4J7r3JsJdDRIgPD-GJwWdlMn8
    MslOONawnk1GYtS6U3w5TGwUQhycU7VGEx6EK162ZWoQ7dHLle_zQ>
X-ME-Received: <xmr:llYWaW5HeaUT_H_9Y7vmLL48HjNMrscVc4NdmZk9xE8J9IaaBkIl8oXsCeKblcPyJcMRklqsYBPYGX6C7fmNxYujXlg9xqYxz1Xi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdefleffjeeifeefffeltefftdelhfejkeevkedufffhgffhfeekvdelieeg
    vdeunecuffhomhgrihhnpegruggurdgtfidptghhvggtkhhouhhtrdgtfidptghomhhmih
    htrdgtfidprhgvrgguqdgtrggthhgvrdgtfienucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghmfihilhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghlrghushdr
    shgthhhnvghiuggvrhesvghfihgtohguvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:llYWaQms5za_YhPczUOvJDp9k0sVf8Zn2lWT4beeOhyCtVbIvWgBQA>
    <xmx:llYWaToqNTPipoYZkBT2MiMMvYyvFbyHBOSjBAnXxkR5NY3garm3KA>
    <xmx:llYWaXt2WB0Dk8F-O5uH9lOmh3uUwsTOn2qMynKSEO02klcZm1WY7g>
    <xmx:llYWaQFQW1AKPABcgZV2AvgyUqoRrM_tzgRZ2TssLwNfkQ9--sj2eg>
    <xmx:llYWafQpwVri1JVk8fQ_TZ1pLWjoNiV0OVgX6WskXewS9aNvOec6gvyW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 17:07:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Brandon Williams <bmwill@google.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Claus Schneider
 <claus.schneider@eficode.com>
Subject: Re: [PATCH v2 1/5] read-cache: update add_files_to_cache take param
 include_ignored_submodules
In-Reply-To: <5796009122c6ab573a2961db598bbd33727a6ac0.1763057433.git.gitgitgadget@gmail.com>
	(Claus Schneider via GitGitGadget's message of "Thu, 13 Nov 2025
	18:10:29 +0000")
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<5796009122c6ab573a2961db598bbd33727a6ac0.1763057433.git.gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 14:07:16 -0800
Message-ID: <xmqq1pm1lh7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
>
> The include_ignored_submodules parameter is added to the function
> add_files_to_cache for usage of explicit updating the index for the updated
> submodule using the explicit patchspec to the submodule.
>
> Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> ---

I still do not know enough if the overall idea of this topic is a
good idea, but let me regiew the code change at the mechanical level
(i.e., what needs fixing if these changes are good things to have).

> diff --git a/builtin/add.c b/builtin/add.c
> index 0235854f80..6d11382f33 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -233,6 +233,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
>  static int verbose, show_only, ignored_too, refresh_only;
>  static int ignore_add_errors, intent_to_add, ignore_missing;
>  static int warn_on_embedded_repo = 1;
> +static int include_ignored_submodules;
>  
>  #define ADDREMOVE_DEFAULT 1
>  static int addremove = ADDREMOVE_DEFAULT;
> @@ -271,6 +272,7 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>  	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
>  	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
> +    OPT_BOOL(0, "include-ignored-submodules", &include_ignored_submodules, N_("add submodules even if they has configuration ignore=all")),

Wrong indentation.  Also, perhaps wrap this new line that is overly
long (*WITHOUT* rewrapping existing overly long lines)?

>  			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
> -					   0);
> +					   0, 0 );

Our coding style does not allow an extra space after "(" or before ")".

> diff --git a/read-cache-ll.h b/read-cache-ll.h
> index 71b49d9af4..2c8b4b21b1 100644
> --- a/read-cache-ll.h
> +++ b/read-cache-ll.h
> @@ -481,7 +481,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
>  
>  int add_files_to_cache(struct repository *repo, const char *prefix,
>  		       const struct pathspec *pathspec, char *ps_matched,
> -		       int include_sparse, int flags);
> +		       int include_sparse, int flags, int ignored_too );

I am not sure if adding an extra parameter randomly like this is a
good idea.  Existing include_sparse is already a single bit that is
stuffed in an int, so it might make sense to change it into a set of
bits (i.e., "unsigned int") in one preliminary patch, and then your
change can borrow another bit in the same flag word.

See the attached patch (not even compile tested, though) for an
illustration of what such a "preliminary clean-up" step to get rid
of the extra include_sparse parameter may look like.

> +++ b/read-cache.c
> @@ -3880,9 +3880,12 @@ void overlay_tree_on_index(struct index_state *istate,
>  
>  struct update_callback_data {
>  	struct index_state *index;
> +	struct repository *repo;
> +	struct pathspec *pathspec;
>  	int include_sparse;
>  	int flags;
>  	int add_errors;
> +	int include_ignored_submodules;
>  };
>  
>  static int fix_unmerged_status(struct diff_filepair *p,
> @@ -3924,7 +3927,48 @@ static void update_callback(struct diff_queue_struct *q,
>  		default:
>  			die(_("unexpected diff status %c"), p->status);
>  		case DIFF_STATUS_MODIFIED:
> -		case DIFF_STATUS_TYPE_CHANGED:
> +		case DIFF_STATUS_TYPE_CHANGED: {
> +			struct stat st;
> +			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory

/* Our single liner comment should look like this, not with double-slashes */

The fact that this block has to be so deeply indented strongly
indicates that it should probably become a separate helper function.

I'll stop here for now.



 builtin/add.c      | 8 ++++----
 builtin/checkout.c | 3 +--
 builtin/commit.c   | 2 +-
 read-cache-ll.h    | 6 +++++-
 read-cache.c       | 8 +++-----
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git c/builtin/add.c w/builtin/add.c
index 32709794b3..49d0199c0b 100644
--- c/builtin/add.c
+++ w/builtin/add.c
@@ -384,7 +384,7 @@ int cmd_add(int argc,
 	int exit_status = 0;
 	struct pathspec pathspec;
 	struct dir_struct dir = DIR_INIT;
-	int flags;
+	unsigned flags;
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
@@ -485,7 +485,8 @@ int cmd_add(int argc,
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0) |
+		 (include_sparse ? ADD_CACHE_INCLUDE_SPARSE : 0));
 
 	if (repo_read_index_preload(repo, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
@@ -583,8 +584,7 @@ int cmd_add(int argc,
 		exit_status |= renormalize_tracked_files(repo, &pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(repo, prefix,
-						  &pathspec, ps_matched,
-						  include_sparse, flags);
+						  &pathspec, ps_matched, flags);
 
 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
 	    report_path_error(ps_matched, &pathspec))
diff --git c/builtin/checkout.c w/builtin/checkout.c
index f9453473fe..766a8e3b66 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -898,8 +898,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					   0);
+			add_files_to_cache(the_repository, NULL, NULL, NULL, 0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git c/builtin/commit.c w/builtin/commit.c
index 0243f17d53..6e42534977 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -455,7 +455,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, ps_matched, 0, 0);
+				   &pathspec, ps_matched, 0);
 		if (!all && report_path_error(ps_matched, &pathspec))
 			exit(128);
 
diff --git c/read-cache-ll.h w/read-cache-ll.h
index 71b49d9af4..c9311f845b 100644
--- c/read-cache-ll.h
+++ w/read-cache-ll.h
@@ -390,11 +390,15 @@ int remove_index_entry_at(struct index_state *, int pos);
 
 void remove_marked_cache_entries(struct index_state *istate, int invalidate);
 int remove_file_from_index(struct index_state *, const char *path);
+
+/* add_files_to_cache() flags */
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_INCLUDE_SPARSE 32
+
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
@@ -481,7 +485,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags);
+		       unsigned flags);
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git c/read-cache.c w/read-cache.c
index 032480d0c7..f32b642446 100644
--- c/read-cache.c
+++ w/read-cache.c
@@ -3881,8 +3881,7 @@ void overlay_tree_on_index(struct index_state *istate,
 
 struct update_callback_data {
 	struct index_state *index;
-	int include_sparse;
-	int flags;
+	unsigned flags;
 	int add_errors;
 };
 
@@ -3917,7 +3916,7 @@ static void update_callback(struct diff_queue_struct *q,
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
 
-		if (!data->include_sparse &&
+		if (!(data->flags & ADD_CACHE_INCLUDE_SPARSE) &&
 		    !path_in_sparse_checkout(path, data->index))
 			continue;
 
@@ -3946,7 +3945,7 @@ static void update_callback(struct diff_queue_struct *q,
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags)
+		       unsigned flags)
 {
 	struct odb_transaction *transaction;
 	struct update_callback_data data;
@@ -3954,7 +3953,6 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 
 	memset(&data, 0, sizeof(data));
 	data.index = repo->index;
-	data.include_sparse = include_sparse;
 	data.flags = flags;
 
 	repo_init_revisions(repo, &rev, prefix);
