Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96B435ABC
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225942; cv=none; b=Tz1yBf35yOga/OS4sidOsUgVo5yHHSBUltcu1iWwdfrZ3Vtt4Y3wc+0iD/X99ZU21W4uYesUfetzpG/9dCs6HvJx57GerTPb3oy66/CCCknBvNM/dg10c/w0vdYLlpj8zniW/UQJEu5iL+U2q37PcuD/VVyTxjXTeCww2q614MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225942; c=relaxed/simple;
	bh=5/gSZwnt5VAnDJQxUfIC7Zm3Q+v3Xk1Y0mlfcemSJmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqxW8Ah4dQEcSm7Ah634bspL71a3lsS3+r21sqqHZumVHghiNv9hCBDhYKE48bmbOLr/Vwnomf9RRRkd/0BDc4vWFhJz9w6FMh2QJehWVQ1PbVRohAoUdS+PA7YqFzK9YbKE2S/OytwqqZ1Rio5QaertN1WfoAzRABGmsae2U/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LY/u46eT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzVidkiI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LY/u46eT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzVidkiI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5264514000F2;
	Thu, 20 Aug 2026 07:39:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 07:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787225940; x=1787312340; bh=ZPr3ww2bDT
	O+QFjBawxXejxaAXJ9y24bjYZV2pOVspo=; b=LY/u46eTqtel7seIq33QlfbRrk
	eVNBh4vezk8rodNyTlUXtz4kclYeSqte4v/+wSFEDSUA1JCWxviBXGslpyF56Sfn
	CA4QF9u+u3XOhNWVKCISspWCPUwPhJOsRdRBX3bjXFaMBYqzAvl24ORgXj9oCFMN
	zBncGlk/dVlsIIR1td6mDbAH8EM0Q+ihEAMXkOneeLTwI7fPwU4PluytorQ080NN
	k4hVAgTu+iRHO3Yj2eSDfVSn4UxVvVUm/OgjZb4SrhFswZIGiGZJAG9YVP0BY3zn
	cKKo29ex1jpcaPbeahE5IUcGW1Sk2Pt2AKgd4Rqmv6dvQmcc0TsGxs//hNoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787225940; x=1787312340; bh=ZPr3ww2bDTO+QFjBawxXejxaAXJ9y24bjYZ
	V2pOVspo=; b=XzVidkiITHBX/JHOf3QUv5qYRBrxnf49jiDDeAG2idHWidbobIa
	+VBDq3SiBlc9LD4n4KxXfArFmyWqTZoLA9Z+SV5Owy1mjd94+SaoR6mr3eiGYSSd
	Tg2WBxticzGKx1LF8R1Co8Qf+aBuVmbUB30zBJ7HJFDeTVgN72IHC6L8Vpm8LQ4S
	sGfxURo1/HFhGOuVzC9GvCj1CyoK3Pmm/OXLIosoKFZAOe3R8g+LDMvHL/g/dyTx
	Q0j6fEeqebo6W/aaerQ1/xsE8gpB/wmVGHpSJu0lo2zC8UjDHzgaZmoO0skXfEfC
	ikaghN1yqQSCljdjQoj8N1MRkIntCewGM+w==
X-ME-Sender: <xms:VOeGaglXBpya8P-CN4KUwCSkKIHaZCqctBvAW4AaA_x5KJR9i0WgBg>
    <xme:VOeGamsLXkaPpyahoPFtP36EQADkkMxnnzxhF85OywGoMuBHslHMmHtQgFnorMNFT
    61TJWhc7KXq_--iH1ARu-VxhmzohepFBZ9wlRBtNKHBvvExLehJ5Q>
