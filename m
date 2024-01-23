Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29D5D754
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019836; cv=none; b=lKW1JXZjKPqRk7cC9rGKR44j+FTFGJgvEz0Ub7atrcIhx8fN77XLXtGPzyprQ4Zfa8KSWIIOo50Kf25sRAMgSW2wDesW9SMEel1tvnNpwm8CUnXrzgjHKf3Vml9eaSPo8p+ReN5Xn9dZdLmGrFB1uK7fIDPG1jaPugczoNYVeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019836; c=relaxed/simple;
	bh=daqja0OLtwQgDL/+q7wKSug86FmYJwRj6W0T8BSZGA0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YXkIIAL9zjdksFQ44/QCODB8C0FaVAl+hfoUrt/y9Cxce4C1muRYZ5d9qg4uyZ7RzEJCD0ppK/olkOIXqWvlWGDWWJFuEYgmSiNKFZd/nEfdGN0FSHMPkLAvDgNIDklqE7YLfOtZmgVP/7j3O3WHAbU/24kkpyk1W3hk64RrR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9pYhPr5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9pYhPr5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337d5480a6aso4188920f8f.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706019833; x=1706624633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzGuX29+jhR+LLVFuQXaRb1MZJ1PUa3QExlZ8bcV3Cs=;
        b=S9pYhPr5+iBiS+Sjfp9gkbJwgv3fwL0A1Ei8Cg2TK6MSJ1b5BWMNhVahuQFrrm5XBE
         CxMqYzKDyFdOvuQzE9GUXMaVGoDFvfZXLw2OfV3Jkk2FxNeYDnPGpx2lWLrHokpVvNE7
         U/2/HG3I0Jx44jjZJ5wy7eS69kSAfLpezlgz86PK83yu3a6TYTyM9IFOSHj5+iXpu4gK
         YYwI/XYcPSevcCLAX4GPvZoyzoFUQvw6PFAnX0xiBvPb8ERCZUeIPRB/jZOY41RxCN/F
         nBk/WzkI+D0/v7SOTQMgd4iBAbQSLM4r3PB/PUQtsadBO0xiAaMoBRHzVvhHobFGkDut
         IPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019833; x=1706624633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzGuX29+jhR+LLVFuQXaRb1MZJ1PUa3QExlZ8bcV3Cs=;
        b=WnClTPtiKg8ys7FUkWkBI9vnLTWqaXIR8B/K4xn74JqCLHq/T1fDqCSOi8TWxDPPdV
         9AeYb4t7zRHPyHVk4KShO0HXIW684rV0t/6wMEF3RRFEgZke/Ld2SIs7s6mUziASGdIz
         9adjr61cqNYJboAEAAY4+z0jzX6pKS9TYXJICS6Px4mCTRkt6OO3NKcym/M8D8+yM0j0
         lB854MXpiEHuQJCzLwlPdkv8XpJ4ER8KXtE+i0UfrEzdolYxM3dnIJ9BHTiOP1i9AwyU
         JuB+Em+Yyje3JjYzJo2+jzbs+I5y05mZvyfTXHrrowXvdVcTYVp4hgxxeWFikNSZTLN6
         UfMw==
X-Gm-Message-State: AOJu0YwnbVL/ETXHzQFi2Ain01IwC4Z/Zhln0c70UmrE90oQ2dhzhG85
	F/VptpcHWGdW/Qbg+TDpUBySXLR01EOueJ4ngAcGyYnaTwdjLT7FDph4tLWn
X-Google-Smtp-Source: AGHT+IGkkJ38phqPaDo3odQk2sPzpmvsZ6UEJkMiul4diO3IKghb1Va/6uiuhp0mqNqa9EyrS4ylBw==
X-Received: by 2002:a5d:448b:0:b0:337:c555:18b5 with SMTP id j11-20020a5d448b000000b00337c55518b5mr3123858wrq.115.1706019832757;
        Tue, 23 Jan 2024 06:23:52 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id q12-20020adfab0c000000b00337d8c40ff7sm12505590wrc.3.2024.01.23.06.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:23:52 -0800 (PST)
Message-ID: <7bf5036b-9f55-4451-a13c-8a2c815dfbb7@gmail.com>
Date: Tue, 23 Jan 2024 14:23:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
Reply-To: phillip.wood@dunelm.org.uk
To: brianmlyles@gmail.com, git@vger.kernel.org
Cc: me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Content-Language: en-US
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

Let me start by saying that overall I'm impressed with the quality of 
this submission. I've left quite a few comments but for a first patch 
series it is very good.

On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
> 
> Previously, a consumer of the sequencer that wishes to take advantage of
> either the `keep_redundant_commits` or `drop_redundant_commits` feature
> must also specify `allow_empty`.
> 
> The only consumer of `drop_redundant_commits` is `git-rebase`, which
> already allows empty commits by default and simply always enables
> `allow_empty`. `keep_redundant_commits` was also consumed by
> `git-cherry-pick`, which had to specify `allow-empty` when
> `keep_redundant_commits` was specified in order for the sequencer's
> `allow_empty()` to actually respect `keep_redundant_commits`.

I think it might be more persuasive to start the commit message by 
explaining what user visible change you're trying to make and why rather 
than concentrating on the implementation details.

