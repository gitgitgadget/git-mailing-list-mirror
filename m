Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD926E701
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612776; cv=none; b=Jtfi5GJdF+mi4kp/udo000XEvy4v16mx70UjX5MaYv1a2Mnx6bifJSPkyVXZHelYIKz1rtrl2PBirVRHCUiA4TJvzqOv2i/Pfi0sGfXAE9qHJh4VBMrln7C3cESmaYlwvErIlHVQPg4rS5WSlbMkuEVCRktkQZdvRQJy3PdMzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612776; c=relaxed/simple;
	bh=I0XKbj90Oplsdp4matqYQFcG6zgrGGIpwryBaUzR1hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nECrlyfsIvnIegt/2zGjz+dlgnAAN/TKBEIxoMr68+jCnwbg2ioaoUkUNfyRYI9XYaOY0iioq91Udq4vAhpctlFoWX2NcLr+5Vm++Xj5n2ZCTDh5Ase0SP5tsl1AKgDpMwp4G1B14VqTfilpyMrJ2SSKz/4g5G4mTmfxxj4KUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6CczbOi; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6CczbOi"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-41b7d12401bso827459b6e.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752612773; x=1753217573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJFdmtkG16TsLYrTMRMSXLwtkVE4jsQs19Gee8tRWxc=;
        b=c6CczbOivZv/obAGb3EvVGxxpUnF5AYQQWLKeENorFeTL+q4CINYPHymAIC56f7nYY
         wpsZ7Po+YUz94JMyeF++ju4hvA7luVidKGgVzKKLZKBL8FjyPLlFhvmqmoGw/CaZlwu/
         HFSxlX1e2Eq57Rx0NSRpkE8+qHlbXVYHLVb/NMTGjS+pQ6LhwsCpcrO8AYE+ELOcqSzK
         zTIcKOeGSS04WALJGqjNZyPk+UhQeKuUs1ljMgGM1Wz0EM/1P+Pmx0jaXaPEmer3v3wc
         pRy3uAsf4n8SmMM3h7irxak2Pf27jrIn8cCT1MH+CWt9W/4xE9ChXOdISDDce/SfaueG
         ouEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612773; x=1753217573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJFdmtkG16TsLYrTMRMSXLwtkVE4jsQs19Gee8tRWxc=;
        b=rBzW1JqyBK5iQg1L1zMevqIttoXfTBXpHLNDFJYGbMDo006H/N8YuKXEks/aMjbAtD
         7Di5T50+iiRZf6ZXFqmMUiTvXH+mTATRmze+ppkA4u9oP8Zj3ejNuNNY0deLpMbtZ8KS
         F1xJvjK1l+13jWafqKBxwix6wQWuHfHGVuFzWSPfRTMXr/m7qtjXGDTGGZiDuGjYbC+s
         jw6jAZjZdjz3OfLT2sIu+nyCFOEP3qbshuMez4lMRYuRW1nuqg/O2tNHMIopT5zk5wRT
         BnaI3I1Q7Dmpq6+FWF25IOzr4ntId9CVG9BOBOPFC2QaqvxUn+b92dZTaEgNpYYpf+lf
         mAqw==
X-Gm-Message-State: AOJu0YzkhS4rFnqeHK8HLjCkuZ39y/rxquTpilRfgC8ixbkpd4pereO8
	PKKftwu5Z7hEkqxywF75dVBflBXXFTdjyaa1lT1aiCDHbihBn9NIfF8f
X-Gm-Gg: ASbGncupkjMIRRbLXwiU2f/ByEsLw5FSFIXqhGvyH9MxNDBxQqRy2bNFmSxliywJJ/I
	IBzJwgpmxo90/ehTBBajkJOO+6GF2YQzwddqojpop3AELDM4Fnt8srm1E8eUW0H5blYMBBpktfo
	3C5zVXJrVfEEoEdhXnFZUtrxBD2ICWkgONbs5DRxkkXpTvgv6CBm927gU6gGJ8MDe8fXju4S4IU
	IUDMIBm1+QMYmuDXtzCnXuubevDqSYugNMYVTNj54lEVza8cJuzDFNfOvMvGsx9EolK3gEK6ihv
	aU0bXFxVfA8SQFslaJnnh1A0NRsj8HHffregSb1UJ+ESW5OTMaKuq/6RxRyOhlQMlKi+UmWgoZF
	RZbEDCDskikzNweA=
X-Google-Smtp-Source: AGHT+IEuu5xEPjp6QQuxvg50d2h3OynYfdYMr61z2jF4+5jg07hJ6chTKLNEKS/swYYHOF7O+Vhh+Q==
X-Received: by 2002:a05:6808:16a0:b0:403:50e7:83db with SMTP id 5614622812f47-41cefe0a659mr350247b6e.25.1752612773433;
        Tue, 15 Jul 2025 13:52:53 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4141c58febcsm2264352b6e.41.2025.07.15.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:52:53 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:47:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <d2myew7nonfrelrwplpypexvcrktmjdlsccobjvx3dydvhnlar@bin5ol2vj3xs>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>

