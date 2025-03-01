Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF023F37D
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740830800; cv=none; b=bow6wrc1aMzH2JybR03qL5U4V2u07jK0lDrJy84XM3Z/kEVwIWO4cLtbFw7fRo2x5VBMB+Os2rCQte4PkBco+LHVe30sI2BVagsdgitaVSPEMLADn++7TT32wL5xhYHWcmL0XquHNkrmV1msl+vbxU+P/yeSWIxLwPUhBpD/RYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740830800; c=relaxed/simple;
	bh=5IocfBbUmTWwrEMDX8Ieh2mfjg6uGvdcY4Fbv5GFI3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxx6GPOwvJCjs+OnqpSWWvkmdXfsI32lI/I5GdPBBSHfR6KVNACjQ9HtnkLVkY63z53BoT8gQ6wtxaUY5yCA/7FQ71MIKHJbHKhtVs7k0B4Pqw/8Zoj5y29fOsu6IcRGTyGWcYQkoOOZ6A+73GEwzEoBOaDYQcsMniwSLpkgsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9bAn+5G; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9bAn+5G"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feae794508so3975741a91.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 04:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740830798; x=1741435598; darn=vger.kernel.org;
        h=disposition-notification-to:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTcEUlYgEtyAEmIl4/w+NK67YysQO02PPsXuswNd618=;
        b=m9bAn+5GreF5utguSdUwMaeGcuSgOjLq9/Ela94BKXyzCiXx4Cb2RQx7+6N3gGmc5H
         QikjI6QuseE2GB2XTdX/H8n1tiVeh5or4c61OIsRhMegD5mR2s8NSTMHv639DJM63+zT
         Yb41ojZDQzqse47Jc3xgHVWvonET3zFu0f82A6B8szyE3t5isKBy+CKnfwHIv5lA9QYm
         21hSTOb8CtfeiZT0wwOp3YDfCTUZZ+yXZKohqZPNTyRnZdvrEJPcodkb6Kj5thEx0vFX
         IQomIAtxrbKjZOtLEv+v/VT4TfXfdT/HptoJ5w7F9lm5Kkf5OMhBOrOcQxuvffqxZ+JJ
         WGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740830798; x=1741435598;
        h=disposition-notification-to:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTcEUlYgEtyAEmIl4/w+NK67YysQO02PPsXuswNd618=;
        b=fC7x/8rXvqFeAtJv/UA9djz5pP/G0WAmSx6S7kWzkyt2PRVn/xCdDtqCSJYIwRXXHO
         eRe070RunBRiIK4ruOVALkOYSjzXJ5Sk1BZyb17lSkFMyQ8m+hxGNp8LZJqM8GVPYUxk
         3vYX55VQ+QvjvCIKJFMX9Vds8SLm2dGuiEPjk5wwhnxgITLVOtCZIHv1rOGAsoEe+idV
         okJmbWxboybmoNqPkzHdvGx0/DnKI5Ik4bL6+GcKt50/zVDeJ2iO1XPia5WAbFyARPvS
         RswkSmaUpYH1qQQTyCR3L3brsboxPrN+XrnkliyneNDdyj8vrHSN3lbbe93Z7IMGaPIi
         sMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3YGriU4kTXhvUmF1i6W5px992a+ma9IYu8KJy0TuZn0MoedtwDlu9bIsl0Z60FyYf9L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqhcff1dlgwZSF3fPSpPsQgOk+WnEzWyruWbVRr0pAly8qhpR
	YnQH1vAnXVS38z52qAAD6sEEDC8J1LdWXLAzf+wr1s248t+qt/L8
X-Gm-Gg: ASbGncst82vzLt/8o59S1AqGy0EOUKT0le8pa+kySmI5CfkQPM1NUtL6gRNls4aQ5HG
	XNWAGElYFyaTN2dS5JUoYW75dtmd2FKgmy9bJIKePADa129KrNCzWbUYit3AFlAkiETQtMRPuzP
	CmYuTG4uIzyRqYSVYjQb7NqWZhi+H7pvyWGjCajNsxoYX15Qd1sVDOnzxArEPKdr0lfw86FkC2+
	/TSgfarMRFP38fYetDKOHPjeMhaC5KAYo54FERtZ9Sf8Ek40C0xguab39ujD9POi9IBTm89ftNV
	gjNJv2FLlh2FR94oD+jW9S+EW4VwUdRkzAvUxww2/tA=
