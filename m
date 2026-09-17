Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A84ABBC6
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660529; cv=none; b=Yg1sLldGk4ZFK/zkvg7kZJjHJIbIVK9sk9sri/IX2qEwIn+q5RpQy2WuzV5XGf9UTDhD9GS76EHIn+2hfbPrhYOx4hF4KGePeKjKz7jhThVoqDQwTh3o8G6/2eUmXB42yJmpyypXcbuEaN/X4o41/fAfe3S/PEZGvBKuFplsxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660529; c=relaxed/simple;
	bh=FIdvnWnAtfwc9rJ9rtBg8FqKtLXG1Namfwm1Twl7UPA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dKNF7TzD4D1rMiYoijs9NfgqGLdwJCtrp1uQ4l3RLuUWRvoqe0V66pBzovH8kOF036m4001AVHmlK89Eu1LO/KUHvqd0GlKUtmpr37DTsMPoR7l/s2iQFTPuCxGPeGEU75/wK+DhrXq1uLQx3ybq/9/F9DAq8nWWRfnh11A5emE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K10sjT1w; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K10sjT1w"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so7637145e9.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789660526; x=1790265326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RaXpQg5bOslR7RPFKOUJpVkpCVMZFl/AqYULxYk5Xz4=;
        b=K10sjT1wrC3/c+GxzT+TNNKxXHPYkR42A65/gUZToeVqU+r7LUVs4E4Ffk68f3oxss
         wZYqlubMEflWZRg2b1VSYomqXsB5OgHJWoIPgtaqy82essv5rIGvqFWewiah6hyF0bja
         azdmk8+1TsWIQsq3iO/AJJ1FnwSwOa2/AswETQpkmtwdM0hKBVPpLP4J9pmh9W95gXsr
         wd1O35IbYbz7uejFcUDe1kfuAvrFkSag/S0fY7RQnQ/BvQNKALugwbJ6GQxiuKWaYaF5
         9p0y2i0IOeCBU1h+NsUx6a25SJJzhsiZiS+AM7zXa4b3ZLjLDlw08MYmFufgExRG4iPv
         Ecxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789660526; x=1790265326;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaXpQg5bOslR7RPFKOUJpVkpCVMZFl/AqYULxYk5Xz4=;
        b=l6jJP8ebz2eMW4toi8L2TMdh/b7oUp1hxkdorirglxjGNA0zJ0ahzHM5ckqkqpLKJh
         ustRkdiQH7plMzq8amh1CNJWx0Zmq2OALrreHZedN7EWRrWwyeQnS32fh0Grx1b/2UZw
         v18q5iEK40fZsTYsNsCYtvQFSk6AbhShsxLZokxEuD43UbNKeiGjVo0iF7d2J0hiIaAq
         /ND/nw4p7c9gubtoxi4InCutpfALSOMymBH0+AunWgRujmqa3WV0vtjwNkxWGD9DQmmb
         nbw8auDQKIKBNWwI130Lxu/Rt0EW+rD9cSnq86QtZJ2lEyX4hb8GRiOfeZbKbxLSs0H5
         0+kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRaYIOwE7DlQqjhK6R6KwvWzDg9KQqNUoiEEVZWiL3lJ+aT7bWZ/KMMamwb/EXAG4l5V0=@vger.kernel.org
X-Gm-Message-State: AFuF++lkYAdRk7+MLCpYopZWTMqQgHl+cfDLJ9PAmeADrCkO1Fc/Mfrg
	zJmjCdJ7+VvqEMMwn2D1keJXJYhn9HMV+5z+sUPNqLyF3T9i2cM/DKFuQ+zE8DDV