On 25/07/15 04:51PM, René Scharfe wrote:
> pop_most_recent_commit() calls commit_list_insert_by_date(), which and

Did you mean?

s/which and/which/

> is itself called in a loop, which can lead to quadratic complexity.
> Replace the commit_list with a prio_queue to ensure logarithmic worst
> case complexity and convert all three users.

If I understand correctly, `pop_most_recent_commit()` removes the most
recent commit from a list of commits sorted by date and then inserts
each of the removed commit's parents into the list while maintaining
date order. Iterating through `struct commit_list` every time to find
where to insert each parent parent leads to quadratic complexity. For
repositories with many merge commits, this could scale poorly.

> Add a performance test that exercises one of them using a pathological
> history that consists of 50% merges and 50% root commits to demonstrate
> the speedup:
> 
>    Test                          v2.50.1           HEAD
>    ----------------------------------------------------------------------
>    1501.2: rev-parse ':/65535'   2.48(2.47+0.00)   0.20(0.19+0.00) -91.9%
> 
> Alas, sane histories don't benefit from the conversion much, and
> traversing Git's own history takes a 1% performance hit on my machine:

As "normal" repositories don't benefit here, it might be nice to more
explicitly mention the the types of repositories that do benefit.

>    $ hyperfine -w3 -L git ./git_2.50.1,./git '{git} rev-parse :/^Initial.revision'
>    Benchmark 1: ./git_2.50.1 rev-parse :/^Initial.revision
>      Time (mean ± σ):      1.071 s ±  0.004 s    [User: 1.052 s, System: 0.017 s]
>      Range (min … max):    1.067 s …  1.078 s    10 runs
> 
>    Benchmark 2: ./git rev-parse :/^Initial.revision
>      Time (mean ± σ):      1.079 s ±  0.003 s    [User: 1.060 s, System: 0.017 s]
>      Range (min … max):    1.074 s …  1.083 s    10 runs
> 
>    Summary
>      ./git_2.50.1 rev-parse :/^Initial.revision ran
>        1.01 ± 0.00 times faster than ./git rev-parse :/^Initial.revision
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  commit.c                          |  7 ++--
>  commit.h                          |  8 ++---
>  fetch-pack.c                      | 13 +++++---
>  object-name.c                     | 10 +++---
>  t/perf/p1501-rev-parse-oneline.sh | 55 +++++++++++++++++++++++++++++++
>  walker.c                          | 11 ++++---
>  6 files changed, 83 insertions(+), 21 deletions(-)
>  create mode 100755 t/perf/p1501-rev-parse-oneline.sh
> 
> diff --git a/commit.c b/commit.c
> index e915b2b9a1..0200759aaa 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -31,6 +31,7 @@
>  #include "parse.h"
>  #include "object-file.h"
>  #include "object-file-convert.h"
> +#include "prio-queue.h"
>  
>  static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
>  
> @@ -738,17 +739,17 @@ void commit_list_sort_by_date(struct commit_list **list)
>  	commit_list_sort(list, commit_list_compare_by_date);
>  }
>  
> -struct commit *pop_most_recent_commit(struct commit_list **list,
> +struct commit *pop_most_recent_commit(struct prio_queue *queue,
>  				      unsigned int mark)
>  {
> -	struct commit *ret = pop_commit(list);
> +	struct commit *ret = prio_queue_get(queue);
>  	struct commit_list *parents = ret->parents;
>  
>  	while (parents) {
>  		struct commit *commit = parents->item;
>  		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
>  			commit->object.flags |= mark;
> -			commit_list_insert_by_date(commit, list);
> +			prio_queue_put(queue, commit);
>  		}
>  		parents = parents->next;
>  	}
> diff --git a/commit.h b/commit.h
> index 70c870dae4..9630c076d6 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -201,10 +201,10 @@ const char *repo_logmsg_reencode(struct repository *r,
>  
>  const char *skip_blank_lines(const char *msg);
>  
> -/** Removes the first commit from a list sorted by date, and adds all
> - * of its parents.
> - **/
> -struct commit *pop_most_recent_commit(struct commit_list **list,
> +struct prio_queue;
> +
> +/* Removes the first commit from a prio_queue and adds its parents. */
> +struct commit *pop_most_recent_commit(struct prio_queue *queue,
>  				      unsigned int mark);

Previously, `pop_most_recent_commit()` would ensure commits inserted in
the list were done it date order. Now this depends on how the caller has
configured the `struct prio_queue`. This is fine though as previously
the caller was required to ensure the list was sorted to begin with
otherwise it wouldn't work properly.

-Justin
