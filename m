Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1142146D72
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158247; cv=none; b=ibtYNIQg4/N6DY3PPzgx6VCM4rvtAEd+31vbhgtdvGfdFEij9CrYdgclLrDvIOUn/ekviv7mK9xTh2ZiSL/30Eu+SwQYi/Q3IgHEPaP/wGPFYOZCt9ghdnSD+mf15gByUM9hBqdrFhiBFgk1UwWxPuWUA9RvfkaM7nGjU6FX5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158247; c=relaxed/simple;
	bh=L988shCxDnMA/h/P5DnRvzfBPeKBZ+JkVsVUjTV8n1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8+9KXurntgaSGumm577FSYvRjM+bo9hPqRxHi+8tRefX5PylCiZmjeYEUGe58Iv3bOQ7F3LrWaBKp9GEdTLr3qIGOBezStmpfR7d11kegjDWvyFaW32LcTsI6Dz5pW4rEhdToRQ2IVpxgBuCANro2Cc0/KABfziIG7OCTPHEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knt3LXuM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knt3LXuM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-416262d747dso2242835e9.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712158243; x=1712763043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zC/FuWKCpuOQpQ6E8eLRqXG7ZCuGYITbn9ZKY14vxIs=;
        b=knt3LXuM6crI4WXA+c+xUVyM6JtXEYxQXLeyymZeeeDVooLslTsW1LHmhQAhacZD4m
         zPK8FtC+T5mJg+JSVxAAwWn7qLm6pLlkDi6XWMjQOdGwmbDTNRA5hC51IuY8llRHUidt
         7QGsTRqzjcXiVsozIR2mhfDH9TpmIaaTHouHorAgSgzF6FhrCbMB6tJCGA4uUPOGu4TX
         PGCwXggcsNISYazPfGIU5aarFxwgRAIV9NmPyJ6Rb4hl8+Zm/m3Vaw5FyvM41TUK1tdG
         YJ/fA/Bjaj12uhWNr6r2/5ETl0CTXh4YLsm4YahyUewY7u3ruqVD2N0R8ybwXcbb05VS
         IDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158243; x=1712763043;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zC/FuWKCpuOQpQ6E8eLRqXG7ZCuGYITbn9ZKY14vxIs=;
        b=KTNRWkKtd3irNIzCQsrnyqWjQl5gfrOitScCqveNv8B+Q9kJDLnrSvhlAfoKBfoyS5
         nnzKx1/VDnfLCT2DLtlDsH3aPFL2j8+OO2T57TN1dOf4MElNncNhMDwZK0mu9oBtPJ87
         kIu8DG/scx+RMcixLECFD6LPZ2Ln4Ezg4+0KQFTpTjCFsddI/1lwvSgwUCPiFrShw8pt
         Ydx6BEmQHQyayL3lHLE2mo3SUTHuP9Y0rzW2i7KQQV4sqc821JACFIbU/rnbN6iaYk3f
         6N2zY06qcm8h5QeGqgbiig6wui0e5AnzH6SSSmC0auJu+TFeDVjVHj0LG8kwgNjuiWBZ
         0IJw==
X-Gm-Message-State: AOJu0YzO0YgbgfYJAypAp4YMO4Ba3+SRCtmQamYjztOIOzC6s2TIaj1a
	BytUi+ipvsDPTgxh6XpALACst//7WqiwaReu2mksTvPLKXsJ2j0SOv24sr0d
X-Google-Smtp-Source: AGHT+IHBmDwscn/Q8zU0LWtQXQHtqBJfyA5/f1Qaw2hveYAMooazuCIqSzTfJTVZ0KjBCV+uU7KONg==
X-Received: by 2002:a05:600c:1394:b0:415:6121:5171 with SMTP id u20-20020a05600c139400b0041561215171mr7821397wmf.32.1712158242777;
        Wed, 03 Apr 2024 08:30:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b0041563096e15sm11434532wmq.5.2024.04.03.08.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 08:30:42 -0700 (PDT)
Message-ID: <781ba921-e11e-4c9d-8764-1366b3043375@gmail.com>
Date: Wed, 3 Apr 2024 16:30:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Worktree shares a common remote with main checkout
To: Bill Wallace <wayfarer3130@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
References: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
 <0f65aae3-15a1-456d-8285-7923a880deea@app.fastmail.com>
 <CA+2m0i_zGcFBd2+L_Q_foMQ=eJbXqUZGqDeOwfefg=Y4GMBRWw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CA+2m0i_zGcFBd2+L_Q_foMQ=eJbXqUZGqDeOwfefg=Y4GMBRWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bill

