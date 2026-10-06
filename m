Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A843EB111
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289106; cv=none; b=iRCVzIDZ6n4JrnEvYxYzPsFtSOskCflmWika7uWUW05bO0oliPGv2qLzQmgHOQp3hKS6Cx8hejpYGteEZvA3gmrHUffoi+Z5/q+iGLGPaGkxdiwDdxrdiClJ//SnBGajakK4QkRnE/TPC5z/qZggw3GXzvOJ1JbaJ3nJI47mC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289106; c=relaxed/simple;
	bh=S/0mdPPNWP12ki7GCileW9Pkh0LNNFb9JEWE5j5qx+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUZxnrKNlDeUFIb779bfWGcak9Ezfs9GSF6oR11GontyEQd7ImjYS2aWV5Y/sp1tKhMvl7rE7j7gTS9XqmXtY54FBBBhD8OxMbYJ8ar7eCFIxxJG12B8qPo2xPq+m/7d35U3B3ep6CmX3zsOXE8MQ7PaAiPIFUnnx/8U90aBeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QthsKK4e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gp7QX6ls; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QthsKK4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gp7QX6ls"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C3817A00D5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 08:18:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 08:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791289104; x=1791375504; bh=FFJLhqstk/
	1RLFGQEAAd/MUwJCH7zwI2ZEyRttYbm24=; b=QthsKK4eeca+wW2fKrx/kVI4W7
	cmBq7khazvuldtKdACG8+q5JRQpKUL/4KThz0+ZxeEfkPqsfwa+EjQyqihNzafLb
	Te+2J4Hs8BNUr9wfeDMr4qZyVyVafNbBy5YTQFvwDdZtDki04s4A30sCGDMkKNnf
	+cvAdJI33n1QtNKhypnWjsngaoJfGQRamZ4gsRN38jJvqjrEbPlFiKBoAWQn/at9
	dE6+Kg3quT7vJkFKr2HHRMqO2zs6t3Yb8YC5xJILngHX+nOY4/kZxVLE48lE7+4D
	dJAiFMRngguNvnBAt/kjEPFPq+KmByO/a2HPlEBDbENh/NPXSs1ON/zwL23A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791289104; x=1791375504; bh=FFJLhqstk/1RLFGQEAAd/MUwJCH7zwI2ZEy
	RttYbm24=; b=gp7QX6lsd4j3X8ImWZB6yzu3KiyJDqiB4/Sp/L7zcMaPertHwtC
	yHQS0pLxc1i0BR+JbOLjJpAUyAkMlmjEsAVCrSyl34Pki4eNOgA8GGXEIC3YjNAD
	1ce/Wv+Qyd/XgSllUxG8QZ7lwcdTvaYQ9xgRpXTUp8scDY1yIj7dUhb/+jPV1NM1
	YOLvjbuU/6M53wbtNIs5vZ6TNRzVA3oiQUSWIHZlgIXXkRIvdqKfgKWAunkCDpbg
	tQjvEnutxf5QXilNJMMjfRZ989DKhdtD51ruZgRc2nWUPJ/o8p5qw7pIBDTbsEG8
	I5Q1EvAbguYENT4BxF3ekIF3T5SiJsIbBSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791289104; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FVu7RRQaHejkwLYDGdUhEsGiK5BvgaFqp+RMbx/dWy9wJAn
	Bl+kY2dS9hEc4g2cY05rEWLRoTEjtDbh20L/LkpdxyhYuEZBqipB8Rsa2BJZniGg
	+Qi2qDzL+b05wcNF8gqb5plfbltl0hfl8QfgfUYJbUt1WtH3m/qkGVuc1RFZNjYp
	oA3+DxmjEwofE4cLDmDxEi5t+YFZEuC/4VkFyguEeEJVIUYcRAaEJ+momaehe4GF
	brZtTDVT8YW9VFN1wXeUE7rnunjX/dc5ZBqe3pJEan9q+2/S9OvpYW2gApW5bKib
	XWANupXnJqH4tKFPDa+Mk1FKFdv4E5vpkHvvBBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bX0AqtYeGre+zkG9hfHJ7Ve1MyMMVYxVhXfSz7dcREI=:S/0mdPPNWP12ki7GCileW9Pkh0LNNFb9JEWE5j5qx+w=;
X-ME-Sender: <xms:EOfEatM9DmGmFK-Sxod8tIoYIouslmFTdheo_TGEBmmMjtVbNYa_HQ>
    <xme:EOfEal-Es--roMj84rYWSQlHMRzfhQrs1nQA18lvWhq3mobMkZrH3jDaTfPCOtBJP
    Twr0ulyybPSbuxWEkreRjXXzRcHovwtDEX6IHcJmCPSsCLOcH8XyYdO>
