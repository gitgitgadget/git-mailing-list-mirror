Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A54F55A6
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369661; cv=none; b=Fp5CLz5D9HLFib2QMX+K5LrIbyeWcRzgWnfU2c8+ue3P/EGY9bdbl+Ih+RREE+b7k4Q237sOZ0LGdpEsSNVT5wGWdxUZgYXRGtnBuBGwKgPFvwEqTWlilqFybdqSKt1DnWaqLARIRCNnDoxKHSQQ3BiZHkFPG8tuTmd6OBz8oAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369661; c=relaxed/simple;
	bh=QJf6TRV/x6nfA0d+vRCvWkPhkJadctes8ti5/aV9Dxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mpXgL8z9BcKR4CxVEx1eARUIJrWS37W1vlZvtRGD5V50gGZExTJi10EsQA6md4ktsVVFMB+9WLb8Yee+XipLLAWn3qIo8pju6eZ6Dhly7hPlwfsguYDrhMQxCEfzIEV2lrNA0G1o4h9NYGs+8lCrhpNUf+xcQpqQCE3Dg6O3Apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/Tb7vbO; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Tb7vbO"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace19so659925eec.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790369659; x=1790974459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EaLJrxT8lt6pt+FVU/1+dJ1gkDeSzIgJhbnPI4gFO1o=;
        b=N/Tb7vbO8HVi93x5y+14ZyjP9xw4kylgWKUo4UioA32JTuKHpkGOO+/XbRyCJ1JZYW
         qZrVemMhiEuZRVEbvnN1mUxPYR2Y5uIQ8yq/e/mEW7W/FBIUj0IUrfNlnJEmSsWwV8gy
         ZjPfTy6o+z6k2MXU3WUU80BjvdHYx2nme4ituNmJekfRwcqjJ27jtP+Ntm54sYHB/utI
         MPa5MlKuruVT2JQQoV1vqK+2UYh75E6ww9FNAKylzL9mF8MIetPz2xzxxJtdODgLycrk
         dVHy3w8uFWRG9wN3J3AnFyGEJNG7h30cHmVOAER9JMguTZ6noXZsf8GtVl2gMXrUrGme
         qgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369659; x=1790974459;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EaLJrxT8lt6pt+FVU/1+dJ1gkDeSzIgJhbnPI4gFO1o=;
        b=LRTpL8h9nEngJFsRv0gTexsD8PbMIl8SC0R7B6dWjf8Q1bp8L6OF6JIiUQT8rA2hY1
         UhzADebMpmdpt5knX1hmgZqXw6xWBISUNgYEIRyuFM1ZcNr6H/j3geQeitzr5fxzaL/v
         cAsVkHm0ehxx2oA+oZVNEdT3rIW2dLnlQTxVyy1klemSNngtTzCn5E/a11iiCW9KwFPO
         i9ISYBfubv08AFu7zpHz23rgKLmn8IpruB/l/DzHjtOOf4wWW+2SxouEikoV/4DG9olB
         bffL8zFzlmWyT/++btSL5d09tT2zbxMEo+iZEVsupDIDLq/OLZDPFYSsSDc14R6Xegqs
         WJAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaVoyIKJCJQjUTI98W+pu3KBzvogNGIdUchZmviKYHxGnqH0MEt9U3D0rpeiI14pQUS94=@vger.kernel.org
X-Gm-Message-State: AFuF++kBJLj9JGVl23fTab3noH4IPPJa5YNeXHTUduzXYUya+tw4sJhq
	toBRoC8n6BirUyJf4Xz6LNLgRdoepLTKjfrNb4LOY3V67MH0xsEVWz9v
X-Gm-Gg: AYBFou0I6fsKQY+itK1456irgCK54Sq/bg7Tg722DF+XuFsqFF03Cpji0bJOfTOv1Mk
	qDaDG2Vsn7jDEry06NvmEJqnEt3kMRswDiEzgCdGCSMrHns5Hl3186SGcnilDYC1tL1bnbvMYdl
	zOvr8SdpYKr/rBKNlUYMdSf1VjEbY+gXvXu1JZE9Pv9iad5I5S1DdPdZ6nScKWGRrVVrQyK6gdy
	UNZQBDVJzc/RrLIzIfMo2reNm4XooFUd5akqsoufgnyLsoL8BavesyF4KNmymMeelDQzJLow/ER
	61Qo44AaIJ5Lg/5SRvQtXxvNKz+OaHkAfkF+aPJllglkuUjWQVm6NMMZ5Qs9YEECMoJFyyvbClc
	8z5FPqQe2aerzmFtxXphjxameZklSWht+8sltnYQ69rfa+fIo5xetc6NJLiWSoUgtU3SjhFkQMC
	wgu+zbSSTm3yrb+UZhTkHoBbR49/lX8JNSJbDK/q86Wf8on5EJZho0c4na/coGH509iWvalafmd
	lvYnjwKxdYPkPRIpreP45M6UUuskOuwbK8kNh4zeLAVTQKgxFl16Q==
X-Received: by 2002:a05:7301:1a3:b0:33b:dd20:f78c with SMTP id 5a478bee46e88-34272e5e6aemr1219983eec.34.1790369659264;
        Fri, 25 Sep 2026 13:54:19 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:a5bd:5e99:a91b:f02d? ([2406:7400:12b:61a6:a5bd:5e99:a91b:f02d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm8278803eec.6.2026.09.25.13.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 13:54:18 -0700 (PDT)
Message-ID: <4e26b51a-f811-4548-97e0-6570680efa13@gmail.com>
Date: Sat, 26 Sep 2026 02:24:15 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] builtin/init: move handling of
 "core.sharedRepository" into "setup.c"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-4-11499557cf31@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-4-11499557cf31@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 14:49, Patrick Steinhardt wrote:
 >
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index e45268f1ff..34215bbf18 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -171,9 +171,6 @@ int cmd_init_db(int argc,
>   			die(_("unknown ref storage format '%s'"), ref_format);
>   	}
>   
> -	if (init_shared_repository != -1)
> -		repo_settings_set_shared_repository(the_repository, init_shared_repository);
> -
 >   	/*
 >   	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 >   	 * without --bare.  Catch the error early.

I was wondering if there'll be any function that between here and the 
create_repository call that may use the_repository. I could not find any 
from my reading of the code, though. So, this looks good to me.

-
Sivaraam

