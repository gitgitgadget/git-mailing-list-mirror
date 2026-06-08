Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A131715D
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929288; cv=none; b=JyvTJtzosJtHJkiy8Sns6UoRhDmSV5c6fyU+W5Odbv20Z1Nu5v7jq9p4bx/B7ebJkSP3luiWzzpYdJGduIP+XHVOTUo46GQxY66BUC25PPDWDIgPTyyVCJCZmKhRCFIH7TmuGqC+Y7mL+0m+O/I+ESkm2EEZ8joCBCcIayFybnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929288; c=relaxed/simple;
	bh=l/g/9zB2V0jJ6wIrlIv6Jcvz4CZ5xCjwBigH1skZ8y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtL7zHwXsox41fQQOpOxB4BrJRHVaPoEUplHOqGQHuIrGxlK0oQvrCDVhkYZmgneiaYp+uSaDcS+++DOPeM0BVGFDUt2iDCGhteOhLR/UBK1HxHL/fNVHmeJIbU9HDrkTsV1NCQEGDWGcxb6/M3ua6HEOlOeUx0t/anJp6/diHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XqacOJ4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0ZSn2A6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XqacOJ4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0ZSn2A6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EE24EC001F;
	Mon,  8 Jun 2026 10:34:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 10:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780929286; x=1781015686; bh=Uq03ZG/T26
	SdOVImrfNnlaUPnKZF87KalOogI7WsBL0=; b=XqacOJ4CmsCWmniXgw1xyrzQ1Z
	Qy+335xLDzI3yfd1Pab4zAcd+BNyNWe3VAcYWwp4J/33YilHNzZWtzSQaQBTHA+/
	QBieooV9cp8nWZTnJmQzRJurYkSGpA8kEwQHt1DzhiI2XmcYYCG9Fj0Wmtz/ZFpR
	Vw+gBAXcUoMfWoev7w6lYCEDq2yjXLFu4Ms/a7R2lMYygnS2wHJYLEFQod2a7jn1
	Lr5A7/bHbUuMOs/t1Rg7Ori9K37w+O7QlJBcC+Jeec/0dQxWBGtO/HsQemnKPqT6
	7UxgfA5jdY96oCHgha7SQkJVOhZUjT1GZuHFNO0Cd1ddA757gHh2sdaQfGaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780929286; x=1781015686; bh=Uq03ZG/T26SdOVImrfNnlaUPnKZF87KalOo
	gI7WsBL0=; b=R0ZSn2A67j8r3vTNZGW7h3+Sc2pUkkvOAUIMWmOmyx+SN5hdAwa
	jAhx7pG0ws6v0L1lGSfsRDeyiuyjgGv2eE6Da1+7PifEahY/UJmHHG7RONwoLyYe
	07xyK6zY9GcPX2Xu9cBwEH73bo38Ybtj6+Q+ZI2ApqNCPEc5xMn3uP95Mf+e0dfw
	2HqdfzenqS+UozUNbubS0yd+Z/R/QawQBaQSf8IZulKt8co4sM6pMS8+sWSzMBIp
	xLgFwrdoG0GYyfNyB6gGV4IYiPdy8MlcHCjyfmRwR2EJKX94emwkKGPGYa+xsaOm
	g5kLSPdFEZcWJso3/H11MqsaVugqigJC9Kg==
X-ME-Sender: <xms:BtMmarSkRAGDFSZ1WaWWJO8eRoIwNJH2oBvgTc1iaVdadaCtR_tJWQ>
    <xme:BtMmajyZUofZZ3iKKZvDWurSLZ1laadCnfzx0e8HtJHwsCCeWBnRAfIfEGs_sbtjt
    VNQ0zTeEdbU1vjbd1BN6ivUeu2oA-VR5PyDTPukIfaxiOU9NU38jA>
