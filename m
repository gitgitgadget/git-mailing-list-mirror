Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214B1A0BCD
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230077; cv=none; b=eyTyhlVt+X196+isP//ml/kkByEJJ139qx1t+LSAmfZLrZ7JAJGVsCbjnq0sRhpMAmxHUdSbv3KpyrtnCWX0II/YobGBpvJFTXU7rLUYpMl5xvOZ3WE491vGrC6u5FcHaNyuHTznW+G/pM2wKwgFSzY5/gTZsm2HUpP3NuLDH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230077; c=relaxed/simple;
	bh=uJeQWcnXHQxNoRB4EfQIHKWYfg7R1thDYtmCg3S2Zds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QMSrmgNdp0FN6uNmRjLNtExhm9U1qX4D+q/fHdHw7XzlcUJJS+lWTi+t+BB+5vFuZ5/sWdTKT6hvlL8WUE7r68BEdu8fTjhc/dFnPwRoeitU5bRtC8xFb2Dw1SIyTTSmBbzeYf0u5iJix/Nt2LcdciboOma1iGRPohDG6jEnE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X+sGrkuW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tNjkIqYr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X+sGrkuW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNjkIqYr"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 26819114019B;
	Mon, 17 Mar 2025 12:47:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 17 Mar 2025 12:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742230074; x=1742316474; bh=E2NTwiT3ih
	ovzv6m4jiM//9KwA8DaLXa2sy4SpzuxxA=; b=X+sGrkuW+AAiWP1FYmJZpIRIeN
	7XyQKM9HSNOZTjSg8dr8/bkq8/qX8OVGB0KSpyS56ymBiAAd2F5ExFtfVGN6lkVb
	dK1FJZhADewy86kTMDwc3feoi28VfS56yrUn6WgvShc0MmB70EVsbgA68CrLg/qZ
	8n4fhe0F1KqSA9YiQmnoy2+lnPf0Xsvcq7W4zvNiPpng6+LiAA++z1oVbHIf8qPB
	LNdtLPJFapZlKC+ujUhsVrwCZJKg6N7oBIcNPoOqzpyfT5nPwSal4dKd9pFL9qsz
	chYyMHlVtOcOQBdcs/Skx+Ib3rq+YO9cJi4PhP1c5gXGTvLEElrThRlooUTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742230074; x=1742316474; bh=E2NTwiT3ihovzv6m4jiM//9KwA8DaLXa2sy
	4SpzuxxA=; b=tNjkIqYrlkEL/v2ewThoBCafFdZ2vK3satIUZDqRRevG9TgD/W9
	7XmmFtzZJiBIXGppkXaKp05lXz7ZGLORC7NtB3oziiENwEAiWVa8Jsi5R5TzGJvx
	BQqisD327P5TPn4PqjJQyyru6vvjlkpGkuZLz8rZoAGFHs7kX+uTbIWILLXYsg07
	TdvzbZ5sXQ+y0Vg5Xizs+t0InGRhf+K9FoHiXugBcBB3d6RPNaufcs6S5JnEMjgl
	zQjHtCJxdJw6HJs6OCAGR5ce+yZCLJ5275SjaqEHsTqq0OixtmGIr45ad94WhzYk
	JBsats9DJCuSddKFG4b93jjcwNBlSm+D16w==
X-ME-Sender: <xms:OVLYZ2P3DRI7KPrlSncnp4p8dc_o0M4XJs6ugcLUqaDJgscbLlNyeA>
    <xme:OVLYZ09jb227myoYJNvr5B_UUpfS2rNhJfPNd7_s-ep5oBRJKDjR_2ugERffpcUsO
    0nuxsKkEneD_Oh6Xg>
X-ME-Received: <xmr:OVLYZ9Sa2rGIL8uxAMq9UypFCPwvNZI87JdhX_s2MKTbV9Q8-GkAM_hzLfH-IjxL96p2PIgLwFYO6mnT-mmKFEVRFpX_xJUi5KSZQqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedttdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhrghtvggrrh
    hnrghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OVLYZ2vQgfkIFXc7H0sZsESJVrUgRdFK22gSxaakPs2jLv32RWsfyA>
    <xmx:OVLYZ-ejbQaJO8eSk9mAn7HeHE6Jx0gVHiOSh3Jm8a_lb_wIhKSckw>
    <xmx:OVLYZ63vyim6kyB6BfI3Uduzy5NNn8LnHY76gUM5IhWFFo8_uZDfKw>
    <xmx:OVLYZy8M14qPwExxLws7PJCwDCin-QiU72vclbR6JyljBJXWyJVesw>
    <xmx:OVLYZ95RBr-bL0qVvvnr5Fw9CfRuW44MiwsY9F_B8z9JBkJE23svUfOD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 12:47:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC PATCH v2] rm: fix sign comparison warnings
