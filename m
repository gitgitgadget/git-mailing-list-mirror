Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84021FF4A
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760888066; cv=none; b=N+Yn25b4ODAxLSq44YPZcgLnhPdhy+6iSmBUcbGAnqiM6bg67DRJE2U9MtXLIT/N5gsk+vmVhzH37BauLZLnECqUcgybNTxKGKOSmdA3C11K62DKpDxFLSlgyF9ujV5vvKvGJpd+cXWJ/kgFyR5JKXwDVr5M/86nnGGOzlax7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760888066; c=relaxed/simple;
	bh=Xu5XcqBJAjcMAbBJzvcAIlK8HIOxfys1muADOFtFGIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVV0eHABwtAhfl4NcG7kFfm+4zZQhwkyRYhJunQ2xcr1D6Aoxor30YbNh0EziZDIoG1rHFLmdtPbY9Dd+Oo9jlzSOqGLcvLkkLnogTiIyiI2aK+D9a9i2icS+Y7rMZtSqNvK9m3qDA08g4INmtSbor0NoDoZHWtmsQIFVu5ElRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILghzAan; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILghzAan"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b303f755aso36326965e9.1
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760888063; x=1761492863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1EYygmpqjbNALqSyJPNI9pKXYGI4nLw2E27b5voepaE=;
        b=ILghzAanbAjSw0EzhnNULEKtopNzu9MT3Fai0KuwKy1Grnu+vGMduHn1WAc2+rOvFm
         97XYYHlxFLSdmO0ZzXBN9Vj8Di1SLqn511rfwG0M1QMos60XamP5cymkJCR5AO2hAc0I
         4N9rvtHLrXSg7TBZJ3lZhE3JGsW7N+GrUKcI1Ox9I1tzOAGx7X65B3YxDxLtosPad5ci
         Y67SBRGl6gNu6T9zUEmIXm5QQtdXhB96wA6N2fEqFhebv+/0YsaYXQHePDOdTCUMQnDk
         0aAGOyHzAegvT7bnZLpu8IN9TYBCWLNiEliJYNF7jr4eLmzIw2bNDzOhHC76G7BR7Vcl
         CT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760888063; x=1761492863;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EYygmpqjbNALqSyJPNI9pKXYGI4nLw2E27b5voepaE=;
        b=CRAGDlfcFnEfTDFuozPVRm2GnSOsWyf/naikrcLkd0Pmx6JtRvY3/yW2UoGLteI4V/
         /tVpWEr+DnLXTRz+sPaF4nN/Du1B48H+7T4D6qs7N5qnMI5c3sKEmKW6tOW/DnusrFOw
         Ess/s2kQ31vvxBRmrQpvTC27yZGhxtE3BxWXHnpAC+km0+E9/aNBuZ1n+/92X0fzWwfR
         UiiyGuwpTdFlivZc8+5weqAwyhoWx1fNME9+xMupruYpUSZk2Y/0ZOmaIM4JGrqvW/Jf
         Xn/UoWZhNblUyPDAkSUEywo+M4ezcH5ad4EPQ0yGIbbg+5pDHIppLRSMPtMv8gcpTjVJ
         OVlg==
X-Forwarded-Encrypted: i=1; AJvYcCV8h3AKdv7QOOe3z5PdhgNKQFqJEM8tNrrHTu1V/gz3tipH5gb75BwcbrcXca9mJQ8JNjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHT0kI7QkrtyaaW6GimWAwNx/F4oFNSB3RWU7xWZ0Jb3tVxiQ
	vExHc/7aup0IgZ/RQP6n9sadEE65C4HyRx0kiEF6Q85wz/qIq6ob4CHL
X-Gm-Gg: ASbGncuUz70YDhrSHS8XSjpbrafwID7OA4zFML2ZcTM6Z2VQsdrMOjYqn28dW30aaMc
	BBoGyzYOj91butjvC0EPe8VAZchsZbMugue7VjY9m4JhSROMp8b5g2vH3s/ZX3QI8zOvK/u8uug
	6TiPMq+zU0/KXahnyAS+X9JPA5Po27cW+FzRO+3/Row3NJIVQ/VExkQbnZXBcLPVWTympRAEO2V
	9WrV94WdfZZ9JqSZwtuUoMJ1FSZzwLLpd0f/xyfcFg+ukGqFx+YaY6XUsc9dzu2wOSTdA/udXfX
	mVcoUpHx0AtmK5TU1eCit69DfZ+ySqZUQ+A7UIMNcT8MxD36IAnAq10LwL4uzirVEKeskiFurCP
	maYsJOpyLP8i1PzCmFEv+tPJeVp/K9I6ICsQ4VVhbBtWMUoTUO8sEMrIilkTcXPnEgrY7UxgIl0
	C2wuQB7ugkjHcRI6LOkTO1jODIoT2EmSxsHHKHKPfjNDZl62Rb9dNlCxQbhQcukek=
