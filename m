Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7D2F50A6
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475809; cv=none; b=kqnydCA7HJ+nLz8qXKVVR4H5gUzoejydbjmVtnlLFebxLrZmTMFMVCR0dCRzvh5Sf2bKT7FqzUCH+O9Vnsp0Ddo7Ntwrx3J1OPpf4vpA0iokFdH/HVHwpOM/PooEc+Q0PjxoELbK4NQcr4tJFxM1WEX/4DjKMWAeOg5x7AjUU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475809; c=relaxed/simple;
	bh=b37CgHorxj/l3tO+upOvaF1XI1zWjVvKx4XPYRbilF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gx0wNcgy2A8docvQ+7lWiRS8UmFb4EPAusjHhtpt/kScegz6DVk14QU+jyBppEyqt0skKx6BvSmoa37VbmaMQIqNgp+bODdL5+RX1hL+lLtPyWUUH7KpCG1++ffUflc20UXkdhQH4ofY7QrjJQNrmKzwUsU+y5qGNcnaOCwfjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBc/aiSw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBc/aiSw"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74931666cbcso6991716b3a.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751475807; x=1752080607; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EMcPETypQP4o0yTXwbOpw2ljPKi0r4TPBGMX7hpllo=;
        b=PBc/aiSw1xxlzpSlggvUenVOC6hI0lHPSUHfcpwqQ9fUloDUtkat4FG1KgZFpjRz6v
         eBwvs2dq/7WJ/pBt5UkayKv9+z93k06wChHdrHE+NLHox5ItrsnnI4vA3QZQYgTps7rk
         lpuu/X0bOqoHG+B6Z6rqN3cdsDWjt86RtdXYSmCNhtIR25sUZW7VTu64sEmJ+4NR8Cxz
         015lHN24vMpIwsqPiXdS35yaNGcM8I9iDhSrFYZPwn72yIjn7YYTpS0m+3NiKEOvOUNQ
         O5txbhTc1AZhechafq+QieDoNP/+uS/XFJxkXgV/tLIQMyY0MvE7h+8+WA7u76vwAoMl
         y8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475807; x=1752080607;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0EMcPETypQP4o0yTXwbOpw2ljPKi0r4TPBGMX7hpllo=;
        b=B7H9dez/kRrxpQPOEgvjEcJRnPKoW6TeLj6PexqOGPu4oJ6eD+YN6NPt36fyqJNrCH
         YNebXpC7HrJymQawgscLdCNstlc1lfqwD722JRga01eDcLsKj0kjGIl/qMcLQ0rYW0VX
         WXifrY6IpHPMlxv4m3gs/l/m4JEtuHtI+frN4ylYz+v31eETWoIuKp6bMYGmiXXU6Upr
         PuFvinbvqEQSPkp0Zei1BTrjIAM/FlgtNcXMJr7WdFzEJYAequW5cTtuJSnKjagxOrq3
         wL39cunAdFRkT7+2nbmHgojGS0niXnVQjBzWOvOZbgarUeTo2zUMJ1HI9hcQBIuukIPJ
         VaYA==
X-Gm-Message-State: AOJu0YyJlFOBSacTvfZoE6yRVgn+134nh3B0YXnRnwPWssq90YZvBqtI
	Anro9jYdUegucVEkUegxAK+1T3K4HIh6qaiIooF/fUYB8TIlc2Nr1aR1W+Q9dA==
X-Gm-Gg: ASbGnctnjHvtB9OtgQHs14QekF0iZuDL+32svkmNYfaNMY5H6C2tsBYSMpHTku/mWGw
	RWTM9Ley36v7+xz9cRcapZlDUXVa+k06yGS/+K5GPnDSCiCPqMc7hO1EEovja6ru30Jh4LMzLDy
	FaBca7/Eh7MRmeZidaF7D84BIQdKPGa0+r96jo56fW34Z1qIEyGBSjgYLse6fneXjQ7QeL2SM94
	CRCilDW8d8Gq32C8hXhsnLLFnM/ZThfe1lK067g5ns4L7T4+mdALr639lWLEFale+673au9zTbt
	+3H9e25Aaje3dl7t66iOgGnJQU1zpO7n0up6Ampf7sFoEECBvTK8JNaZYHa+WmF4sLijUt5CouF
	Vbof57kpWuk4H4RNTqCQIIPc0Y+fJXXOVRjyVuA==
X-Google-Smtp-Source: AGHT+IFqtZSNBoyqC/uKfYeGnpemurbD64TnHHECL8m5JYPN2QrS49q21u5Hmdjx+A/oa6W6XGhA0Q==
X-Received: by 2002:a05:6a20:158b:b0:203:ca66:e30 with SMTP id adf61e73a8af0-222d7f2c63fmr6606957637.37.1751475806355;
        Wed, 02 Jul 2025 10:03:26 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af5409895sm14646768b3a.7.2025.07.02.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:03:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Karthik Nayak <karthik.188@gmail.com>,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>,  ryenus@gmail.com
