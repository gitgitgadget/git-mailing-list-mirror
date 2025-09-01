Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54E2EE268
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721407; cv=none; b=g9tg1u9Fw0+XqN52jWpjxvg1p/KD939ezMZfpxJeC5xYaQG9T19FGZDRfXnYpPF1Q1PI+E5zAnozrrmxhX98NFUFoD7iLDFbvcY1j/ust44c0AEHvvyozNXgEdf8OiFcUQijYZ31opQsc4iGCQ/Cobd8rCALJJJePBoZpMqiQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721407; c=relaxed/simple;
	bh=Twi0TUr5c4FQJP6TrXt4UWAd1X5ZR5BHBaoRs9WBMLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=sUymg5qcHypElMtg57Bz8H8lYu1SHF4GFfubg2KGCufgPsCg6zeUnBqSyEdYQ1fn8GhQdz1+kQgk3u19OmK8cYmBRYvNJCe2d1DAT1ebaIlciwNXTdR5u4VFgAAHhiEk0gS/XP6Fd6LJ5W45q92Zpexjw/BueoqcS4Yo5BmY1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRZGcWY7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRZGcWY7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7c01a8c1so32761045e9.2
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756721404; x=1757326204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSCIsRlEW5CeTM4Mrb/HnIwa8mHCL+Rb1HK8XN1O3/0=;
        b=aRZGcWY79C9U+OTdjJrla2llpgAhzRQhOjvWaQ/1Pu5g85mIUq1Au4m+C4JIWsSRPY
         Jdip3hPEuEiL1KrOUCnH1Yk6uuPbS674P5tA9ymia1QUlIHZBpD6+uejVHbpI09GPGCA
         fssKRBsu7g8qLsOSUqtPngKiixh9LkeVk7tAZAz6eWoPE0A2PkLj+f7reXuiuiPMlBKB
         9+cF2HU35T6duYnV63z6WbV97bnWnGo2Zf0GSJZJKvigMotYmkm7K24VNqOAvYdIZmdT
         JkE7PYxE8UwFClmafLvxGYAp4Y/yUYFFe9LNTF2PjUpgRsHKR/b0pYriELimh2QCRUrb
         jktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756721404; x=1757326204;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSCIsRlEW5CeTM4Mrb/HnIwa8mHCL+Rb1HK8XN1O3/0=;
        b=Bv/a8Lb8LwXOIOdUXXghi4R7kzr4V4TVm6hgOIqIvkxIbpLPHr7Nu3hFcxgzeYFMc0
         6exyulVuGdGhTX/C0Uhfzrj9a4oxGDxRpuqVTvvt6l/ov7Y9mh3ruuAvUHiEXWagjvx6
         JhssR66K44zbzKU15p93NjLNhi0UfihWxS8RfXVjhY+LtqVXsc21QHSUC4vjwgs/UUDc
         nOhzW8P3gIm8BqzPrEpfJjpzkR7PwujluUwcyrGlRBL1R+S8XJDsbfqI+ZNDZFKHWtYZ
         BAqpdcbteun0H4iwCSmbRppep5rIfLHnyU0tJCZwVasowX8hsV7vQSggVGXFsypgZ3Dz
         XDaA==
X-Forwarded-Encrypted: i=1; AJvYcCXC6mug9G11GaQMHMNqFkZKutk1UJ16jtShlZGl2e7tw88so1c+Cn7dD67mBnOUIbDizUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8jLODqlR7GKDQjXVFmLJAwGAvl/ncoJIqJXGP9a4i7qcVCsz
	rkkzpG6F3O5kxgiYcnU6RViKJaRY9VC2X0U8VL8DARx9GNwcxISYm8We
X-Gm-Gg: ASbGncuV93fHc0I/9U+WE8tSNmk8EGkrkIuCLOsKVCJ8E0AYD7Mx4LODffYBdzQkyXi
	XGBLtyak+pV0n5j7aUGy/WEcR1JcfPPSOPExQCpST9acAgIqLQTnUwYUtusnK1zQg2VsVShHFuW
	rINE9WvMqISZ3ZtkZr9RY3T5L95ELSZ2E/SZ4shfrqWRuX9TlgRwGVx02QZ0+FY+z/Tz4X3KN4I
	gc0KstzGCpvpjLOZ0RO3MFktDpNlusxK4xm3zQbNhz0paPAjVvvxlzRwh4svzknWz0VEugNxdlD
	kxH7wkM869Uv6pSuyhyhk/JyTFZIRcmnxhp79evnmKYrslYiAXBOGMrQUF4jf8A5+leBvsiBtrF
	F631rE4xdZZkw9haVwYZYy0gSRqJq7NunihSdAmu3dlQn8YYKVEzc66mSCWy0P3eknBYyw2D0Du
	shHUFVf+ICQP/C
