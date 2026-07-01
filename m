Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42436C9C0
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923123; cv=none; b=SP25MbGgaZWoWzmmH0VOoN/5XoT2jAkYXS5x4ab/Hj75TFsj0lK8JGM9lofNgVJ3SCQQX5xal0Ev2fJynTNsFMb2ACJjjxcC9Hr7OZTvnYFZZEIPvnV0dI9v6Z15nZ012poUP+KigHL7r+pVc7uoMBfSEQhO7GPlsORsYd8jgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923123; c=relaxed/simple;
	bh=IIQcrMsEfDBRIxx146GCf562DrC9QyO8LRPoNrxpkZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jZkmnnCd9BFykRF9ifukyCXiIUGI/0t0hXRFUi0Rdg8d5wfbJkU784D3suEvUPVek18fdvT3FFl1RPDRqgTuKzYTq8zhIvcv2waUAo/FeSKOq38ppLbzPYXAw/U8VTJovxMq2lYdMfgiu+TdgqoLJSv6cBLUS8pN6ChgOevSSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bLOcfils; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0syny0D; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLOcfils";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0syny0D"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 582751400120;
	Wed,  1 Jul 2026 12:25:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 12:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782923121; x=1783009521; bh=1M72VA8mp+
	LK050YJCHp+rBrLzvwAsgDXYsCtN7oc2c=; b=bLOcfilsE2RnOMFa90Jgk3DPsx
	t8X5AP9j+61OJE8TZIPrb4CVON9r+ef/abukKweYt90K0g7SOcbrI7sSJlmkg3hz
	MpV7ydXQ0SlxlB0l0xr31NMFXMzpXmR4e2BE37efsX8nPR/gk1Oijb0oulS4KHxA
	evfsX4t2wlF3/G0dG9uEVuen4EcL7X1vyQIl+Z09X2zbQJDhG7bEYD1A732tyCqa
	nE9wMn5TmDuaZ7HM3WhosmpmrMikwaqZqg4YH6L75u3iTxHCqlw1VaiZrk38tzYZ
	OjLin2hluMpNHRCMAJ5PVdf6FhlGgGvnDWK17SzV4kM0yw0ScimeeE3eCuhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782923121; x=1783009521; bh=1M72VA8mp+LK050YJCHp+rBrLzvwAsgDXYs
	CtN7oc2c=; b=Y0syny0DXuloPtXRVwpsGrF++iq6UNC1vVF5m9jJmttnih9Z1M5
	ExeK+/6BCnKYzDNrQjxzPsLoGgd26rg9hoTdsKRj/wDamKSuyS4w1nh+N8Cm23m8
	C/0iskRKU5WD4USSVR+e9MY8zELrg0iLQISHY8K8NLonKjeq6dqM2PAEhmVQDrOM
	Pz2CLyGbnf/x/9la27V44nZid/koORy/AgdbK7RJv2SmJJuk9vL3VNPK5ILonPQV
	3iaKfrjzyU29p47WQwctRjsZ6Vk+MQn0CZ25K9x2ae8OibHxb+Qny3dchCeaiIYv
	Z0B/ZPEaZx4kLH4Evnc6cGkuRpF8ZyO6yQQ==
X-ME-Sender: <xms:cT9FahCVumtfZ0ymxWAAvL92VX-pluRSumNlWD1kC3ipb9N_7X2gUg>
    <xme:cT9FamiYTC53oM06g-lFVy5ZJgCnlMe43CJlSFsqWwqPAJVBEV_kqYtigc2IsyZSr
    RuOETlnlKiwF5bUCfDqYOZWdta4nNNdEgVm0ANOLR4ZQ5wCFB1cdA>
