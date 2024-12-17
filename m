Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7191F37DE
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438626; cv=none; b=SEOKV5IvLXzZjl2loCb2jnEHHSpZI+DLPm3bTmsJo3/Nc36+EUCKEv50p+0OKjk6IHkrMnSXeAmp+06EMkvJJCV1iVqonOJadvjc1gbIeZtmk+OSc3wG/CfREpAIVCJDdQ3Gt9TmUsOEL026R9LT3dxnnoC+/Zg2FjEWHJzI4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438626; c=relaxed/simple;
	bh=rK83Mdu0rcPw9j1KTzXFbLDnEfGXB9OXQ386VZgFLvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+FQ9j7tu70fEFMuZgDk9nlY5IKDNmRHoo839lDggObUoo3KD5Djn4LTRsiowoHUVW/Rp3QkFGzN795EPDG1Rs63BCyvaxMgQOcLfiHUEpUl1u87KQ4Dh74u/Ekcf3hZN8hGf83sFxYBTVYjy4cw7BRmN7lZbr0s4hdTv/tR0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dASC/Fnu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dASC/Fnu"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso3969521b3a.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 04:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734438624; x=1735043424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQCjyWkSP254k1ZfHEm1o3oSqdTuhWgN0DOJN31lqHo=;
        b=dASC/FnufekppvORDa248qW6GDxwgSI6/qqrx5lmt57m50ocd0D+hmLxg4j2e5sDRQ
         b/yWDA83Crw4frJ2pDB+ZIwzGsLjapx5QViSkRbi7h3aeFeZ8+gbMwnwWLPp86/BGoHj
         JxQ6mAH6gR2lKzyZWNY7k6zRjZKBKyOChXAfGnnchG3QDNUgqfmmHRY6TObg4BqUX1OK
         4TEFNeHVcsXSjiDdSfOb7u3v19G6qed9fDUkzeTqHXs+l9ue5JAr7qKUxfLINI/T/8mh
         ZA/ae8AfLhXjFAIEV86q/3Y2uDojCbe4nGN+8Dx7MB7CKeGrZzLLWBmUYgdQ9p8fqqQ4
         /gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438624; x=1735043424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQCjyWkSP254k1ZfHEm1o3oSqdTuhWgN0DOJN31lqHo=;
        b=jteyYZEHrwaOwMKaYh5Lo7GnRmJPf/qgeGf5Tnycq0RM0Xi+xr4WMjoRZn/DI4GelX
         hOfADJJMvps45DXC2ytE8dCavnVRtAdurXS2NnmL+N126iFSAg0VdMlUO2MvD9lkW5vD
         P5Glqzomj0lx495rLpQvMJhb7t606pzdQJM/4Ft+qxWFctDtlD7xZDHhtTJ7Top4/+bG
         K92B1mRJl/XgRVCkqz2lWtIB7xcMjydAvu8390CJxPKGX6h6MIWGL1q6uSJ+BJvELSiy
         vy9cLu8X55sM3p+o8ICrP6QSEGhvMwGWicNaP++feYbu6hN6Gi7mRo9wkdenGQn2c/6v
         klKA==
X-Gm-Message-State: AOJu0Yx44W3YQM7T0Qks5FEY+g0NgmVUpkkgVv1cE/+o2zeVBhVZaEBo
	/L488m0ZG4lpmYnLY+wQKHnRSrkIPYZ+nkGRnDUk9M3dW8GfmBUqZSQfww==
X-Gm-Gg: ASbGnctciGZQSj9NjFpUuMP/fzb4X49Wl6tRVATDJ3Ozw0kQwl3GrU9W9RP6M31tYGh
	uEO4j60oSxbvQWRhF4JQpfnXNcSOrcUxHpCgfal6Q/fjLqsFAw1QHPkfTm6ypbtjz8F0qSsLkY0
	+ZDjK2mOXdCGXctt5VRf4AYp1IUiiNjSPrvqdNUP1HONQGcT+RX7iX7qYX8j4MePWmOfmqTlgTF
	DVzdf031PYMoti3zn8aKp+ubAKXwZ/yhuhro/BX6Qin3qsyAANd
X-Google-Smtp-Source: AGHT+IE6hG2OQkOf7vyeSPg+oxVMEioMhMCipG8JehGpeucKZp8RiChcG9sqwojYqZWOKkqdWZrVtQ==
X-Received: by 2002:a05:6a00:1ad0:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-7290c273be8mr24065903b3a.24.1734438624394;
        Tue, 17 Dec 2024 04:30:24 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f93sm6502292b3a.119.2024.12.17.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:30:23 -0800 (PST)
Date: Tue, 17 Dec 2024 20:31:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/14] server-info: stop using `the_repository`
Message-ID: <Z2FvCKYdRLZzHJVC@ArchLinux>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <20241217-pks-use-the-repository-conversion-v1-6-0dba48bcc239@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-6-0dba48bcc239@pks.im>

On Tue, Dec 17, 2024 at 07:43:53AM +0100, Patrick Steinhardt wrote:
> Stop using `the_repository` in the "server-info" subsystem by passing in
> a repository when updating server info and storing the repository in the
> `update_info_ctx` structure to make it accessible to other functions.
> 
> Adjust callers accordingly by using `the_repository`. While there may be
> some callers that have a repository available in their context, this
> trivial conversion allows for easier verification and bubbles up the use
> of `the_repository` by one level.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/receive-pack.c       |  2 +-
>  builtin/repack.c             |  2 +-
>  builtin/update-server-info.c |  2 +-
>  server-info.c                | 40 ++++++++++++++++++++++------------------
>  server-info.h                |  4 +++-
>  5 files changed, 28 insertions(+), 22 deletions(-)
> 

> -int update_server_info(int force)
> +int update_server_info(struct repository *r, int force)
>  {
>  	/* We would add more dumb-server support files later,
>  	 * including index of available pack files and their
>  	 * intended audiences.
>  	 */
>  	int errs = 0;
> +	char *path;
>  
> -	errs = errs | update_info_refs(force);
> -	errs = errs | update_info_packs(force);
> +	errs = errs | update_info_refs(r, force);
> +	errs = errs | update_info_packs(r, force);
>  
>  	/* remove leftover rev-cache file if there is any */
> -	unlink_or_warn(git_path("info/rev-cache"));
> +	path = repo_git_path(r, "info/rev-cache");
> +	unlink_or_warn(path);
> +	free(path);
>  

The original "git_path" will be returned from the static string buffers,
so there is no need to free. But "repo_git_path" will return a allocated
string, the caller need to explicit free this. Make sense.

>  	return errs;
>  }