On 03/04/2024 15:26, Bill Wallace wrote:
> The problem is that one wants different default remotes for different
> worktrees - for example, suppose I'm creating a worktree for two
> different projects, plus the base repository is on the "origin"
> default remote.  I then have:
> base_repository - a directory with the base/default origin (call it
> 'origin' for now as the remote name)
> project1 - currently checked out with 'feat/1'
> project2 - current checkout out with 'feat/2'
> 
> Now, project1 is being developed against a remote repository
> 'project1-origin' and project2 is being developed against a remote
> repository 'project2-origin'
> However, both are getting merges from origin/main on their own
> projectX-origin/main branches
> 
> Now, when I'm the directory for project1 and I do any of:
>     git fetch
>     git checkout X
>     git push
> 
> I want the correct default to be chosen for the remote - for the
> base_repository that should be 'origin', while for project1 it should
> be 'project1-origin' etc.

You can set a different default remote for "git pull" for each branch by 
setting an upstream branch with "git branch --set-upstream-to" which 
sets "branch.<name>.remote" and "branch.<name>.merge" or 
"branch.<name>.rebase". You can also set a different remote to push to 
by setting "branch.<name>.pushRemote" - see the "git config" 
documentation. Would that help?

Best Wishes

Phillip

> I KNOW I can specify those manually, and git push will give a
> suggestion, but I WANT all of them to default to the correct remote
> associated with that worktree so that I don't accidentally pick the
> wrong one or forget to update the correct repository.  This is to fix
> dumb fingers that sometimes do the wrong thing without thinking, and
> to try to reduce the number of things that don't get done
> accidentally.
> 
> What I'm doing now is to create a new non-worktree version against the
> projects directories, but that then doesn't share any data.
> 
> git remote add ... has nothing to do with this, but I want something like:
> 
> git worktree add project1 --default-remote project1-origin
> 
> The idea is to make the expectations of what happens to be consistent
> with cloning a new directory, or at least as close as possible to
> that.
> 
> Bill.
> 
> On Fri, 22 Mar 2024 at 13:29, Kristoffer Haugsbakk <code@khaugsbakk.name> wrote:
>>
>> On Fri, Mar 22, 2024, at 15:50, Bill Wallace wrote:
>>> This issue is just to fix an easy to make mistake when working with
>>> multiple remote origins and worktrees, where it is too easy to push to
>>> the wrong remote origin because one can't set the default origin on a
>>> per-worktree basis.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>> Used
>>> * git worktree to create a worktree
>>> * git remote add to add a custom repository
>>> * git commit/push to try to push changes
>>>
>>> What did you expect to happen? (Expected behavior)
>>> Expected to have the git push recommend a remote origin that matched
>>> the worktree, but it defaults to 'origin' all
>>> the time, which means I need to checkout a clean clone from the
>>> specific origin I'm making changes for so that I don't accidentally
>>> push to the default origin.
>>>
>>> What happened instead? (Actual behavior)
>>> Suggests 'origin' as the default origin - which is CORRECT for the
>>> main git branch, but I want to use worktrees to allow working against
>>> several remote origins, with the default being determined by which
>>> worktree I'm in.
>>>
>>> What's different between what you expected and what actually happened?
>>> Suggested 'origin' for the --set-default rather than allowing me to
>>> define the origin I want, for example 'wayfarer' as teh name of my own
>>> remote that I have cloned on github.  The default origin is still
>>> supposed to be 'origin' for pulls/naming, but when I push, it needs to
>>> recommend the matching origin.
>>>
>>> Anything else you want to add:
>>> This is a bit of feature request, but the reason I'm listing it as a
>>> bug is it makes it very easy to make a mistake by pushing to the wrong
>>> origin for a new branch.
>>
>> I don’t understand the expectation. git-worktree(1) just gives you a new
>> worktree to work on a branch, do a bisect, maybe a rebase and so on. I
>> expect `git remote add <remote>` to have nothing to do with the current
>> worktree that I am in. A remote ref is for the repository, not
>> per-worktree.
>>
>> If you are creating a local branch based on this so-called
>> worktree-specific remote and this branch exists on this remote (and
>> *only* on that one) then you can use `git worktree --add --guess-remote`
>> to automatically track the remote branch.
> 
