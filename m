Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294746F483
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247948; cv=none; b=Id9igcCMBqeZNsFhHQ0fwKao4D5P9bQ6BilCPf3uEcBGAcYcARIqaXfIhS5PQCTvf5W4DSPb0QpMBMpF18f6k20F/qPEfIxfsYNJrOQoPyhgjJpmVGl9biQppyWOL/7IBBh/Cex+vZYmKLIlh74MlH1I0lFH2upQbN9xkg8/4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247948; c=relaxed/simple;
	bh=ehyy/Xx/TPLY+Niz4aDIi1q782JA5D8+H2QCLOoJPcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JEhAqqXMsp7anjPbSFwz3akSU8wkxLMvMLwDq5tDJv/aU5div/C7mGNmIE2qrhsCGZP7KD+FvXz56swgaettWFnP+pfBvZYQQl5jcFVCH7burxlItLT7cK4VrpojPjfUYFQFEmpHjCYG8LAf0yYQQzQUAEpdaikvApPyBGO/qiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sRwFL1Al; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMOijCzn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sRwFL1Al";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMOijCzn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A44831D00137;
	Thu, 20 Aug 2026 13:45:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 13:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787247945; x=1787334345; bh=F0mdqyBLp4
	2FRkA/AUHDRcCTr8fRJn6/4yW/PHahcYQ=; b=sRwFL1AlhXjRdSGkEcOwy1ScJp
	w9no1s2fkJjboBRqSlyLbUDD6yWzShibm7G1TglLCXJWXH07dpO5RfUkyRp29Lrx
	I2XRCqE9mm9/KwA0lZoHcSGUwd37koLSXKgFLnIqIOLjPqPOPV2+SWO2cAa5FxHY
	63QVcDBCCS/IqLx8PmEcn8eNFeQggita1U5mhdtKc96QosraksbZktVSly0g77/H
	99YUoEpZsw8R4yEHL3PaJ2OintBCbmT33Hl9kr5Jwt6mf6WTTAwZNV86EXmghP+a
	yLZIMDSqxWNLnPEPo/dhzx9ySuN9GM2Y0bCG00YO5CFOwZ+463CwzirO3IAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787247945; x=1787334345; bh=F0mdqyBLp42FRkA/AUHDRcCTr8fRJn6/4yW
	/PHahcYQ=; b=OMOijCznvsOPg3/QdcqjCYJSog6IrDeFG7dQhLxqyT5PKuhbWpU
	ryGpqtz/cJLsIZFIMAg6HnSU5PoVGBkpxGLEko1TE/KgdM/UoskYUPN4DAsBmTEC
	i6Njqb/FhhBCjaCNOAG5R9Ci4CZ4NdMvia2UE+dmFuQvL2XfvclRIIvftNsk3jYY
	KwlS5V3iHFqxJYR8e6o6yyyYjLb+DZcP3BZ2kyjJ2uIqJfs5+2ZlJV0Y63BQG6DJ
	TNFb9/eiKDBh/XfRaXPBvxmvdrwBWbgP4+Ra3BUmvC8e+J6AjcFEGMtEtEeF1JyQ
	9f9s6ORJRz4Lr0SJfFcGm3v7JQPmkBhTv3g==
X-ME-Sender: <xms:ST2HarDnoydVCbZSz5v9O1vKxXoAIzpQuqKnUTwauNdQctSr9qDR4w>
    <xme:ST2HaoasXnRuO3C4CFCTbUuP66eCguWqriZ_6OpAOytXxLZ7sX0GkQnwlIiMqokOr
    CIf7MghbgPLK4pOD_XMALKkQ1yoqmEls9C4g-ICp7AnvmS_Q42ekg>