Subject: Re: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
In-Reply-To: <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
	(Patrick Steinhardt's message of "Wed, 02 Jul 2025 12:14:21 +0200")
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
	<20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
Date: Wed, 02 Jul 2025 10:03:25 -0700
Message-ID: <xmqqbjq2ed9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index c6bd94986c5..c96b5319cdd 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -118,6 +118,45 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
>  <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
>  
> +* The default storage format for references in newly created repositories will
> +  be changed from "files" to "reftable". The "reftable" format provides
> +  multiple advantages over the "files" format:
> ++
> +  ** It is impossible to store two references that only differ in casing on
> ...
> +  ** Writing many references at once is slow with the "files" backend because
> +     every reference is created as a separate file. The "reftable" backend
> +     significantly outperforms the "files" backend by multiple orders of
> +     magnitude.

These list benefits of using "reftable".  Can we also add one point
that stresses why we want to make it the default?  Something like
"Having to do X once per user to make them opt-in is too cumbersome"
is probably good enough.

> +A prerequisite for this change is that the ecosystem is ready to support the
> +"reftable" format. Most importantly, alternative implementations of Git like
> +JGit, libgit2 and Gitoxide need to support it.

... in order for them to access the same repository.

How common is it to use a single repository from these multiple
implementations these days, I have to wonder?

> diff --git a/setup.c b/setup.c
> index f93bd6a24a5..3ab0f11fbfd 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2541,6 +2541,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  			repo_fmt->ref_storage_format = ref_format;
>  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
>  		repo_fmt->ref_storage_format = cfg.ref_format;
> +	} else {
> +#ifdef WITH_BREAKING_CHANGES
> +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_REFTABLE;
> +#else
> +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_FILES;
> +#endif
>  	}
>  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
>  }

That's obvious one.  I think the approach taken by brian's SHA-256
topic would have introduced REF_STORAGE_FORMAT_DEFAULT and did the
build-time switching between the two in a single conditional
definition

        #ifndef WITH_BREAKING_CHANGES /* 3.0 */
        # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
        #else
        # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
        #endif

somewhere in a header file.  Either way would work, but I wonder if
these breaking-changes definitions are collected together into a
single header file (say <bc.h>), it may make the transition at 3.0
version boundary simpler and less error-prone.  We can just discard
selected conditionals into unconditional definition more easily.
For example if we moved the default flip between SHA-1 and SHA-256,
i.e.

	#ifndef WITH_BREAKING_CHANGES /* 3.0 */
	# define GIT_HASH_DEFAULT GIT_HASH_SHA1
	#else
	# define GIT_HASH_DEFAULT GIT_HASH_SHA256
	#endif

out of hash.h and have it next to the above REF_STORAGE_FORMAT_DEFAULT
definition, and then in a subsystem specific header file, after
including <bc.h>, can say

	=== In hash.h ===
	#include <bc.h>
	#ifndef GIT_HASH_DEFAULT
	# define GIT_HASH_DEFAULT GIT_HASH_SHA256
	#endif

	=== In refs.h ===
	#include <bc.h>
	#ifndef REF_STORAGE_FORMAT_DEFAULT
        # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
	#endif

If some reason making reftable backend the default when unspecified
turns out to be a bit premature at 3.0 boundary while the world is
ready for SHA-256 by default for new repositories, then we can tweak
that single header file like so:

        -#ifndef WITH_BREAKING_CHANGES /* 3.0 */
        +#ifndef WITH_BREAKING_CHANGES /* 4.0? */
         # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
         #else
         # define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
         #endif

	-#ifndef WITH_BREAKING_CHANGES
	-# define GIT_HASH_DEFAULT GIT_HASH_SHA1
	-#else
	-# define GIT_HASH_DEFAULT GIT_HASH_SHA256
	-#endif

and optionally change the "if default is not set, use 256" in <hash.h>
to "unconditionally use 256 as the default", but forgetting to do so
would not break anything, which makes the process less error prone.

By doing something like this, we'll have a single place <bc.h> to
see what are being planned, and we can "git log that-header-file" to
see how our thinking has evolved over time.  Hopefully we do not
have to keep too many entries in that file and can retire the
conditionals as we plan ahead.

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f11a40811f2..e0f27484192 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -658,6 +658,22 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'default ref format' '
> +	test_when_finished "rm -rf refformat" &&
> +	(
> +		sane_unset GIT_DEFAULT_REF_FORMAT &&
> +		git init refformat
> +	) &&
> +	if test_have_prereq WITH_BREAKING_CHANGES
> +	then
> +		echo reftable >expect
> +	else
> +		echo files >expect
> +	fi &&
> +	git -C refformat rev-parse --show-ref-format >actual &&
> +	test_cmp expect actual
> +'

Obvious ;-)

Thanks.
