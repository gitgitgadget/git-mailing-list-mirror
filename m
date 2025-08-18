Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C3335BCE
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524600; cv=none; b=CRMNMZMJhenQ34t6Gc7twF3/B0sj2dr24MrqaqCFeNd8H/SRGJLkBmtoSPAd+lXFsquCtCacoluatucwiic1oNVbGwpz+kjg2eOxNMaOwPA0c6OPTT7XZ3aEz/50LMhlxLrjualDg4QsHYFLJ2rLbXAcH9e2ZnZhsNYI48oxbY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524600; c=relaxed/simple;
	bh=NrVoW8+PUSrWIwvu4oGNJg2qJFQoZeEebBNvftAAelQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M/czsFqt+R9POCnYLSue3FtDiTkqx2PU7ZDmJAS+znW5y2dIXiBideE7qgh5LlRrhL5e1vWElVWSRKjjSG0G09ok6RQ2XyN+cYMuZgSzUqfDyR7GtHRt3kd5lsDHtsCtf2CrLd6iyzfA0augt8acSYKOgHacQUVqd75gVARTV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEhZnI+5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEhZnI+5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so24824765e9.2
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755524597; x=1756129397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ+lJLuXUVVzGWRCy2pMXfFd6QLbXB993n/5iqZwEb8=;
        b=jEhZnI+5Jf3EfBkNstFBTD4kpjTlMQ4i7QiYT6H1NYj7tmt8uIQ5B4vAwqgFUiHkQM
         V1XDSeoasjtbygJto+qK2VHxn+w1dhAcnLNRSJg9kPz/p7IgdUm7xofRt51eL9q3ipgl
         lOphGHmkL6mSeEl0bVLhzGm/vUq/V/OjuKqLuvoRZ3VdxTU4RN0Fkx4DH/Z7aXgSlhTS
         E0Yf428OnKjhtoeIpbr/TBcjL8INmPkrkHAgqzbH6navG9H4rAtrr9ZZEiDB+JefcnRp
         EravvXiZo04FYERHgmWJQVMIuyu4avDO2jsBNampkDtPA9hMR1MoZAv0hloKBO+DZjvD
         hScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524597; x=1756129397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ+lJLuXUVVzGWRCy2pMXfFd6QLbXB993n/5iqZwEb8=;
        b=RdGYl8VlCjj0R9Fyamniw0JzL02sCXZS6CpZJZQWwS/nnuOtfAVxIS3Pty6YW2cJGJ
         GMi4Zetq4qjD6XKdjxe68s0xq30LwtW5geakxp3aY18hyyYlE3/bXwlUxVS7l+B+biN4
         ntJCEzPMws1x1SGPFN6+Xriu4r1Rtq531Dajw6mjDKq8BoA7KPTYr+6CoRk5hUdDiBE7
         9PO7CiKguJoBHtOeQzemDe4TaYSpeZO0wp0WY1z+HYWVdFncwIbMseDFN/febkTidU5/
         dZmuyC8Py9BMc4rIaskai1qYvOdaM/2iy6+968zVkYsTmQTqXAZbyomcYbk5wXuyTZrM
         ATAw==
X-Forwarded-Encrypted: i=1; AJvYcCWkhgn8Ne53G5pb3pF24umEaAK45A8f0uptO/qsFiSjEM51AswI8UOqwHzu65KuUBOM4dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJmHY47FN+Kdq+0m9StbdfvR9OBFND2wPuxUENlFXsgZaMBiX
	5XXZ3328qF59+bC+CwiqHLyBr2nC79vZC2Bw6gmucOagC+fh9M9TXhls