X-Gm-Gg: AYBFou1mjtd+rfF7CAgzkyLaxG1wulzr7D59SHkksOoniccoMvu0tefBdSM4744K9e9
	nbW5tVONjHd8ZaV8Wd3r79+wnVFQZFSAK/BMPM+keyW9NsqROcYASNyATxICPPUDtuszooSeKLR
	SPourBc3+mw2QUolObBRu+fLz2gWr5U15s7XtUPbbZ663/WMcSCohRRMQ0se9EV6+AxC9paQBK3
	3lG5DWUcbdPJMRVVCWfG8VmvMD2DWjEz7iRndY+DbyV8gB4Ag5/UEmZUqMmR/UTGN/ZNJHIMLaf
	UMqgZMNJBfHbsxtnlUD/nfXursmpSqbchyFpOzpM/EgWCfjXPZLnX9wMh2TpuHgri/EPeAZ+kd7
	cemn3cy74hDliBebd6/OVAqd3kocTG9uaQ9rz3c+v443HC+rrZb30UIl+VBLvEg0nAGdzY/IoGu
	LI/XroG+EwIqS2LldpvudDUx7SOKl4d9n/ppBdrks1ZO7gm3UULfCb5goeJm9I8g0l2D0fnW7yJ
	Omr2uG9v8V5MwF9rZK1JEPlJ+ERNo7MQGy7ygUJYkFc4Fiw3IwXQQ==
X-Received: by 2002:a05:600c:3547:b0:49e:7423:687c with SMTP id 5b1f17b1804b1-49eac46377amr88665795e9.1.1789660526153;
        Thu, 17 Sep 2026 08:55:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf342a0sm16467880f8f.24.2026.09.17.08.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 08:55:25 -0700 (PDT)
Message-ID: <44881557-f15e-4ec5-b1c5-4112752f757c@gmail.com>
Date: Thu, 17 Sep 2026 16:55:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
 <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
 <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 14:15, D. Ben Knoble wrote:
> Ok, here we go.

Excellent!

> On Thu, Sep 17, 2026 at 5:24 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 16/09/2026 15:30, Ben Knoble wrote:
>>>> Le 16 sept. 2026 à 09:35, Phillip Wood <phillip.wood123@gmail.com> a écrit :
>>>> Taking a step back, this code applies the stashed index changes
>>>> into the current index, writes the result to a tree and then resets
>>>> the index to HEAD.
> 
> I noted that we save the current index (?) into c_tree with
> write_index_as_tree(), then feed diff_tree_binary() into git apply
> --cache, aka applying the stashed index changes.
> 
> [from my notes]
>      - that is, diff H..I in the diagram from the manual:
> 
>         A stash entry is represented as a commit whose tree records the state
>         of the working directory, and its first parent is the commit at HEAD
>         when the entry was created. The tree of the second parent records the
>         state of the index when the entry is made, and it is made a child of
>         the HEAD commit. The ancestry graph looks like this:
> 
>                    .----W
>                   /    /
>             -----H----I
> 
>         where H is the HEAD commit, I is a commit that records the state of the
>         index, and W is a commit that records the state of the working tree.
> 
> We then have a discard_index()/repo_read_index() pair, which I assume
> is refreshing the in-memory index? 

Yep - because we're forking another git process that updates the index 
we need to read the index file again when that process exits.

> Followed by
> write_index_as_tree(&index_tree)… so that must be the "save the
> results of applying the stashed changes" part.

Yep

> What I totally misunderstood was "reset the index to HEAD"---of course
> that's what "git reset" does! But I didn't understand why until…
> 
>> It is a bit confusing the way it updates the index, then resets it only
>> to update it again at the end. I don't think we can avoid that though if
>> we want to error out when there are conflicts merging the index.
> 
> …which now makes (some) sense. That also explains why my attempts to
> use reset_working_tree() in various forms could never work :) I had
> the wrong idea entirely. But it seemed in my debugging like something
> was touching the working tree, so I wish I had kept better notes.
> 
> Just finishing up the flow:
> 
> - we then refresh the in-memory index again (we just reset the on-disk
> index to HEAD)
> - we continue on with a "normal" stash apply merge of c_tree (old
> index), w_tree (W), and b_tree (which I assume is H?); this applies
> the stashed working tree changes on the current state?

