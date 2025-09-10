Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9931B127
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513125; cv=none; b=Qu6SJzYaBYalGvR+2cwD4zVlR8+eS69qOEhtBL0dgy4EFCKfFGWwkO90lUubtc1piRcpr4HWXN0ujvfPYNEXJufP6AxVN6HaASThUI+dSQWru+5XxGIAxvdsnomSOAEVrZgkjbN4t/pxiipiJ/qQNXkXLbMchE3d0BteuB52G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513125; c=relaxed/simple;
	bh=wbDsn/OF1jdPEKuLIWHz6pYxlXVS47gAEHDu0zNFIa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgGlz/kaFlQUAwBY7Jqa+giJ4OB+l5WmMibE/7On3KR8uGEsyKBE7Th7ggXBjGHFsh3YV6kGH5wGTzsUZJljyWhEOpr3WMaOXnxUjSVjmsyUlycHWxfuHLm5K+IFyWP7lor1mfc9LohSKyDW9doB9c83QlnamNeo7VuOHEU+c+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwrMEcpT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwrMEcpT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so4846003f8f.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513122; x=1758117922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5CuCkZIo3f0eAU7vGciwRfLofMPIcsixAM6p3qk/PlA=;
        b=jwrMEcpTQJg30FMs4ZtfDIlTQZrheNMoYGXuNVHbC/f89tGTbUGi1Yf1QdIvqZ216G
         mXfLnU+ZPX9awBI50JQRhxmd/mxueoAvVPrpj63VyZiG1aOHWMX4ovxjWTEaUd7w4mTj
         RilCOD3pmKFGjugUEs/6rYcgrWOr/3Q6ytQwvJ9dqJ272soDqMu9TPYlnPlxa3ocTRTn
         /HjTnh2EZjKMx5SojYAtIWvBtwkUrTCSvkXl0bMaggAfWVFt0dd4G5pmVOPXqz1rmXxU
         ufY/vlV3iOoinZu6B9Yaa/tjLNJMYbOLitiFnmZigpOL8Q+xYeuZbCV0SfyMIKNSb2Gt
         x7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513122; x=1758117922;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CuCkZIo3f0eAU7vGciwRfLofMPIcsixAM6p3qk/PlA=;
        b=JVbsHn/Se+pe5S3L8TmFTwnxZkTWz91+J7SSDcFB9WjIDFJ3H1u4tfQUrmWcyoduyj
         SQyVs5ux6i7T13rcFC2V9faGeSD8psHWWFRUvDsANqt09syD7I9JbXoxcrcNEi2oY7Xw
         QnB8YMri7+vEVLBnKI1beu1lR1oIRckvLkW3QddkvovScyVgJGtdl0U7Ypj+4vtM3Ja/
         axPsZPL+9Viauz2xYzAEC3JgmUHqG6mr33tjsPqrpSNehtsXlgtYFQvNBsyW6nPiAX7E
         ZpnfS+OCITSpdjG9MMCJULL5TQqD57aX3xh599yfXLkDDuoJkIIqn0A1sLn93ZvCBouV
         5xWQ==
X-Gm-Message-State: AOJu0Yz+EFI6Zkd5N7jrSWb9xaW87JVAZWX/vkCdl6StUvDmQ8lqkyRG
	KqdmuxcRtjX8BE0OjyNGRgx+WXEYldC6VZUboBZeKLOXq2Bc52fyqDCW5KCExw==
X-Gm-Gg: ASbGncuzP2joShWFzTNfIXvxUwGi1JY2zJhJ4VYA42iIm78iBWUbKmatkR5UTlxc9B+
	2L455b52l9aM0gGfdP3IOFqSmf1D3p+tcIs2k4nyudf1QhKFxYka7OwJp6DUlnFO9R1w9rEL+WT
	exur8BV7NfAIBN1O4vhGk1VxSibg4XG7WzdGYKrCy5kXDCoDmNcj9j4N7u7wDYagxG4hoTXwWxg
	Yg/q9N4RRNibX/tWFqt49GFqwiGOEe3SSQ12uL6yFuFA2XTY884zrsWMz1ucCENptYFBmW6bAC6
	kwHogVW4Ti2q5p/USHeLBq6vq0gJv59M7SDHF8j9qZGZPg/c95IKzlNy/hEt9cnq7RXiIMovk1g
	QUfEVqrviEkIByODFIXE0BDFSUw1itRY+MJoYotHd6f6SDOOiL3CXuYxniqvk8YAQANs0OCmj3U
	o=
X-Google-Smtp-Source: AGHT+IH0uFdkXCK0Zaojbd4zG26VEgC0K+HDc5avdARE0NzVuifi3GP43bH+QecXF8x8xKdTskCuLw==
X-Received: by 2002:a05:6000:430a:b0:3e7:471c:1ddd with SMTP id ffacd0b85a97d-3e7471c223dmr8880511f8f.49.1757513121557;
        Wed, 10 Sep 2025 07:05:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a65sm7457098f8f.17.2025.09.10.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:05:21 -0700 (PDT)
Message-ID: <978e6351-1c08-44eb-8a2e-4a39541b9337@gmail.com>
Date: Wed, 10 Sep 2025 15:05:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
To: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/09/2025 07:46, Elijah Newren wrote:
> On Thu, Sep 4, 2025 at 11:43 PM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> over recent months I've been playing around with Jujutsu quite
>> frequently. While I still prefer using Git, there's been a couple
>> features in it that I really like and that I'd like to have in Git, as
>> well.

