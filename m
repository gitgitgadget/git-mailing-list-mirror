Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927921ADA4
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802320; cv=none; b=T3XNXYnfkUSzuqN12P2h8LjKlojDmdfOk0IETOuSBOnRnLbaxsXH2RzcU1N4MDABmbjjY7ALz/Qzgj/6VjuXAtKObFu2ie3O7BKkd70EiYzYAnUgNrx8uh0nr+VmIS/ipawKVxo7ZT5RiVSvZCka7tNucfoGcWlQkA5X4DQxhKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802320; c=relaxed/simple;
	bh=cbLDSY5yYMewKk/CRNTjtFudFgf7vugra+s1+Ca/GuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cxo1v+iDO0KAocj4YtUPWQQGOs5GEF/3mVdOXF8oy39/DDFCeBwlH32vfLayidDQdbv9gozDlvJqQCct2SM5L51zREd9F4sVcS3LSj6n3ixEhd9BpJq74HXq2bDctL9UL3LxcPd/0LrjOCJrGsCN19pOVf+iZs+EpI0XlL6zpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxGHNrvV; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxGHNrvV"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43622089851so1652445f8f.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 01:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770802317; x=1771407117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m6sMBMntdIJtTMJH1Dgs+f9j0vFoMCy7gtAVxHTJClM=;
        b=mxGHNrvVkWcMJVFJhqfboj5QElvr6h5dFsFbADExHP3794SWCNRmJFj6K6Jm1IZ+iK
         iJDbfeO2kNETIluxGaW/11dOLamlMpCdoVjYUDIEM8FGqlSZZs3/7MUTe5gfHK/SoLxk
         qFIMu/Gr4yVrMtAU4dDLY1yTmFhOZTVX2T+5Nee1kGRsFBOyoGQGnoFlZJEnDFFTfMoj
         qZFDdHOgPlvbatQVzt7g7t4ccZgcdODDSxVmuIhVcOxIEKcK8cFzli0NVn2HLfa/kWR7
         GdQJ00vt7KqidA9F6Mri+HF3+b4IUpQ0D+SohJ//d1NHStfAIbTt1qJg+zvIpneO41De
         RafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802317; x=1771407117;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6sMBMntdIJtTMJH1Dgs+f9j0vFoMCy7gtAVxHTJClM=;
        b=rKma+StaXVcsRcJaCF7ySRq5iFs2ChxQetKSF+J+5tqaqnmNVLiZCOWHDg341FaxYC
         YdDV+Tw9t+K1v2U9W3FDuo9sRP8GHOEAIM9YmTxLIddU9Fh2akzfCfFAUx4NW84VbIcK
         PcSLOvIqU/HcBmqdnk/orZDdVzXMPQVYDWcbMLt/Nyu9MIKKf8GzTpMRz2D8nNig8uTh
         Ww+trXRGB+CR2Af05fFLVOtA9fru5dFW31MJu4m/p3dq1ezEMDV/+ahsWWEbg15IOZ71
         ckC3C/C93CVAo7II+NUb3FdbuD1hskiLKl3qDstZluYNSwIJOVpdc+Q0N1hqjg9v4s/C
         oPnw==
X-Forwarded-Encrypted: i=1; AJvYcCX1nrApTnQd9YclYTQgp3hcvqT4Z1tKZN/ZyUPXlLuPK86fkW5cBkrlPpWaLdrbhU5HpkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUyXVSbXlAMsz2lNVD8HgmXBXgFDNAtW6LPHvwuUj8CEsL7DG
	XqGqjJgTKRNL/HsB7BII6BjtU1eelYDIwEq1G3D0YtCzpPJ5aCW/o/jb
