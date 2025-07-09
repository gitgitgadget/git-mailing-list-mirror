Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BD1DFCE
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071974; cv=none; b=fFgVBuft02GgoPO8iGSPlRr18L1uEptB6IjYI3Lciy/YdYx1i8vtyswxAjeGRIsT+EtXaJbvy32PJhR6fyar0+HxKHtqDFv9JHQ7UgvTjsG1GlLn466aNirsOV6amy4ixfYoLKVhyAy6nW/mUB9822xY7sksAcQLukIgUd+Zz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071974; c=relaxed/simple;
	bh=2D79RAZ334na5MYby1nvfYtBEn/TDbR1D13mW9R7tlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlaGAjds9jDH+huIQUVroDv47SnUxMFA5gqRNpxcvJbZujpJJ8BExqZBhJb0k4MsAe9YuyC1aT63FDsRL/A2CLOeoGs3T+GXStwkKFktMi9GGtffkaJuHRSFQzpj0Mvlmuqdd0DowjP8xQ+QIqtOfKb8Psuj0udObu5+ui46O5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epeVPBKC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epeVPBKC"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso5034131276.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071971; x=1752676771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdXzrfSt3P6aTJ3KVOtmby3vwZtljrK4pSep3BuXLNM=;
        b=epeVPBKCI8Tov8CZytpDHKACWFrCMCNOmkkLVhOmeYNfKd66+t8UftmgSvKCnkJ5YY
         SZocqJX8nPgW0NUa1Mk5MU6prC/ZpVY6djv0r8HyOkNMs7je0GmBXupoxrMxdhE/5vJe
         c5zuHJT7Dg1N1b2Jwxs/M+yckVC8eQLRKirh7PtuSc154nByex3XrS9/fvL+GxsDV9aY
         ybkIGojMC3uTPJNTGahhbRDvE9iO1tNvZ+h8f02j7EZ3WPaPnN6ErFKeiebp3KNby2pA
         T991F9HciLyYVWJNTkCg/81XkMAsh0er2gBmkNLYK/17SmFLkqpkRfdhf3HdIFrQUujl
         7W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071971; x=1752676771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdXzrfSt3P6aTJ3KVOtmby3vwZtljrK4pSep3BuXLNM=;
        b=fk5tVJodLZ7kbgWuvkQKFmsScyD76g/ZL9px9GwR7UkxF8Op72dF5BMn18dPj79HR9
         fQJVtigNfvfqKFipY3ymMFxNBW9d0jd5Ebe0FIP6WUaD4UtPg7iL8zCfoxCHYfYq36do
         nclO1O3siw7A2FyqNxunb8Qe37KJM4kQkzToyTYpKObetbTmMFuXlVNomjyuwHuI2+ht
         ERmcSRBt3eOzpNg1poCYvDeoQ3rkyulH3c2uxVLqblzs0gzHLQI5CLz+bq6Pkq1GdPtN
         RxSunICUe31Y6QnCmGLnl8NLCUyIu4TXq7cKLoP3JnWT+Blrphei1V1MgpBHGMrg7M6J
         EKUA==
X-Gm-Message-State: AOJu0YzzKi501BAAOeAQ+xD8qZ+9w7eoQDUpaykKo8Pt4ILZl0ltvRb5
	p0FzYIzuJ4YyNOXws0UCdFsNd5zmdJNwneIT1UXyaQjEBhJx0ypqufg44Rbhwhnj
X-Gm-Gg: ASbGnct2LA9UGeqbGS2AfTMuYCCEo9yTspI259i4EQabBnFRot7s03E2C0MqVc0RDD0
	Une7aRg19PK5OuFa/3mKkbSl4GTLBS66mlmljo5J/GRZMErsaOZ1uOraqWCU4PRVVHfI91xd/mB
	XHMtLkSP2DQFkzsXJwGOgSE56E9IuwaG0qTFUpp8UvYMYOld07+nATirDABRphEtHoSz+G3WW3W
	4zO45iM5OuHRmZS8ELSeAgj92WiiqfFHjWsbaUN/s6MTzOZQ4fBZI4//v2OoLRoqhhTL/Zkfht3
	Lvftg8HBVamylDHzo8qo/LVDByy0HX7Gv/juW1rALkgLZY2uydYvgKWet8Rv4hoJRWCg54nhrWD
	fefSITzSP3caMwFMNp0eYfDML0I6FzvX1GblfEg==
