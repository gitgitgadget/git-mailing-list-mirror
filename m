Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4165D3B71DE
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367720; cv=none; b=qa5KUPgILtqqnk1qPVf+se/7f4fy2JbEoUmhMZpLxPpRRKprIrk4D1M9KUB3ErMM7DgIUMK4MMhdrKqqHtL2BaJ4hZ9M7v2oAaF3ZCTTQpQKSg75pJmBnSrHz2c7jR54DstxNTTsjgejuiXRTGRYv8TofE1r7nXOs7+lGiwrbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367720; c=relaxed/simple;
	bh=QLbpxrX/EAMkI9yseFQc22AIC8M8pEEogXQKramenN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Ilhbl9q3oQFm1fZ0o9BM48oswJb2SDw+29nAGA8cHH0c6SuTW2A5hhIh0Pvbx1cSypWuxT1xI6jYMt3ssskiuGq66WV8H9TTEzPUwHhzINWZHfW6ZujanfJ/1gy2bvtw88wygchvR5ZLEnPrK7h5tV48ItX6O3H0wEt2GN4lYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF5D0qV6; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF5D0qV6"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3381a6a05c9so790071eec.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790367718; x=1790972518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/aWLSzYAAt1xlk90XaFzYn4S8LzTFnQUf9vwttB+bBo=;
        b=OF5D0qV6iOD7S44+cRQb2Yb6sPsI2AC8hkFw1NWMyt2Eb1ofB5XTMyTM5PyiXLK2xG
         q8yoOtslMRuO75Ql5Vu9tizkRq142XE2JIq7cJrZZ1CQ6EGbqvK9KbW8TDw/tPW5YT5M
         BjY8n/Ww4Pla6P0bb7fdkGyEQ8IhMJBK+4+ZXW7S9wmodtGJ2arlnyx02Vd7+9zC74BS
         TYsdQyyO7rU2vkok66h5qYcQ6n4XalpQ0QHnIG7cMud2XMPSgJaOQ4UDEPc289kRGtzc
         LR2qA2idgWEFIl2P4hOrZ726qTBKmeaCnxImmxBndivpum/JXymuNY9TordgrdiG4EjQ
         mB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367718; x=1790972518;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/aWLSzYAAt1xlk90XaFzYn4S8LzTFnQUf9vwttB+bBo=;
        b=CdtygFUOtpEe9wsB1//zk9GSOaHAqnv+tN4SudsknaMwo4f+IzT1iRdZKVLt3gYB7O
         IxWiZLSjzYfVX27JNI2PmfN1BnP4nXvq1V8NEdxIkWqKTCez6jwXeCWNlMVxGLrjUDb4
         EMOo3YxRksqgRuis+eu1+aLdApYDzR3rv54xQmFOtBSQBQEHCp36IBeNNNsRpDeI2mFp
         WDluao2CBbByRqmPsVMhz4aF5GYUvn2tV++FRCDKPio5b6Lfq099j3wm3dV3szTcZa6n
         ZcM5cEtJiduBp1/Xfcl2CZQogQiVBfjHp3gFo21cXKLDfv/qLdcJ2+VInS9jqkmnzsOa
         M43g==
X-Gm-Message-State: AFuF++n/cFacDvoAMJ/CsWvg4RbAaOITTxzZDoexER9ki5V7DBYOpkky
	C/+znLdNzbPLoRXdlV+rqRoMbuJT51ZS7gPqVdDsXZcUG9tqB8MrIUxz3s/UtdJXPGY=
X-Gm-Gg: AYBFou1vM3HM3xfc52TZY2KLNmp9lNc1hXTrEO/2lieqPxrLovYcQrHRiR1lWzOd1SV
	3g5w152uUBqcFqDnI3NEvswWlB2qQK5hAlwPId11WpcOrORSvmFtfjRFqpYIMJjq7RifmBtDye+
	aDESjFImB7NBzN9mAszBm5B/juG2HAtwXhRNv0DWdV23ZzQyJTfTKlcK/YZQ+u9gnQKppc31v9s
	3NUJL9jqfm9Fo0zzVxJcgNDBkm04DU19AVz0/RJZSbOBHrld+w5g/mRv8fQf+disfXhEO7VNwOz
	Zt8KfwwiFGMhDYewlFuVwEtAQ8fw2Rtcwg7QAVrAZLbBs6JgDMoBeRyetr1USFDbr5aCwH0PFX1
	K6cz67ZoLdk0XKsBzTy+IaNNpaghoZMSrErT/wz22bnsb0nhXIS7uby+T1U3pBSpCm4tMPUWEdo
	azaw5XzSlrmC7O6UKMduhbtgqEdRfjMLf4xlUA732cgJRAR9rCew7UmFBrQ11cdqmOPo/4AzZOi
	v5jx8FTLxmluBgI9SsZKCcwWoPCzfrZiqN5VLPW8rB2wktrMmJzRg==
X-Received: by 2002:a05:7301:18a9:b0:33b:fc17:e691 with SMTP id 5a478bee46e88-342700c7a9bmr986140eec.2.1790367718177;
        Fri, 25 Sep 2026 13:21:58 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:a5bd:5e99:a91b:f02d? ([2406:7400:12b:61a6:a5bd:5e99:a91b:f02d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414485a9cdsm8574710eec.16.2026.09.25.13.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 13:21:57 -0700 (PDT)
Message-ID: <63798ed5-3fea-4938-8b0b-910d5f1c7bf0@gmail.com>
Date: Sat, 26 Sep 2026 01:51:54 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] builtin/init: refactor messy creation of leading
 directories
To: Patrick Steinhardt <ps@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-3-11499557cf31@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <20260924-pks-create-repository-stateless-v1-3-11499557cf31@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 14:49, Patrick Steinhardt wrote:
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 5c22eae2f3..e45268f1ff 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -131,15 +131,7 @@ int cmd_init_db(int argc,
>   	retry:
>   		if (chdir(argv[0]) < 0) {
>   			if (!mkdir_tried) {
> -				int saved;
> -				/*
> -				 * At this point we haven't read any configuration,
> -				 * and we know shared_repository should always be 0;
> -				 * but just in case we play safe.
> -				 */
> -				saved = repo_settings_get_shared_repository(the_repository);
> -				repo_settings_set_shared_repository(the_repository, 0);
> -				switch (safe_create_leading_directories_const(the_repository, argv[0])) {
> +				switch (safe_create_leading_directories_no_share_const(argv[0])) {
>   				case SCLD_OK:
>   				case SCLD_PERMS:
>   					break;
> @@ -150,7 +142,7 @@ int cmd_init_db(int argc,
>   					die_errno(_("cannot mkdir %s"), argv[0]);
>   					break;
>   				}
> -				repo_settings_set_shared_repository(the_repository, saved);
> +

Even though this patch does not aim to do so, we lost a bunch of 
'the_repository' references with this change which is nice.

The patch also looks good to me.

-- 
Sivaraam

