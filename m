Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC031064E
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117157; cv=none; b=YcBHPHC+RexgFVuhy9ftGTcOgE+Pnl4e2RyZJul7k2oz/L/uqy7HCEjATgE44LKlvr4ZpqyddrftAMG6Ox1REgpPu2pKvUPYQlGT10gc2eaJrCnI86WRWywm2mMZ5zVwqbhvA8UFM74G8iOnzoO4nubtcxJjvramnEhm1wQaN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117157; c=relaxed/simple;
	bh=opA9ZtxxaMucAL+Eavfd+NfRxx9ySxOUfBEchBL8BDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/39fo0TOs5Fg5+71unj8Cxp+3YhvkTrpcrUfiSsCA4VMX1lXWiZubSyAOAKQm9g3tfmCxkeBw6PtKVyd7cvrvSjipALSWmV/TES3jbyDRqAJ048agHeX8UrnmJtFJkztQSjxDRvxX55VjXLMMZH54saFaZ9e4QQS01p0F8pfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE/BDjWX; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE/BDjWX"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806bf39419so15415015e9.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 06:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772117152; x=1772721952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3aMm1P07gvrQes0xDsQjIWPutgWl3sxnmAobhw4fOA=;
        b=SE/BDjWXDAwn/1J+UWz7YUZeCH3WersaUgfsuFh0LIyOnbchfe6BgcNgEoO/jDh59K
         ppExaQ5jyBh1GykJ0K0J5tYDwnEKb1VgozzF1Stv/4OTG1Z8HumBd3/gxU8lIE+/hISM
         qZr9GzYWDbO4QjIwEh2vPbU28oWQBt4tGMBmZda1denAV0wmXkZJ4HY08uaOqX6/vbDl
         Kq6g8yv58sFVVuyq4JF8eZyOctIVCHYq/jyDSgip2GyOBB8qnFyhGfTs+Pjxcbmkhjhg
         nmX3jA+fi0jBaTdUcoIsLeKYCPO/xhVK/w6Nt547OU8l9v9uuM47tnmg3ZY+6Pb4HMV5
         2xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772117152; x=1772721952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3aMm1P07gvrQes0xDsQjIWPutgWl3sxnmAobhw4fOA=;
        b=G0aEUUnfmfk8xLknmeRJlCRviwLYPuKZFr5UqzuEnjSpAEtsy/oDukrY6VvKmDzuz/
         ZZB6GvXK1uwSAj2m9r+3KFZagPCQKer34FRvMZfZOTZB8h7xFJnl+Q73U22Izgg3x11d
         n/ieIjfLxuRPfEGNApPhhRlF0V8m+0fB+KVAn/lbn/9mR6+xzV5+oQOQVgTPGW88PuS/
         U364MfL99k/Bt3I50gWNpgDFEIduW1pdgCHiGUB7NBcIVdICaBOvFyhXn3+xH8YgIMSY
         Nrqgd1ghtHiPx0ob4My6Qz/YHkNlBri95/NjToTW2o3VqEeoGIj7vgYa6C19KBjhhRyC
         Q1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrDOKlK+UFK1PaD1+6z5vLg3CCtT5sNSSZrysFM+xYtWzSYtfKddNEQaCxb3ORgEZwKGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwlxrkWOuWS02PMVWvDUSF1fOzLxYJVgyXlvFXmoK+hSdsK7M
	QCOCDeSX8Hysd2ENP42XL7RgWez9nPcNGPaDAh4Pqx+dxuW9fhK8DZ3R
