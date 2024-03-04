Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF5224FD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546172; cv=none; b=EPMQ5iVrTw7MLmaVlp5GNu21veSywHo1T1hg+8JDU5IfIPN0bXMZ1JnNU2K8GjfrkbMilYo192g77ID84X86/p57HGIurF7pfM5jm6rcpm2LJP51iOQeSKynfcdwWbxMS6gJnBFJh0f/LIioXIW7vOYyYH2DLwFrKPoGAtbVmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546172; c=relaxed/simple;
	bh=5fG2fFX8VYJ+m9KX++RMCsotajjMgYGxnBBEj5Uoj54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfO9d22OLsbzwI4qbxgarZOy2rBLS1SZPUL0Mh1WZ2jMvF9TpxEkNJVVGEyBq3QoiY3o6EpLLugoaF26sogCCT5QSrfZHF1jtoo5wTDCSQG+wbUwbmrve/JJD7gCgRjbdIAgrzDohCZx1CDgFvxh5WjPzNws40PZFFU+xNbl3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBjyZRyr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBjyZRyr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3235697f8f.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 01:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709546169; x=1710150969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9q87HXq4KfpEDgoBxPuFQEm1spk9LcvtXeMyGNHkGIk=;
        b=aBjyZRyrWsqSv15++0ZqzoQSHxlcvjLI0LgNyyqY37hkuar25ia9Q2FetWZcr1GBKm
         zDE5cL0xkOAMTm82Gt3fTh4kBcgHdiZn80EFdMcnHhrGtOCDBBulNHgmJ2hUv6vRbwIk
         /2pBbav52opGBWNL+yHlhbJIe/pRqg0tfFvc3xAW3RC8aFkBveZRtnF1RvqHj4OGR7XW
         8DYq9hG95ecb6HGlN600LgJ2oKtV1wpXv/ZPXUa28e5pBYDywSI6lB0gTZclTCRHfv/4
         nGHRAPCpfsJAUAuHiY98uKrwJ0llm4T2e/QhH9q0PBi5wSFddrbUYL7GTS7FgObWFsNt
         aWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546169; x=1710150969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q87HXq4KfpEDgoBxPuFQEm1spk9LcvtXeMyGNHkGIk=;
        b=K7W87KgWedbE11c35VbmxHyVYD7sQhMuRBg8nNLR248mEY+ZcDZ8RdTXoV6pBTuc4J
         EO1JC6UAXkUc4ISmQ1zVul+/w6O3pXxNB+gGcwbOyP6jZfhwvUGg55PJJ9Lvfo7FqiH7
         tFckdH4qJC85o/3QbjSb6DmhRf6/KjpLvhzTbr1vwjkO2u56eO9RPNo6bYwAuunBzD4n
         sLdFtbV9KeRIvBDQClzhDTV6J+9KfMSKok9qVwBrCZ6KKzopL7e+wYTK3CB63IxBIYBU
         0WaBckiAp/0sHsWILaE3iKpQIV+yddVqFtIBp0DtXFmcWofJB6Ql6vy6Gno1+P+jHFEW
         hV9g==
X-Gm-Message-State: AOJu0YzVVnvwor1263UMSInqN7RKbfcqSgGsYbVbVM3GPfFk8u/AXuQR
	cYxPz9doLci28WsBWIekIV+XY2qNvUG0eOS7/JXpCn1qGvO/KgI5
X-Google-Smtp-Source: AGHT+IEN6ngCJNdMD+T7jEYfzunZZhkAMGgOfuA60fp3TfRQxHDrLRdnwlOdlDYMVZa5mkgEw5VSqg==
X-Received: by 2002:adf:fac7:0:b0:33e:3a4:6c1a with SMTP id a7-20020adffac7000000b0033e03a46c1amr6700203wrs.30.1709546168858;
        Mon, 04 Mar 2024 01:56:08 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033d6bc17d0esm12047001wrb.74.2024.03.04.01.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:56:08 -0800 (PST)
Message-ID: <6d7d6be1-6d3f-49a0-baca-2a05b8507e12@gmail.com>
Date: Mon, 4 Mar 2024 09:56:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] rebase: teach `--exec` about `GIT_REBASE_BRANCH`
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
References: <cover.1709495964.git.code@khaugsbakk.name>
 <4140fca4f454310d215df8bdac237caeb5c38521.1709495964.git.code@khaugsbakk.name>
 <xmqqo7buuce7.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqo7buuce7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2024 23:24, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
> 
> So, isn't it just the matter of surfacing the information that we
> are already recording and is already available in a fashion that is
> easier to use?  For example, if "git status --porcelain=[version]"
> does not give the information, perhaps you can add a line or two to
> it, instead of duplicating the same information in two places?

That was my thought as well. I also don't think it is helpful to think 
of a single branch being associated with a rebase these days. If we 
update the output of "git stasus --porcelain" we should show all the 
refs that are being rewritten by reading the contents of 
rebase_path_update_refs() as well as the head-name file.

Best Wishes

Phillip
