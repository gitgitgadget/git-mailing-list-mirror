Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE36ED9
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464350; cv=none; b=QWwZ5F3kZsiIXFV7kXRO9z3hYzplqzGkX963XvW5go5SUHZ+WJG13ZVQHn8O6qqN0qVdgSH+qaiC2+O3pz11jyqhS60Qg0mKxt0hg2Azae5EvhS3RLKl7+AMIQ5rNnzW1vF8gH/XP+lun1199qJW9ZceHnOHc5ZoU3qzmL4Ays0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464350; c=relaxed/simple;
	bh=WLFPIrDhGPLV0Q1TnJ+rKohPh0oPSXuOdwEsUqJWCL8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=df7WLjIljJ7OJWpQkzvtPQiErOWWa1SyAT/cz4c1mC++G286tjL8l8kKTKsrs7oTDY5iM11zg2D8qN+F4vJiKmqUdMU5EZbtKXE1SND4NX++89JVtJ69eCrSuAVE2wdeufFf1izJf+eOWPLiKBJUnamHZLOMF+hJQLOq54Ivvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWGf7D7w; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWGf7D7w"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso42425911fa.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464346; x=1712069146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ut6edjW/eJEhBHgr1bTFkiizGRMKocPyMcchlzUuY=;
        b=FWGf7D7wT8HUFOl4oFpXamM0e39qbUJ+IhzHgbRlPFcs89JRHc6p3nL0R10TSL6SlR
         ku0FlYPQi8UtctJysY614S3O8/mtuYFgZBnQUoOH3sj2AHmIuTio5HDDyH5SxXgJp1K6
         nMwBItugruc4WtB5G5I21JA1UzDsiHwjeYN5QgUFOtEGS2cfaTzo07XB2ynOGDyyejYk
         NQ2Oz+OX9/31v752JRjsvUdvKsjeZUzvp7CfcjasWwLsVHa7mku6RM0UVyoQ43R3rW+/
         zDbFHxqB2E7EzvSyjIKPF0Jtkv4R0ltm++UYF6N2fwaIowei4aEU2PZ/cRr3Ix2jyhET
         WFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464346; x=1712069146;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4ut6edjW/eJEhBHgr1bTFkiizGRMKocPyMcchlzUuY=;
        b=M43fovpNfO+ZV2g0LtO+X7HlxTa2896kWnwyWQLQOu50cpd4PJRxmA9y4yGoESZ3vk
         jgq1uq5RQb3oh8dOuxeLtgdVdlOlQRbUrbLyX1loQIiJ3JXJdftacnYrlPUYqKu6PRGq
         /wSLWhYAbyLpFLKNe61NaeRruoc1cHvBgZBWr6PXH+8wSo6cYuBiyeNbEIvNtlS/qgs0
         T8dliuYL1GGG2kEZ7G+kK+Y/xmfYAmaUOseeZzkVHVv2Lvm269Y0LZ0oruAxr0nQaKA1
         na7iIPGAhk8vl5fkH7FdJylI3h00FPUhC+cgTjgQXKASgNO2C3T/eJWZJeUX4ZsTcBW2
         UanQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwoCJDun2DU+CIMo5XsBljLEEFSJBf0TcTXJC6dS1iOb53sBmsSfPt9+GPvDTNA4ylR7KFasVwsPSNOehG/IrEfh4f
X-Gm-Message-State: AOJu0YxD/TtkIhHagGKy4fUh7s/VDuBRvc5l6pNRyDQgVheIfs+q+7uS
	JCjIX/p4kTR3qJtB2cfTMlS2HeVxLVgH1MaXknLuH7uZQ8aQZbYs
X-Google-Smtp-Source: AGHT+IHB3K7Shf8pNa0nqgByF/caCMiAXb22XHmwBDfs5EdAtgs2wDBsz0N0yPP2XdVDPuWxmxPDAg==
X-Received: by 2002:a05:651c:2123:b0:2d6:dbc3:3d57 with SMTP id a35-20020a05651c212300b002d6dbc33d57mr1203247ljq.27.1711464346004;
        Tue, 26 Mar 2024 07:45:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id o22-20020aa7dd56000000b0056c07b6924csm3160361edw.41.2024.03.26.07.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:45:45 -0700 (PDT)
