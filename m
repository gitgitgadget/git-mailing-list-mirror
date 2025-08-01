Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A722D9EB
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054874; cv=none; b=eKAdDugmjB1WA8xEDDyi4JC2fuZaSgOlfsKWheaNHHOGuT6JwYxKWS8a6g0onTROJUqPe1NHpSIAodAVj6VUsA9Kj97Lxu2/cT44DO61wIB0kMcpRdsQkB+ke6bnn4tXpLB8UhZn7IyPcRtAPe7t2pBgmqHOlOTdFULJrtOdWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054874; c=relaxed/simple;
	bh=WsqUzo+Zw6fmGeGmcZzDba6URiklGrnFw3nZ5g6UhGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C07ZdW8lPSies7J93CGl7waU4UrNilJIREbCA7GZ08sIir6lLPTjHLD1vx2NHFDenO8UkRi3fslettrQp1aKdqocrSV2FKrSd1PMD/AUmo4az3EVbIQCHvAseMfJjyqezZuKqDlk6i5q+2zzZeadKBeEIMkxPW4D+19nYaEihWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMj7/f6r; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMj7/f6r"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7886bee77so1720111f8f.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754054870; x=1754659670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vgfU5zFGR6ViMhhqo5hjxrIIZfvToph3q4URoXPbtr0=;
        b=lMj7/f6rg2gVVBO1FyUd29AcySyT9hLdg5TLZwnlC+FiAf8Ggn5loVK9Q+dD6C7pjS
         Ksv0i6RzitY0UxhbmKfcUtWWlr7K2qr7JR3jjXpN7hfjob8CSzWPoTJqqQOKoCuBgo29
         yzAACcqU1wePbdsE5o2YUo/b3j2/WncnzDy4VGF5/o/XdiSJLR5JIkDDf0MRJGzC8O45
         3tj+ybMqPw6dgOlXzoOV2wA8xopynlrsBhul/9p7Edi5qSYZ6VYTdPx9IagXw+/ZC2FU
         XYFY6kPdjEua6OIRRqfA6oOQfTyu7Hy0drGX2HqHO0eiFuRRkZH8ncFkHCH+rsD3wXYf
         PiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054870; x=1754659670;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgfU5zFGR6ViMhhqo5hjxrIIZfvToph3q4URoXPbtr0=;
        b=Su0WG+ne50K0t/BtHBlwxxPiLhpyRDexdpKgerHZ10TH7WE6A5px8X0K9ULeGMniiR
         oi1jPAI62dCvPfTKziiyZvwDFf+nTUa0eSXua6l42IMjuzrxS9tdvUoE49DT43jX2Vav
         XUJevTPBT8yx2wbR6qD0KLLDRlaQNwPq5Y+ptxM3Tf2BoI90s1zXb5URT3oW9BsNcUT5
         BG9P0lqHHun5ewnilGzGujwihRgOgYVbv2+lkq5RwPRrG2mj+EvpMtbs2UtxQWxAcRYo
         oAJltco87FkD/5nAISW+ij1BKUWGrb7Ri3wRXOFnE8Y+xSBVG+3+dTWqM00G4S+8M47R
         eXGg==
X-Forwarded-Encrypted: i=1; AJvYcCX9IqTP+dbI5rNr7lG70jNquMnsPy8L/hdJHn8zfZa60f2tfM4NiaBXSowFphHP2iXIrbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04HOXQYFknMbEOMnH67gSAaBFnxuoBH/iv1SS28J9mcRVdtT4
	L7HsGKzmBAeC4GKw2Pd9o4Elw95oZBqvhbomhpHHsiU6skNWVQuifJpR
X-Gm-Gg: ASbGncvFCa0O2r9YOH0iHKh3SHbczoQYK0VXLR51DyBxqaBOXnEERml7u8bKjSzaam8
	SAjKlxxdtancyuwi19wVNVjyb4To4fjRA5dJ1NRf7VaIeNP25wvblawgA38qhwtXzm/wuG0E30Y
	tLPvgdcbBHb5NXVyePEP4XJl8WfLjNr3Tof7J30QKm72EdVOSfGoEi9X2YxvYXHLar0F3+7gd+a
	8ikqZsqlpXA8285+m9mPJUGEGThNze8CHu7dd05yzSLffx/D8ccIPa+Ib7kVmsq6TZpTuoWLQFh
	sX9lTr58WbZlO2jrMvKkJvsrNWv5ixv0vfglRc8LhcdO5F99TQ39PDJu0sPlV6g1qbMZgh8MKgi
	zLvRqyBuQWSNx2wE3iOleTBI2XxmjSou6UQi9zM3W81SDPQwueCj8o8ZasoKJPWyOQEoCtC11oh
	uG/ijtPUq2kZ8=