Fantastic, thanks for working on this

>> A copule of these features relate to history editing. Most importantly,
>> I really dig the following commands:
>>
>>    - jj-abandon(1) to drop a specific commit from your history.
>>
>>    - jj-absorb(1) to take some changes and automatically apply them to
>>      commits in your history that last modified the respective hunks.
>>
>>    - jj-split(1) to split a commit into two.
>>
>>    - jj-new(1) to insert a new commit after or before a specific other
>>      commit.
> 
> Cool, I had been thinking of adding some jj-like functionality as
> well, to git-replay in my case, though I was more interested in fixing
> up the infrastructure to handle replaying merges sanely first.

Interesting, one of the questions I have about this series is whether it 
makes sense to use the sequencer or extend git-replay. I do like the 
idea and name "history" though. I've been using a wrapper around 
git-rebase that I call "git-rewrite" that lets me amend, reword, or drop 
commits and rewrite all the branches that contain the modified commit 
for quite a while now. I find amending the commit directly rather than 
using fixup commits and then squashing much more convenient and it 
avoids the problem of the fixup having conflicts when you try and squash 
it (though not the conflicts caused by amending the commit of course). 
One feature I particularly like, which we might want to add to "git 
history" in the future, is being able to specify a filename, line pair 
instead of a commit name. The script then uses "git diff" to map the 
line number to the file in HEAD and "git blame" to find the relevant 
commit. This makes it easy to start a rewrite directly from my editor 
when I see something that needs fixing up.

If we do want to use the sequencer then I think we need to decide 
exactly what behavior we want from the new command with regard to 
running hooks and copying commit headers and implement that behavior 
rather than just accepting the status quo which is largely a historical 
accident. I would suggest that for commits that we're not modifing we 
should not be running any hooks. For commits that are reworded we should 
be running the "commit-msg" hook and possibly "prepare-commit-msg" as 
well but no others. Where we're amending the commit content or splitting 
a commit then we should be running the "pre-commit" hook as well. 
Currently "git-replay" copies any extra commit headers when it creates a 
new commit whereas "git-rebase" does not. There is some discussion at 
[1] where people were pushing back against copying extra headers by default.

I think it would make sense in the long run to update all the branches 
that contain the modified commit. To do that we can use the sequencer's 
"update-ref" command. To that end I think we should add a new entry 
point to the sequencer that takes a todo list rather than a list of 
commits to pick. That would also allow us to implement the "split" 
command in the sequencer and reuse the infrastructure that already 
exists for rewording commits. The way this series is currently 
implemented makes it hard to extend in the future because it is based 
around cherry-picking commits rather than creating a todo list for the 
sequencer to execute.

Thanks

Phillip

>> Not all of these commands can be ported directly into Git. jj-new(1) for
>> example doesn't really make a ton of sense for us, I'd claim. But some
>> of these commands _do_ make sense.
>>
>> I thus had a look at implementing some of these commands in Git itself,
>> where the result is this patch series. Specifically, the following
>> commands are introduced by this patch series:
>>
>>    - `git history drop` to drop a specific commit. This is basically the
>>      same as jj-abandon(1).
>>
>>    - `git history reorder` to reorder a specific commit before or after
>>      another commit. This is inspired by jj-new(1).
>>
>>    - `git history split` takes a commit and splits it into two. This is
>>      basically the same as jj-split(1).
 >>>> If this is something we want to have I think it'd be just a starting
>> point. There's other commands that I think are quite common and that
>> might make sense to introduce eventually:
>>
>>    - An equivalent to jj-absorb(1) would be awesome to have.
>>
>>    - `git history reword` to change only the commit message of a specific
>>      commit.
>>
>>    - `git history squash` to squash together multiple commits into one.
>>
>> In the end, I'd like us to learn from what people like about Jujutsu and
>> apply those learnings to Git. We won't be able to apply all learnings
>> from Jujutsu, as the workflow is quite different there due to the lack
>> of the index. But other things we certainly can apply to Git directly.
> 
> So, this brings up a question.  Should we have git-rebase &
> git-cherry-pick & git-replay & git-history, or should we consolidate?
> I had envisioned having git-replay consolidate both cherry-pick and
> rebase functionality into one (then got pulled away by combination of
> work reassgniment & multiple life crises hitting at once taking my
> focus away for quite some time).  But now we're going in the other
> direction.  And further along that other direction is another extreme
> -- just having these be top-level commands, e.g. "git reorder", "git
> split", etc.
> 
> In a separate conversation we had (and I hope I'm paraphrasing
> correctly; if not please correct me), you mentioned you wanted
> git-history to be the home of history rewriting, and viewed git-replay
> as just a server side thing (whereas I created git-replay specifically
> as a user-focusing thing and then Christian changed it into a
> server-side thing since that part was complete and enough for his
> purposes).  But if git history is the home of history editing, how far
> does that go?  Do we have a "git history reset"?  "git history
> commit"?  "git history fast-export/fast-import"  "git history
> filter-repo"?  Or is it just the home for certain kinds of history
> rewriting operations?  If so, which ones?
> 
> That all said, I'm a big fan of the idea of incorporating more of jj
> capabilities, and you clearly marked the command as experimental
> (thanks!), which leave us room to adjust later if we don't like this
> path.  So I don't want to serve as a roadblock, I just think it's a
> useful conversation to have...
> 

