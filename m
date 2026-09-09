Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA543C5848
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937431; cv=none; b=X8mP/nsjARGLPwDUW0JDelTx+dA4gSsnQ1Usj6BYMANPa67VBfUOyb+GKiAfPKSN5OLRuzNj7OEB3LWUTyNF5GWigFGSl3rSxArHOQ43NBzoMY9IcwBxd+/AQUzJG55cxwsJwpiBODMzu+9QQMuDMv8qSY85jpO5jis9aTKpcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937431; c=relaxed/simple;
	bh=gSfn3tzrmrF1bylN1LxnRHMB7L3LZ3EPPlGviUyWw9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8wbyVfYRCBERRN286GhSvLENwmnw07/yZTYnTU8YZUNcBm+59xP5kAdK40IzgJpgD5THvc+qEeeoRkF0tgWUzHJMooMlGWjzDagrLIzgM5Xbn50l69cWvn9IuHR8zebkerhoPzvxqYGwQYsToTLI/RRitGksGShx2nWC6D8OkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PYS1qk8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ay4apWtA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PYS1qk8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ay4apWtA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC18414000BB;
	Wed,  9 Sep 2026 03:03:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 03:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788937428; x=1789023828; bh=ETnlpj3bs1
	zwqiBzh5GVM33pp6CAymZ4JL5z1PHgps4=; b=PYS1qk8Ck5Xzc93L9ud7n0oh10
	0hbNSoiIvOTSt0FfF5Yw4yLsJ2nXJ7mWy7p8zThCScJpw/sGaQqJF8mpYayQb66U
	eXljlnI46q++Y29uVgqDU3AwI4esKLhnQp6QdKlXbtAnqNGBB30IFedh0NjSu8Jv
	BGlae1zhTokHpPqDAKhS3Xo1JNfMVS1xUSAzXoGvrh++XuPDII6ODCH26X7bqjwy
	SlC9hcE9Yf3XgZBHhapcz3TGxtVF6bP5/asQNsVyf+hWB6EZq6xG90cpVdkVJ+2u
	jZuumNFG/uA55LYCoZBPHwNC2GQ4IeXCbh9N4xnyatH1FIxBI1P24V18GSgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788937428; x=1789023828; bh=ETnlpj3bs1zwqiBzh5GVM33pp6CAymZ4JL5
	z1PHgps4=; b=ay4apWtA4hvB9STChW5TTkqCAIY9b7pyIIPX6zluZVVYE+qdoTt
	KM/chL+06WBs5rqeJ6+9BUdQ6iPSs9sp1TTtdnbax+nu2idTwJaC610xL6Di30P6
	aN7jrMpqwRoqOq7jdvQFK9MUBc/KjnCDMNTiTLGQfrK37xXRoiOn88cokAQxilhr
	JHOeZuoDt/dr09nSV5hcSgtklJZ0gNq1wuB5b+th+i/BcIIuFXO0kVBazwzkB8M5
	z4yyDzyxPKf8b7NOGMvMZQvnGf7buixMFWsSdxSrd0Y3mvi3YOx65/6e0b5+I8OS
	FeUAlFXhfASDVqmPkNaJ11+ZSc5OdhR0+gA==
X-ME-Sender: <xms:1ASharYtucypcLT-VSDAkficBpBEwFB2blkh5fFtxHqTutoO5fkvGw>
    <xme:1AShaha74OTNAhIvDEOIIS7Cn3e7yYVWf6S0Kuy0dORFyKkRa_KVcM_OTQN--jOMm
    9Y2SWmVMzy9lHcqgvsQ4PC7dh1yHcLwW15dl5_tlmUIKKWgUwGsrck>
