Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FB1FC0E6
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116330; cv=none; b=brLtrx7du+MsUz7iajlBuKKSB8hDpgb/RW878sVjLrrQAl7g8XLAS3hmvOWvzIshqdiA9Nbo3Vl3sM3JEs8UEcscN2FurHFz6j0vb01q1LpVbbaS5oo5zXXjWADoZFiWJ9huVexFphAZK5qoICvX0zuRYt2xcXxOZTGS0U7cuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116330; c=relaxed/simple;
	bh=BUKOuYgpdP//t3xjyYcCuRUlR+iHga3t8ZJetixqksE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=an9HyYCggm3+zH81Qy6b66LcOCxJkMjdh0ap6fflYYsDmlzQ7ZMlLvRrWMuCAQN447lvxjit5Yt+7/F1/p9ggIOm9+5UqBL/ccBhi6ZbCOwLi7oAjuZd8KHvgfJDQUg0RvdPF6Oj2daMsDoGi0C6aulV0iJb6+eNiKnTyaRbSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUYnoetB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUYnoetB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so8412805e9.2
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749116327; x=1749721127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h25Cx/JCVrTddzdXw7lyl/9zt57UxCwWjAv6zYLqEjI=;
        b=EUYnoetBXwu1LoVsTw5/WdOv1eThfgKv9WNAVFh+2qMaTlrr6lVIl7QbryvMuI8sLt
         K8p+mnPTfi5m2QMmhupnZY2zSQL1XtalmVVb0HbESCkKCXSQ8IIDqMPeI2ojAhnBEFA/
         wEiuuslSuthUZOx00O4mO8TxVI5R/IX2rMg42H6zLVjuUHVW+3f7zSovFWccFYN0ajuz
         DE+U0ZnqPTZSR7GxEZEFIYjpyOEU3rFv+GfRT9aLT2gBuVauRp54QrMikQdc32Z7R16N
         +bK0BlH3pEcuQgXaizVVjApR0V10ULx8A3ZlzeI0fhxZgVvLy9P49vsjSKPbzZgv53/A
         s9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749116327; x=1749721127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h25Cx/JCVrTddzdXw7lyl/9zt57UxCwWjAv6zYLqEjI=;
        b=jUS7RVe4bbPBOverMUNaNPomn2+ZVqRLJjUkkv9LRR+r9swZw6/XmhInOiODCFA+ib
         wHIITwqjjsFegLpQLMjvqgFahiIViBP/7tdqW6mu7hpmisSBqThBoFI+hc9+zn5zJvKg
         zqXE+0A0AXQRQsqxVfxMM1yxLh86EDdwCSwMTQBx9pqbR7D8GzY6rUZ0rWFwW5D/aSru
         6/3KYLoi0fyxULam+je+fCa35eAY3OHHVevovzf9X7eKYMaxI7SNpbC9BO6wtHQ2j1oY
         6hLHB5yupXaXHo9sTQ5Px5jmNo5zNGz72xnE0HyC9c4ehVGo03JBudXHcQgVrmB1mINH
         olrw==
X-Forwarded-Encrypted: i=1; AJvYcCX1+q01diB2HiUb6BhqZFDOADXzO/rGxiWi9JeYlf0KeAEFgrQEkkSbHmBSEr385lirMGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVhuQgsFQcL4duGu9UiTWrvS5V7iin9HjGoJ9mPJn+UFvqWXx
	9ZBrjd95h0RCbz/uwd3kEcm76mBStRLE23HH9OmVVMIwXa5K64XX9rmo
X-Gm-Gg: ASbGnctvoTQCHZwB/XxfNJPG5Q081b2c8EdNk1JYS8eLEmIcb44kbkZZkQ9RRnnyw2j
	yIwVbLhAGAfLyvwP5fmfLYgDfgnSEX8AUL6K57MGEp8fRmqL/RotOnVTCz7SO6TLoLg5CC4Shbn
	No5WH/p59nIJXKLfzc0CJqZ+vn8YY2vRs6m1+BEGmZZPhRIraKSvKVuPFZbjPX3thAeOK5barHI
	cRlrBbW3HDX+/yjzVRL/a8cBfLw9ncslXmEBsPGG5Nij50X2WNY2rvrv8N3hbcgk2Ro6fN30fJk
	QvWToL3JhRdOJQy3MI54QbqgfCrlUeWWM1KRdfKea1K5p1KXt6zR9n2vTD2cdftdjgsOhUi6uFX
	hXNK+VmbQOggBJo0q9BqhRL94xVM=