X-ME-Received: <xmr:BtMmal00EY1kVV1W1oKbha5GXkAC9jRhey49DL317vWBf8ziWOD9QPyLgp736rlgzo8JuouHCxTsTTPnE2wEkNqnxQKfhC6Q90XlzEm53w>
X-ME-Proxy-Cause: dmFkZTFCx5XgRMEOpFlEl5PxpnTQjOkz4mvTYTVSPz+ID6qD5t2cnE1cjyxI43o6Lp3d4C
    J5cnt6y1eC35Hd+XewsLGSNqeav4Jty8IwUDd1huL93l1mI8XVuCuKmmONdqSRJ3CZoyZ+
    oUncH9pn1EXrLJVM2uFpDEvRMefs6DEDD0rCjmT5eXDudu2vpIYoJa1pyPatEcpXC2Xq9Z
    OyuRfl2CXoTl0dQrHPHC9LWflVRAvQgweUqqpH9B1mbb8yQgw3lrMYTyZaI8w5g4S8uMoy
    RMy1ZK45KoWqjFJi/SbInH6iMmWpWWLzxfl+CJR7w49HzJGF1IHyy0LroelNz7GPQcLtrF
    iIXtBIOoPRwZ/YvxlT1ynIaZMwOMlUpD0cXvKs3FjMBcG7gB8TLCZSK/f1K8alV8B5iXh+
    +RL3F7WyQhUkvfMixMD9Sx0Rdw0UV+VYNvgDm4R/R8O916GXEDdAMU71Lq4rIIpwspxFGP
    hC28G7znH+tdiboaR1ANB3AtgADr4BXVmy9bmxqNyMJj+pfMr499HxFAuxkxi2Hhf5sDJP
    35qOQafu7GebyDHOsTjr+jH1HVF+WcfqEIyxVblKQgcTK62ZaprX4hA6uaWqUmYicon8FE
    qlBBEhQvICAqhSnPyfWqL4CDFc8+cIxATsHg3QNLXGVwhh0t5qSHR8+WjcpQ
X-ME-Proxy: <xmx:BtMmap7nOkpKZgbpu0P8zUp4te1KmuCiUR9N7vE9RW0RaUvgyvcW-g>
    <xmx:BtMmagXIFb4fHr2t1Z0Anez72cll4Hap7busouv-d9QnmLmbgn8wfw>
    <xmx:BtMmagD2LIoGHHr7B6Ce_OM9ubfSGt7JScS5PSnkyDQJHKRfp2-BTw>
    <xmx:BtMman7RE4rMIWCHBQxLfOBHhdWFv5kixg7BsiqH4359368AHi4_eQ>
    <xmx:BtMmatWQIe1FUrCJ_6WbxRgqiFTKDFcXazagCgUyuhuFU29pWdgi1DY_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 10:34:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8d0f59f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 14:34:43 +0000 (UTC)
Date: Mon, 8 Jun 2026 16:34:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] config: add GIT_CONFIG_INCLUDES
Message-ID: <aibTAOrcSvTOtv78@pks.im>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <b48fe9f7abe794864ac4470c2620048c2e5e6b53.1780927027.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48fe9f7abe794864ac4470c2620048c2e5e6b53.1780927027.git.gitgitgadget@gmail.com>

On Mon, Jun 08, 2026 at 01:57:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The config keys 'include.path' and 'includeIf.*' allow users to specify
> config stored in a location outside of the typical list of config files
> (system, global, local, etc.). For example, users who accept the risk
> can specify helpful aliases via a file checked into the repo by pointing
> 'include.path' to the position of that file in the working directory.
> This is dangerous, but people do it.

Huh, I never even considered this use case. But of course, this is
possible, even though it's quite scary.

> What becomes tricky is that this modifies all Git behavior, including
> operations that are intended to be limited in activity or sandboxed in
> some way. These include directives can provide surprising changes to
> behavior, especially when expecting a specific list of allowed file
> accesses. This could lead to failed builds, for instance.
> 
> To allow for these user-desired features when they are running commands,
> add a new GIT_CONFIG_INCLUDES environment variable that disables these
> redirections of config when set to zero. This variable can be set by
> automation, such as build tooling, to avoid these strange behaviors.
> This could be considered a recommended option for tools executing Git
> commands, the same as GIT_ADVICE=0.

I don't know about this part though. I could see use cases where the
tools _should_ read the project-relative configuration. It might also be
the case that the user may want to evaluate some includes, but not all
of them.

That raises the question whether we can introduce the configuration in a
way that it allows a bit more flexibility than just "yes"/"no", like for
example an allow-list of locations that should be evaluated. But maybe
I'm overthinking this.

Patrick