X-ME-Received: <xmr:ST2Hau5r6n3GuOhSkq65MIk2NWBhMRCs2iV_lrbX7TEF5Nbe3PptOBR0AIJmgA2q6ygdgT8WJWaYP3vC4m8bPZL1VrRCd6kTPA>
X-ME-Proxy-Cause: dmFkZTEsECwbfnvjpibj80CyJVbaTZcP6Uoecsx0WrA4pnb6J3E8jvU/xKkt3ay7C/Jpwq
    Ba5LCCtO0faYTOWeGEcZ+ynmQgz52988lIMTv67DcBh1bNE2oUjBha1j6lHtfDhPIyLlSc
    Cu8zLzsDl564Z0T8tP16S3iD5bAdBBhQQ/yvsvuErtZgW7ZLWvdGUPYIWg4KMOUGrnwYV+
    jZiyu4YwCArp1/v95buf74dXuvULINfsL89UgDAzgkFTO+/wQdmpx7j4QH5P73LcbQmN1m
    bKDDekTDt9uWNx+ybmsozz0V3hwvbSwspe57mpZU5Ip3cTit99ixfDOjA1c3Y2hxX5oxl1
    2LbRiZub5pi0CTTuPEWSOhtAyNzREfj0pLON4mm4JJwy7mehJxE5xOrMpiPcbTUJFbmdyw
    4j2cTSaQZM6OEqV8SMO78hSPndcf5YhHx/4FXuMCd1CpB9kOcmWyVfkLwJ+3OPJ0kbPr8O
    62ZNIF2ZJ8ylTYaHthQWtdfdUEgib9q00OEECZckmt63IcEzmdyoqczWj1nt1+l5aj7e5Y
    8R8r2iGPhddZsKQRSj0OHeVZdm2h5P2VHmziCAQYHTiUmDY2scC2CdJINpQ71yOmYt5Omz
    yy7G/rYj9GPHtVCq/3JRzW1WsrOou+YQsmjAShQQD850cw4T8uFxvenqmhCA
X-ME-Proxy: <xmx:ST2Hapby0KLSS7gwjYiIoxJJ371PWBtr7u7zIQYQojSs6ysFI7wRyQ>
    <xmx:ST2HatjKR_jSKrf65uo7FQPhiFT4mdboArq4IaI4I0vU7fccBx9WHA>
    <xmx:ST2Haq_H64loPo2gZnvigaFG2eyAUUK7kU883CGU88eXTx2eb6oqdQ>
    <xmx:ST2HaoqHWLwnKxXrc5H0QbhDupl8EwBg92BCVkel5rkKFVddlwUt5g>
    <xmx:ST2HavqQIOVV48WFtjA2HxQ4ZxFaq_gYOdS-_j7zS7u8EVF1mNSSmiPm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 13:45:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Tian Yuchen <cat@malon.dev>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v4 2/3] environment: align repo_config_values_init with
 struct declaration
In-Reply-To: <5693baa9923afd20333c0eb016cc5949f8dfc423.1787231825.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Thu, 20 Aug 2026 09:18:08 -0400")
References: <cover.1786103607.git.ben.knoble@gmail.com>
	<cover.1787231825.git.ben.knoble@gmail.com>
	<5693baa9923afd20333c0eb016cc5949f8dfc423.1787231825.git.ben.knoble@gmail.com>
Date: Thu, 20 Aug 2026 10:45:43 -0700
Message-ID: <xmqqa4qgsn20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> The order of assignments in repo_config_values_init is chaotic and hard
> to follow, especially when comparing with the struct definition to
> ensure all members are initialized. As new members will be added in the
> future, make it easier to validate changes by aligning the two.
>
> Refactor assignment order with no behavioral changes.

After reading the above three times, I am tempted to slightly tweak
the above:

    ... comparing with the definition of 'struct repo_config_values' to
    ensure ...

Other than that, great improvement.

Thanks.



>
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>  environment.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 76ee65e62b..6676e6f5ae 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -745,6 +745,7 @@ int git_default_config(const char *var, const char *value,
>  
>  void repo_config_values_init(struct repo_config_values *cfg)
>  {
> +	/* section "core" config values */
>  	cfg->attributes_file = NULL;
>  	cfg->excludes_file = NULL;
>  	cfg->editor_program = NULL;
> @@ -756,20 +757,24 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->autorebase = AUTOREBASE_NEVER;
>  	cfg->object_creation_mode = OBJECT_CREATION_MODE;
>  	cfg->apply_sparse_checkout = 0;
> -	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
> -	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
> -	cfg->ignore_case = 0;
> -	cfg->trust_executable_bit = 1;
> -	cfg->has_symlinks = platform_has_symlinks();
> -	cfg->branch_track = BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime = 1;
>  	cfg->check_stat = 1;
>  	cfg->zlib_compression_level = Z_BEST_SPEED;
>  	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
>  	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  	cfg->core_sparse_checkout_cone = 0;
> -	cfg->sparse_expect_files_outside_of_patterns = 0;
>  	cfg->warn_on_object_refname_ambiguity = 1;
> +	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
> +	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
> +	cfg->ignore_case = 0;
> +	cfg->trust_executable_bit = 1;
> +	cfg->has_symlinks = platform_has_symlinks();
> +
> +	/* section "sparse" config values */
> +	cfg->sparse_expect_files_outside_of_patterns = 0;
> +
> +	/* section "branch" config values */
> +	cfg->branch_track = BRANCH_TRACK_REMOTE;
>  }
>  
>  void repo_config_values_clear(struct repo_config_values *cfg)