> The latter is an interesting case: As noted in the docs, this means that
> `--keep-redundant-commits` implies `--allow-empty`, despite the two
> having distinct, non-overlapping meanings:
> 
> - `allow_empty` refers specifically to commits which start empty, as
>    indicated by the documentation for `--allow-empty` within
>    `git-cherry-pick`:
> 
>    "Note also, that use of this option only keeps commits that were
>    initially empty (i.e. the commit recorded the same tree as its
>    parent). Commits which are made empty due to a previous commit are
>    dropped. To force the inclusion of those commits use
>    --keep-redundant-commits."
> 
> - `keep_redundant_commits` refers specifically to commits that do not
>    start empty, but become empty due to the content already existing in
>    the target history. This is indicated by the documentation for
>    `--keep-redundant-commits` within `git-cherry-pick`:
> 
>    "If a commit being cherry picked duplicates a commit already in the
>    current history, it will become empty. By default these redundant
>    commits cause cherry-pick to stop so the user can examine the commit.
>    This option overrides that behavior and creates an empty commit
>    object. Implies --allow-empty."
> 
> This implication of `--allow-empty` therefore seems incorrect: One
> should be able to keep a commit that becomes empty without also being
> forced to pick commits that start as empty.

Do you have a practical example of where you want to keep the commits 
that become empty but not the ones that start empty? I agree there is a 
distinction but I think the common case is that the user wants to keep 
both types of empty commit or none. I'm not against giving the user the 
option to keep one or the other if it is useful but I'm wary of changing 
the default.

> However, today, the
> following series of commands would result in both the commit that became
> empty and the commit that started empty being picked despite only
> `--keep-redundant-commits` being specified:
> 
>      git init
>      echo "a" >test
>      git add test
>      git commit -m "Initial commit"
>      echo "b" >test
>      git commit -am "a -> b"
>      git commit --allow-empty -m "empty"
>      git cherry-pick --keep-redundant-commits HEAD^ HEAD
> 
> The same cherry-pick with `--allow-empty` would fail on the redundant
> commit, and with neither option would fail on the empty commit.
> 
> In a future commit, an `--empty` option will be added to
> `git-cherry-pick`, meaning that `drop_redundant_commits` will be
> available in that command. For that to be possible with the current
> implementation of the sequencer's `allow_empty()`, `git-cherry-pick`
> would need to specify `allow_empty` with `drop_redundant_commits` as
> well, which is an even less intuitive implication of `--allow-empty`: in
> order to prevent redundant commits automatically, initially-empty
> commits would need to be kept automatically.
>
> Instead, this commit rewrites the `allow_empty()` logic to remove the
> over-arching requirement that `allow_empty` be specified in order to
> reach any of the keep/drop behaviors. Only if the commit was originally
> empty will `allow_empty` have an effect.

rebase always sets "opts->allow_empty = 1" in 
builtin/rebase.c:get_replay_opts() and if the user passes 
--no-keep-empty drops commits that start empty from the list of commits 
to be picked. This is slightly confusing but is more efficient as we 
don't do waste time trying to pick a commit we're going to drop. Can we 
do something similar for "git cherry-pick"? When cherry-picking a 
sequence of commits I think it should just work because the code is 
shared with rebase, for a single commit we'd need to add a test to see 
if it is empty in single_pick() before calling pick_commits().

> For some amount of backwards compatibility with the existing code and
> tests, I have opted to preserve the behavior of returning 0 when:
> 
> - `allow_empty` is specified, and
> - either `is_index_unchanged` or `is_original_commit_empty` indicates an
>    error

I'm not sure that is a good idea as it is hiding an error that we didn't 
hit before because we returned early.

> This is primarily out of caution -- I am not positive what downstream
> impacts this might have.
> 
> Note that this commit is a breaking change: `--keep-redundant-commits`
> will no longer imply `--allow-empty`. It would be possible to maintain
> the current behavior of `--keep-redundant-commits` implying
> `--allow-empty` if it were needed to avoid a breaking change, but I
> believe that decoupling them entirely is the correct behavior.

Thank you for being clear about the change in behavior, as I said above 
I'm wary of changing the default unless there is a compelling reason but 
I'm happy to support

     git cherry-pick --keep-redundant-commits --no-allow-empty

if it is needed.

> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> 
> Disclaimer: This is my first contribution to the git project, and thus
> my first attempt at submitting a patch via `git-send-email`. It is also
> the first time I've touched worked in C in over a decade, and I really
> didn't work with it much before that either. I welcome any and all
> feedback on what I may have gotten wrong regarding the patch submission
> process, the code changes, or my commit messages.

As others have mentioned I think it would be useful to have a 
cover-letter where we can discuss the aim of the patch series 
independently of the individual patches.

> This is the first in a series of commits that aims to introduce an
> `--empty` option to `git-cherry-pick` that provides the same flexibility
> as the `--empty` options for `git-rebase` and `git-am`, as well as
> improve the consistency in the values and documentation for this option
> across the three commands.

I think that is a good aim

> The main thing that may be controversial with this particular commit is
> that I am proposing a breaking change. As described in the above
> message, I do not think that it makes sense to tie `--allow-empty` and
> `--keep-redundant-commits` together since they appear to be intended to
> work with different types of empty commits. That being said, if it is
> deemed unacceptable to make this breaking change, we can consider an
> alternative approach where we maintain the behavior of
> `--keep-redundant-commits` implying `--allow-empty`, while preventing
> the need for the future `--empty=drop` to have that same implication.

As I said above I think it would be worth looking at what "git rebase" 
does to see if we can do the same thing for "git cherry-pick".

 > [...]> +test_expect_success 'cherry pick an empty non-ff commit with 
--keep-redundant-commits' '
> +	git checkout main &&
> +	test_must_fail git cherry-pick --keep-redundant-commits empty-change-branch

When using test_must_fail it is a good idea to check the error message 
to make sure that it's failing for the reason we expect (see patch 4).

Best Wishes

Phillip