In-Reply-To: <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com> (Arnav Bhate's
	message of "Sun, 16 Mar 2025 15:43:03 +0530")
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
	<71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
Date: Mon, 17 Mar 2025 09:47:51 -0700
Message-ID: <xmqq1puvbo3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnav Bhate <bhatearnav@gmail.com> writes:

> -static int get_ours_cache_pos(const char *path, int pos)
> +static int get_ours_cache_pos(const char *path, unsigned int inverted_pos)

This renaming of parameter is not right.  

At this point when the value comes to this function, it *IS* the
position, there is nothing inverted about it.  It points at the
position in the .cache[] array where an cache_entry at a higher
stage would appear.

It is perfectly fine to state that the value that is returned from
index_name_pos() is potentially inverted.  The function is given a
path name (without any stage information) and

 - returns a non-negative number, the position in the .cache[] array,
   where a cache_entry at stage #0 (i.e. an entry for a path that does
   not require conflict resolution), or

 - returns a negative number, when there is no such cache_entry
   exists.  The caller can "invert" the value to recover a position
   in the .cache[] array, where a cache_entry for the path at stage
   #0 _would_ _have_ been found, if existed.  Due to the way the
   cache entries are sorted in the .cache[] array, when you are
   interested in finding cache entries for a path at higher stages,
   like this function is, you can start scanning at this point until
   you see an entry for a different path.

Calling the parameter "pos" is the right thing to do.  The value
used to come here _could_ have been called "inverted", and the
result of (-inverted_pos-1) can be assigned to "pos".  But because
the patch moves the inversion to the caller, what the code in the
while loop sees is no longer "inverted".

>  {
> -	int i = -pos - 1;
> -
> -	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
> -		if (ce_stage(the_repository->index->cache[i]) == 2)
> -			return i;
> -		i++;
> +	while ((inverted_pos < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[inverted_pos]->name, path)) {
> +		if (ce_stage(the_repository->index->cache[inverted_pos]) == 2)
> +			return inverted_pos;
> +		inverted_pos++;
>  	}
>  	return -1;
>  }
> @@ -58,7 +55,7 @@ static void print_error_files(struct string_list *files_list,
>  			      int *errs)
>  {
>  	if (files_list->nr) {
> -		int i;
> +		unsigned int i;
>  		struct strbuf err_msg = STRBUF_INIT;
>  
>  		strbuf_addstr(&err_msg, main_msg);
> @@ -83,7 +80,7 @@ static void submodules_absorb_gitdir_if_needed(void)
>  
>  		pos = index_name_pos(the_repository->index, name, strlen(name));
>  		if (pos < 0) {

Here is where the caller notices that index_name_pos() did not see a
stage #0 entry.  This caller wants to see "ours" entry at stage #2,
so it "inverts" the returned value and asks the helper function if
it sees such an entry in the .cache[] array.

A handful of prerequisite pieces of knowledge to understand this
code are:

 - The index (i.e. the .cache[] array) is sorted by full path name
   (down from the top level of the working tree).

 - The index can have at most one stage #0 entry for each path name.
   When a stage #0 entry exists for a path name, there cannot be
   higher stage entries (the path is called "resolved").

 - The cache entries in the .cache[] array for the same path name
   are sorted by their stage number.

 - There can be at most one stage #2 entry for each path name, which
   are called "ours".  Entries at stage #1 are from common ancestor,
   entries at stage #3 are from "their" tree.  These higher (i.e.
   more than zero) stage entries appear only for "conflicting"
   paths in the .cache[] array.

With the understanding above, you can see why "our" position is
computed only when index_name_pos() returns negative in this hunk.

> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;
>  		}
> @@ -131,7 +128,7 @@ static int check_local_mod(struct object_id *head, int index_only)
>  			 * Skip unmerged entries except for populated submodules
>  			 * that could lose history when removed.
>  			 */
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;

The above hunks are perfectly fine.  

> @@ -314,7 +311,7 @@ int cmd_rm(int argc,
>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>  		ensure_full_index(the_repository->index);
>  
> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
> +	for (unsigned int i = 0; i < the_repository->index->cache_nr; i++) {
>  		const struct cache_entry *ce = the_repository->index->cache[i];
>  
>  		if (!include_sparse &&

OK.

Thanks.
