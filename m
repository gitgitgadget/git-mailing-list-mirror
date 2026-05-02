Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96E14EC73
	for <git@vger.kernel.org>; Sat,  2 May 2026 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758667; cv=none; b=WLQTBsGxPYkZalt2CWMPkv+hjqKaUjlapchg45E0NNG0D+wGK3feRievIsMSP4VWgrQjTg2n+OHNsV3OkcG5j53tJ2bQI9IgbAMMtOVb1Vsp+HPHtw1CxfFh1pVM3ktaAjEqBKwMg/5gPzljfIKmZf+AXDZSIy6TJ0bZz8wpo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758667; c=relaxed/simple;
	bh=CfWnqGXBw+KSw3p0AjbKe+W3vx3+A1Jx1pklPBBHCkY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OoPENhiwVwF7GHKDVExP9DO247PXft8U24IxPQDP4Nfh9Gb8/vheWoe+wqu6cRTLMiIUjAN+OUvyzpEi/8TdSEFHsp2R868Ucqx7lo4EwI7YrtHVMLa5nyLU+WngsDuoI7vVfLwPxmDF8UDN59qNYKVMD3taKWeDCKpITTv9avg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB7YLZuv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB7YLZuv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d75bfb259so20026021cf.1
        for <git@vger.kernel.org>; Sat, 02 May 2026 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777758664; x=1778363464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CfWnqGXBw+KSw3p0AjbKe+W3vx3+A1Jx1pklPBBHCkY=;
        b=IB7YLZuvuKOYThm+CLq39QlWrKVBk0MEHpVWUDgKCEU/GZZajMpW8gt0vMydTjRg2n
         iLfJvMHaDs51T+HrLdXUCPanFPhjFjE/TYmSbQqBjTbp2OvSfWfsYGZq9sGqTTOwLYRw
         Xc/tFEzEQNJF0uiEfn7OvCNNVU4GjDEhp9Nt9aILWESZPeUGZKVbp8YNQlPu5is1+LVx
         0eVv2r9Ibm2irOo6N7TNpU0XZqJMpIXXllihIbuQjaI2W60yUYn4l7lYgRXZpE4nD9E2
         meCEUuczTQERojyCs6bvA9CVybZVTYAsIcht/ASA7EOBKphGN3xvQ0CDbLwmoqKjOdCv
         1XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777758664; x=1778363464;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfWnqGXBw+KSw3p0AjbKe+W3vx3+A1Jx1pklPBBHCkY=;
        b=TdKwDjvckMg6iIK3GsyJgYral5sGUWcdCx9//G1Lb4QsGX37xJQYOnRQklKXpoqZtV
         Nfpc3br7S7TAmtYyx8RnYPocQbb5TFha5dbO6pPTQUk1VnyDEhnHQCg8OAz1YR7jPP7v
         Rz2W+AlCv5zuY9f9wG68k5g1fAqDQ2Jjtwul0MhthVD3/uVhNWDbYSC/uj/DwxBbdTzB
         +z9LoD5W3qZMHOvD3rit2prB/79dMr9amtW4i8rPBRvHxuf3hapi3vy9d2g26I7yiPVU
         1bloOu+YJpj2IowIKJNQGQPZKNJtygvUdjcWvkK+Qhaxav5R3vxMPymY0EuUcPRgvmS4
         L+WA==
X-Gm-Message-State: AOJu0YxwcGOrPG6PVeUmrJQPuRsu5AsuQprTbBSukZmBA3wIfDt8iRy2
	wVIcBRqG0wzs6ks5RpkOu1JRexmnP3g3GzU9cCTdPR/7B7m47XeMDKLH+EqWdbOd
X-Gm-Gg: AeBDievMRsvb1DBM+R2Ddw3xaeBhSmq0Z6CAcsYLn0XB9Gq2WTZu0eAV0W6xJJnBiTv
	vRLqr3PDBIJ/tXyuF8u7fK1zciMkNDqJVDxhL2PI8jcJDi/t1djYdQKEtVp24TXQDLo/sNtwkh/
	Y5EcCyaC44lsfO2GUeuCB/i31kuDoD6UBYeMntd265i1jajjJAP/pA7TeSlKz+va0DJs27cXJsV
	USjzRZqNRvNBzqUCyeV5dzRu6NqnPFavES3PSoJr49fOZ3gOEdBDYyBqQ4YZ4uXdcwCJVB1ZFvv
	Mpi1fD3p/2GNTEluTxn9Ppc1Gioe2BO3HrivI7hx4wp/Er4ASYyuKgLtdoXof4CeBDgoKflah8V
	nNiTslcDTg1FXEm/OM7JnorWMGXQDFY+2vto8vYWdpt7g0e9oqkCpLCZr3bnEJOew5YSBz78Fp6
	yZRVlf4GRZs848gkVTgaQadBrKwF9lLPAG4r01amc0fe1E
X-Received: by 2002:a05:622a:2608:b0:50f:b904:457 with SMTP id d75a77b69052e-5104bef3d5bmr66864901cf.25.1777758664497;
        Sat, 02 May 2026 14:51:04 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040931552sm52968221cf.12.2026.05.02.14.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 14:51:03 -0700 (PDT)
