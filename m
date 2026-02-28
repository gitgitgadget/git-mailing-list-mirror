Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B138DF9
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772237349; cv=none; b=q35BcYdyVrMYn2/lnNVNO65pteRTD/y+PNqGtkTvS2sPOUOJzYnYjw/s00KSqJG+hs/HEZ3nad6hZPmJUYIUDnIPmPkFAty2EB96LQlTmeYWwS+nmHjaWEmoelBamEA0X9XR2zzA6cwtBmQqpDRAb9anKj+OtbR3/D9k75EWonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772237349; c=relaxed/simple;
	bh=1KTbR0/tmc9eh36wPXffxhdBUhadB6RFy6cnUucnj6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSmuJRofh2dv1Om/H1CzHMITAvORVWPvNg+oPloPFve2w8raleSFuyKZvrKwopF2rOLOKDQBvRduN/LMrFXRqKOmTBbyOStL9BwGMV33CqPDDqv0OEc0hrnLDxhz/0qY08WDxSPt7IO2vI0aHBsgDC/4+4KAN5vV64ZY67UCkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VPmtKeoA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h98HQnkZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VPmtKeoA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h98HQnkZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 73111EC05DE;
	Fri, 27 Feb 2026 19:09:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 27 Feb 2026 19:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772237346; x=1772323746; bh=QIkD0CPiQs
	DW5Hpt+Vx84pNliN/hO790qpJDitzF83U=; b=VPmtKeoA2TLLoBSYiSbOJ06EVn
	k4XGLDTCemW3QfAYfC2vi1S0X8QeGY18/a+EIffi60UOm4FR7sC2YQV5kowMlAPf
	CHAgC7+WEj+tUd0RopfE2irJdb9/cWADR49vBN2HSEM+sz5V5khMi4j3v6usHGM5
	w8H87Ira7LH1zG5CB8mVgrl7nSei+xWlTcMkhLRzDeV4Jo2roW5v/kw2mDl1JAW9
	x5Av0VVebSr60Hq8YOHaoehe+YWqswUGdUxiBnJ4kqE0dR0+WrJBIFNROGgmul8t
	NurJjfjGgszpPptfFYSwvoBORlT4BQptdG4kF5hvlAHpy3Y0P8CttkC1Q9dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772237346; x=1772323746; bh=QIkD0CPiQsDW5Hpt+Vx84pNliN/hO790qpJ
	DitzF83U=; b=h98HQnkZUIVKVFUCvHoDQjM58bwDRjobm8k+vrQX8BYitWE8Qng
	9uKg089743vrMbwFrX4VM51twJ4DdjehzRUnPP8VH2iNcC9208rGNT9FlxZlUW9M
	sXVLRUi9C5zWKNB2NHsdzztORuT+4s8fmUhOj1BZSVQceBwJETwrTFmjEPPlynZ6
	pIxe8EL23Pk3JefDO2qCZ9182T/ILaiUongYCq3RFkF1Gl1dch0Athb/3DfnPbXi
	1cuzo4axbPNTqcCDnlmcMTSzQafrIU+G+elIU+wd3+lNYU2xsQhdJTfMDxLMn/Ti
	hcb7jLI7t9JLDkCX58NtXNEkQKZFK/tl7NA==
X-ME-Sender: <xms:IjKiaYbqyaj62y6xk9-yYbo_8-sDiZGo3Mjk5yzKLaPrLF49XaZVSQ>
    <xme:IjKiaab_YxHJP1wq29ash6lc_WHMUZZqilAwTkKofq_4GHQpzl_xUygqvNGBY0ZMB
    kk56J2kyeen7Z1GvLpEv6ZxhvAR6bAnUxKU6MJJJWB32GJT5PkgKg>
X-ME-Received: <xmr:IjKiaX8LNU5dTNwWiaM07CfHpXbmMjkHn7AsIlbt0GB1OLDelbjdk6wTg3hjqtQ7zySEecVk3ObhWxIrO7-mYab3tYDh74PfWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IjKiaRgNHonZzJlyKmzrln0n5ARAHR1YhX9-xnDcMOvzp-qy0fs7kw>
    <xmx:IjKiafdY8PCHJZG3GvJ9Qp-whBZSOELuLtSn_rJnwF38vgzkLUz5Iw>
    <xmx:IjKiaQoZjgryqP1WVLsyuN4-Tg2bCltytdh0ocfej7BZfiiZoiT13Q>
    <xmx:IjKiacC4InLje6f0dv2Xao_zvJAoSj8ggdQ0PRFT7WwmQwILNFjxuQ>
    <xmx:IjKiaeKIf9xqH7QA-oWJHfIPd13jypK1s8JKWCwvtmfKQJSNQlK_TzZL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 19:09:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 2/5] builtin/rev-list: migrate missing_objects cleanup
 to oidmap_clear_with_free()
In-Reply-To: <20260227234213.17633-3-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Sat, 28 Feb 2026 00:42:10 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260227234213.17633-3-kuforiji98@gmail.com>
Date: Fri, 27 Feb 2026 16:09:04 -0800
Message-ID: <xmqqcy1pohjz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> From: Seyi Kufoiji <kuforiji98@gmail.com>
>
> As part of the conversion away from oidmap_clear(), switch the
> missing_objects map to use oidmap_clear_with_free().
>
> missing_objects stores struct missing_objects_map_entry instances,
> which own an xstrdup()'d path string in addition to the container
> struct itself. Previously, rev-list manually freed entry->path
> before calling oidmap_clear(&missing_objects, true).
>
> Introduce a dedicated free callback and pass it to
> oidmap_clear_with_free(), consolidating entry teardown into a
> single place and making cleanup semantics explicit. This improves
> clarity and maintainability.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  builtin/rev-list.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ddea8aa251..567dc5e7f5 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -88,9 +88,17 @@ static int arg_print_omitted; /* print objects omitted by filter */
>  
>  struct missing_objects_map_entry {
>  	struct oidmap_entry entry;
> -	const char *path;
> +	char *path;
>  	unsigned type;
>  };
> +
> +static void free_missing_objects_entry(void *e)
> +{
> +	struct missing_objects_map_entry *entry =
> +		container_of(e, struct missing_objects_map_entry, entry);
> +	free(entry);
> +}
> +
>  static struct oidmap missing_objects;
>  enum missing_action {
>  	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> @@ -935,10 +943,9 @@ int cmd_rev_list(int argc,
>  		while ((entry = oidmap_iter_next(&iter))) {
>  			print_missing_object(entry, arg_missing_action ==
>  							    MA_PRINT_INFO);
> -			free((void *)entry->path);
>  		}
>  
> -		oidmap_clear(&missing_objects, true);
> +		oidmap_clear_with_free(&missing_objects, free_missing_objects_entry);
>  	}

Hmph, maybe I am confused, but the shape and memory ownership of the
structure involved has not changed before or after this patch.  We
have bunch of missing_objects_map_entry instances that embeds
oidmap_entry in each of them, and we iterate over this oidmap,
enumerating all the missing_objects_map_entry instances.

In the original code, we used to not just clear the oidmap used to
hold these missing_objects_map_entry instances, but dropped the
string pointed at and owned by the .path member of them while
iterating.  With the new code, I can see the newer interface
oidmap_clear_with_free() being told how to reclaim resources held by
these missing_objects_map_entry instances, so it is a perfect place
to not just free the "shell" structure, but also the piece of memory
held by the .path member, isn't it?  It appears to me that the
string pointed at by .path is no longer freed, introducing a leak?

The above hardly convinces me of the claim in the proposed log
message that this change improves clarity nor maintainability.  I am
puzzled...
