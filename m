Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2E1531C3
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001134; cv=none; b=rLWDNiW4SkvhmBtnsihsniQOz5Ct35Gw2Niv9isPfRluV1mRa5Vax3db/A++bilIzNAQHufBaisMNGqHdzZ/0aXtqL3ClGP0xWVA48WUq4TGypbJi3PqU1SHGd5V8/o60y5oU2at4S9fls82LXNSJ23dj1PapEmiOmvf3jU4QBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001134; c=relaxed/simple;
	bh=xtmzBo66zyTYwazCbZd72d7i+is5YR7grpOTUuyfiJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgCGcsQyPsbhsOh1JOUlKfC9iUQTriIHvOZSCrKl4l8FChPf3rrP7C64g+NU/h8N1VVW8XidJhtUC79+zsL9Jl2At8i1Tn1AKeR32p9ElCdrPQ/7D4nPMVLqU5e7oIzyqVkHpjIdoyaf5Svph3xxuPGG4zTHYmaXjfZqEI6P5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jzTlNDbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKqkuQzM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jzTlNDbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKqkuQzM"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D97C41380282;
	Fri, 30 Aug 2024 02:58:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 Aug 2024 02:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725001130; x=1725087530; bh=kkJrRut6GN
	DvJcf7wD0l6uUIZQ3n04z4JKm8FNnKaQo=; b=jzTlNDbPEyuOkAi9VklWWvMbmA
	81/1ENxZ3lijBYqZzO79jQwvICvQfXjMK8zH3tMX8MsJk8y+zVh/hGBf/qw3tkni
	iAQ5+zWD2PLDTB65ywKcbGaTEw6doxOZxyfnyUEa5UFZqRRcuD2I9GfIzyVkmpO4
	xMPXUbQpzrnaejxbLsuSBdj42FntB5ydChdZvUSmaYgQuHvQri/5q1Lp8dCgs1h8
	s8uaap5pifbbLy253J9cLzUjbgAFQxDjmVTJg6zm3g1016jrHBgelf7/Rn3zJxRA
	CjlOZVMQyNZQweAHbcknt+BTrySrC6uFR8VyNgYeqZoD0Utu7AgQ7pQ/o8ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725001130; x=1725087530; bh=kkJrRut6GNDvJcf7wD0l6uUIZQ3n
	04z4JKm8FNnKaQo=; b=IKqkuQzMvrGRS9VU6Pbnc0URKfYw1uPl6MCoXotjbdGX
	hwsha0Op42DlKnKH0q+bQn7IfyKOWENcaR+YEPp6arbqqMCJvYhqT9OZwzGJDjJY
	RLz1GRjy+nhCIbDlf1DUgBaNtqP6Hoof5V/yj1Mn/EQgC9HcVMzvJEoiu0MnpStZ
	9VdV0Fh1b6L83lsYkOQbQK+o9rXW4E69JEjOkeagGHAxmSza8gRxsSXuiHm6gLST
	sCDMeT41G4PQXgUsd1itq5qAqgeciabAvEKeG9UL4TzPPgMXvcmuA2OauVWHLRlm
	kwMfes6zV1hYKkpXSEzTyRNeVg09t5/LHBnt4Mt41g==
X-ME-Sender: <xms:qm3RZsTdnsmvgKoH1m9Rczz7BOYdVlxc636RNokahlbUI0Wh5wDKnQ>
    <xme:qm3RZpygiET04r783xZHXV5dmS6E1A8vpy7kCXJL1iHO_IULYprUDh5nVRQfSwfNk
    VgFHCN3BB38qJQxRA>
X-ME-Received: <xmr:qm3RZp3iqD3PXcJ3xzwqobOw1K_ppeJxLHY8OTXZhNxZWFE5xtjbTa3QqVjSvOB24WziieKUea98KDit1SH0gw2FSrphXgruz1yHdk7uJ9QDYdHS4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefhedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtoh
    hm
X-ME-Proxy: <xmx:qm3RZgD3IFA22sPUruIjQIJlmj9AY6RySLmT1899L2CV5WWubyqWDA>
    <xmx:qm3RZljvNqz56KF_lKPOe0AbQ_V_D0KJZ2hSfHTR9S-BxcFZZP_C9Q>
    <xmx:qm3RZsqUcyTBLhP572f5jwDxxSk-MwVpWcY2EenJtSXYXo5nmP8Q9Q>
    <xmx:qm3RZohnuSX7UD2-z1624gEnmUf5KCFmUvC3lA1Tq3ao5_4xGc_HUw>
    <xmx:qm3RZqsJKlljzSGmWH_csAg81LOS3smNC9TS19PUkMqGi0JxrFtupRfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 02:58:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id efa809eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 06:58:39 +0000 (UTC)
Date: Fri, 30 Aug 2024 08:58:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 00/21] environment: guard reliance on `the_repository`
Message-ID: <ZtFtpjaGFhORNEP4@tanuki>
References: <cover.1724923648.git.ps@pks.im>
 <xmqqle0fuml4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqle0fuml4.fsf@gitster.g>

On Thu, Aug 29, 2024 at 12:59:35PM -0700, Junio C Hamano wrote:
> There may be more, but I know at least of these at the moment from
> https://github.com/git/git/actions/runs/10619536685/job/29437358521
> 
> Perhaps this can become [0.5/21] of the series, before globals are
> hidden behind the macro.

Thanks, I'll add these. I really need to spend some time to finally get
Win32 builds set up in GitLab CI.

Patrick

> --- >8 ---
> Subject: [PATCH] win32: mark the sources that depend on the_repository
> 
> These source files still need access to the global variables like
> "ignore_case" and "protect_ntfs".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/mingw.c            | 2 ++
>  compat/win32/path-utils.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 29d3f09768..5c2080c04c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1,3 +1,5 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "../git-compat-util.h"
>  #include "win32.h"
>  #include <aclapi.h>
> diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
> index b658ca3f81..966ef779b9 100644
> --- a/compat/win32/path-utils.c
> +++ b/compat/win32/path-utils.c
> @@ -1,3 +1,5 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "../../git-compat-util.h"
>  #include "../../environment.h"
>  
> -- 
> 2.46.0-567-gbce23f156d
> 
