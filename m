Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B721D59B
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551142; cv=none; b=Y73rMjCvJO7UBtru20R2jxMNECWiWLq3yzwmcpBaNxE9Y7iFjupzrecKJRCLhgXqKR9q5Hl1YQtJcgVit9D7s1aO1fbCxbjUhJYTman5vCGKiDQlRHKkGAtt85G/0c14bb07B31r4aombQfNwPyEzzmgWj7cmjQLV9HPeKrydYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551142; c=relaxed/simple;
	bh=wCeUwfMF8T7dppbcIAXVcMjVwyzyE7FiVOEB6eOkoPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SsVXj4GcamIbwceNoazusJms0EZlQA2r2l6xpFE6CLwiD21dD4hJlrRUoDxvBLSjvwDLL61QuMCNLe0+plhHyPJf3lfHKAhH4xhCSDXTDoPdVF6gx9ao0oV3xqR7s2B9W5iDMA6rPSKpwEUuv06BXJRLndiq4EDA7AN0HtsZkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kl+EXKrV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GO8V3Hax; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kl+EXKrV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GO8V3Hax"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id DEC611D0019A;
	Mon, 18 Aug 2025 17:05:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 18 Aug 2025 17:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755551138; x=1755637538; bh=S0kyMx0LZ+
	4gj110mP73vQegerlSvreprXLIeIlQ3h0=; b=kl+EXKrVodJ+x9/yciEPRK642L
	HiwDyGelQpdtPlKtwKDqgOsDZ9z1Gqq6x8KccZ5rUc58281ZF2sa3ij0MFNdmluw
	P7VOmSjeVa/O4d532bM2XLe6sZL5ELDqjLru0rHNLDrK7DqPmADOa1IWoDzjVY1a
	Up+V3uZBSE84D+7hs8bVZIgyTQX9BJ2I0C3WXOPjztm1T1K7IaLKM/IHJZHQCTi0
	4xdWeZZf+U/201MrAs2kw47yK1jWLmc1xY6qah2FVYSOWWe6WhOGBso8ZagX8O/O
	zF4MQek2q5+Ge20hZFFzw6iTgUuDbWBsIBZD9nH6G4H8/ZPczm9ailQlQ/EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755551138; x=1755637538; bh=S0kyMx0LZ+4gj110mP73vQegerlSvreprXL
	IeIlQ3h0=; b=GO8V3HaxtiVAZmGfNUeLl7VtmD74UF0mspChvMAl1ZFMl0m0JpB
	ECr8BbJvfKDIPEdUo/imPAo4YFBdaZlLGRPCmnaSrtGaG+qDtR/rP5WzJOxuwkLh
	3yEKtXLwwkZHEHfe/XISzFK4F7CUztvo209e/KFr2vqmp6vm0Y0DgFRVW2m8Np4R
	28AlKI5bgm4iymPAM18eXWhH3IaU5CQHclkyqebLQkvEdImB8uFXDG5jJD1EStoI
	WYVYtvg2zW0uex+paN9NT1n3wPHrqyK0FNhmy9b4uo+/RAo5PcBks4kOQkIygeH9
	yulm1ybaq+iXsQPch9SrTaot9Z44OnR4UtA==
X-ME-Sender: <xms:oZWjaIWpbN8f4a3WZ6ailfBCXUZPohiNTbttaWPeljPef-sHqWyR-A>
    <xme:oZWjaNQZ3exe6pnYh_4SWuUMdrPhrVmt08dehIoyUd2WZtujsIVohyHdWyoA_2RdJ
    igWky5_RMqjQjqmIw>
X-ME-Received: <xmr:oZWjaKlLfW6WWcXP15MgQq75kjUtPMeB_uiBB37NJf_61FbcSbpvqP84N1MkSKiS0RQExK14Av4ra-J6IhIrPAS0dWezHTIfJ0M0u60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohep
    phhrohhphhgvtghhvghnghesshhtuhdrphhkuhdrvgguuhdrtghnpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:oZWjaL5sbD2kRyVWjJLTjmKiRuiQBUVrsr_FA2JkvQOoNd7QnLTDxw>
    <xmx:oZWjaIhc3wdUAYHaCYe-j1ODxx6Cg_ftcbfRZugj_EbHFjsON3zu8w>
    <xmx:oZWjaAGRBdO4DjPADYTiqXh6rdQYAAxfWX-va3BBomTqx_ATPe-9_w>
    <xmx:oZWjaGRhHviA8lO7PWsNU0ryu1kgrAya9HF3r9C9QwvTIWwegGQ44g>
    <xmx:opWjaFu-K4b7QmL1j_yY8Ar9DP2Vog4j9Ak50SgoopoueI9TJSBJ0r0H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 17:05:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  phillip.wood@dunelm.org.uk,  Cheng
 <prophecheng@stu.pku.edu.cn>,  git@vger.kernel.org
Subject: Re: [PATCH 1/5] describe: pass oid struct by const pointer
In-Reply-To: <20250818205929.GA1024556@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Aug 2025 16:59:29 -0400")
References: <20250818205812.GA1018043@coredump.intra.peff.net>
	<20250818205929.GA1024556@coredump.intra.peff.net>
Date: Mon, 18 Aug 2025 14:05:36 -0700
Message-ID: <xmqqfrdoibmn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We pass a "struct object_id" to describe_blob() by value. This isn't
> wrong, as an oid is composed only of copy-able values. But it's unusual;
> typically we pass structs by const pointer, including object_ids. Let's
> do so.
>
> It similarly makes sense for us to hold that pointer in the callback
> data (rather than yet another copy of the oid).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not strictly related, but I noticed while in the area and remembered a
> recent discussion in this direction.

Thanks for making this part of the code less odd.

>  builtin/describe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index d7dd8139de..383d3e6b9a 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -490,7 +490,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
>  
>  struct process_commit_data {
>  	struct object_id current_commit;
> -	struct object_id looking_for;
> +	const struct object_id *looking_for;
>  	struct strbuf *dst;
>  	struct rev_info *revs;
>  };
> @@ -505,7 +505,7 @@ static void process_object(struct object *obj, const char *path, void *data)
>  {
>  	struct process_commit_data *pcd = data;
>  
> -	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
> +	if (oideq(pcd->looking_for, &obj->oid) && !pcd->dst->len) {
>  		reset_revision_walk();
>  		describe_commit(&pcd->current_commit, pcd->dst);
>  		strbuf_addf(pcd->dst, ":%s", path);
> @@ -514,7 +514,7 @@ static void process_object(struct object *obj, const char *path, void *data)
>  	}
>  }
>  
> -static void describe_blob(struct object_id oid, struct strbuf *dst)
> +static void describe_blob(const struct object_id *oid, struct strbuf *dst)
>  {
>  	struct rev_info revs;
>  	struct strvec args = STRVEC_INIT;
> @@ -554,7 +554,7 @@ static void describe(const char *arg, int last_one)
>  		describe_commit(&oid, &sb);
>  	else if (odb_read_object_info(the_repository->objects,
>  				      &oid, NULL) == OBJ_BLOB)
> -		describe_blob(oid, &sb);
> +		describe_blob(&oid, &sb);
>  	else
>  		die(_("%s is neither a commit nor blob"), arg);