X-ME-Received: <xmr:EOfEap6sOfa8DrQ8xZKkIvyNP8L7IfwpEXo-flaDiwggDlXd_N7bYFnVth6EFDaRBf2qQQ>
X-ME-Proxy-Cause: dmFkZTEgd8L4Cuw5BPDNNThyrFCYLN9bX0xEU42AXwnxe4B0TMOWU7vAPn5K1+6cgOy54l
    Rz9aKZjqX/wc5iMBVK3ZeZQZeAJdoEPYq+85l0ENIS3Bb/4IVz0Y0rI00RoowZ9DsYNG6O
    C9rXLHLjqde0y1gUj83hHZlso05vs+3901Zp7NR0lqMFDOUctHAyL8HG9lqKUgsI4FkFGy
    /V3sWuIz3ynBmQLialw4b1m6U88SqVsVoQUhL12mIg/Mb9dmXnrOJ2UIuhE8Okjs7qG0SF
    m8o7rJcpvmgpoZD9wy1LVakaes34p5g1ICNDqLXoXBEKZYaHsDXCZM5FolBjD4XPI0GeGN
    ZaxJ+ZQE+FLvqiGaUasl3DSrwV9DiXh4WLuu9e0LRywmK4HsHK+fgkXBm8dRp+EfiGpzrs
    445IvghNsjNrj8slZqs7IWrdbujStJLbulEGGLOLDJ+mhJ/y3L9YiAUxFmzCCuII5cu2qU
    HOTlNMtTeVd71iwBZwNpu7lU+At8/1tqUibSM/yfEV9nveFcGXqi9eWWU83Es8oR7/BHaO
    wSzcVaqTMP4leATwvem1VUW/Ik6HOMeSDbIey1vBN4TPtFeP1VXFVhOoLz93EMjn6coyJB
    VMwEgulrA4Br0JDpbiwo9g3PnIJ9klkrlnSzDpgt/WxIVDoe3aU2NOsBIVFA
X-ME-Proxy: <xmx:EOfEak28JvXgN7e59Xm0_UbSAROXxjMkjt-m3ZHRrUNE3YJ2gXJreQ>
    <xmx:EOfEaoDYbXUYDVt-tZ38TSvShtU64xR5NvFif6J--x91AuP9rXm1Wg>
    <xmx:EOfEau0Z4OOEoaSBa1yYBpk8WJs71t_PtxxbYERI6O4RyZgJPqmmeg>
    <xmx:EOfEaquqxqVmmLc_HSVZMKm09Lx-3aU-plcSowLean9Gs4WOGc2wFw>
    <xmx:EOfEav-dYXqTUd6hZcRkNAsRc6KaQ4vwWlajmWqD1_AS6BNCtktANk2W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:18:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e6ab028 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 12:18:23 +0000 (UTC)
Date: Tue, 6 Oct 2026 14:18:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] commit-graph: stop depending on `struct odb_source`
Message-ID: <asTnDMrTjUWHVSwR@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
 <20261002-pks-odb-move-alternates-v1-2-8a63507b88c4@pks.im>
 <CAOLa=ZSNHWFw5Vj_5qg16ipp1QA0pDcV8h=hOA=ma4hy6F_LcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSNHWFw5Vj_5qg16ipp1QA0pDcV8h=hOA=ma4hy6F_LcQ@mail.gmail.com>

On Mon, Oct 05, 2026 at 03:43:44PM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]

Thanks for trimming! One more ask though: it's helpful to retain the
diff header itself so that one knows which file this is that you are
commenting on :)

> > @@ -28,7 +29,7 @@
> >  #include "tree.h"
> >  #include "chunk-format.h"
> >
> > -void git_test_write_commit_graph_or_die(struct odb_source *source)
> > +void git_test_write_commit_graph_or_die(struct repository *repo)
> >  {
> >  	int flags = 0;
> >  	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
> > @@ -37,7 +38,7 @@ void git_test_write_commit_graph_or_die(struct odb_source *source)
> >  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
> >  		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
> >
> > -	if (write_commit_graph_reachable(source, flags, NULL))
> > +	if (write_commit_graph_reachable(repo, repo->objects->sources->path, flags, NULL))
> >  		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
> >  }
> >
> 
> Shouldn't the caller of `git_test_write_commit_graph_or_die()` send in
> (repo, path) and we forward that path, instead of using the path from
> `repo->objects->sources->path`?

I'd agree if this were a properly designed function. But it's basically
just a hack for our test suite, so I was aiming for the easiest fix
possible to make this work.

Patrick