X-Google-Smtp-Source: AGHT+IEN8aCfloEDOZxqGvskRhWi0q7QnQ/9/Fi+xRpuSRkb5EBIn70M4bbrQkV/Huzk8oUdtscTGA==
X-Received: by 2002:a5d:588c:0:b0:3b7:735f:25c9 with SMTP id ffacd0b85a97d-3b794ff29cbmr9948545f8f.21.1754054870429;
        Fri, 01 Aug 2025 06:27:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eba17sm101893685e9.24.2025.08.01.06.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 06:27:50 -0700 (PDT)
Message-ID: <2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com>
Date: Fri, 1 Aug 2025 14:27:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
To: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com, gitster@pobox.com,
 sunshine@sunshineco.com, John Cai <johncai86@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-4-meetsoni3017@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250731090040.1625303-4-meetsoni3017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Soni

On 31/07/2025 10:00, Meet Soni wrote:
> Git's reference management is distributed across multiple commands. As
> part of an ongoing effort to consolidate and modernize reference
> handling, introduce a `list` subcommand under the `git refs` umbrella as
> a replacement for `git for-each-ref`.
> 
> Implement `cmd_refs_list` by having it call the `for_each_ref_core()`
> helper function. This helper was factored out of the original
> `cmd_for_each_ref` in a preceding commit, allowing both commands to
> share the same core logic as independent peers.
> 
> Add documentation for the new command. The man page leverages the shared
> options file, created in a previous commit, by using the AsciiDoc
> `include::` macro to ensure consistency with git-for-each-ref(1).

I find the behavior of for-each-ref quite confusing so I wonder if we 
really want to copy it to the new command. For example

     git for-each-ref 'refs/h*'

does not print anything but

     git for-each-ref 'refs/heads/m*'

prints all the branches beginning with m. Another example is

     git for-each-ref 'refs/heads'

prints all the branches but

     git for-each-ref 'refs/heads*'

prints nothing. To me it would be much easier to understand if the 
pattern always required an explicit wildcard (or possible always did a 
prefix match in the absence of a wildcard).

Thanks

Phillip

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: shejialuo <shejialuo@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>   Documentation/git-refs.adoc | 16 ++++++++++++++++
>   builtin/refs.c              | 14 ++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index 4d6dc994f9..ee563aa7e0 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -11,6 +11,13 @@ SYNOPSIS
>   [synopsis]
>   git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
>   git refs verify [--strict] [--verbose]
> +git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
> +	      [(--sort=<key>)...] [--format=<format>]
> +	      [--include-root-refs] [ --stdin | <pattern>... ]
> +	      [--points-at=<object>]
> +	      [--merged[=<object>]] [--no-merged[=<object>]]
> +	      [--contains[=<object>]] [--no-contains[=<object>]]
> +	      [--exclude=<pattern> ...]
>   
>   DESCRIPTION
>   -----------
> @@ -26,6 +33,11 @@ migrate::
>   verify::
>   	Verify reference database consistency.
>   
> +list::
> +	List references in the repository with support for filtering,
> +	formatting, and sorting. This subcommand is an alias for
> +	linkgit:git-for-each-ref[1] and offers identical functionality.
> +
>   OPTIONS
>   -------
>   
> @@ -57,6 +69,10 @@ The following options are specific to 'git refs verify':
>   --verbose::
>   	When verifying the reference database consistency, be chatty.
>   
> +The following options are specific to 'git refs list':
> +
> +include::for-each-ref-options.adoc[]
> +
>   KNOWN LIMITATIONS
>   -----------------
>   
> diff --git a/builtin/refs.c b/builtin/refs.c
> index 998d2a2c1c..848a7c9072 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -6,6 +6,7 @@
>   #include "refs.h"
>   #include "strbuf.h"
>   #include "worktree.h"
> +#include "for-each-ref.h"
>   
>   #define REFS_MIGRATE_USAGE \
>   	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
> @@ -101,6 +102,17 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
>   	return ret;
>   }
>   
> +static int cmd_refs_list(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	static char const * const refs_list_usage[] = {
> +		N_("git refs list " COMMON_USAGE_FOR_EACH_REF),
> +		NULL
> +	};
> +
> +	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
> +}
> +
>   int cmd_refs(int argc,
>   	     const char **argv,
>   	     const char *prefix,
> @@ -109,12 +121,14 @@ int cmd_refs(int argc,
>   	const char * const refs_usage[] = {
>   		REFS_MIGRATE_USAGE,
>   		REFS_VERIFY_USAGE,
> +		"git refs list " COMMON_USAGE_FOR_EACH_REF,
>   		NULL,
>   	};
>   	parse_opt_subcommand_fn *fn = NULL;
>   	struct option opts[] = {
>   		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
>   		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
> +		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
>   		OPT_END(),
>   	};
>   