Yes, b_tree is (H) and it cherry-picks the stashed working tree changes 
on to the current worktree. c_tree is the current index at that point.
  > - [skipping ahead] in the index case, we reset_tree(&index_tree, 0,
> 0), restoring the stashed index changes.

Yes

> Sans doc comments for
> unpack_trees() beyond "N-way merge len trees […] resulting index […]",
> I haven't puzzled out what's going on, but it _looks_ like we merge a
> single tree, possibly with the original index (opts.src_index) and
> write to a destination which is the repository's index.

Apart from the "git read-tree" man page, the documentation for 
unpack_trees() is basically non-existent which is a real shame for such 
a fundamental function. As I understand it, the one-way merge copies 
across the stat data from the old index to the new index for entries 
that are unchanged between the two. Without the "reset" bit it also 
checks that there are no unmerged index entries and unstaged changes for 
paths that are removed by the merge.
> It's extra unclear what the reset bit is applied to in
> 
>> It looks like stash has its own unpack_trees() wrapper, so I think the
>> simplest fix is to replace reset_head() with
>>
>>          reset_tree(&c_tree, 0, 1);
> 
> I'm not sure if that is a pre-merge reset, post-merge reset, or
> something in between.
> Unfortunately, a whole bunch of tests fail (6 files) with this suggestion :/
> 
> Summary of Failures:
> 
>   339/1062 git:t3904-stash-patch                              ERROR
>        0.45s   exit status 1
>   503/1062 git:t3903-stash                                    ERROR
>        4.40s   exit status 1
>   763/1062 git:t6424-merge-unrelated-index-changes            ERROR
>        0.90s   exit status 1
>   778/1062 git:t6402-merge-rename                             ERROR
>        2.06s   exit status 1
>   864/1062 git:t1092-sparse-checkout-compatibility            ERROR
>       26.19s   exit status 1
>   868/1062 git:t7611-merge-abort                              ERROR
>        0.45s   exit status 1
> 
> It _also_ doesn't make the bug go away, hm.

Oh, I wonder what's happening there.

>>>> We could avoid touching the index at all if we
>>>> used merge_incore_nonrecursive() to cherry pick the index changes
>>>> instead. That way we'd get a proper three-way merge and avoid
>>>> spawning subprocesses for "git diff-tree", "git apply --cached",
>>>> and "git reset". We're already using merge_ort_nonrecursive() to
>>>> merge the working tree changes in that function so we have nearly
>>>> everything we need already set up to merge the index changes as
>>>> well. Essentially, when merging the index, we just need to call
>>>> merge_incore_nonrecursive() instead of merge_ort_nonrecursive()
>>>> and use info->i_tree instead of info->w_tree.
> 
> If I'm following this, the suggestion is to replace (parts of) the
> early "if (index)" block with a merge_incore_nonrecursive() to merge
> index changes, reporting conflicts as we do today, and saving the tree
> for later… and this would not touch the real index, so we wouldn't
> have to reset at all? Interesting!
> 
> The attached patch [Gmail headaches, sorry], which needs some
> polishing [*], passes tests and fixes the bug! Yahoo. I'll send a
> series later, tomorrow probably.
> (It won't apply directly, because it's on top of the experimental
> reset_tree() version, but resolving conflicts should be easy.)

I had a quick look at the patch, it looks good, but I think we can 
simplify it a bit. As we abort if there are conflicts I don't think we 
need to spend any effort setting the conflict labels (I'm not sure if we 
can pass NULL, but "" would certainly suffice). Does the current code 
print any errors from apply when the patch does not apply? If not we 
should silence the merge by setting verbosity=0. Also I think we should 
use oidcpy to copy the merged tree (it probably does not matter in this 
case, but it I think it does some extra checks on the hash function 
which a simple assignment does not)

Thanks for working on this, it will be a nice improvement

Phillip

> [*] namely, the log message, some tiny first cleanups, and removing
> now-unused functions
> 

