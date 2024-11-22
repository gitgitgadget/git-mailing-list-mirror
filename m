Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2ABA20
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289177; cv=none; b=IiSODGRaRA4IWXovL7k6VhRk6lT9Z9W2y6YqSeg+nJO3Z9Z6QZFuZJF4zKm6nmvk1J/WxC0zxxyLptgsR2tBldyV3LAeOcYQb94WOmpLuWOUvDlS/FAcDCzpUw+bgHmyM2t8/f5Kpzsq+2b33AE9D1WYYL6hG6wTPf7Gy7cOPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289177; c=relaxed/simple;
	bh=dKsFMBfV8xXGUlKM/9UhQTF48QSktRsDVND576MTqDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hp9ScIpkw5NccyxHiu+leRNgXmaVzhjY7D4QeO+xf0edF2HeyBwP/Caoqze8Camsg00W9fb48H9xQhdRpHOx9eLyOorwkxnbzSrAOLDH1Q3q+UCmMRuMHuP/iGDXygjpzwPAYtNcTKyjHMkeEfBSRE9LbpwPgPJ+D2eklsPKuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsLgPGqn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsLgPGqn"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e388e1fd582so2219776276.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289175; x=1732893975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBpQUbDoCySm47/oL3SIUPYMu+LwfO80Y0aviNM4S00=;
        b=VsLgPGqn1Xfhia2l1ZR1HXsk+kQUWBM3zI7eEMrTGlD0pMgke0FD/pqYnZyORBHwQm
         Bhg+/FPssRnbUHIKVDuPbPqqpdoeERPDG0aTMJf9pzZQ7t3s+uSe0EryzVzl++uwE6WE
         8ud9sRPF+u2yG3ZZwXE4qrEd6gFKxJq8D52a+hPijYFJCRyIXF3yeLSwrASgU8gUH8pv
         +DK4WC5G6cQi15/efz2ml1hZfIV6LMod0c8mc8j8aOC+tIyBqBpkrdvKJf3Gu4wtv8uA
         Ll20rS11AOmiqPNCLim2e2NUIpoytqrTSCxqPeGc2gK99TWQ9zRwFrjxX/fzo+e49+Sl
         3N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289175; x=1732893975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBpQUbDoCySm47/oL3SIUPYMu+LwfO80Y0aviNM4S00=;
        b=pMt5LB+OkOZEQdKOtbwTMXyE1y/NIC5XvSgSEFjxrxanXCn66i3lWrURKyNKYfn9MG
         NjWkmw4P0DnBU0LXNVEA5vTCLkDBj7pjbHPG/SlOkCuTsU7kAAPlHLtpzmoWlMi9tnqX
         PHUZ7qGwkxeB7oa59MDj/mO2NyUANQdwfbgi2Yj5RY8CfKww1oKM4fIoiTU4a/ZELsIe
         CXZOSqXSXLOhhQliT+VuJrtcgqHHlxJYX5VFSKjYBWKyL4/NtKghSpp6jjuuu719mns7
         qAT9QnKgCMPZSjCsmlDbKUTX4Nj2blCqFRmRLt9PPK80j/Y+s95eVecOnKsW+kmM/jNX
         hVOw==
X-Gm-Message-State: AOJu0YwLOksoHtKJvrbdO9xE6m0WTBIitoJdQkcmXcO0FzkupNP/vRZT
	Fuf/ljpMKpL1muCJj9chlKnWOce6/aqiJZsTCHw4PE6i1XjzDIPB
X-Gm-Gg: ASbGncsYINLd00uBwGqkH+2rzlvrWd5DkCbcaWbhMvYguzaNh7M6/OtMdJUV6EZArdP
	rn+knSD1dz8W7wvwVHl1U5xNKunTpO1tTAI6xmvW7jSsBkE/BpUpRGt+pxStjPp3t5Zg0fw1MbH
	mMyTNEThhZlcHCS/Sn9cE1Jqhfck1pulfXeN1UEaCWYaBSY94Xdt31f8SqdD4ob1vU7EbZ958Gs
	gONo0zZneCV6YdotLix6uQ1VZH4yh8Dxe7GOVkLkEOidrgbS+3cSM8Xwecf6kT3KdCEGTMJ26VX
	FTkQxmHfe8KGB9lAnI1rO1tmLmcIA5DNoupvmg==
X-Google-Smtp-Source: AGHT+IHyf9lIadYPxfYx0PQLVROjav66bBxTbqOAuTQ6PlYBeMRZ6co3jHA/5gxRjBZ4du8iy+U44w==
X-Received: by 2002:a05:6902:124d:b0:e33:336:10a with SMTP id 3f1490d57ef6-e38f8b0b940mr3648555276.14.1732289174641;
        Fri, 22 Nov 2024 07:26:14 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:313f:79e7:4a86:b985? ([2600:1700:60ba:9810:313f:79e7:4a86:b985])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f60b50bbsm645140276.36.2024.11.22.07.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:26:14 -0800 (PST)
Message-ID: <6a2f399c-8d65-4d1b-a541-b139d3e8fbf9@gmail.com>
Date: Fri, 22 Nov 2024 10:26:13 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] git-repack: update usage to match docs
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <65784f85bce943e6a6bf29d7a57bb106aff8226b.1730775908.git.gitgitgadget@gmail.com>
 <Zz+VRZnWjsDI9bLt@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+VRZnWjsDI9bLt@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 3:17 PM, Taylor Blau wrote:
> On Tue, Nov 05, 2024 at 03:05:04AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> This also adds the '--full-name-hash' option introduced in the previous
>> change and adds newlines to the synopsis.
> 
> I think "the previous change" is not quite accurate here, even if
> you move the implementation to pass through '--full-name-hash' via
> repack into the second patch.

Ah, I should definitely rearrange the commits.

> It would be nice to have the option added in 'repack' in the same commit
> as adjusts the documentation instead of splitting them apart.
Part of the point of the split was that the synopsis in builtin/repack.c
needs more than just the addition of the --full-name-hash option in order
to make it match the Documentation synopsis.

But you're right, the code change is small enough that these things can
be combined.

Thanks,
-Stolee

