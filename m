Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57062571D8
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497969; cv=none; b=XrZqgUREH8v7u5tosP+42AFq9BkToWI/w5qpjweEYQ0brvFM4y2iTfGp2W9/W4XSF07DfUSUCsHwNYC8ZVPaZC34ozYeal8gcq478wB9AdAleuksXeih9Y3xdZRSb9WwvThwfN64++iN/uWUCvPOF7O1cG1HiMQifBJSgWzfDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497969; c=relaxed/simple;
	bh=PCI5VUX8jCzbijHDBquw8tFqqHs7fJAdr4zS8i+dPTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI+fyZJbWpt/XyPNfqhANSUHbNmvXvWPhXHBdVMRnYdmlfkyXfNwLg2sUYb28isZEhIqZZtfzzjFT4onVe4VGjPMEpxTAN9o/0O5jE32yvHu04kXZKD9t29F4+tSBbZRbbK0LgbSKDrB+UUG4DEXE1IcTS0cV7SMYMNZ45POTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE+uTZ4T; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE+uTZ4T"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3dea538b826so5561020f8f.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757497966; x=1758102766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=74kMluN9rDOedoTStS/ZbI7PoTcYBkx34PNCXDSa0DA=;
        b=WE+uTZ4TBrL4iKrlEEznJ9sAtwd5X27OwUAiMBe0kTLTaQjO/nvUaYtx9Piqmd0Jlb
         oYajb7fOxXe8pOIDFcrAzMG0Bf65tjZV7g95Zs5OZENrItyTNcYTzXLAgQh1YPvtVVgt
         U5Hbm6n6yZ3N68GzTZQ4dviaz3LiNG5ZVfxK4Gnz76KCxO0svzou+dlmLD7dW3ioAdxC
         w8oxKxjvSSANpIRNZFyrnwtNDX9dNVVsUxOCib8F0lUGHC3PrTWylWs60AH6DPey3HeZ
         aFL37Vg1IXbYHc3m5TaUWYeMk21Pkje1THRLZNaCBJNDD0XROylCsVhya6tPYP/lII1G
         16ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497966; x=1758102766;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74kMluN9rDOedoTStS/ZbI7PoTcYBkx34PNCXDSa0DA=;
        b=ElgRVJXONAscU5NBWQB7n1ifxq62EpodF3+AuCFaZLZD+a32CM5bGQej+1NSfmOr97
         cLOmhZV6gS6mOJy4PDjGpu056ZODhJv0TdMnpdf58MV3Ha/7ir1xhKJjd4g5kl6qkEmf
         H3BR7k/QmVm/tKlwaZF+YQDv+NlujR4Gvxi5BXSkpswjzvSV37lq7Q8lqM4uTknhi+9X
         tGuh5ZsNViNNw753rRUk7j/DTHUwVIdzPlTy8bOGrM0eGSPuTfabSlLsOAgdReaW674Y
         DL+6MpjtJSGgY07HhC9K8veWHc8eEKcU2av4XlTn5vRRh7t7hl29KBFPLZPwEg8ZYrn3
         wyvQ==
X-Gm-Message-State: AOJu0YyU9QIzdfRlxA1gVlvQEoybvuxlOYmFRCrq0UNCdMTyZVckV+VG
	XWGB6aesPytyx0R6sTDqIPk6YmylJSqsc7rK+nG+6b0cUBT9MDI8RxRf
X-Gm-Gg: ASbGncsgJhIjSNyq3O0eAOQMeuQsbqu/88nu9NVzw7dH6zn1v6rB0kjOsd5n7HcNwMi
	ovK5/W3wHCd8ILGygy6oJ72mswhRqnf2DZko9NyXFNf8ZZKQkZqSY92lcBueMVRqIccWS3E/1Qz
	TFpDszpyhxWVLqk9R6IGV7L8GzQZZvCLr/zgeX38vkLw59P/kCg6z4Le6jfPwNOFglNFHWGOPIq
	4FhUgNAla4TMy76uPGAPAf5+O9EKQ4/6CGDz+WtyS9sWnAYvw/DO3QAs19/3OHQm/gQysHmJuz+
	kZc6ImeXutGdt9uUg5oG6smIKvygdlLfeW9XDgN2Bl/8hCeDldqlMMHkA2OheEw1aI2SwxWGyaG
	VDVnlTpaqdJsZ9bxXQbfjU+CP2Tu1WGi7NVujpJLJAeBBsm1HyckKEnXqMecNMLzhrrtw0OB7hA
	8=
X-Google-Smtp-Source: AGHT+IFJC6an/Cyv+1zhUGaKz/7iD9ipl2vVLI2e1YoMsIhEMqkvrVapDLCoRn6o7IBgQJ7RvC8pxQ==
X-Received: by 2002:a05:6000:220d:b0:3e5:5261:9fa6 with SMTP id ffacd0b85a97d-3e6429cd6c2mr11980224f8f.23.1757497965872;
        Wed, 10 Sep 2025 02:52:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca0e9sm6611877f8f.25.2025.09.10.02.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:52:45 -0700 (PDT)
Message-ID: <94d614fb-63b8-4733-b78d-b55c482fbed8@gmail.com>
Date: Wed, 10 Sep 2025 10:52:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git Stash Synchronization - Best Workflow?
To: Brooke Kuhlmann <brooke@alchemists.io>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
 <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
 <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
 <FEB150D4-2B5E-41CF-ADCE-93DD0B48D364@alchemists.io>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <FEB150D4-2B5E-41CF-ADCE-93DD0B48D364@alchemists.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brooke

On 06/09/2025 13:50, Brooke Kuhlmann wrote:
>> That sounds like a bug if you're getting the rejected message above
>> but the ref on the remote is still being updated. I'll try and take
>> a look at that next week.

I'm unable to reproduce this. In the script below the final push succeeds.

     set -ex
     dir="$(mktemp -d)"
     cd "$dir"
     git init --bare origin
     git init repo
     cd repo
     git remote add origin "file://${PWD%/*}/origin"
     git config core.logAllRefUpdates always
     git config remote.origin.fetch refs/stashes/*:refs/remote/origin/stashes/*
     echo a >a
     git add a
     git commit -m a
     echo b >a
     git stash push
     echo c >a
     git stash push
     git stash export --to-ref refs/stashes/test
     git push origin refs/stashes/test
     git stash pop
     git stash push -m message
     git stash export --to-ref refs/stashes/test
     git push --force-with-lease --force-if-includes  origin refs/stashes/test

>> You need to pass the name of the ref whose reflog you want to look at,
>> otherwise it defaults to showing the reflog for HEAD. You should be
>> able to see the reflog for you exported stashes.> 
> I gave this a try and every time I use `git reflog refs/stashes/$USER`,
>  I always get a blank response. No errors and no output.
Ah, I wonder if core.logAllRefUpdates only affects the creation of new
refs. You can force the creation of a reflog by running

	oid=$(git rev-parse --verify refs/stashes/$USER) &&
	git update-ref -d refs/stashes/$USER &&
	git update-ref --create-reflog -m 'export stashes' refs/stashes/$USER $oid

the same applies to refs/remote/stashes/origin/$USER

>> Let's try and find why the remote update say's it rejected when it isn't
>> and then we can think about the best way to document pushing and
>> pulling exported stashes.
I haven't thought much about the pulling side of this. "git stash import"
appends to the existing stashes so I'm not sure how we'd cope with forced
updates - have got got any experience of handling this from your
experiments?

Thanks

Phillip
