Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C34A3E
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 04:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735963889; cv=none; b=L84uraNBnJIoGmz2OZGGH4CJXltDuOkKnuO1vqPhqCGvbzEgEfR/6qWPlNab/3Qc4JQs7XOJ2dbsSH9tAwhyZ+G4h7VvUMvbqFTDogH3hgkL+Om+4rIThoxF1BKAM9mpqmcAcwrEBeR0V/YT9Z1dz/ggsujXBQCm7r8AEZvFbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735963889; c=relaxed/simple;
	bh=T3Fvkr5iO6Rt21v4ZrZlCHiqL34HXXaVYYYYzzaqO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZtsF8BisIWkS3g8ZED6KI5g73qfuMIeP56f+Jtd9vNxiTP3V6dek+mkTiLtmVsLufSGLxdJ/vQyNeMx5nYejpZssGUzLFL23ZWt8G04HRnfZOvzf352K3hmIvq9TupkEshuVZpcB7mnrrrJVPC5pXUB/zOHyQoexiq+cf+Sr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxyCTQtc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxyCTQtc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so16185967a91.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 20:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735963887; x=1736568687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZESseVPpcOHGzKjCgF4eN49gKnAcpTOtYqiuPK+Jts=;
        b=DxyCTQtcbRY0t91mydkQkkiNBH2+T7ZgMp7eze72QWHpPtAQLLrSeROGm7hzVYpT6G
         FAUhDIfCUHazd5m/i/Zo7fqwKUA7zSb9MjM5xN9uAbLdXvm7oPAI5BaVMtpDLFXYpf6R
         33uPBioDcMlsxWmZ5ASI4TVTJ1fjl5aD2eByPcLucBVPg8f4DAmGJOSz2EGbUO7YZIa8
         /XBzN8X97yL6YmfwzKvASY/WWZj5KTZ+ghPZSXq9IL2MgAvprhOHlElFFfA5Db6RpdzR
         OnUUpoLfY0HvjTm54utBOWxTOxYSJiLXDIG6deIyVGmKMokt6GZ1Hh32r7hxK5JwKlW4
         634w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735963887; x=1736568687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZESseVPpcOHGzKjCgF4eN49gKnAcpTOtYqiuPK+Jts=;
        b=guAQGBrtVpP3n+JfGmqYx/KkuxKEEu8yUSnuayIrn6iaeZMlF5oukbBM0dHkrwaeZV
         TBJMHWfSPgEkk/Vpf2eFzbfGkVjMDr4FeDLLbd9BBItornNq4gpNw+Hnv5LwTlpYRGUA
         nIepXwk0C/d01vimy9s/Csi8V1ekZneaB0rPD9BDZxxeShz6Cs2sZEhnH5lz3rQ3MiCF
         5gTGst7FBMB9/6fQvIAO4NDooVeXefnDxeBV6ZYZQjvk2GuCmZYdvpqOcMo7cjmpJonp
         39u9JUUL+yeYwrb0fDxlESuMuZRafBwMMsQswXRaxDwwPHi5yP+Y1kqCcWQtCF6pijj9
         IWfg==
X-Gm-Message-State: AOJu0YxTGHR+u90kz8cuGGDASphp0rlfGF2OmX9GztCEUimLqfUzt0zY
	VTodudwh36o1XgNIAHhfFDB7gtr1hpNp94Yd73puvRv+ouVQuQ+b1MdkKg99
X-Gm-Gg: ASbGncuSO+6TarP+Fr2BDLKiWlTHKIOBQo68VdvAG0dLONyvJqYWT9ACgBrSpODdpvj
	OvwF8SarHgFy7pSiZY3yRFIMurWl9/55AfMniVUn4suu4wZItkLFJ313VtQQR6un1HU2WQw5AgU
	RC10BBkZLonsaRES9UtOsasrtv3n+ZMyRvRud5FwenzAq69OQ0/kl5saUCAoTwBJUH7oGJbgCql
	49jMrTBL6XTbm+yzsDSeDvGmHphabvw6rc=
X-Google-Smtp-Source: AGHT+IEAxOHPGev/VT9mOlLuCwnRv0ebGxLjc3vILoRdWknk9Zr7HyLFJpp4zXWS8IUYVdirSXEizA==
X-Received: by 2002:a17:90b:5208:b0:2ee:7e53:bfae with SMTP id 98e67ed59e1d1-2f4536531cfmr70824374a91.10.1735963886940;
        Fri, 03 Jan 2025 20:11:26 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478828besm29113589a91.34.2025.01.03.20.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 20:11:26 -0800 (PST)
Date: Sat, 4 Jan 2025 12:12:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #01; Fri, 3)
Message-ID: <Z3i1Kgf9M_AiBMBr@ArchLinux>
References: <xmqqjzbbpp6f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzbbpp6f.fsf@gitster.g>

On Fri, Jan 03, 2025 at 01:23:20PM -0800, Junio C Hamano wrote:
> [New Topics]
> 
> * ja/doc-commit-markup-updates (2025-01-03) 3 commits
>  - doc: git-commit: migrate secondary files to new format
>  - doc: git-commit.txt: convert git commit config to new format
>  - doc: git-commit: apply new documentation guidelines
> 
>  Doc updates.
> 
>  source: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
> 
> 
> * jc/doc-opt-tilde-expand (2025-01-03) 1 commit
>   (merged to 'next' on 2025-01-03 at b3e6e7acbc)
>  + gitcli.txt: typeset pathnames as monospace
> 
>  Docfix.
> 
>  Will merge to 'next' and then to 'master'.
>  source: <6e0abe96b60a94d4fdee15a45b7d53c2f44a0c69.1735903029.git.martin.agren@gmail.com>
> 
> 
> * mh/doc-windows-home-env (2025-01-03) 1 commit
>   (merged to 'next' on 2025-01-03 at 1d4db69ce0)
>  + git.txt: fix heading line of tildes
> 
>  Docfix.
> 
>  Will merge to 'next' and then to 'master'.
>  source: <50e47d14a8a0a2ca0dd158f01b833a28c7b46887.1735903029.git.martin.agren@gmail.com>
> 
> 
> * ps/ci-misc-updates (2025-01-03) 10 commits
>  - ci: remove stale code for Azure Pipelines
>  - ci: use latest Ubuntu release
>  - ci: stop special-casing for Ubuntu 16.04
>  - gitlab-ci: add linux32 job testing against i386
>  - gitlab-ci: remove the "linux-old" job
>  - github: simplify computation of the job's distro
>  - github: convert all Linux jobs to be containerized
>  - github: adapt containerized jobs to be rootless
>  - t7422: fix flaky test caused by buffered stdout
>  - t0060: fix EBUSY in MinGW when setting up runtime prefix
> 
>  CI updates (containerization, dropping stale ones, etc.).
> 
>  source: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
> 

I have sent a patch in the previous day in

  <Z26uXy31q83dyxvD@ArchLinux>

However, there is no need to cook this patch because I have decided to
send it with the packed-refs consistency check implementation. I think I
could send the patch in this week.

So, nothing need to be done.

Thanks,
Jialuo