X-Google-Smtp-Source: AGHT+IEdcoxd9PMwuP9zC2yBFfVkLYqc9B6kWusWRWsG6ymgzHPBocRq5BILO4YHW9jjn9iG36562w==
X-Received: by 2002:a05:600c:1c02:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-451f0a634e4mr50927335e9.1.1749116326850;
        Thu, 05 Jun 2025 02:38:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f9816cf0sm19079165e9.16.2025.06.05.02.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 02:38:46 -0700 (PDT)
Message-ID: <1585978c-f284-41a0-a34c-e31fa8502309@gmail.com>
Date: Thu, 5 Jun 2025 10:38:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/4] Importing and exporting stashes to refs
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250522185524.18398-2-sandals@crustytoothpaste.net>
 <20250601223225.464076-1-sandals@crustytoothpaste.net>
Content-Language: en-US
In-Reply-To: <20250601223225.464076-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

I've left a couple of comments on patch 3 but everything else looks fine 
to me

Thanks

Phillip

On 01/06/2025 23:32, brian m. carlson wrote:
> Stashes are currently stored using the reflog in a given repository.
> This is an interesting and novel way to handle them, but there is no way
> to easily move a set of stashes across machines.  For example, groups of
> stashes cannot be bundled, pushed, or fetched.
> 
> Let's solve this problem by allowing users to import and export stashes
> to a chain of commits.  The commits used in a stash export contain two
> parents: one which is the pointer to the next exported stash (or to an
> empty commit with no parents if there are no more) and the second is the
> stash commit that would normally be stored in the reflog.
> 
> Original thread at message-ID: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
> 
> Changes from v6:
> * Add Phillip's sign-off to the last patch.
> * Use `commit_list` for tracking commits.
> * Use reflog entry walker.
> * Fix some commit messages for improved legibility.
> * Rephrase some error messages for precision.
> * Drop the patch that exposes `read_complete_reflog` since it is no longer necessary.
> 
> Changes from v5:
> * Rename `parse_revision`.
> * Remove extra call to `free_stash_info`.
> * Fix parsing of existing commit.
> * Add more validation of imported stash commits.
> * Add more tests for improved validation of imported stash commits.
> * Explicitly cast `items.nr` and make the iteration counter an `ssize_t`
>    to avoid casting problems.
> * Don't require a trailing `\n\n` in commit messages.
> * Use `read_complete_reflog` to walk reflogs.
> * Be more defensive when using `lookup_commit_reference`.
> * Apply parts of Phillip's patches for improved robustness.
> * Update commit message to explain additional use cases.
> * Use `OPT_STRING` for `--to-ref`.
> 
> Changes from v4:
> * Fix another use of oid_array.
> * Fix various memory leaks.
> * Fix a segfault which appeared after a rebase.
> * Use strstr for commits since we don't need to worry about NUL.
> * Added some additional tests.
> * Verify the ident values we're using to avoid using bad values.
> * Various other code cleanups.
> * Rebase on `master`.
> 
> Changes from v3:
> * Fix strbuf handling to avoid leaks and generally be more sensible.
> * Make use of the error return code more often.
> * Use oid_array.
> * Tidy various parts of the code and fix long lines.
> * Simplify tests using git tag.
> * Shorten and tidy tests.
> * Add an additional test covering the base commit OID and importing and
>    exporting empty stashes.
> 
> Changes from v2:
> * Fix uninitialized strbuf.
> * Avoid C99-style initializations.
> 
> Changes from v1:
> * Change storage format as suggested by Junio.
> * Rename to GIT_OID_GENTLY.
> * Remove unnecessary initializations.
> * Use ALLOC_GROW_BY.
> * Ensure completely reproducible exports.
> * Avoid size_t.
> * Various other code cleanups.
> 
> brian m. carlson (4):
>    object-name: make get_oid quietly return an error
>    builtin/stash: factor out revision parsing into a function
>    builtin/stash: provide a way to export stashes to a ref
>    builtin/stash: provide a way to import stashes from a ref
> 
>   Documentation/git-stash.adoc |  29 ++-
>   builtin/stash.c              | 460 ++++++++++++++++++++++++++++++++++-
>   hash.h                       |   1 +
>   object-name.c                |   6 +-
>   t/t3903-stash.sh             |  94 +++++++
>   5 files changed, 577 insertions(+), 13 deletions(-)
> 