Message-ID: <a397f3dd-e4e1-4275-b17d-1daca9e166fe@gmail.com>
Date: Tue, 26 Mar 2024 14:45:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240325232451.963946-1-brianmlyles@gmail.com>
In-Reply-To: <20240325232451.963946-1-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 25/03/2024 23:16, Brian Lyles wrote:
> This is the final planned re-roll of this series, addressing two minor
> style concerns with commit 4/7 as noted in this [2] thread. All other
> commits are left unchanged.
> 
> [2]: https://lore.kernel.org/git/xmqqa5mmhvx5.fsf@gitster.g
> 
> Range-diff from v4:
> 
> 1:  f6b8a655cd = 1:  f6b8a655cd docs: address inaccurate `--empty` default with `--exec`
> 2:  401de76c0b = 2:  401de76c0b docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
> 3:  031b3bb7bb = 3:  031b3bb7bb rebase: update `--empty=ask` to `--empty=stop`
> 4:  fd53c39482 ! 4:  d3bfe41819 sequencer: handle unborn branch with `--allow-empty`
>      @@ sequencer.c: static struct object_id *get_cache_tree_oid(struct index_state *ist
>        	struct commit *head_commit;
>        	struct index_state *istate = r->index;
>       +	const char *head_name;
>      -
>      --	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
>      --		return error(_("could not resolve HEAD commit"));
>      ++
>       +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
>      -+		/*
>      -+		 * Check to see if this is an unborn branch
>      -+		 */
>      -+		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
>      -+		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))
>      ++		/* Check to see if this is an unborn branch */
>      ++		head_name = resolve_ref_unsafe("HEAD",
>      ++			RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>      ++			&head_oid, NULL);
>      ++		if (!head_name ||
>      ++			!starts_with(head_name, "refs/heads/") ||
>      ++			!is_null_oid(&head_oid))
>       +			return error(_("could not resolve HEAD commit"));
>       +		head_tree_oid = the_hash_algo->empty_tree;
>       +	} else {
>       +		head_commit = lookup_commit(r, &head_oid);

This version is definitely more readable, thanks

>      +-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
>      +-		return error(_("could not resolve HEAD commit"));
>      +-
>       -	head_commit = lookup_commit(r, &head_oid);
>       +		/*
>       +		 * If head_commit is NULL, check_commit, called from

This looks strange, but if I do a range-diff locally from v4 to v5 I 
only see the line wrapping changes above so I don't think it is anything 
to worry about.

Thanks for working on this

Phillip

> 5:  90dca45c12 = 5:  5e690bca6e sequencer: do not require `allow_empty` for redundant commit options
> 6:  ab3b6afc97 = 6:  ed03908e9e cherry-pick: enforce `--keep-redundant-commits` incompatibility
> 7:  0e2577ea56 = 7:  d3cf068c45 cherry-pick: add `--empty` for more robust redundant commit handling
> 
> 
> Brian Lyles (7):
>    docs: address inaccurate `--empty` default with `--exec`
>    docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
>    rebase: update `--empty=ask` to `--empty=stop`
>    sequencer: handle unborn branch with `--allow-empty`
>    sequencer: do not require `allow_empty` for redundant commit options
>    cherry-pick: enforce `--keep-redundant-commits` incompatibility
>    cherry-pick: add `--empty` for more robust redundant commit handling
> 
>   Documentation/git-am.txt          | 20 ++++++---
>   Documentation/git-cherry-pick.txt | 30 ++++++++++---
>   Documentation/git-rebase.txt      | 26 +++++++----
>   builtin/rebase.c                  | 16 ++++---
>   builtin/revert.c                  | 38 +++++++++++++++-
>   sequencer.c                       | 72 ++++++++++++++++++-------------
>   t/t3424-rebase-empty.sh           | 55 +++++++++++++++++++++--
>   t/t3501-revert-cherry-pick.sh     | 14 ++++--
>   t/t3505-cherry-pick-empty.sh      | 51 +++++++++++++++++++++-
>   t/t3510-cherry-pick-sequence.sh   | 32 ++++++++++++++
>   10 files changed, 286 insertions(+), 68 deletions(-)
> 