X-Google-Smtp-Source: AGHT+IE6ckwEvWLhYZ6P52q7FmPc6Kc+Tgx7z3brbVyURbM33xp6OY4tx/DZnT1hLoKva0uZlr4P2g==
X-Received: by 2002:a05:600c:8105:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-47117872704mr73056145e9.7.1760888062561;
        Sun, 19 Oct 2025 08:34:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm104812955e9.6.2025.10.19.08.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 08:34:22 -0700 (PDT)
Message-ID: <2688a523-e324-41bb-858f-b32040e1e909@gmail.com>
Date: Sun, 19 Oct 2025 16:34:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] git-add : Respect submodule ignore=all and only add
 changes with --force
To: Claus Schneider via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Brandon Williams <bmwill@google.com>,
 Claus Schneider <claus.schneider@eficode.com>,
 Emily Shaffer <emilyshaffer@google.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Claus

[I've adjusted the CC list slightly]

On 18/10/2025 21:07, Claus Schneider via GitGitGadget wrote:
> The feature of configuring a submodule to "ignore=all" is nicely respected
> in commands "status" and "diff". However the "add" command does not respect
> the configuration the same way.

I was curious why, when "git add" uses the same machinery as "git diff" 
to figure out which paths need updating, it behaves differently. It 
turns out that add_files_to_cache() contains

	rev.diffopt.flags.override_submodule_config = 1;

which makes "git add" ignore "submodule.<name>.ignore". Tracing the 
history of this line, it originates from 5556808690e (add, reset: ensure 
submodules can be added or reset, 2017-07-25) which made a deliberate 
choice for both "git add" and "git reset" not to behave like "git diff". 
If we're going to change the behavior then it would be helpful to 
explain how this patch series ameliorates the concerns that lead to that 
commit and why it is sensible to change the behavior of "git add" but 
not "git reset". It also suggests that a much simpler way of 
implementing the change would be to delete that line.

I'm not convinced that the approach of using "--force" is a good idea as 
it conflates ignoring changes to tracked paths (which is what 
submodule.<name>.ignore" does) with ignoring untracked paths (which is 
what ".gitignore" does). If we're happy to break existing uses that rely 
on the current behavior then having a new option to override 
submodule.<name>.ignore strikes me as a better way forward. I don't have 
much experience of using submodules so I can't comment on whether 
changing the behavior is a good idea or not.

Thanks

Phillip


  The behavior is problematic for the logic
> between status/diff and add. Secondly it makes it problematic to track
> branches in the submodule configuration as developers unintentionally keeps
> add submodule updates and get conflicts for no intentional reason. Both adds
> unnecessary friction to the usage of submodules.
> 
> The patches implement the same logical behavior for ignore=all submodules as
> regular ignored files. The status now does not show any diff - nor will the
> add command update the reference submodule reference. If you add the
> submodule path which is ignore=all then you are presented with a message
> that you need to use the --force option. The branch=, ignore=all (and
> update=none) now works great with update --remote, but developers does not
> have to consider changes in the updates of the submodule sha1. The
> implementation removes a friction of working with submodules and can be used
> like the repo tool with branches configured. The submodule status report
> could be used for build/release documentation for reproduction of a setup.
> 
> A few tests used the adding of submodules without --force, hence they have
> been updated to use the --force option.
> 
> Claus Schneider(Eficode) (5):
>    read-cache: update add_files_to_cache to take param
>      ignored_too(--force)
>    read-cache: let read-cache respect submodule ignore=all and --force
>    tests: add new t2206-add-submodule-ignored.sh to test ignore=all
>      scenario
>    tests: fix existing tests when add an ignore=all submodule
>    Documentation: update add --force and submodule ignore=all config
> 
>   Documentation/git-add.adoc       |   4 +-
>   Documentation/gitmodules.adoc    |   5 +-
>   builtin/add.c                    |   2 +-
>   builtin/checkout.c               |   2 +-
>   builtin/commit.c                 |   2 +-
>   read-cache-ll.h                  |   2 +-
>   read-cache.c                     |  54 ++++++++++++-
>   t/lib-submodule-update.sh        |   6 +-
>   t/meson.build                    |   1 +
>   t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++++
>   t/t7508-status.sh                |   2 +-
>   11 files changed, 202 insertions(+), 12 deletions(-)
>   create mode 100755 t/t2206-add-submodule-ignored.sh
> 
> 
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%2FPraqma%2Frespect-submodule-ignore-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Praqma/respect-submodule-ignore-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1987