X-Gm-Gg: ASbGncug2SmTDtYjveO8mHsJUOpztbd0d6Y6vOMaGoX2LHVqMcE4DAQ7yfRNs+Or5se
	oi0b+AWuu/jMIgkKODu2DrtCKpAk8eUF/u/4ts7X4JBpyLlap94RaeoZHMV0GOUQgZBJA0/1sgV
	2WSy2PkbFdPDHq+rbH7LO9utw7+WXzGNt5b80WCtstXjKVV14TlebSISa2iv+sn4muXmmjk6zrB
	x5ThaYNlMKZtd3rf9lVIPC+YsHCcxVHBTBp3asoQR+M4/NA68Nuxea2v3ndD+owhyh008lmJUwU
	clZDrEo1VJ4Gp351oy7BAh2U3w1uT41iGNprJvjXneyZHt9yTTivQASTdOPrO65dtDghF7RA8rP
	XQMlyV0hRO9q0P3fqLHWb7QeqgQgZgTg0dqk4LVC18QIdctc6hyJxPDcocWxgzHujI0p8Adn+HS
	PIPWAGxKy6mm+X
X-Google-Smtp-Source: AGHT+IEdQmfXiqLPKwC1rSWmK8k1rWGlI7r402tdkUx83eT7EoWrZzrG8jvw/d1dMplgm/U40W5q0A==
X-Received: by 2002:a05:6000:40d9:b0:3b8:d082:41e with SMTP id ffacd0b85a97d-3bc6a83c651mr6863325f8f.57.1755524596862;
        Mon, 18 Aug 2025 06:43:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475857dsm13105450f8f.2.2025.08.18.06.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:43:16 -0700 (PDT)
Message-ID: <a14efbe9-0d7c-4631-9f03-6adf979b690b@gmail.com>
Date: Mon, 18 Aug 2025 14:43:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/5] doc: git-rebase: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
 <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 17:52, Julia Evans via GitGitGadget wrote:
> Combine point 1 and 2 in "a simplified description of what git rebase
> <upstream> does:" into a shorter summary.

This looks great, I've left a couple of comments in reply to Junio but 
I'd be happy enough to see this merged as-is.

I'm going to be off the list for a week from tomorrow so I wont be 
commenting any more this week.

Thanks for working on this

Phillip

> Julia Evans (5):
>    doc: git-rebase: start with an example
>    doc: git rebase: dedup merge conflict discussion
>    doc: git rebase: clarify arguments syntax
>    doc: git-rebase: move --onto explanation down
>    doc: git-rebase: update discussion of internals
> 
>   Documentation/git-rebase.adoc | 298 +++++++++++++++-------------------
>   1 file changed, 133 insertions(+), 165 deletions(-)
> 
> 
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v8
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v8
> Pull-Request: https://github.com/gitgitgadget/git/pull/1949
> 
> Range-diff vs v7:
> 
>   1:  e7a8fbbe53c = 1:  e7a8fbbe53c doc: git-rebase: start with an example
>   2:  ad63f69918d = 2:  ad63f69918d doc: git rebase: dedup merge conflict discussion
>   3:  7ee6b0afe88 = 3:  7ee6b0afe88 doc: git rebase: clarify arguments syntax
>   4:  4686417b28e = 4:  4686417b28e doc: git-rebase: move --onto explanation down
>   5:  79f29ad1e68 ! 5:  cb85642bb9d doc: git-rebase: update discussion of internals
>       @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
>        -to point at the tip of the branch before the reset.
>        +Here is a simplified description of what `git rebase <upstream>` does:
>        +
>       -+1. Make a list of all new commits on your current branch since it branched
>       -+   off from `<upstream>`. This is the same set of commits that would be shown
>       -+   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
>       -+   change how this list of commits is constructed.
>       -+2. Check whether any of those commits contain the same changes (according to
>       -+   `git patch-id`) as a commit already in `<upstream>` and remove them from
>       -+   the list.
>       -+3. Check out `<upstream>` with the equivalent of
>       ++1. Make a list of all commits on your current branch since it branched
>       ++   off from `<upstream>` that do not have an equivalent commit in
>       ++   `<upstream>`.
>       ++2. Check out `<upstream>` with the equivalent of
>        +   `git checkout --detach <upstream>`.
>       -+4. Replay the commits, one by one, in order. This is similar to running
>       ++3. Replay the commits, one by one, in order. This is similar to running
>        +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
>        +   are handled.
>       -+5. Update your branch to point to the final commit with the equivalent
>       ++4. Update your branch to point to the final commit with the equivalent
>        +   of `git checkout -B <branch>`.
>         
>         [NOTE]
> 

