Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D7363C72
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940862; cv=none; b=SzeBYAFfSOmKvQaZ5V5SREOEJ0CLxb1rRmorofhPZM0bVN/H6EqI1UnbpzuhdnGhxLRoZVc41h9yklA64sTiuHNjn9C7VcZddRuKMtnTqPLKylpC2LuVETF4n/fFffRN44GVTQ+kbVeG7FSSHFcrrxvz+Dq0cbBY+R7X/SzKN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940862; c=relaxed/simple;
	bh=qgEyiC+3TYWLO0TLrm1sxMTGpZLfHyEGDHvyPHuQ+hQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=urw0CcPfrp1NCYY6P8A68T0kLCSJzcncDFpHbn/qTlCUbqLj9efJJl5I6ZanSxR6SZ6EwFK3rfxCQXHimRB/SJzYUblJTNlqsRgLj1Kh6j6oVybwx31SaRACBbftDZXuQ4A4KTmrBtX+5R8C+I4LYaSuLAIdJnzlxAtuIGwn6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMn98qai; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMn98qai"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-859e0bc7dd9so753638b3a.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940860; x=1789545660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkX/GnJBwHl1EOvnxFZAfki7yTYslzITUYB03p7Uyuo=;
        b=rMn98qaih0JgiqcaQ6fQdRBsizIlspDRFbmNNtZLeF/18CgQNOXXapxRGFqw75Zg4p
         dl/Bk0hCYPjmopP7Gg3lApQ02rDtMeQNfOGtwIQ+3LU4PQldPVgR/gAj5Ghn18F1LAMR
         +DR+Q9yMjXybmlI1GF8UqVOVKyaGExwS394SClG37j/RYepzL6DtcpGKoDDXVMwyLRBI
         HghfjjcHF9deITst0aqps8lWokDcSznm6JNsAUQsQfeAVk92yJew1i1cE8p7R9LC91Cz
         KmGYy+GJudj1WmlEe4hoZlvd1va/DUx7BtMFbJzME2fhGAIyUaKh39PmAt6+oHVXGZRP
         et8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940860; x=1789545660;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkX/GnJBwHl1EOvnxFZAfki7yTYslzITUYB03p7Uyuo=;
        b=dMauxS36ZvteoPzvW5xnupsf/FKFWv6UY56wFdpaovCWS9E0zgIR7xjOJSyihevFGx
         BloTKjjHSu13PpESB4f6qpbuweHF9NdKLH2XP6aQeD/oQHczqUfGRfuYZfzsY2zXfTYl
         ARxufwYUEmnLD3plsFroVnsbl5GAX2xhbp6w17gqEjdG+TnQJ/5j6BbQ/XBS+QM6gBSn
         0MAcMVFMYI38RoCdv7sqKiNX0EUo8dGE79ESn6rpDsqYO7c7Gk4JKhLIzG30im4YrQcK
         WqgV9dumUDdUNZX4L5Pl2zu4pRCLuLNEO8NTHevVP5PBDM2PIGOPKmf7iBkdFr17PVjO
         EQDQ==
X-Forwarded-Encrypted: i=1; AKwUvByPnnidi1B5UqAMhWbze4IzqewnhtISBz8kykDoSa6cvNAbi4ThgrhTFWlQSVmB2JKYx6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kbp9/hS8mXB6koj38Os4qlOxxgNgeVajg+LXmLFoBy055Pk4pQ
	rq/8TTjtJwu5kBqLovDYuyBoKUfh3n1Xy9OHggUKHayPL6frsAJ7a7YG
X-Gm-Gg: AYBFou0tynxNHdro/8o+05G6Vb5do9d5iT8MUnZw5wriay8TEqUArWN5KlnS5XdGfar
	dmTymLyLyr1YGLIXLijiSw8F0gC7lt+9BJoMqJvbuGRePDjgFkOM5OT+fHpyripQJSj9f294ot/
	Jxuq170ZTeTeQavfNHAb3VZvVZJruObhLBimKdbiRRrIdL6IKAtIhVVGjYaQfdvV2OVuUSVBrKj
	bIi0bRWq2EKJKevSyK6m2ef/Dv3RiMg/CLDIOVFworHKJem7q7+CPfSAWGIAMCciiJlW46scT8g
	Sv3oH6dSFnV8QDvtCobfyoka6ep8d+gSjTxYRaJCC7U4sxiQ4+SskVgose20nM4MLQ30zMR2NwP
	5vJIgJRHY0UM7z658RTxNWuXM23A9dDZpWlbvPPbHQq7T5ggED0hsRsCmiH8lq6RGe15LQKIEph
	aFWDQkWt28SKHFQCoePNFtYd5GD5ivjG0utQvcIUwGArYlKFMyVJFhkcuOyFtlviweAc2wSMJtM
	fnmm8PJ+Cm0e0PsSARqK92s/V5Qs52ZDPPGrBe5yjUYOa5jk3nUaqY=
X-Received: by 2002:a05:6a20:9396:b0:3cc:ec12:a788 with SMTP id adf61e73a8af0-3dabafdfc12mr6861232637.4.1788940859950;
        Wed, 09 Sep 2026 01:00:59 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:e00a:2dbb:bdc9:907c? ([2406:7400:12b:61a6:e00a:2dbb:bdc9:907c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm46824001eec.30.2026.09.09.01.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:00:59 -0700 (PDT)
Message-ID: <be1c7560-0da6-436e-8f46-073e95bcad07@gmail.com>
Date: Wed, 9 Sep 2026 13:30:55 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 08/11] setup: refactor how we configure the ref storage
 format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-8-6733c90ca5b0@pks.im>
Content-Language: en-US
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-8-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:
> diff --git a/setup.c b/setup.c
> index 3be7dac452..38fa5e854c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2761,40 +2761,65 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>
> ... snip ...
> -
> -	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
> -	if (ref_backend_uri) {
> -		enum ref_storage_format format;
> -		char *payload;
> -
> -		format = ref_storage_format_by_uri(ref_backend_uri, &payload);
> -		if (format == REF_STORAGE_FORMAT_UNKNOWN)
> -			die(_("unknown ref storage format: '%s'"), ref_backend_uri);
> -
> -		repo_fmt->ref_storage_format = format;
> -		free(repo_fmt->ref_storage_payload);
> -		repo_fmt->ref_storage_payload = payload;
> -	}
> +	/*
> +	 * If we have a preexisting repository we need to verify that its
> +	 * current ref storage format does not change.
> +	 */
> +	if (repo_fmt->version >= 0) {
> +		if (ref_storage_format != repo_fmt->ref_storage_format)
> +			die(_("attempt to reinitialize repository with different reference storage format"));
> +		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&
> +		    strcmp(ref_storage_payload ? ref_storage_payload : "",
> +			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))

Rather than a strcmp, wouldn't it be ideal to do the path comparison 
using strbuf_realpath to make sure we avoid similar paths like the 
following from failing during reinitialization?

   $ mkdir store
   $ git init --ref-storage-format="files://$PWD/store" r1
   Initialized empty Git repository in .../r1/.git/
   $ git init --ref-storage-format="files://$PWD/store" r1
   Reinitialized existing Git repository in .../r1/.git/
   $ git init --ref-storage-format="files://$PWD/./store" r1
   fatal: attempt to reinitialize repository with different reference 
storage payload

This matches with how we actually make use of the path at runtime in the 
refs_compute_filesystem_location function in refs.c.

Rest of the patch looks good.

-- 
Sivaraam
