Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108975915A
	for <git@vger.kernel.org>; Tue, 14 May 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680900; cv=none; b=mAcAzc0eGN6NLyqTArYvxLyosAP3ub2ObaB9ynP3jGDyaXo25ClD4t+6p70sbIpHSBaWqZ6dDRMXxIuMHLn6gG+fY90cYNb4FZGF7/xvDuJbqnTui6BHK7pSyK9ZNXx1Shi9DrmIGfZwyAkzrA30jkQKGAUQ76QxFt9t9MaFAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680900; c=relaxed/simple;
	bh=kO02UEUK7Y/KpY3XJddUP4XYLdHXF7MldBFm8OyzJKg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qa3WxhK4CW/M43aE9qnrBB6tmlqD41l+A4vzhTAiZLSG8AAPvu8eUsHLHq1Xcilsl7fRnL1KED7gVkI0lhcGn3QtMRxgNWD8XE/9Jf+K5ALZAt6ShDpAcX6pG7ZsgkKQwaFstP1bn46IGFEBn0kqvAXoPHBkMo0f+Qer/Il1Fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPXHC85J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPXHC85J"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so53928775e9.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715680897; x=1716285697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Gpyae8FG6l8VTMLbai8Ub0c40Gnav/UtOmbfeHZKvU=;
        b=NPXHC85JjKbTbRLX7UqFBnjMhGBDzuZeX3ZgEajs4bboBQWibNfWRReOBd679zf7mN
         gCb9eqMiXmSIg1MACPjPJ7MjmMfUM7pRcUWCEQI46uhgoEBFjlYwOp5JMg5laFkqRele
         2EQyLBnlKMmpSd5nTnt8mlU02GlSS5tTmE1SHYqQjI/ASmE5qnIgN8N4uhZPnEZkeVVl
         EGwg8hnGgT6Dvy+BnHcWlSpYfggcKmJQr/5rT1oEum05kJtI55AekDv2TKvSssJewJCj
         08jabhs54l5O8vI5Pw+y19WqCnVI9iYbamWaDjPxl3p4OBWm3a7eGZyPvN4sleCJSJa3
         XZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715680897; x=1716285697;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Gpyae8FG6l8VTMLbai8Ub0c40Gnav/UtOmbfeHZKvU=;
        b=G9viJaQnlqLvguLAOcREyR1+Z7O5nkCrDD/5XwxNRh+yO2bhOz2nkOfcdFYtIQogCu
         NluosvoO2Xa1T/m2FkxEuxCGqzMuWmPNEx4p8VpDBhy+1v1eJWn0IUX5BA/blKqB8nCB
         rk8fwZtsmzh9ZZsQSmLyYXIMdO1OiVeF9g8AEZ/rp6Zrn4i9i3UZXTK91hrdYNYpE9qt
         yx6BPpxL94LfWWkAbYAeEejpyFngEkbu3LJVWzkJnDitWlXSs/p+6hirw43Uo8JXlmY4
         oqYrU3D/cIh6orj8jRDc8L/k0fDz6cpxutBN/QS8VscQZ7zJ1dKLvuAqUDUhwcVCm9r5
         XbKw==
X-Gm-Message-State: AOJu0Yx6uT4oQfiYZJzI9VdbO6hu+f1T1F60FiyN4TZOHxqK3J3CWJII
	ICuEGWHdxie/NoswHI8RV742N0vDt8U9gvSKdSqsF0OWkGOjyYZb
X-Google-Smtp-Source: AGHT+IHEfDm/p4St2xQ/+25QMG7fK1uN+WojHltWQn6JXXt0Seltg+ncy8XT68qAZRd0enPlYk+zpQ==
X-Received: by 2002:a05:600c:6a14:b0:41b:f577:373 with SMTP id 5b1f17b1804b1-41feaa38e45mr119865465e9.15.1715680897217;
        Tue, 14 May 2024 03:01:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012a025dbsm88076435e9.23.2024.05.14.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 03:01:37 -0700 (PDT)
Message-ID: <45674580-e7f6-48aa-ac17-3e0b96acace9@gmail.com>
Date: Tue, 14 May 2024 11:01:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Checkout to different directory at certain commit without
 changing index
