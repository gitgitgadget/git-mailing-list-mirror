Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23E288C2D
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774068138; cv=none; b=ZonfutdoPTfxGOyGqljgKl7TdV0TCjE6bWi9Bv6W0fQGhruVYrC+LmCElytGGcQ/7koTRWG3fh86F/7spkSGf67TTakz8JwlNlLleM0rbyzcY6T/VytkcbDcYJOs2nQ7oGJDeTWheMt3rOpiDp15RbM6WpjNTapon4TMekEA25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774068138; c=relaxed/simple;
	bh=6MnO4tyBvtuPaqj54MBSz7MxoH36ybfpbYgq0plmXFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOEeAIrkhjXaE7oSXM3oEFG/O8DpA1p4AG1eHNR/xlk76hH5ylWjCc9Q4aRszrJuDjNAyJ22tVAXnvK0Vb82qSsHJX1INx5BcZC4ZAoqOYohC1ekTlpLUYTHfJcauuWD/JqxbGKgpl3F2AnxOm6KLwwReRdyr+6RYmwyVVgwin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iAywPxu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUvVNltZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iAywPxu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUvVNltZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 581C61D00128;
	Sat, 21 Mar 2026 00:42:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 21 Mar 2026 00:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774068135; x=1774154535; bh=PewfXhwVQl
	IXD5wN68laMTk9qSILbAIC9O3NeUbws7c=; b=iAywPxu7aFilqxdQm1/V2uNfpl
	wnICyxniNqrj8W7C6CNPgdCacs+Gbt5ps5kcRABt2iaTCqNrljEjkKudZmyaJTlt
	I/8veXlbqUIm9M643KZnNt5Fg0VUIQrlfwYEbxvoGK/cbzdiAtK2hcCUINzxQvXo
	s17jVN5AaMeziFrkTS2Grg7O5zIRTVLxW8sCtS8N3k+r9odPRQKCWXrYu2CHNykO
	vfxQHFyHWkCOKt/9nQwGOhvJDE94Eld33P1XuRk03fDXie7ziCp0YsXA+4+yWiCf
	kLK0R5G6OjxfREjPTMbLhoq2NoA9FEAaP25Kr86l7YZV6tb+645UvzqhfSVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774068135; x=1774154535; bh=PewfXhwVQlIXD5wN68laMTk9qSILbAIC9O3
	NeUbws7c=; b=WUvVNltZ+IJBlnOeU7lYDN3ulv8md5uTFxZRU7ZjY2VzxRIlQCc
	qt2o3J53N6I7oBvvmjFwcdko2Ek49G22riD2Ag9i+lCfZ6Db/nPo7VyqO1wXFLbf
	CkjN/8kFNVYkAgAldDzYq9CuxG6cn7Wkg5KbVF8Rp+R9cvGwXsurw8EeF5WZ1qKE
	987KtbHZqY2So+qBH1Hq/rva047gGqLx12AI8fHw2D4os4UXDm7At1OAULaJiahe
	6u09X+q9ysBAeOWjqMnIIWQhIprHUSLZiOk2Ehm8h3bGKAwuk3QND7UXRmGVJG1t
	+w/sOM5T5Q266WmKv4kbCLzJPSUWiAf8W+Q==
X-ME-Sender: <xms:piG-aYiH2_Ko0LXHzeEeQQXFk-Q-yL9Ww-FSc2Afr2jnMDmwItRSfw>
    <xme:piG-ach3rydmNA9W67CKJNueD1lMZes7SYm8zO4S_TV4uG8NVHF8caER92R7BccLU
    ZJhY0t-cvaGR7bcm9a7yeidBeNEkJgWjqjfKmmPLN54EI8Ot4YhsE0>
X-ME-Received: <xmr:piG-aWjaVO0vitM3mvsF7xU1nmBsD6dZNQ84Oya-eQvu-n2Avi9YKoLHKYpA3H_duztux2xFWFtmO98Ntx8GRvSsw-pr-71P0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:piG-aUIrUAawVsZFfxOPjJR20Q42tV81D4KVfW_GL_O4p-HBFwvr8A>
    <xmx:piG-adEQ1Nc4kemdtsizSnRkvZ_d6WTuqZLZJX5KsNvBeekdqDfCrQ>
    <xmx:piG-aQQ3TIHUDcZbdnHwV1tJXdtVA3sc-TWN3ulqtkVmSzPFjmTadQ>
    <xmx:piG-aRdGAq4TVOVpd9iKuTOKVxXM8efoePP9H7c8Ky6md_h1FsEr7w>
    <xmx:pyG-aThTynLMGqGN2NfpnB9Tt3ANcBuxwXO_6Xe4XUBfK3J8BjT6jzkR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 00:42:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  stolee@gmail.com
Subject: Re: [PATCH] backfill: handle unexpected arguments
In-Reply-To: <20260321031643.5185-1-r.siddharth.shrimali@gmail.com> (Siddharth
	Shrimali's message of "Sat, 21 Mar 2026 08:46:43 +0530")
References: <20260321031643.5185-1-r.siddharth.shrimali@gmail.com>
Date: Fri, 20 Mar 2026 21:42:13 -0700
Message-ID: <xmqqtsu9dc9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> git backfill takes no non-option arguments. However, if extra
> arguments are passed with git backfill, parse_options() leaves
> them in argc and the command currently ignores them silently,
> giving the user no indication that something is wrong.

Well written.  If you drop unnecessary "currently", it would be
perfect ;-).

> Add a check after parse_options() to call usage_with_options()
> if any unexpected arguments remain. This prints the correct usage
> and exits with an error, consistent with how other Git commands
> such as git-gc and git-repack handle this situation.

I am not sure if this is a good idea.

When parse_options() finds an unrecognised option, you would get
usage-with-options help, so without explicitly telling the user
"Hey, you have an extra argument that I do not expect at the end of
the command line" and giving only the same usage-with-options help,
the user would not know why they are seeing the help message, as it
is totally unclear what mistake they made in their command line.

"git bugreport" is also a command that does not take any positional
arguments on its command line.  Study how it complains about an
unwanted argument, and follow its example, perhaps?

Thanks.

> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  builtin/backfill.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e9a33e81be..0eb171478a 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -135,6 +135,9 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  
>  	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
>  			     0);
> +	
> +	if (argc)
> +		usage_with_options(builtin_backfill_usage, options);
>  
>  	repo_config(repo, git_default_config, NULL);
