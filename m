Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7D2BEFF3
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287720; cv=none; b=fplgrnlBnlUlQVlj25MtOUXM+9YovuEaZqmUxnk2jKaPXQyRjSG0C5LJ52MU1yz/BzGcPDIMsEu0f8TbGOt7sxfib1XYadE6zqmiSF/N+B2S8b0dPEBu37KCGAqVqWjt52VRaYSDfkaM25VPRwj7klOzgkpJpoI81ngTP4z3sJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287720; c=relaxed/simple;
	bh=i8OgkuzLWX2HkZaejEqRurmudmzztM3OIagX9UBrHYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdjdqILIE3CafDUrqtEcSJDK7uvurkQ28uTvwLdigNQ3qC4T9InNwmwC2g54faNek98fbr4s9ePOKuc5XgXh2yxF6VNAjqjBhCE3KOY6xdS06Nn8YtfiSTfUwVcDRvngNrLZNJ60kRe0t4yeu90Mkox+NETIJDeJbgzNRc2vPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpdJis3J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpdJis3J"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c8fe6bd038so1603064f8f.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756287717; x=1756892517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9+ZFe0SpsqQ32eIWQdZHgGpE5j6oT8uSl+SaENsI9Vk=;
        b=YpdJis3JmAGfpnMakebrZKqosXiZH7UzRodBXFxDW/yvjJDvtAFsDwb4m3/uTSTP+W
         50u8iv5JcimVS1lznOrQQ24eEE5qblwgJe8s/k5WCFaaO/eBvtFULZut94RkT1vF12N7
         GrR74rIG4SSOtJUQG8w7kbhzmA1CJPB0MRUuIz8Otgomcbd4YckPGCzklmz5M/ORFYVn
         xs2PjlXGoxRTp9oNaeWXlN/tJ+L0mFl5GNndHLYYhHHkLyCJFmkvt7jaQZyrAsMexXQl
         l2unAEMNbqaeegzDmvoLM8RIv5Q3gznQL8xU8g7JXZyJXOlVEan4Kg/u8zn0BDXgAmER
         r8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287717; x=1756892517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+ZFe0SpsqQ32eIWQdZHgGpE5j6oT8uSl+SaENsI9Vk=;
        b=ka2f+GUm/tcrTytn/9TLSwxBRNIV6LDh+HpEipuAs6bF8wP59jdc5OeL1bVh4n7Xmg
         fos7Kw8pkx1O6oYrr9H3WT1qNyX3rL9nrlhxJpJqAmHATeIg3Z1rK84lGEUDUCgIy+KQ
         pA/A5g+TsfaBcC3QM4E9w1SzBQ4R+6oI7rFysJNL1LwmNA9LtkjguOn4hztQQgbX+0yZ
         5t7BayFt1kIeWgWv7pt/o/vWgBRmajTqF6L8VGAFnLySyS3QXvpWPsB+Tjw4z8VhCKRk
         sj+vcpMcK7fxi1R61xGFuSrmxaUsNzTE5nhTpsJjVFYT6d59YPYRZGt3hJL+/aUDR8t8
         IzcA==
X-Forwarded-Encrypted: i=1; AJvYcCUWSxntBMlpRgE31VBWMeLmVHDEatf2Si3iW3J2lt1OFcHdcQT3yM01qGn0W9AbxPwNk9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+yLAvJd36hFuivqqNPk+6HGOooLDQt3njF56u7OmuhetWxWK
	S+Svw0Ae8S0Jtiv63A8HVJqbgUfk1Vfv7a1uwSw+Qr+knjt3AOMtacWt
X-Gm-Gg: ASbGncuqD92qCyBCwWjXQ1Qx3DDIVXbE33k8MvPMK1BayezDOHppbPljx5OEnIs42nJ
	WNLZUlhkQFXDFHehdgnXaPba7ZUYq0hE6z55M0RWPpxHDLVrwUV1c9VZyeSWpZTAHZYwEE+OUI0
	pWFx2e0bRfcnm4OrX9P6E/Xw4zn2+O3ig4Edc7SZpCSDnzytBIKhJBZnU5Ua72ic3lbJ5P7oIb7
	GNYWsYA34iSGn0Ic7v8Ht1i40rSc2xxjYEclDpBalnFWD0bioOkynvalny88iU4EEqOmcsyAKHk
	q9wEzJcAZfKdBhzCjrWqsfA2pNtfNiut/xf8XjPVMzK+OjZWHUhK72g1Hkz1YEjr1yr6Nc8g0lB
	V94uo0iXlMVdTAjkYNISN0bHYj947mDSnEkokcA1ZjX2aSt0VHpVYm1h+sYQA5RFxZcGQkkZa1x
	K10Q==