X-Google-Smtp-Source: AGHT+IGeIhCkTDEP8dvrLSQVKg8xGDKoIK9OhNtwkpWgBsHVl4XsWoV6+PrNObgAPJik534ffVYT8w==
X-Received: by 2002:a05:6902:6807:b0:e8b:4282:65d7 with SMTP id 3f1490d57ef6-e8b6e193725mr2337264276.25.1752071970684;
        Wed, 09 Jul 2025 07:39:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c467:2cb3:90ce:6b3a? ([2600:1700:60ba:9810:c467:2cb3:90ce:6b3a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c30a5b8sm4023232276.1.2025.07.09.07.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 07:39:30 -0700 (PDT)
Message-ID: <2503c79c-68f3-4ed5-bbfd-3a7af07a89cc@gmail.com>
Date: Wed, 9 Jul 2025 10:39:29 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
 <xmqqa55etm5g.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa55etm5g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/2025 5:20 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> When users change their sparse-checkout definitions to add new
>> directories and remove old ones, there may be a few reasons why
>> directories no longer in scope remain (ignored or excluded files still
>> exist, Windows handles are still open, etc.). When these files still
>> exist, the sparse index feature notices that a tracked, but sparse,
>> directory still exists on disk and thus the index expands. This causes a
>> performance hit _and_ the advice printed isn't very helpful. Using 'git
>> clean' isn't enough (generally '-dfx' may be needed) but also this may
>> not be sufficient.
>>
>> Add a new subcommand to 'git sparse-checkout' that removes these
>> tracked-but-sparse directories, including any excluded or ignored files
> 
> Are excluded files and ignored files form two separate sets, or are
> they one and the same?  Do files that users forgot to add (e.g. new
> source file that would not match any patterns listed in .gitignore)
> and object files left over from the previous compilation (most
> likely match *.o in .gitignore) treated the same way for the purpose
> of determining if the directory that is no longer in the cone can be
> removed?

I think of them as separate in my head because:

* .gitignore is committed to the repo, and is common to all users of
  the repo.

* .git/info/exclude is custom to each user, so users are choosing to
  ignore extra files that are atypical from most users.

In the monorepo I'm thinking about, .gitignore files are rather small
because all build output has already been redirected out of the
worktree for performance reasons. Thus, _most_ users don't have this
problem. However, some users add extra excludes for things like vim
files and those get leftover, causing invisible (to 'git status') pain.

>> underneath. This is the most extreme method for doing this, but it works
>> when the sparse-checkout is in cone mode and is expected to rescope
>> based on directories, not files.
>>
>> Be sure to add a --dry-run option so users can predict what will be
>> deleted. In general, output the directories that are being removed so
>> users can know what was removed.
> 
> Hmph.  It would be safer to show not just the directories but which
> excluded files are about to be lost, wouldn't it, especially when
> the user is trying to play safe and see what potential damage they
> are looking at?
> > Also even though ignored files are "ignored and expendable", nobody
> marks their temporary file as "ignored but precious" (yet), so "it
> is listed in .gitignore so we can safely remove it" may not be a
> safe assumption for us to be making (yet).  Shouldn't we at least be
> listing these ignored files in --dry-run output, next to those files
> that the user may have forgotten to add?

I considered this, but mostly behind a potential --verbose option to
list the files that are leftover. Much of the design here is that
these _directories_ are out of scope, skipping over any details about
the contained files, so I thought this directory-based output would
communicate enough information.

A curious user may want to know "why are these directories still
around?" and the more verbose output would assist.

>> Note that untracked directories remain. Further, directories that
>> contain staged changes are not deleted. This is a detail that is partly
>> hidden by the implementation which relies on collapsing the index to a
>> sparse index in-memory and only deleting directories that are listed as
>> sparse in the index. If a staged change exists, then that entry is not
>> stored as a sparse tree entry and thus remains on-disk until committed
>> or reset.
> 
> Removing untracked directories is a job for "clean -d", so it makes
> sense for this new command not to touch them.  Not losing changes
> that have already been added is just a bad as losing new files that
> the user forgot to add, so it does make sense not to remove them.
> 
> I wonder if we need "-x" and/or "-X" options "clean" has (and
> perhaps "-d" that is a no-op, as the whole point of this subcommand
> is about removing directories from the working tree) to control its
> operation a bit finer-grained way.
I'm of two minds here.

My first inclination is "we already have 'git clean' for fine-grained
control of removing ignored/excluded files".

My second inclination is "'git clean' would remove these ignored files
even when they are within the sparse-checkout, so that's too big of a
hammer".

There are a lot of ways to filter the files that would be removed,
but I think that in this case most users are wanting a one-command way
to get their sparse-checkout into a better state.

I'm not making any final statements here. I appreciate all of the
thoughts around which options should be default and which should be
hidden behind options.

Thanks,
-Stolee

