Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF823A1A21
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990380; cv=none; b=SGNYq9EXKJNqa3gHo0mvfYRS4sasmDat9XemKuqHLsTNXXGXZgX/XmAXxK4Q8E7ZyQT+fWl0NnpuHm3j8gdu5E6WungbabRjl/OdM7o4VM1u187awKhrKHJHIkAqEgOLxL7AAOVHbD2ZTlEltD/4vt8RjIVguMUHLB1YDZFdQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990380; c=relaxed/simple;
	bh=gxw0rKADrFkVMDYeNO3BppHupu6wIfCY0H5xUQTPWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTVHzyZ+LDJQbelhieyc6oJDPmztunJ0f5OrMjCe++tSbpLol3PpwT1qw1drQhONtix00wFKFCTRS5ZnEUnQnkbK9GKSqQHqGagXXbfvP4tkKfqqBTKBc/bkYb5sxxWXsbqQUFki4iwrIY1l/hczRXMKlT1wxPBEEKuDnHXFnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qi5NeTao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4dMiUmg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qi5NeTao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4dMiUmg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48886140016D;
	Thu,  2 Jul 2026 07:06:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 07:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1782990378; x=1783076778; bh=y8ZArXyy5N
	RogcEaVI9T96yaDkhzyvDsVbMzDYDBWYo=; b=Qi5NeTaoR6q+xtix8bmixaWmls
	UuopGYJje7ANto1CHin3lwOWdM66yH6t4QcrUd83STprx4ngAv72gBD2mQqErnan
	mPIAKWefXXWUN7r0up1GcsdSlBspyNjER43B05nGpc15VbasmWy3JvrmqTq/nhWM
	gkJ4WrgxH1SNYcsDc5cbIKbCV71M8pPGChpjR6vGTyJkhY+voneZXmsIQJn0eIwP
	AnSbGULl8a4n5EOubl66EI4+6iVWKGYb5YRqux+3dzr+iZ7vGlDBuScfj9IL2924
	3LVG0yWATbILWSCN/ilNNoQ7eKCo5g9LWRVZGEqc9TUGbcyQYLhKU30DYUSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1782990378; x=1783076778; bh=y8ZArXyy5NRogcEaVI9T96yaDkhzyvDsVbM
	zDYDBWYo=; b=R4dMiUmgTKS4y+nHlER2MWaDWHOKzwQOX7NDZV2MFShIs+vguZJ
	sykVveMef9wFs+fUgHtmjNv6zpE/qmTK/HN66Y8+3Wh8YrpZ6Verfdcr5YZyKp58
	d3YwYq6BJPS8DA3N9kz0G57dZOG1r4U48FVBIaopFjRGYAgH+0gJxilthSygq9LR
	Yxt4KZxUwOT7oTDDTKiauNFf25i9VnRpXgq3TTCfDK5duMfDJD1SpKWH3qLFBFDx
	o350Uqd6kRC5GRupD8jUsqe9o/LDTj5K1fo3rRSWpLLrbzmQE0dtvWwYqCduWR+p
	pexU5rwaWS5f24czghNCXDtKBsJ7F+Zatig==
X-ME-Sender: <xms:KkZGavrqSCX933pSv92nZoC42O1BBXYeNYEpwOGWbgHjiaPnGVriLw>
    <xme:KkZGahGgcn_VzlcW8qQ1Pvywj4LmoacEeU-1MG9eR_V6E1jygGULxgJP298yHxozK
    yXJEF_KW1a7y5APypbY_42CBxrilicGr9_vRX0anXnJZyiHwFAh>
X-ME-Received: <xmr:KkZGapl1x8ErSg3-Ycxxcb48BPlVAy61urjY2ukjWd9KEVV4R14Bv6y17y_ySiujHLOLW-exGkS2kaGxVtJara6YIgUio_LZfNc49VY3UbIXRg>
X-ME-Proxy-Cause: dmFkZTEkasnHBZmemhsWOVTpxJt8UmwCSuIoIsAum0QcRxzcPkXUIAFoNHDxnm3gZdy+qh
    58oOYDk8aMxfswvv1C5FQuQarGB/id+kHbUHOG3F2JgupR5Zh3vfM6aog5+ctmxPKg585/
    AXGJKtS92zprRwXctXlw6PlH0aowvL02rHNSaRqAjfSIW3N4Hnx88VS+VYEZGvf91Q9/hV
    n69Ms+9Gz7xxEqrQt0Ict5Oy9yQrniFqhv5jvRO4mEtncrvW1yMqms1WHk7EjSzFp4LjIO
    NcDTkuv1VpRdfDKEHe36Uor3walQs1YYJk9ixGmY1ysTG5VIuB7eQX3SZcH/9Yj8gC/pNK
    M5X5sYvbIBSYDw3mpaMMw8RAFQj6bxbIL8AVHBfU42+zEmQRIp308HacpgVDuaUSG1i608
    sSSTjaNc3BOF54qTQWjcy9gs7/aoQdtIJcWjrFp/5FQpW8h/x33Jo651gEav1qvoGZFLPY
    s0K0rSgpK57JAIChwTz7O29qwkPyUDDPGqyGT48fdhn3vJ8uR4QjiPuwL/zAT/dm5vH/5S
    u8m6lLXkvBdE4bt0NIlZDdiFUH0B9jfYkAH+RY3Xuw72UIl8rnDsKSg0aAD0CFZ9S1+uj0
    yONAC+SWMs7igDFiKrxEAYFG8i3urFqMJw6J/qG14vaAfYHbvYSLnwlv/vSQ