X-ME-Received: <xmr:VOeGam-RA2iGDNI71DW_QWtEl2n9CeFlOWl0-4DWtyuuViZ_fUeH5VhGdfT8v83bq1UN22Npgman-p23_yWY0kJG5U3bVaRgllsQIjsiBw>
X-ME-Proxy-Cause: dmFkZTGS2H/CjXUKd1LOuXSn7c60Ycid+g1KQbzZ+0w0WcL0vQGqK/4KZ25+LOU6uqK2OE
    EqWUxx6bJlCNWJM4Qjy+KCJgx22wjZGTINs3ZKRL+hGmrIWEmzBhAuYjCma925YiLPzS6P
    SlbLJgBlv5mau+HBF/bCU1sWlkza8Jdh/vxIPKOxphv2658MjVJqbC3N18tsyHZo3RcIpp
    9OazjtVWZMVfBFO9R9WNwaA+Nd0VPuNLIwFbNT2oUYvMVRlbIUBUg24/5nbFCuHyr7k/kn
    ZtzF22wrvIx/9gjQ7FGgt1lPXW0fMiNybnZe8yqKHdQwZbuArGaVu8cPJYBsHpYW9p8ZQd
    HUhpdLTqOt4JY7o+b9z4x6MbiCpayS779epLsh4YcLEfF1z0ElkGq/qN/TOXvLb+e5MGfN
    lFL+T+03apk/cF1Bou6yfV+CLWBWQJAs96bBxXMNnvhnffjbKIJFkeXa4pJU67dCwG5caG
    zbe8RCGZY0G12igLMm4myXSQAPn28JwXfkpuW7WqFAIn9R8kB33l/VNqVxpCUF/JK9Bjm1
    Ek1QjJseyW4WVyUQi5CtzNFCdpPU8AvRIfkdD2J52gexWekE1+0dLTPhFwQeSKYsnjW0Cu
    gjzbM8LSipJSrZqF6pUOPyinDaFysbkeEb8lHBkxv3ubZbHmPrzxJl/d54oQ
X-ME-Proxy: <xmx:VOeGaoPQI1gwNBoapPyR_T4Pcql7MpyZPswc__S0f6hKcsOTMFnT-w>
    <xmx:VOeGasE2b7zFf-dKtR4bzaqFdoZ5lOholBWBoyJN2I7iQS_EuL53xA>
    <xmx:VOeGauQPdAIjEDG20zmGXkMPGt73yj2vLQwarYxyZdMNRobTpIjk6Q>
    <xmx:VOeGahvkGgbmxi26mCFiRKLH4z-wr2m6eqLfIs9oOj3_MxVvs1TNCg>
    <xmx:VOeGancT_Ii9lJxJxcLUIu2nd0Zod_tK3a6DUekN5AdUz3iFyz5C2PO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:38:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2436613e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 11:38:58 +0000 (UTC)
Date: Thu, 20 Aug 2026 13:38:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/6] upload-pack: generate packfiles via the object
 database
Message-ID: <aobnT6mmINHBmV4g@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
 <20260820-b4-pks-odb-generate-pack-v3-2-bc42252f6169@pks.im>
 <CAOLa=ZQcZ93R6wRyDiQtyATBNfj_6Eu0zXtEx7kbfzihvyP5qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQcZ93R6wRyDiQtyATBNfj_6Eu0zXtEx7kbfzihvyP5qg@mail.gmail.com>

On Thu, Aug 20, 2026 at 06:24:09AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When serving a fetch, git-upload-pack(1) spawns git-pack-objects(1)
> > directly to generate the packfile that gets sent to the client. This
> > hard-codes the assumption that the object database is able to serve
> > packfiles via git-pack-objects(1), which is specific to the "files"
> > backend.
> >
> 
> Naive question, the previous patch says that only the primary odb source
> will be used to generate the packfile and we added the implementation
> for the files backend.
> 
> Does this mean that this will only work if the files backend is the
> primary backend?

The primary backend is the one that will generate packs in the first
place. For now, the only primary backend that we ever have is the
"files" backend. But if we ever add a different backend then that would
of course implement its own implementation for generating packs.

So at the status quo: yes, but with the added infrastructure it's now
pluggable and can be implemented by other backends, too.

> > diff --git a/upload-pack.c b/upload-pack.c
> > index a52856d869..75a857eaa8 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
[snip]
> > +	if (odb_generate_pack(the_repository->objects, &generator, &opts))
> > +		die("git upload-pack: unable to fork git-pack-objects");
> 
> Nit: should we still talk about 'forking' here? As far as upload-pack is
> considered, it handed over the task to the odb, 'forking' is an internal
> implementation detail.

Fair, we should probably just say "unable to pack objects" here.

Patrick