X-ME-Received: <xmr:1AShai9691X56eqGBz7uzh-rz8nUuDsh1a6oczc4M9FGS9rsABh1VVRvb4ftgcVx7rsoqA>
X-ME-Proxy-Cause: dmFkZTEc1LrQzykGOGRD+1S0nSLhWKhG7NH9rJczC9Xh0m+KNxpvsWTk8MVWfAa/Pg5VGC
    TvfThAxqogi6G7gtulACNWY8vFINppBzt4rFtETONSWcl9BXkvfk/vj0xIefvInI5PtkDk
    SJCDDzawpggKyl65GwrzZ8f2tPggHwZUI60+7o73nRKv7R0Y9r5zjLkLbHvHUuVXOEONuI
    Q01GCdHq6IDiOK/Z+GRdfWKyww6K97Cop0jbameKXsZJjwuVJCmfdrw0E+0T0IbTsQSTqo
    /65lSgsQTFouDbWQ9MtbyYhcpWzNPBJkT7Redq04TUtE+fgbEXzS1cnkIHhJ6HKxZMgmnI
    cMT/TN1IpVQ2Zy0b8B2n+geV9U+DUxHbaYmGS9ukJmTW2y2tikjvSTHlEagOIGCYHPEwYG
    MX6NHEH6/dd8dT4ng4iX7synsKKAxgBlpuIH94/doidaaGBpVKaLqnDNhbvevj7WA429zx
    QcR71QyoFBEOuYDmyy2N0ikaxHn8DdveERItnKDXN51ZaoH4t4lB6gOp3CgWKKyf7T+nC8
    Km4XH0IXlKvjA2ldqhIFCs797+qIu/u0LEapXefBKSq6entLx+bVRKTRzvUinjBO53HUIj
    E65OJ0lUtzWA08U8yGUYhDts9WAFfrbfyiGPce9vK8lpH2t01A5iUQ/ETz+A
X-ME-Proxy: <xmx:1AShaghOmTC_fnPghX9PQMmybw0ZffzGJUVpwrb8eBpZu1Nw85cNRw>
    <xmx:1AShaiefAvqXxEt7disrD9ffOmyDPIsdaKOL6S04OA7C3FYfeddDAg>
    <xmx:1AShanobpaafFnEyCQ4y2rnw2iAg5HaXjQCMJO5ikCpG6PGvHuQ7mw>
    <xmx:1AShanBiX_P1dAWkuJGLYlTktrsG8IUnHv8WivWnGrxYFTVdFLEg_A>
    <xmx:1AShaieRWC0_EuZjkpCrm4XntoaZ_D9GeCTYu9dWwIR7CjHoCRzhLC33>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 03:03:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 698c1bbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 07:03:46 +0000 (UTC)
Date: Wed, 9 Sep 2026 09:03:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/11] builtin/refs: rename "--ref-format=" to
 "--ref-storage-format="
Message-ID: <aqEE0PdjrRnLDkGA@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-3-6733c90ca5b0@pks.im>
 <53eac227-1034-4dd5-9f4d-416537dcdd1e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53eac227-1034-4dd5-9f4d-416537dcdd1e@gmail.com>

On Tue, Sep 08, 2026 at 04:25:35PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> > index 5cd21c25fe..53b12accaf 100644
> > --- a/builtin/refs.c
> > +++ b/builtin/refs.c
> > @@ -10,7 +10,7 @@
> >   #include "refs/refs-internal.h"
> >   #define REFS_MIGRATE_USAGE \
> > -	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
> > +	N_("git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]")
> >   #define REFS_VERIFY_USAGE \
> >   	N_("git refs verify [--strict] [--verbose]")
> > @@ -44,9 +44,12 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
> >   	enum ref_storage_format format;
> >   	unsigned int flags = 0;
> >   	struct option options[] = {
> > -		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
> > -			N_("specify the reference format to convert to"),
> > +		OPT_STRING_F(0, "ref-storage-format", &format_str, N_("format"),
> > +			N_("specify the reference storage format to convert to"),
> >   			PARSE_OPT_NONEG),
> 
> This is a bit of a tangent to the change that the patch aims for.
> 
> The `PARSE_OPT_NONEG` flag made me wonder if we needed the same in other
> commands that accept this argument too. I tried to take a quick look at the
> series that introduced the `git refs` command and I could not find any
> specific rationale behind why the argument to this specific command should
> have the PARSE_OPT_NONEG flag. May be we could drop the flag for `git refs`
> command to make it consistent with how the argument is supported in other
> commands?
> 
> Either way not a show-stopper for this series, of course.

We might want to do that, yeah. But it's certainly outside the scope of
this patch series, so I'll not include it here.

Patrick