X-Google-Smtp-Source: AGHT+IGslGcbBLuDvPIxiTJ1On5QveZY8+xc2QktNAtu/N1+dxn72i7K4fLu9GBs6964TOESvSQJfg==
X-Received: by 2002:a05:6000:2c0e:b0:3c9:c898:86a7 with SMTP id ffacd0b85a97d-3c9c898880fmr7741918f8f.15.1756287717259;
        Wed, 27 Aug 2025 02:41:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc66a45c09sm3065224f8f.47.2025.08.27.02.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:41:56 -0700 (PDT)
Message-ID: <c856cecb-ab70-4c43-a952-cf0350c7949b@gmail.com>
Date: Wed, 27 Aug 2025 10:41:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] doc: document rev-list opts in revert, cherry-pick
To: Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Andrew Jeffrey <andrew@aj.id.au>, Emily Shaffer <emilyshaffer@google.com>
References: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
 <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emily

On 27/08/2025 08:22, Emily Shaffer via GitGitGadget wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
> we added a handful of new options to `git revert` and `git cherry-pick`,
> but did not document them except by example to `cherry-pick` only. We
> have a nice shorthand for adding the rev-list documentation, so let's
> add it now, to both commands.

I agree that it would be helpful to have a some rev-list options 
included here but this adds a huge amount of text to the man page which 
comes before the documentation for frequently used options like 
"--continue". I'm not sure all of the new text is relevant to 
cherry-pick and revert. For instance do we need to document --bisect, 
-cherry-mark and --boundary here? I'm not sure the History 
Simplification and Commit Formatting sections are relevant either. There 
are already a bunch of ifdefs in rev-list-options.adoc that change 
what's included depending on which command we're documenting, maybe we 
should add some more for the cherry-pick and revert documentation?

Thanks

Phillip> Reported-by: Andrew Jeffrey <andrew@aj.id.au>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>      cherry-pick: document rev-list options
>      
>      Ach, sorry for the noise, turns out it touched both revert and
>      cherry-pick, might as well do the docs for both.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2042%2Fnasamuffin%2Fcherry-pick-docs-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2042/nasamuffin/cherry-pick-docs-v2
> Pull-Request: https://github.com/git/git/pull/2042
> 
> Range-diff vs v1:
> 
>   1:  fa352ccda08 ! 1:  f41cb4e8abc cherry-pick: document rev-list options
>       @@ Metadata
>        Author: Emily Shaffer <emilyshaffer@google.com>
>        
>         ## Commit message ##
>       -    cherry-pick: document rev-list options
>       +    doc: document rev-list opts in revert, cherry-pick
>        
>            In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
>       -    we added a handful of new options to `git cherry-pick`, but did not
>       -    document them except by example. We have a nice shorthand for adding the
>       -    rev-list documentation, so let's add it now.
>       +    we added a handful of new options to `git revert` and `git cherry-pick`,
>       +    but did not document them except by example to `cherry-pick` only. We
>       +    have a nice shorthand for adding the rev-list documentation, so let's
>       +    add it now, to both commands.
>        
>            Reported-by: Andrew Jeffrey <andrew@aj.id.au>
>            Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>       @@ Documentation/git-cherry-pick.adoc: fail unless one of `--empty=keep` or `--allo
>         SEQUENCER SUBCOMMANDS
>         ---------------------
>         include::sequencer.adoc[]
>       +
>       + ## Documentation/git-revert.adoc ##
>       +@@ Documentation/git-revert.adoc: include::rerere-options.adoc[]
>       + 	configuration variable can be used to enable this option by
>       + 	default.
>       +
>       ++include::rev-list-options.adoc[]
>       +
>       + SEQUENCER SUBCOMMANDS
>       + ---------------------
> 
> 
>   Documentation/git-cherry-pick.adoc | 2 ++
>   Documentation/git-revert.adoc      | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
> index 42b41923d5f..03848aa9f21 100644
> --- a/Documentation/git-cherry-pick.adoc
> +++ b/Documentation/git-cherry-pick.adoc
> @@ -174,6 +174,8 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
>   
>   include::rerere-options.adoc[]
>   
> +include::rev-list-options.adoc[]
> +
>   SEQUENCER SUBCOMMANDS
>   ---------------------
>   include::sequencer.adoc[]
> diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
> index ffba365e639..28827807473 100644
> --- a/Documentation/git-revert.adoc
> +++ b/Documentation/git-revert.adoc
> @@ -122,6 +122,7 @@ include::rerere-options.adoc[]
>   	configuration variable can be used to enable this option by
>   	default.
>   
> +include::rev-list-options.adoc[]
>   
>   SEQUENCER SUBCOMMANDS
>   ---------------------
> 
> base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb

