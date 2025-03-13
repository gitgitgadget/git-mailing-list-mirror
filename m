Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2EBA53
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850205; cv=none; b=fq5c1c+RKP1z64RvalVd5kltyoCRpj7jeVKHtsJoMrWvwZrSNpuPNM8LbrLZkNcfwTK+850b5n2GiJhWwrG3fKPv3lgrW2I5pbIQwpAWG00oVrK8OcyMP2/g88aU8Jv/saetSuaU5Q9MWvM236Kieinlt1H9G6Uywb9tGslIukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850205; c=relaxed/simple;
	bh=EdT8Ea4zSH5KnwldK1Rul4u8L7vedbUgILUunSGqQMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tsb5oGoa08AH98tuEwEIu8ElVqoDo7xE+8HmoQjE1dmLXWBRQuO2HqFueXE9SzzzvpS29kkQC6hCkRRgNIaS8TyiOgn8OQ6cCNR5PiHDtdOlWZuaywVAkAD74eVQxNRCCPTteckxQVifLYDQKG1URhND4bPIxiTspzsTHcdQ4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pAPuEOyi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wLpLIoRx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pAPuEOyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wLpLIoRx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 71FC21382DC7;
	Thu, 13 Mar 2025 03:16:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 13 Mar 2025 03:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741850201; x=1741936601; bh=pcPtg1VMaw
	oad+Nmd1CjAkSiVfQ0nSeUvo2vkT760d8=; b=pAPuEOyi4XQQLu02GInNFlQoit
	gzMIjQmNC2hNVB7E4gcIm/1wuVb3XYpTc/ed/HyJdNp8axiWdTOfV41f5e7frvxr
	5LMl7g515/hyT07BpE61z2zrTYROVAaM/2MkXVApyWc2AeKwNaQC+h3o+kxtJjtD
	S9l4WRlrPN0qqBvhUBHxGoPh5Q1DRuPKdhFwDIhz2j9NdLcJPKwIdOum4sOaFRiv
	XKfeAUTGDOzHlP0UjYuUumot/MpspP6GRfDQx9Y0FXTLq4b7NPtVqIoW8B6crnsJ
	kL7kQFpkRCm7dMGJU65zaUSyPQS954OS9b0GtvXWmgoCJ75mzvm1DJs+qgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741850201; x=1741936601; bh=pcPtg1VMawoad+Nmd1CjAkSiVfQ0nSeUvo2
	vkT760d8=; b=wLpLIoRxh05vaGIYaFixhfFMvZvY9poIgKypLdqzsL1oLmmRdfn
	sevAcPJyFefznGMITwHYUKqTjOTJoqNrp7dY/+B58j+PDmNnMdAF+C1porsiRDJ6
	Mt9Abbjbiv0Wd71BawnJj3Q4YYjP5sSSX39dcSh4GJQVgn0sPbn+EQrVQcPgyO+Z
	B5UEeM5MNbHzE+QCLA2o4HuHCiMaeS5UFgWhKRAtmjecEwdtqUXbxRL4mAf8XPD5
	MoPW8aza6iE04LvdvBZtPMz2ae8aAqT4vBSvzr/aAxCKvSM/2/vYyBYLgZRfRm6s
	fLQQSx0dk1SbnnYdGmwrp+y2ixS8+F4UtNw==
X-ME-Sender: <xms:WYbSZ_Yw0y6KoXmfWXnOVB76GRo0dACS9HZB8WmVNLEg3PMFm0TPhw>
    <xme:WYbSZ-b4pmzPOmCNh6eMGa4JyNwYxf0g96ujdGO-1FYA_cGA4MoMJcnYM9enP-ZlJ
    wZzSi9_Dex85ATmtg>
X-ME-Received: <xmr:WYbSZx_2HibJpqD8XPh-VTf69Rj6fbPWJBcQ6MU64mpH3ZIiAs0Jijg54G-lOc1-5SH6pSRFV-GZoGnLsqCEgIAp-ZFAg4rtXejYV0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhrghtvggrrh
    hnrghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WYbSZ1oRxhenfMAuyPbWblkt5V1_CKYKAYg5jdWtQoN4iDFMBYBZfQ>
    <xmx:WYbSZ6oDKFpyTupfn9HPZ_7K6Ir4NGCDEOP5vklFZpXvvWPwIKUWKQ>
    <xmx:WYbSZ7Tn8qOOaYJ3t2UNPNV2cq245--oJSs48EIhkDQyQJmNnFvJOQ>
    <xmx:WYbSZyrxJS9bionrRLT1nnxy89fEr1aBwnXKjuXUmxs6Jq1Sg9AQ4A>
    <xmx:WYbSZ9UP5S5SusR3pup_ckj_qMpW27Zw35yJhPGCMBRo-ka1SerbpYSe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 03:16:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] rm: fix sign comparison warnings
In-Reply-To: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com> (Arnav Bhate's
	message of "Thu, 13 Mar 2025 01:49:08 +0530")
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
Date: Thu, 13 Mar 2025 00:16:39 -0700
Message-ID: <xmqqy0x9s8mg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnav Bhate <bhatearnav@gmail.com> writes:

>  static int get_ours_cache_pos(const char *path, int pos)
>  {
> -	int i = -pos - 1;
> +	/*
> +	 * This function is only called when pos < 0, so -pos - 1 is
> +	 * greater than or equal to 0, so it can be safely be stored in
> +	 * an unsigned int.
> +	 */
> +	unsigned int i = -pos - 1;

"Can be safely stored", sure.

But so is "int i" perfectly adequate to hold such a value, no?

This is one of the many instances that demonstrate why the
"-Wsign-compare" warning is of dubious value, and invites worse code
than necessary.

> @@ -58,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
>  			      int *errs)
>  {
>  	if (files_list->nr) {
> -		int i;
> +		unsigned int i;
>  		struct strbuf err_msg = STRBUF_INIT;
>  
>  		strbuf_addstr(&err_msg, main_msg);
> @@ -271,6 +275,7 @@ int cmd_rm(int argc,
>  {
>  	struct lock_file lock_file = LOCK_INIT;
>  	int i, ret = 0;
> +	unsigned int j;
>  	struct pathspec pathspec;
>  	char *seen;
>  
> @@ -314,8 +319,8 @@ int cmd_rm(int argc,
>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>  		ensure_full_index(the_repository->index);
>  
> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
> -		const struct cache_entry *ce = the_repository->index->cache[i];
> +	for (j = 0; j < the_repository->index->cache_nr; j++) {
> +		const struct cache_entry *ce = the_repository->index->cache[j];
>  
>  		if (!include_sparse &&
>  		    (ce_skip_worktree(ce) ||