Message-ID: <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
Date: Sat, 2 May 2026 17:51:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
From: Mark Levedahl <mlevedahl@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>, Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: git@vger.kernel.org
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
Content-Language: en-US
In-Reply-To: <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/1/26 12:42 PM, Mark Levedahl wrote:
> On 5/1/26 9:13 AM, Johannes Sixt wrote:
>> Am 30.04.26 um 18:18 schrieb Mark Levedahl:
>>> On 4/30/26 6:02 AM, Shroom Moo wrote:
>>> We have quite a bit of code that attempts to make Git GUI work from the
>> .git directory and also in bare repositories.
>>
>> 87cd09f43e56 ("git-gui: work from the .git dir", 2010-01-23) made the
>> first step. The original code just used the $_gitdir as the working
>> directory. However, at that time we did not have alternate worktrees,
>> and the old code, when used today, does not work in a `git
>> worktree`-created worktree. Later, the `git rev-parse --show-toplevel`
>> call came with 38ec8d3e2652 ("git-gui: correct assignment of work-tree",
>> 2010-10-20). However, it also changes the fall-back code slightly, so
>> that running Git GUI from the .git directory would not work the same way
>> as before and takes the .git directory as the work tree (because in the
>> .git directory --show-cdup is not "..", but empty).
>>
>> I think we need to restructure the existing flow a bit and not just fix
>> a single spot in the code. I suggest this order of operation:
>>
>> 1. Handle the bare repository case. If not enabled, fail. Otherwise, we
>> can work with an empty $_gitworktree.
>>
>> 2. Collect --show-toplevel into $_gitworktree.
>>
>> 2a. If this failed: If --is-inside-git-dir is true, and the last
>> $_gitdir directory component is exactly ".git", take the parent
>> repository as $_gitworktree. Otherwise, fail.
>>
>> 3. Handle all the other edge cases, if any, with the so determined
>> $_gitworktree. (I didn't think through, yet, what needs to be done.)
>>
>> -- Hannes
>>
> I found one horrid edge case: 
>
> Start git-gui in a gitdir not embedded in a worktree, with core.bare=false as there are
> one or more gitfile and/or symlinked worktrees elsewhere.
> - current git-gui aborts with an uncaught error. Good.
> - git-gui with the wrapped --show-toplevel call finds no worktree to switch to, so runs in
> the gitdir allowing commits of the gitdir items.
> -  I just added and  committed the *file* refs/heads/master to branch master in such a gitdir.
>
> git-gui's normal gui must be started ONLY if rev-parse --is-inside-work-tree is true. (The
> blame view invoked by gitk in theory could be allowed to run in a bare repository
> read-only mode.).
>
> For read/write mode:
> if --is-inside-git-dir == true at startup, we must abort, or find a valid worktree and
> switch to that.
>
> My personal preference is for git-gui to abort:
>    I started git-gui where it cannot run. 
>    My error. Let me learn and fix that.
>
> Alternatively, ask me what to do:
>     e.g., prepare a dialog after looking at git-worktree list, and the parent dir IFF this
> dir is named .git, telling me of my mistake and offering me one or more worktrees to
> switch to.
>
> But please, don't just switch to another directory without asking. This is just
> encouraging me to make careless errors.
>
> Mark
>
I dug a bit more into the startup logic, and I think I better understand rework that is
needed.

Two basic problems I see here are beyond the question of if (and when) git-gui should try
to locate a worktree:

- git gui blame in a gitdir was apparently broken by the git repo commit 2d92ab32fd
("rev-parse: make --show-toplevel without a worktree an error", 2019-11-19). Prior to that
commit, git gui would stay in the startup directory enabling only features that cannot
modify the repository, and gitk could bring this view up in a gitdir. This doesn't work
right now.

- git-gui's logic includes a conceptual error embodied in proc is_bare: is_bare uses $(git
rev-parse --is-bare-repository) but what we need is $(git rev-parse --is-inside-git-dir),
and these are not synonyms.
It does not matter whether a worktree exists that points at the gitdir, and as discussed
before, main worktrees can easily exist that we cannot locate from the gitdir. At best,
is_bare is a guess.
So, is_bare should be replaced by is_inside_gitdir, and we should also have
is_inside_worktree. These are mutually exclusive, though both can be false.

My current idea of an improved startup flow enables features only at the end:

1) If not in a gitdir or worktree, 
    1a)   if git gui's subcommand is not 'gui', abort with an error (citool, browser, or
blame invocations carry information specific to a gitdir/worktree). 
    1b)   otherwise, invoke repository_chooser, which either aborts, or changes directory
to a worktree.

-- we are now in a gitdir or a worktree, and this may or may not be the startup directory.

2) Look at the combination of git gui subcommand and directory type (worktree / gitdir) to
decide to continue.
    2a) blame / browser are ok in either directory type.
    2b) citool requires a specific worktree, which should have been the initial startup
directory. Abort if not.
    2b) gui requires a worktree. Abort if not (my recommendation), or offer to find (or
automatically find) a worktree.

3) Change directory to the top level of of the directory_type (git rev-parse knows
toplevel of a worktree, different code is needed for a gitdir).

4) Enable features based upon subcommand and directory type.

There are 12 combinations of initial directory type (gitdir, worktree, neither) and
subcommand (gui, blame, browser, citool) to consider, with a lot of duplicated code
amongst the 12 cases. So, obviously, steps 1 and 2 can be convolved in many ways that are
different than what I wrote above.

Mark
