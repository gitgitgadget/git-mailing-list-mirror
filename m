Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D911B0F20
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490769; cv=none; b=nKt3aWwKJ4DRE+t5SDNAifD27nOSM0Uu+Vc/RnYAYmSAVgTTr0qyjFibzDfXWP/c9XXjzV/ItE6GBrjtsDNTmYDlPR/tKLWaCNTubS6f4Xnr3GBxF7jU5+LEqAr2Bj98GQyvcOax7Tjkp160YIoSiBaqTw4r3C8tYjV4jnaplu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490769; c=relaxed/simple;
	bh=VoZd06IF9SVg/6Ikfb0iWapw51Cj9Y2y0mJ8PUJymFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jhyRxoSdm9P0oPb4yBax9eJZ/IoaLjTmgMubhKtXlOVmErT3lmcf09YolrB5dgH4Eou4gkm/lPikd5qooV2d/nydgoqRcvuPqmYCMCxyhNEp/oGzLv4tRhXSMiT8gcFPkoexRHgqxnv1rti8XlsUpQhKDioriwRkqoan8bBiXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EranmR5f; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EranmR5f"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3983426f80so9387679276.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737490767; x=1738095567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMdsuNBtY2CYnseyo5wQ7/CeGPz8W5Crb6cBoMM9/3M=;
        b=EranmR5fscyP7CY26hYDzoF+v9UotuMnpX75DNKygDD8zEHOJ74KyyZe6FMh+ourdN
         ceuA0qp+VJEWB0deB4T2Ujv394rsW779xqbo3cioD0K/X31hodeYlGXitLoTFYezQJ0G
         snZyIiVVFEBCpIptW7E1/yYLjEAKNTDSP6MTo8CM9/Rgy4A091y3WEPRTHVC6Y5teOZL
         2UkWENJKWMdm4TkhOJBKwa+NrcohLxJjno2OuuX/orjMgZuiATwjGQflUyuvyBWcyzM/
         KUbT5Y2Jtpy6RxVM5A2wUIydzZrHK2KwOUrznvo7WUmnCCfqFwl94EbFe+Et8XOih8f2
         htMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737490767; x=1738095567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMdsuNBtY2CYnseyo5wQ7/CeGPz8W5Crb6cBoMM9/3M=;
        b=GDVCd3dq6SEFvZqK0+9tnNfpa64WK3URkzPQQvilroMVv5xc2fU7VNP1CMeF+EJObU
         YUqA6HBSfqdUGyJ91d+PWsju7vJhxoNzqasMSeUryEmN0Tn/CeSrnedtByqjy/dh73oL
         MAp1l9U5W7U506sd/hG4xzisy4zxfMJlRIR0xKANT9016lAtceedgAExfSlvqpBmizTT
         X0WCeabe0gwb9PfEyEGlAzeBNwi0INiuEjnb7Txh4wuevg0MYTnDbjgG7nkqVruQFpAC
         f26EkW9l0V609qSv2MeF5zphapzgJt1muBScWT+L0tsY0kt02j3vPkuIxl36KDUkwYwz
         Y39g==
X-Forwarded-Encrypted: i=1; AJvYcCWqvvA4R5h4cwNfDwpmA/981FY94zU71wpXnIr1/YWKA2VNONRU31ymFVKbPvD35qUBdtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/DuG8gATnCIYLa46TYt7mhE/Kq803bngTge8yBeLTfpKQw78
	qbvAfjM6mPcslA5PHTY1NcOsgmD2n+9FaL4NTfClzIbgwzhj6jYu+/C1IiMV
X-Gm-Gg: ASbGncszOzCF2YJbq8Qd3DL3l55d2AVNiA0jR13QHJb30C7pRHqY3HCPqOLupy4jZ1d
	FVt3SfmLrNDkDGyxymzmb4F5mHIPX5risiW/JqEXAQ2X6lsVNOgdQz256qGor0m+pTf9Yw6suK+
	Up7wmlyje/a4xQW5SFmn3RQlSDUBJy5/9TvuDsHCnjY7xvVNWSh7eTmpigq4u/YZfsq9lgTbGD4
	by8L/9likZeHqTM7iF/w1QAPkDQzpDn52VGJEAdWWCicNpQ4jzRzBdKcNoFbm8FGdTt7NkciNWI
	dj1gLrcIUXT6EOkAsBrYByKRhmLfaLVAgLRx/BCt13A7hxzriYrcmUQI0Q==
X-Google-Smtp-Source: AGHT+IHww/OeQgII/zMx5HHUxvLMzXWg8cVB7Qm75L1KeDbmWwzoVb/7QsF6pyQPyzy58ztKNnNp0Q==
X-Received: by 2002:a05:690c:4808:b0:6ef:e390:1d36 with SMTP id 00721157ae682-6f6eb6708b0mr145094877b3.12.1737490767295;
        Tue, 21 Jan 2025 12:19:27 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:c52c:1d3e:3dc2:a210? ([2600:1700:60ba:9810:c52c:1d3e:3dc2:a210])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e6405690sm18128547b3.43.2025.01.21.12.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 12:19:26 -0800 (PST)
Message-ID: <1331d214-890e-4b47-87c6-44f445172bb2@gmail.com>
Date: Tue, 21 Jan 2025 15:19:26 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwmetgdgm.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqwmetgdgm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/25 7:42 PM, Junio C Hamano wrote:

> * ds/name-hash-tweaks (2024-12-20) 8 commits
>   - pack-objects: add third name hash version
>   - pack-objects: prevent name hash version change
>   - test-tool: add helper for name-hash values
>   - p5313: add size comparison test
>   - pack-objects: add GIT_TEST_NAME_HASH_VERSION
>   - repack: add --name-hash-version option
>   - pack-objects: add --name-hash-version option
>   - pack-objects: create new name-hash function version
> 
>   "git pack-objects" and its wrapper "git repack" learned an option
>   to use an alternative path-hash function to improve delta-base
>   selection to produce a packfile with deeper history than window
>   size.
> 
>   Comments?
>   source: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>

I'll poke the thread, too, but this seems to be the most promising
topic in the area of better delta compression. The latest version
does not have any comments.

The only decision point I think remains is whether or not to
include the last patch (--name-hash-version=3) which I would be
happy either way.

Thanks,
-Stolee