X-ME-Received: <xmr:cT9FahliVKVYXnT6ESZJaQT-57FYS2dtOuIwhnuERcsa4wRqB_JrVLJG0f_6qcZU0Tyzuwo2i0Z0qqH-FOv9-R1MbFQa1yG10rWqjG8>
X-ME-Proxy-Cause: dmFkZTE4FAS2nxgdg2XN3qQdDo+jUEuA4qghqhJB0x6sEewwo/IZS6hfEyRmq0bbAsL/BV
    enf7YnogOytomVBYH0lTHiUhTm4slCQ+J+4dNZhklgrncCo/uvXyuKnmxG/AD83dAMDIny
    umWzvb9MYgU9gl3cA2TxcZ9jpwQRnoKIzFsZ8vvMOpHEs/fiHyrU7bipu6JCXy84VqNJws
    OyKXRDxIREXJNsIw8bIJsazdfZ/GLe3tuEIF6O+dAbXcDFfYRZcImd3Wu4nbICGbjExqQ0
    a//5Z0kDmV8WAYWg3PnDzucmx8miwZSECoYY5LMCTyPvlA/FmZxNgSX8/I9DNZVV7sePVM
    8kQXfMFRXsQ+c9B/0LN1zhIen7f0MeA8TcgqbHk1AhEEoXP3+lGP/o6BBdHWYvqr8lZ7r5
    BXhbZ+FlOtjhDy2z8Ll2HhhLjC14fsRwnxSg71SoXgpoA8O18GXvmPKkH/Ro7vo89//6Ed
    6rkRjKic52ZhAH62QkoCukOr3XdJlrSlNXIn7IWb5pcPlrnKKMiSbozyiaIVlRBDy0/Wbv
    2CQSAtgx1J4FX1nrNHKM3fAiXDGLmlMn7DYUj01gesRY/H0mm0qjOiHfY0CQb3wQdtKuaW
    WVYj7o6dZ7rOfuFCBbnNOE8+IGkama4czB3I/gEG0K3PiMASoKeX/uVIb1pQ
X-ME-Proxy: <xmx:cT9FaqpIPCsqn_tUN9tRDcWet4Ykwb5l6jxcQYyovoRUfvtoiosQNw>
    <xmx:cT9FaiHi7KcxD9xxNo7x7-oNOr_4_JkWXcL7rseEESTnOaXxL0aa7g>
    <xmx:cT9Fauw7CLYIeKRoj1hCaXkn1zJE2jdfNwOqPB-9OFevnhjW2Q31AQ>
    <xmx:cT9Favqe0lR8jmuT5BLNUnr-EDoIDk5Rhx8Z7AGVZL8Sa57fq_0szA>
    <xmx:cT9Fam_i9OhKiaYNipafp2z3On9nodxg_uHlXp2UBZb1BSbMfUViGmMc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 12:25:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/13] load_one_loose_object_map(): fix resource leak
In-Reply-To: <17242c249f0beb387fd30634663f13ce42d34f79.1782889472.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 01 Jul 2026
	07:04:19 +0000")
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<17242c249f0beb387fd30634663f13ce42d34f79.1782889472.git.gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 09:25:19 -0700
Message-ID: <xmqqcxx6pths.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Pointed out by Coverity.
>
> While at it, reduce near-duplicate clean-up code at the end of the
> function.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  loose.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/loose.c b/loose.c
> index 0b626c1b85..47b7f5ec38 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -65,6 +65,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
>  {
>  	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
>  	FILE *fp;
> +	int ret = -1;
>  
>  	if (!loose->map)
>  		loose_object_map_init(&loose->map);
> @@ -98,13 +99,12 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
>  		insert_loose_map(loose, &oid, &compat_oid);
>  	}
>  
> -	strbuf_release(&buf);
> -	strbuf_release(&path);
> -	return errno ? -1 : 0;

Wow, this is bad bad bad.  We do not even know what is in errno as
we are supposed to have jumped to out-of-line err label in all error
cases.

> +	ret = 0;

Or we can do

	ret = ferror(fp) ? -1 : 0;

if we want to be sure that we have caught all the errors.

>  err:
> +	fclose(fp);
>  	strbuf_release(&buf);
>  	strbuf_release(&path);
> -	return -1;
> +	return ret;
>  }
>  
>  int repo_read_loose_object_map(struct repository *repo)