X-Gm-Gg: AZuq6aLGVzLZdKZQjo/INN3a8ztSWhCd6HWlHvXEuc5GLQqkwJCnZ5He6ahZeJcYWQK
	hrFJ2MWukNzTXnLktDG0ATVFBZVJE8JMNK4qUt6J9Ot6j6wK4x3hxm7qQZBBmnWF7+mGh6YrpbF
	RXpOHnSJA4y2fSyD/Mh4lbLpKqPMxKQIB9pfRMEOsjxYsrHL3/WluKcAC71urVnqpoOjTr2zdSd
	yqPHgWZS+kZIEmRy3BeK31ya8GX9aPQcuPaNCR9Dd0j/T5TPxTqwpBVgZexKtsWfKjTEvQuEwGW
	cfH0jFd7O7Dn3Py5E8RS7TRk5QqASwyJ0o9HG9/oacTo520QOkhFLbf261yDVnxKBZx/wOb4w+v
	B5FcOcWeDmrJ7p+cdqsIfvcogEogQLdd/rQtWtTJ3iV5CuLO/nYcQZGq+bdB4kUt2WuHJj1bEyn
	06gDfTCUip1QAoRrF2QN/UYvPBEwC/w+syRcCMVtC6oeLHdRtjBnq7/kO+HFQWmWcuLJ7LIdSpy
	HqRPg==
X-Received: by 2002:a05:6000:3104:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4362938b45dmr29385828f8f.52.1770802316910;
        Wed, 11 Feb 2026 01:31:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d58b4fsm3255953f8f.15.2026.02.11.01.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:31:56 -0800 (PST)
Message-ID: <37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com>
Date: Wed, 11 Feb 2026 09:31:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: Bello Caleb Olamide <belkid98@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com,
 christian.couder@gmail.com, usmanakinyemi202@gmail.com,
 kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com,
 phillip.wood@dunelm.org.uk
References: <aYsEpvFwCSHb5DYO@ubuntu>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aYsEpvFwCSHb5DYO@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the backtrace which helped me spot the problem though I 
should have spotted this yesterday. The problem is in 
initialize_repository()

>   void initialize_repository(struct repository *repo)
>   {
> +	if (repo->initialized)
> +		BUG("repository initialized already");
> +	repo->initialized = true;
> +
>   	repo->remote_state = remote_state_new();
>   	repo->parsed_objects = parsed_object_pool_new(repo);
>   	ALLOC_ARRAY(repo->index, 1);
>   	index_state_init(repo->index, repo);
>   	repo->check_deprecated_config = true;
> +	repo_config_values_init(repo_config_values(repo));

Here you need to use repo->config_values_private_ instead of using the 
accessor as it is fine to initialize the config values to their defaults 
in any instance, it is only when we read them that we want to assert 
that we're reading from "the_repository".

Thanks

Phillip

>   
>   	/*
>   	 * When a command runs inside a repository, it learns what
> 
> Some of the tests that fail are related to the submodule and a
> couple output is shown below
> 
> ./t7412-submodule-absorbgitdirs.sh  -i -v
> ...
> Initialized empty Git repository in /home/ubuntu/Code/open_source/git/t/trash directory.t7412-submodule-absorbgitdirs/sub1/.git/
> [master (root-commit) 50e526b] first
>   Author: A U Thor <author@example.com>
>   1 file changed, 1 insertion(+)
>   create mode 100644 first.t
> BUG: repository.c:56: trying to read config from wrong repository instance
> Aborted (core dumped)
> not ok 1 - setup a real submodule
> #
> # cwd="$(pwd)" &&
> # git init sub1 &&
> # test_commit -C sub1 first &&
> # git submodule add ./sub1 &&
> # test_tick &&
> # git commit -m superproject
> #
> 1..1
> 
> ./t4027-diff-submodule.sh  -i -v
> ...
> Initialized empty Git repository in /home/ubuntu/Code/open_source/git/t/trash directory.t4027-diff-submodule/sub/.git/
> [master (root-commit) 4431e0b] submodule
>   Author: A U Thor <author@example.com>
>   1 file changed, 1 insertion(+)
>   create mode 100644 world
> BUG: repository.c:56: trying to read config from wrong repository instance
> Aborted (core dumped)
> not ok 1 - setup
> #
> # test_tick &&
> # test_create_repo sub &&
> # (
> # cd sub &&
> # echo hello >world &&
> # git add world &&
> # git commit -m submodule
> # ) &&
> #
> # test_tick &&
> # echo frotz >nitfol &&
> # git add nitfol sub &&
> # git commit -m superproject &&
> #
> # (
> # cd sub &&
> # echo goodbye >world &&
> # git add world &&
> # git commit -m "submodule #2"
> # ) &&
> #
> # git -C sub rev-list HEAD >revs &&
> # set x $(cat revs) &&
> # echo ":160000 160000 $3 $ZERO_OID M sub" >expect &&
> # subtip=$3 subprev=$2
> #
> 1..1
> 
> Thanks
> 