X-ME-Proxy: <xmx:KkZGaskLa7WHUCLLwV-RFsaKEI24vwfYl9u2Icn_QnoXe0YEis-jLQ>
    <xmx:KkZGaisW2AD9koDAVmw6lTB_JOOFZf0gRee-EgNOS1VBserJedk__Q>
    <xmx:KkZGanmTIUS1J9CHXdInhhWt8sdLKVmD8ZSm_3ciAJAzgdfrcnhByQ>
    <xmx:KkZGaluKKXw9JcFR7dW6OZT0jwhRnYM_2ilyFTox17z0Cs_FOog4kQ>
    <xmx:KkZGapuNK7lKJEQ54zeYp9nN7_pE9S20Wnzmnlp8ApclZedvig0HifXG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:06:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 241b5b08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 11:06:15 +0000 (UTC)
Date: Thu, 2 Jul 2026 13:06:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mike Gilbert <floppym@gentoo.org>
Cc: git@vger.kernel.org, adrian.ratiu@collabora.com
Subject: Re: [PATCH] meson: restore hook-list.h to builtin_sources
Message-ID: <akZGJP1kVtjBFN_e@pks.im>
References: <20260701193928.358825-1-floppym@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701193928.358825-1-floppym@gentoo.org>

On Wed, Jul 01, 2026 at 03:39:28PM -0400, Mike Gilbert wrote:
> This fixes a racy build failure.
> 
> ```
> builtin/bugreport.c:12:10: fatal error: hook-list.h: No such file or directory
>    12 | #include "hook-list.h"
>       |          ^~~~~~~~~~~~~
> 
> ```
> 
> hook-list.h must be generated before builtin/bugreport.c is compiled.

"hook-list.h" is required by both "hook.c" and by "builtin/bugreport.c".
So you would expect that we indeed need the header generated for both of
these, but right now we only explicitly list the dependency for our
libgit sources, not to our builtin sources. And consequently the header
may not be generated:

    $ meson setup build
    ...
    $ ninja -C build git.p/builtin_bugreport.c.o
    ...
    ../builtin/bugreport.c:12:10: fatal error: 'hook-list.h' file not found
   12 | #include "hook-list.h"
      |          ^~~~~~~~~~~~~
   1 error generated.

The fix is of course to explicitly list the header for both targets.
And...

> diff --git a/meson.build b/meson.build
> index 3247697f74aa..bdc83843e8e0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -278,7 +278,20 @@ compat_sources = [
>    'compat/terminal.c',
>  ]
>  
> +hook_list = custom_target(
> +  input: 'Documentation/githooks.adoc',
> +  output: 'hook-list.h',
> +  command: [
> +    shell,
> +    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> +    meson.current_source_dir(),
> +    '@OUTPUT@',
> +  ],
> +  env: script_environment,
> +)
> +
>  libgit_sources = [
> +  hook_list,
>    'abspath.c',
>    'add-interactive.c',
>    'add-patch.c',
> @@ -566,19 +579,8 @@ libgit_sources += custom_target(
>    env: script_environment,
>  )
>  
> -libgit_sources += custom_target(
> -  input: 'Documentation/githooks.adoc',
> -  output: 'hook-list.h',
> -  command: [
> -    shell,
> -    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> -    meson.current_source_dir(),
> -    '@OUTPUT@',
> -  ],
> -  env: script_environment,
> -)
> -
>  builtin_sources = [
> +  hook_list,
>    'builtin/add.c',
>    'builtin/am.c',
>    'builtin/annotate.c',

... that's exactly what you do. So this fix looks good to me, thanks!

Patrick