X-Google-Smtp-Source: AGHT+IFLFbTIBdaD0PCRooskj36ks2DAElqTWC8ZvnQW4Pwyc6vTOs1IUEfKVf7wNubOx6n7ZODnkQ==
X-Received: by 2002:a17:90b:52cc:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-2febab3e63fmr11514061a91.11.1740830797524;
        Sat, 01 Mar 2025 04:06:37 -0800 (PST)
Received: from localhost ([2a0c:b641:69c:caa0:7e25:5c80:5e89:3e1b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea6769ad2sm5425156a91.11.2025.03.01.04.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 04:06:36 -0800 (PST)
Date: Sat, 1 Mar 2025 20:06:03 +0800
From: lilydjwg <lilydjwg@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Calvin Wan <calvinwan@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Enrico Mrass <emrass@google.com>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: Question about `git gc` locking files
Message-ID: <Z8L4K9ww_pdmOvzx@lilyforest.localdomain>
References: <CAFySSZBCKUiY5DO3fz340a0dTb0zUDNKxaTYU0LAqsBD2RMwSg@mail.gmail.com>
 <ZxeilMDwq0Z3krhz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxeilMDwq0Z3krhz@pks.im>
X-Mailer: Mutt 2.2.14 (516568dc) (2025-02-20)

On Tue, Oct 22, 2024 at 03:03:21PM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 03:55:45PM -0700, Calvin Wan wrote:
>> Recently, after upgrading to 2.47.0, we had internal reports of users
>> erroring out with:
>> 
>> fatal: cannot lock ref 'HEAD': Unable to create
>> '<filepath>/.git/HEAD.lock': File exists.
>> 
>> We believe this is due to "(98077d06) run-command: fix detaching when
>> running auto maintenance", since we have neither `gc.autoDetach` nor
>> `maintenance.autoDetach` set.
> 
> git-maintenance(1) detaches itself by default unless told not to via the
> config keys that you mention.
> 
>> When this bug was fixed, the maintenance runs that triggered during
>> usage of the external tool, repo[1], would lock the HEAD file in the
>> Android manifest repository thereby erroring out `repo`. Additionally,
>> long running maintenance tasks would also cause users to frequently
>> run into this issue when using git commands that are written to HEAD.
> 
> It is a bit surprising that HEAD would need to be locked in the first
> place. As far as I am aware, the only step where we end up locking refs
> in the context of git-gc(1) would be when we decide to repack refs via
> git-pack-refs(1). And that command shouldn't ever end up packing the
> HEAD file, as that loose reference must exist
> 
> Digging a bit deeper surfaces that it's `git reflog expire --all` that
> causes us to lock HEAD, which is... unfortunate. Seemingly, relfogs are
> locked by locking the corresponding reference.
> 
>> We can fix this easily temporarily by pushing out config changes to
>> run in the foreground, however, I was under the impression that `git
>> gc`, whether invoked normally or through `git maintenance`, would be
>> able to run in parallel with other git commands and therefore not
>> lock. There is no mention of this in the documentation for `git gc`,
>> but I do see it in the `git maintenance` documentation. So should `git
>> gc` be locking the HEAD file in the first place? And if so, is there a
>> way for `git gc` to have less of a dependence on HEAD.lock?
> 
> So what seems to be happening is that you have two processes racing with
> each other: one that is trying to expire entries from your "HEAD"
> reflog, and the one invoked by the user to update "HEAD". By default,
> Git will wait up to 100ms for the "HEAD" lock to be released, but it
> seems like expiring the reflog for your "HEAD" takes longer than that.
> You can work around that issue by increasing "core.filesRefLockTimeout".
> 
> But this whole thing uncovers an issue with git-maintenance(1) itself.
> The above commit fixed how git-maintenance(1) behaves such that we
> detach at the correct point in time. But what it neglects is that some
> tasks are more special than others and should be run synchronously
> whereas others can be run asynchronously. Packing refs and expiring the
> reflog are tasks that should be run synchronously to minimize the impact
> on users.
> 
> This all demonstrates that git-maintenance(1) needs to get some more
> love. You have uncovered this issue with git-gc(1) as configured task,
> but we have a similar fundamental issue with the git-pack-refs(1)
> subtask. So I guess we'll have to classify those subtasks into two
> categories, where one category needs to be executed before detaching
> itself and another category can be executed asynchronously after we have
> detached.

Hi, any news on this issue? (If not, I'd like to get notified when
there is.)

This issue has been happening to me too. I have automation tasks fail
occasionally in the last few months, and has only traced to "git gc"
(instead of another concurrent task of our own) just now. It is the
"git pull" command which fails for the most of time.

-- 
Best regards,
lilydjwg
