Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8391EB36
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208010; cv=none; b=K1SceG2UMlhantARYVnllOL0IAVCEyz/hJeXSZixLe3PZzkySc1VzFwrn6eu3sVBJkmSyfedqxChGm0zA5HhbtpegfMgUIU1XQGNGLOkYsyW6fDvK9ki0ZMw6YC6iP4ItyBF52qkTuGoZpWbCx9XURUJ5e58v76lZlau6CjDxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208010; c=relaxed/simple;
	bh=Ts/qeNROkjvZLC+5iVtBmgeHn4tmk9fuNQ5w7NLDlQs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fhUZEzBdwHD/f7LhytTIlnu4s/YCHk2P5CaQcjYWH7Zfn+iC3qdszHfs7kLp0oUmRQy/7oYh+PK/Ah9za9colaGufRaK+LRwDoT0bKFT07wzTJP/MGf9jo9/v4VxC/Kutt+G1Ifi3PwGet0VAa3LP8WOPUBZZ5pQ8MDoxmFfcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqOIICvu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqOIICvu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee1317b1f7so474874f8f.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758208007; x=1758812807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgvh3nZNcFhuN3TukTCzxkxcQ3zjHI9Iwb9ePTbA2xg=;
        b=IqOIICvuJ8rdaeo/s116barypf8vf8ynhUqS44HGdER9oPBEZSD/S3dBxkXlPVGTLG
         gHlXX95mvHhXKjSiEgNaNvVhaUMNwiIbSeI0TOm4OH1PQyd2XmvGPO7zmUXba7o/zsfl
         0GoF62WVYLb/11GBWV1PLP18kZh7Z4CvEQmYUFABOFLkQOMz+6xgrP/znkWGTGbQsh5a
         7EdDCko/tCdxNQSSABXq0h78jyMray/aVhZBZQg9DBX0pfYUoiRLMcrxPXC99rudp3at
         icVpBW5wiijdsPSmMrncQS2WLkRFpT392fYxiwi2PhrCfmMvZs9OpXBbyFMJH8hC5IyR
         haNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208007; x=1758812807;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgvh3nZNcFhuN3TukTCzxkxcQ3zjHI9Iwb9ePTbA2xg=;
        b=Dyk5i5CJmZJzBVZV9YSbKvv3i/yIafXFsszg5iEyl9wzAyCoO1725yFtNcJMashQNT
         6gbm3YnvQuTq1sjOeQTv+IzFm17RPZEflx/YbvOpC4h225AzzbddMUnAuaTRL5UQ3ERW
         AV36eSjaeGbnBzAqA6PFFkPEtk46E8OF9r6vjNFjGk6UhQ+OK7fnYoo0dtRScKHUmH4d
         fr+Uw+SQ4QMV5ApujoQdfc7/KACOxGUfyd+D+TAqHKiIFE0Anuf/v8igmLQTgBJDonrT
         5Jh+35PfAwrAiRa5zjYnA4z4N3WJDFzGRu/P1W+q2Z4EwFAPdonYmRZudY2+gvHV6gM7
         zU/A==
X-Gm-Message-State: AOJu0YxkqVigpjcuIuVqo4fldG6lO2di5HjGg2rxm2Qaw97YXDr7/Dpy
	K8A/jG4EkaJvjPTAAo8euVqfw+3IGcicDv8lLcWov2kBn1ZFMvP+au3s
X-Gm-Gg: ASbGncuRuYP0/oH59tDQMtdoM/tGTkGpjRMoVWbm7eXrYkikmkycVrPE51iFIQeVhP/
	duF2Qo4+BhKOLgD5gAf59C10IMNvZXxaLrPn7N6jE81jZx1tIWMqaPKS8B5vlZMp4YmW7fqGXZH
	Q2QMixwAIKERTcUuJXXkGqVBo25gQj31YQXoDv/SrcgM6cpHvK+oXixWHBLESLtnKY4kw4glY6V
	5DyJm+ZCi/KdYbbcZUfZJadzsIjwgylBXo6siXsDs8XWGvCWlnu7qrDaXiVTnIWZ6A0D3CVwFkT
	ORSfliUHGS22SQX1HHQKof3ClS4A5ttuwPw6hl6DEMukZCYDsnFj+In96u6V9Si41tKy+Gni5cj
	5pk8QkrAVd/VIZek+gqlXuTAmpWXhl2QGcVMHE6qhqbenTxdbb03nIVGy3In75re783B3htD0FW
	bakHIpBSFLHan0mnCZmQ==
X-Google-Smtp-Source: AGHT+IHP3NweGTM8aipz1Id8ZdeyfAAVouijtRRcqccupQL49FfDo7lIaQcunrPdByNywnHLfWhf/g==
X-Received: by 2002:a05:6000:2313:b0:3e7:42ba:7e66 with SMTP id ffacd0b85a97d-3ecdf9f4477mr6144111f8f.3.1758208006480;
        Thu, 18 Sep 2025 08:06:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc1fc66sm3938836f8f.0.2025.09.18.08.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:06:45 -0700 (PDT)
Message-ID: <7701b104-39dd-4f73-a16b-e207a3ef813f@gmail.com>
Date: Thu, 18 Sep 2025 16:06:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1757518141.git.phillip.wood@dunelm.org.uk>
 <xmqq4itarqfd.fsf@gitster.g> <xmqqv7lhigb7.fsf@gitster.g>
 <70fa7537-3b89-4c3b-9dea-5a7ea0174a9d@gmail.com> <xmqq7bxxf6kk.fsf@gitster.g>
 <xmqqsegldpgo.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqsegldpgo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2025 17:16, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index df0040b9ac..c7f39248e0 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -562,9 +562,9 @@ test_expect_success 'init warns about invalid init.defaultObjectFormat' '
>   	test_when_finished "rm -rf repo" &&
>   	test_config_global init.defaultObjectFormat garbage &&
>   
> -	echo "warning: unknown hash algorithm ${SQ}garbage${SQ}" >expect &&
> +	expect="warning: unknown hash algorithm ${SQ}garbage${SQ}" &&
>   	git init repo 2>err &&
> -	test_cmp expect err &&
> +	test_grep "$expect" err &&
>   
>   	git -C repo rev-parse --show-object-format >actual &&
>   	echo $GIT_DEFAULT_HASH >expected &&
> 
> I think in the longer run, a change like this that makes us check
> only what we care about (i.e., "do we warn about unknown hash
> algo?"), without assuming more than necessary (i.e., "we shouldn't
> get any other warnings or hints, or this check with test_cmp that
> expects an exact match will fail), is a good thing.
> 
> Perhaps a #leftoverbit material.

I could go either way on this. If we want to test to be focused on the 
error message when git encounters an unknown hash algorithm then I agree 
using test_grep is an improvement over test_cmp. On the other hand it is 
a bit weird if we start showing hints about the default branch name when 
the hash algorithm is invalid and so we cannot initialize the repository 
so maybe detecting that is useful.

Thanks

Phillip

