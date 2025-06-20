Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9412AD16
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455566; cv=none; b=nrKKHHct+FHjoX4ZbsHrWkmrXsUE8uPsnySbuAOjVDgvN28Ts9pkEqSOXg7NmBi5NCEN9p7OAxTG+HcAJBovq27rFtZHz3jbaoDRB9GzVbCP/u4DJT5NN5wvRXNWcEsQq3+JpFgl4cqA562HyfNmnPzgiJzv8KRfgU2c0FyYCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455566; c=relaxed/simple;
	bh=rZlR6dC1lfpm5esHUUH3NJTSCIQqba1aBKHX4zIHEAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dieWX1CmacDDtMZFeQXcXw0ngPjOLWnibYs8s+yASYTI+WxbxwaVw7SubZmk2p40vdLKqDxCUuaKfwHJKRsOJJnDlxY3gpMycGOLaGTHBxj1T0SiTwnaZCGDHg97SuKD1NEfO2cbT7Dgb/kYUwGzPydaNaw4vgS9BiOG687xoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CJxC4Onh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3LlSMRK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CJxC4Onh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3LlSMRK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54225254024D;
	Fri, 20 Jun 2025 17:39:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Jun 2025 17:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750455563; x=1750541963; bh=d7Bba7QlL4
	cHuhiqlzKRUjzya0UTHQExL1g8ILQOZA8=; b=CJxC4OnhnfEgF3PFfEwMJdxQfn
	46/D3lN9lYBi8F0Zyt27srkH1OJkAGxrOGTzqzpfvjnSUhvclrJ1WdK2PiL0N+mp
	OWx75rdoXD/2JwJUtHTq8uaAZQOwWOGy02G6PADJX9Pe+PEOH/rvoYX5sfpgTmRC
	0SMxtvTeCKIGsTtuvvqVPYLjFLKp9X3q4I+88zOKypPaKkfoajU5MmGhqDr17K1X
	ooVOXFIWxdEemXwDSDxd7Hqq4sYKgeHc32dBNPEM2sLjDnGm5Z4ablzHmv4aIPxC
	CWyJgcophyTmX7HY7y5TpGJkiCU4KEhBOebCi2eD2FsF71ZRZtHhGIJ7VZGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750455563; x=1750541963; bh=d7Bba7QlL4cHuhiqlzKRUjzya0UTHQExL1g
	8ILQOZA8=; b=X3LlSMRKVip+3A2xZSsD5dhP7zWn96dzNGEYCZyjrJSZac4JODL
	D5Uyi4tuso/th19g73JYz4LG8YTAiQq+u00SFNwvchcCmaP0FMoAEl38+VBtpxTD
	CYNjnMcupf3TCb2w0JqMDm3D9sFSKJNMs+hK273XfYr8vJiXmHmzSvfApbNrEvYx
	Qb34k+8qpFZvXfF7VN+jcOISSO3U0OQbFtPCqPCVIFOpQBRHfoQg8Ys1OwNrW40k
	smeOTGDcLLaIgLARaH6fpA1SNodHa057RIpv/E9fF3shjh8idXo5rKxPoZqREhCN
	BfwqkHKi5/Q6C/KBXsFpd1xde6s8e8IoXqg==
X-ME-Sender: <xms:C9VVaIuWHayMsSuqAxrzlIzJoph-yawnmACR-cpo0pzbcGtdF8FzKw>
    <xme:C9VVaFcX9HeOUViUdO8hzF4DoH64WBdX-AU_RNuVlxN9bXBeobTmLoo2QCa66ZPPi
    tgMSVgq1_uAPbTtVw>
X-ME-Received: <xmr:C9VVaDxyek04O4z3s-_qW87etmuTvIVXWV_q7yq0aXIUl14-PGnOmq--LAmhjER1JkAnX8ChnmK1HXlkcrS4ZEk99PBnVEigosTV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C9VVaLP395s6HOEnNVjOYBdhp-mJ3MOQi4DYtGqE8QjiWtez7w2C9Q>
    <xmx:C9VVaI8NZwBYLvTYewwIjkcD8UVdwKWLypcr-r0NqW8VJaqsAel4sA>
    <xmx:C9VVaDXcycQ7ao-Dp-5QEaBwY2wsX6Hyaf_rGukvDFbf60YIs3jukw>
    <xmx:C9VVaBfyQ4-RuOGngdt4YgvXCAh6KSddF1TRKcX3EPECcQfCplpuVQ>
    <xmx:C9VVaBKhYbsyJHUKPs5RC_uimarLVNZnhOuwqmfI6G_Snjx6IWqpUi4d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 17:39:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 4/7] repo-info: add the --allow-empty flag
In-Reply-To: <20250619225751.99699-5-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 19 Jun 2025 19:57:48 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-5-lucasseikioshiro@gmail.com>
Date: Fri, 20 Jun 2025 14:39:21 -0700
Message-ID: <xmqq1pre14ae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add a flag --allow-empty, which will force the output data to be empty
> when no field is requested.

I still think we should flip the polarity of the option and give "--all"
to iterate over all variables, and by default show nothing.

> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 3 +++
>  t/t1900-repo-info.sh | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index cd7c110f47..6499be0eae 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -68,9 +68,12 @@ int cmd_repo_info(int argc,
>  	};
>  	struct repo_info repo_info;
>  	char *format = NULL;
> +	int allow_empty = 0;
>  	struct option options[] = {
>  		OPT_STRING(0, "format", &format, N_("format"),
>  			   N_("output format")),
> +		OPT_BOOL(0, "allow-empty", &allow_empty,
> +			 "when set, it will use an empty set of fields if no field is requested"),
>  		OPT_END()
>  	};
>  
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 998c835795..db4a6aad17 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -15,11 +15,12 @@ test_lazy_prereq PERLJSON '
>  '
>  
>  test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
> -	git repo-info --format=json >output &&
> +	git repo-info --allow-empty --format=json >output &&
>  	test_line_count = 2 output
>  '
> +
>  test_expect_success 'plaintext: returns empty output with allow-empty' '
> -	git repo-info --format=plaintext >output &&
> +	git repo-info --allow-empty --format=plaintext >output &&
>  	test_line_count = 0 output
>  '