X-Gm-Gg: ATEYQzzJ98G9RwJBhElHP1joSJYdIaOROqd4O73EJj4LA1HHwOBW/sNjE7Ir3G2oBxQ
	aK3ah0ooYGiJZXnB31olSx6rkmv4vg20pR9grvM48g4buRxe8niMzQfVVJKLjZR4DN/rBkJbtnS
	Ktu6l9Jm+vaVv+SMRrwn2TOnotq/L+g7oBPsZKgvE2MKLuIJ1RN70f05gnjUZO5KRnFnLd6/l/n
	gvJ90hs6ud3SFckTFtHZ78dsyWiCFnT8tyt1ICcYD22uC8Bdj1Dr5aylUr2g1g9OyHkHDpIgygt
	BsvD55IVAoHlB9OyVuY7ajO+CHPV286oty6U18AelLOasb0cAL2CI/7qXEO4Qi47omj2Qks5S1g
	sFbDigsKhN0x9gIlSxJBBbR9nvoXId8dOZQ7PbN4h1P6pkhoo7DBnWN8JoQ/KVWnU342kYea33I
	zALnANZ7d0InZDgwonJaM/g3SKoCNtbv4NhwzU5aYmpY2Fzc9j3oyl5wH9gBZ5ozmKxutlUjNoc
	nsN8g==
X-Received: by 2002:a05:600c:46cf:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-483c33ccbe8mr64532175e9.7.1772117152354;
        Thu, 26 Feb 2026 06:45:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm91371385e9.3.2026.02.26.06.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:45:51 -0800 (PST)
Message-ID: <405b0d34-c2ad-498d-93a1-2e7925ae11f1@gmail.com>
Date: Thu, 26 Feb 2026 14:45:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit
 changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260218234215.89326-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 18/02/2026 23:42, Siddharth Asthana wrote:
> @@ -42,6 +42,25 @@ The history is replayed on top of the <branch> and <branch> is updated to
>   point at the tip of the resulting history. This is different from `--onto`,
>   which uses the target only as a starting point without updating it.
>   
> +--revert <branch>::
> +	Starting point at which to create the reverted commits; must be a
> +	branch name.
> ++
> +When `--revert` is specified, the commits in the revision range are reverted
> +(their changes are undone) and the reverted commits are created on top of
> +<branch>. The <branch> is then updated to point at the new commits. This is
> +the same as running `git revert <revision-range>` but does not update the
> +working tree.
> ++
> +The commit messages follow `git revert` conventions: they are prefixed with
> +"Revert" and include "This reverts commit <hash>." When reverting a commit
> +whose message starts with "Revert", the new message uses "Reapply" instead.
> +Unlike cherry-pick which preserves the original author, revert commits use
> +the current user as the author, matching the behavior of `git revert`.
> ++
> +This option is mutually exclusive with `--onto` and `--advance`. It is also
> +incompatible with `--contained` (which is a modifier for `--onto` only).

We seem to have lost

     NOTE: For reverting an entire merge request as a single commit
     (rather than commit-by-commit), consider using `git merge-tree
     --merge-base $TIP HEAD $BASE` which can avoid unnecessary merge
     conflicts.

from V2 which is a shame.

I do think we should seriously consider reverting commits in the reverse 
order that they were created (i.e. do not set '--reverse' when setting 
up the rev-list options) to reduce the likely-hood of conflicts when 
reverting a sequence of commits.

> @@ -152,6 +172,15 @@ all commits they have since `base`, playing them on top of
>   `origin/main`. These three branches may have commits on top of `base`
>   that they have in common, but that does not need to be the case.
>   
> +To revert commits on a branch:
> +
> +------------
> +$ git replay --revert main main~2..main

It might be more realistic to revert some commits from a different 
branch, for example

   git replay --revert main topic~2..topic

> +static void set_up_branch_mode(struct repository *repo,
> +			       char **branch_name,
> +			       const char *option_name,
> +			       struct ref_info *rinfo,
> +			       struct commit **onto)
> [...]
> +	if (rinfo->positive_refexprs > 1)
> +		die(_("cannot %s target with multiple sources because ordering would be ill-defined"),
> +		    option_name + 2); /* skip "--" prefix */

This is a bit of a nasty hack as it stuffs an English word into the 
middle of a translated sentence. Using the option name as below might be 
nicer

     die(_("'%s' cannot be used with multiple revision ranges because 
the ordering would be ill defined", option_name);
> @@ -226,25 +269,46 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  [...]
> -	/* Drop commits that become empty */
> -	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
> +	/* Drop commits that become empty (only for picks) */

Why? What's the advantage in creating empty revert commits?

> +	if (mode == REPLAY_MODE_PICK &&
> +	    oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&

Thanks

Phillip