To: Ondra Medek <xmedeko@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
 <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com>
 <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ondra

On 13/05/2024 18:23, Ondra Medek wrote:
> Hi Phillip,
> 
> besides dependency on tar, I do not want to use git-archive because
> it's influenced by export-ignore and export-subst attributes, too (as
> I have mentioned).
> 
> Thanks for git read-tree, seems it's exactly what I need. Just git
> read-tree has complained that -u switch needs -m or --reset switches.
> And I have simplified it to

Sorry I'd forgotten about that

> git --work-tree="$destdir" read-tree --index-output="$destdir".git -u
> --reset "$commit"

You should be aware that --reset will happily overwrite files in the 
destination directory, using -m instead would stop existing files being 
overwritten. If you change to -m you must set GIT_INDEX_FILE instead of 
using --index-output otherwise only the files that differ from the 
current index will be checked out. Also using a relative path for the 
index file specified with --index-output or GIT_INDEX_FILE is error 
prone when running the command from a subdirectory of the repository. I 
avoided suggesting --work-tree because I wasn't sure how it handled 
relative paths when run from a subdirectory but I think it is in fact ok.

> rm -f "$destdir"/.git
> 
> May I post this solution to the SO thread I have mentioned?

That's entirely up to you but I'd make sure it works with relative paths 
and note the difference between --reset and -m.

Best Wishes

Phillip

> Thanks very much
> 
> Ondra
> 
> On Mon, 13 May 2024 at 17:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Ondra
>>
>> On 13/05/2024 08:26, Ondra Medek wrote:
>>> Hello,
>>> I need a simple script for unskilled users to do a fast checkout (LFS
>>> friendly) of the current local Git clone at a certain commit to a
>>> different directory I.e. something like "copy at a point in history".
>>
>> I think using
>>
>>       git archive "$commit" --format=tar |
>>          { cd "$output_directory" && tar -xf -; }
>>
>> is probably the simplest solution. If you don't want to rely on tar then
>> something like
>>
>>       GIT_DIR="$(git rev-parse --path-format=absolute --git-dir)" &&
>>       GIT_COMMON_DIR="$(git rev-parse --path-format=absolute
>> --git-common-dir)" || exit
>>       GIT_INDEX_FILE="$GIT_DIR/tmp-index-$$"
>>       export GIT_DIR GIT_COMMON_DIR GIT_INDEX_FILE
>>       unset GIT_WORK_TREE
>>       mkdir "$output_directory" && cd "$output_directory" &&
>>       git read-tree -u "$commit"
>>       status=$?
>>       rm "$GIT_INDEX_FILE"
>>       exit $status
>>
>> Which uses a temporary index file should work (note I haven't tested
>> it). You may want to add "--recurse-submodules" and/or
>> "--no-sparse-checkout" to the "git read-tree" commandline.
>>
>> Best Wishes
>>
>> Phillip
>>
>>> IMO all possible solutions are summarized in this thread
>>> https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
>>> I describe some of them with my remarks:
>>>
>>> - git checkout-index : works with HEAD only.
>>> - git archive: influenced by export-ignore and export-subst
>>> attributes, so may not produce exact copy of sources. (And needs tar).
>>> - git worktree add -d : needs cleanup: git prune or git remove.
>>> - git clone: Unfortunately, -b param cannot work with commit hash and
>>> does not respect local worktree settings (e.g. autocrlf). So, a
>>> solution may be a bit complicated: git clone -s -n . dest/path ; cp
>>> .git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
>>> rm -rf .git
>>> - git checkout: Unfortunately, modifies Git index, so some action to
>>> revert index is necessary after: git --work-tree=/path/to/checkout/
>>> checkout -f -q <tree-ish> -- ./
>>>
>>> For me, the best solution is with git clone, because it does not
>>> modify Git index nor any source working tree settings, so no cleanup
>>> is necessary. But it's a bit complicated, though. It seems to me that
>>> "git checkout" could do this better and simpler if it would have some
>>> param to not modify the Git index. Is it possible to enhance git
>>> checkout? Or is there any other simple solution not mentioned in the
>>> SO thread?
>>>
>>> Thank you
>>> Ondra Medek
>>>
