Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374D219E82
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714194; cv=none; b=rAOGrRBKRHtBYOG2YJRsZaDqEXLqZYvxxpLJwc2q0q7gBYw59emBFnZowGUh+pQb2O6Z/JUIVfl4Mw8NjbbGz08YaZIw9RTnHteeEfy/Os8r/IcStz/MdEqQYWK7m26LkKFlJunw8L1sZi7LeleqsUK95b7IlPNXjfYs/M+BghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714194; c=relaxed/simple;
	bh=GshU2/KLPNo74VmnFSPJXSPTOiG5BmshIYw+FBvXHEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK4RZaUsRvtnwTodW95bs4tcrpd5egeZbti7pp+mLdQyx1k3jSk3aWY5drsVet8WAbJpgok7HAh0V6mUt09D9wyrMq5SH6jj+vYBkjcMoRLJSchbg9OM+MaI7yWYADtEymT+ifevRYGT71CmNhCc2ywPgWAcbkjltpgHlB2kwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcHWency; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcHWency"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39779a268bso1887468276.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734714192; x=1735318992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwNIiW3VtzsSTdx8q1Y3GnR+TMSlVX/lgIWzia084tU=;
        b=DcHWencyQBXGJRLBCPArDpwCmAdufTdPETQi5YjOWdyX/vkfcx3kCBwcsNLQLDbjzU
         Mev8umXMhQwH2ngDusBkIOVzmxTln3cKP8ITNnO8iWO1cARmrGHLz2vcgAytgilSpLCQ
         rukMXPUk/yANfd/Zxif+1VxQWWtGDj/Eieq+HbioQuFWBxbk2WRlVQtcEtcu8VwP+aPH
         l5fKLmZcrPf0JFBy2kT4/+02ymIQV+KqPbn5KrJZ1lV4dvQYa0uw/8tk1huWD4VDYR6L
         R5jSud51U+m0O2lTIaEIYqEmUDQABVqOzindSwHJoj0qU5ChciLHINyXmKJSUbjpLFVE
         dshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734714192; x=1735318992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwNIiW3VtzsSTdx8q1Y3GnR+TMSlVX/lgIWzia084tU=;
        b=wWiR554GufHLVMz6XtRfXDbcv1DxZhrtgMC0dLCzeAF99k5LkjpCS1jk0A0/jC1/RP
         WzgmHdA2uzhBDNa2xQ02cwrfx/WmvMsOYZIqgt/rwUkwplhnpVguxufGMBOLbLuvTD2Z
         bxhZlKu/X2/1wQnip3azrBhEsiTI05BC9570vcxAxNfgQFk/Dk/gx8eW/nSW7PZ0kFoe
         SGOamEdbBbUV6oLOZseO+X+5NvrCCvSv6EbWgPjBUxp3eY80ReAIR3t100t7O7JschaA
         fq1EN5mkl6ozd67/pk5CJ/c9bYkCcueuL8KovvfzZ1o0kwxZeriOnA+wzcfuYr6J37bI
         SRsQ==
X-Gm-Message-State: AOJu0YxTp8rNdFayld7v9MjvxATljtU6/XelWyTSmQvD0J1lkT9Td+TU
	/0byiAMYcocF8p0gNUP/DOgLa7uc8JNDHIwEW1S8dkWCGVH0RTQT
X-Gm-Gg: ASbGncv3OvJbOp/0hvTlQDEzMtC4C1DxfZv1UYSOxO5AkTbJXEf/j3C3lpCsHTuL74I
	BEQlWOZikkPKBu4NHFKYTttRE8Hn4Q7pLuulMAfwsWx6r/UOETY+t2/OR+5IIapqAwfWkE10W7X
	Uhy8ulXbdn++EVk569cW0rJ5+0I7rsk2dEU1SE1OZeYwZoyOEyIeV7n0Rlb3hcF9HM17GL3kQX3
	hn0WL0dcGbZkjFu/j/3OtEVuTRaW4Sv1zzu0BHPjmpFMmWC7a/N21MteBcA5pYF9iGCinPCnIPo
	8WV5uNA+6/sxawkE2Tr1/NiwUYru+FqWSfHShTP3sw==
X-Google-Smtp-Source: AGHT+IEVdglFKW/EdIaxbSJ9Y6xokq8AuscLPCtCj9Me2dbQfB/wm49wCwm03SLt8Ce2T8PbKUUk/Q==
X-Received: by 2002:a05:6902:280a:b0:e4e:32d6:e9f2 with SMTP id 3f1490d57ef6-e538cd02015mr3272181276.6.1734714191921;
        Fri, 20 Dec 2024 09:03:11 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:749d:17a4:27e:8972? ([2600:1700:60ba:9810:749d:17a4:27e:8972])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cc7885bsm902680276.27.2024.12.20.09.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 09:03:11 -0800 (PST)
Message-ID: <718f22e5-5ddb-4efc-a46e-33c8d7c4f362@gmail.com>
Date: Fri, 20 Dec 2024 12:03:10 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] pack-objects: add GIT_TEST_NAME_HASH_VERSION
To: Jonathan Tan <jonathantanmy@google.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com,
 newren@gmail.com
References: <20241209231201.841076-1-jonathantanmy@google.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241209231201.841076-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 6:12 PM, Jonathan Tan wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>   t/t5616-partial-clone.sh        | 26 ++++++++++++++++++++++++--
> 
> I believe the changes to this file are no longer needed.

You're right. They are only needed in the last patch when the v3
name-hash is possible.

(Unless maybe you fixed this issue in 'master' and I didn't see it)

Thanks,
-Stolee