X-Google-Smtp-Source: AGHT+IEefly4ujQ0dlrDuExpxLBbuByTgJx0gFR1VsVRxhaSpOP2LZWzKRWuqlKCH2eJN68UJjCl6A==
X-Received: by 2002:a05:600c:c4a1:b0:45b:84b1:f638 with SMTP id 5b1f17b1804b1-45b8559babbmr48522925e9.20.1756721403539;
        Mon, 01 Sep 2025 03:10:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm149906445e9.3.2025.09.01.03.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:10:02 -0700 (PDT)
Message-ID: <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
Date: Mon, 1 Sep 2025 11:10:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git Stash Synchronization - Best Workflow?
To: Brooke Kuhlmann <brooke@alchemists.io>, git@vger.kernel.org
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brooke

[I've cc'd brian to see what he thinks about setting up a reflog by 
default when exporting stashes]

On 01/09/2025 00:25, Brooke Kuhlmann wrote:
> Hello.
> 
> When using Git 2.51.0, what is the correct way to safely export
 > your stash and then keep that stash up-to-date? Here's an example
 > workflow:>
> touch demo.txt
> 
> git stash push --include-untracked --message "Demo"
> git stash export --to-ref "refs/stashes/$USER"
> git push origin "refs/stashes/$USER"
> 
> git stash pop stash@{0}
> git push origin "refs/stashes/$USER"

This push doesn't do anything because refs/stashes/$USER is unchanged 
since the last push

> git stash push --include-untracked --message "Demo II"
> git stash export --to-ref "refs/stashes/$USER"
> git push origin "refs/stashes/$USER"

This push fails because you've popped and then pushed a stash since the 
last export so refs/stashes/$USER on the remote cannot fast-forward
> Notice, in the middle, I pop the stash only to rename it. Upon 
 > pushing these changes back up, I get the following error:>
> To https://github.com/bkuhlmann/test
>   ! [rejected]                  refs/stashes/bkuhlmann -> refs/stashes/bkuhlmann (non-fast-forward)
> error: failed to push some refs to 'https://github.com/bkuhlmann/test'
> hint: Updates were rejected because a pushed branch tip is behind its remote
> hint: counterpart. If you want to integrate the remote changes, use 'git pull'
> hint: before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> 
> The work around is to use `git push --force` when pushing updates.
 > I'd like to use `git push --force-with-lease` but that doesn't work.
You can use --force-with-lease=refs/stashes/$USER:$expect where $expect 
is the value of refs/stashes/$USER when you last pushed. The problem is 
that there is no easy way to find that as by default refs/stashes/$USER 
does not have a reflog and there is no remote tracking ref set up for it 
either. If you add a fetch refspec like

     refs/stashes/*:refs/remote/origin/stashes/*

(note "remote" rather than "remotes" to avoid clashing with the default 
refspec for branches) then refs/remote/origin/stashes/$USER should be 
updated when you push to or pull from refs/stashes/* and I think a bare 
--force-with-lease will work. In general --force-with-lease without 
explicitly specifying $expect is not that safe as it will happily 
overwrite the remote ref if you fetch and do not incorporate the remote 
changes into your local changes before pushing. Using 
--force-if-includes is safer if you don't want to give $expect 
explicitly. That requires a reflog for the local ref though which you 
can enable by setting core.logAllrefUpdates=always. We should perhaps 
change the export code to create a reflog for the ref we're exporting 
the stashes to and maybe expand the documentation to mention setting up 
a fetch refspec.

Thanks

Phillip

> I realize that force pushing over your remote stash makes a lot more sense since you typically never share a stash with folks but was thinking it would be nice to ensure you don't accidentally override your remote stash when working on different machine when you forgot to import first. Basically, wanting to protect myself from myself. :)
> 
> Is force push the only way to handle this use case or is there a better approach? Thanks!

