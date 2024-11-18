Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6017597
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912195; cv=none; b=i6ErjWyupg/k5a4+KTwlANrafoykVaCCdTr0uL+s+gAMtyTcXvxnVH0n1StDTq/GrMG5v7gWZCIi3Ktwrd9a/hO+bJEZPKHHc/taVNWqsDIFARoDcFykbpPRNlRezOgSgWtlhDlViY2AyVr1sjqhdixYq892xE937mt1BJqQA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912195; c=relaxed/simple;
	bh=PsHDXaOnOvpbS8ZRilogP5w4HN/MQrMgB2gHj5eBSfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiAIwNLdVbZx3BahuFsPop0E9hAS8g82xT/dlCEIhb1GO7LyBeWxpxfW2Lq4uVSGCeEhi2owcPug2c9DqOjP514qkUfFO0zsuD4yUiKksTwYGyR3uAmtlRNAIusAJ+NbAMObZgF45VqAA5P+yZLXPd8ZGUfEDWei81QSizwjX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e1pga9xh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYVA7F7M; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e1pga9xh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYVA7F7M"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 845281140122;
	Mon, 18 Nov 2024 01:43:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 01:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731912191;
	 x=1731998591; bh=MPaYVofita9XguIC04iPOsFC0N0Z33/96Se6dAqwEig=; b=
	e1pga9xhOx2Pi/sm85NERcvxrfPrWl/VkqRgr/s4xi5G2xvCaqEuT0QU8PBhumhY
	7h5XsC+hdWwQ76g3DdU/STcLSR7NAbBbOmtOA73HW+GcUA6n73c01jviQvLQpHUo
	fXNF/CFinbjFqydFgef4YLklOFReD3SyKMClX63J2sRSRO6Q+4f6YDqJMfl3uvbj
	shaEbqTy+Gg5g0GNZejn52h4aElzn4F6QLEsOdmJfX7tGArvHB8YhI42OrsgryVU
	ov8hKMCQRxiIVd//xzimWdYr8NNls0TAvlWN+Hc5XhilS701OwBIgh4N2lUqaC9p
	YVxtEXSwbf9n6gGkWc3s5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731912191; x=
	1731998591; bh=MPaYVofita9XguIC04iPOsFC0N0Z33/96Se6dAqwEig=; b=K
	YVA7F7M/YtB7RAIuv5sfr85i6LcVhklWCs9eSXPNMjesfAtnRmPySc/HH/bDzbsV
	0aOYGJUriwWM6nLKmuI41TBU5GLBHOR3Ql/vOFaTNBxI7CSCCP5Xg7gM1YWQAIQp
	tUVChCMOC2UcsvnE+9GJQSDwbwLBHhAEApuUpmNv4aWw+5Q4pWTD7BJYDvSAY4Cx
	xjaJP8YGoecCgyHP/aFCWBZPJxW7IfwwGUYTeMCGBXyMxvuoTdJGV/QPLcQFjrrs
	EOKoCa1u1+h/NNOT+fyL7PLdFvNfx7BnD4k/RG+v047pwBpW5dlB1C4DkqPW7xvh
	qo0OUnuszcspIJWyb0g5g==
X-ME-Sender: <xms:_-E6Z1lb9Chge0sSTreiIQ2HZLuWyZvL_Tdfon8L5Wy5N60aRcUq2A>
    <xme:_-E6Zw33HqbHpb3WE2TTtRMw1-RyCgiDnAizv_InCG1zxKKFyKbsZSzPmAbCuczJU
    vJeEbZHKqMUnR5QQw>
X-ME-Received: <xmr:_-E6Z7o2gYqXrhnP_1G9SeClkpYhQrdXjMhEHuGb62VS13WXbSq-rz2297DLQkHIby5Pb5mpkuVIKSjVwpVLPJwmDnOQtMB7p1Mvt3EWRQGZJe_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_-E6Z1nVihRkzLa_kRHKGOD4Nnf4RAjUeCR6X7jPus105uOFdHiZwQ>
    <xmx:_-E6Zz2RGpPiIlITB9A_Vc34JL5z0Gl98He6ybpkbOXd7KS3PXPH8g>
    <xmx:_-E6Z0tB78vzUiBzxoNfY05biOv9ND6dAoCh6S4msT467QmDd2HIxA>
    <xmx:_-E6Z3XASXdqgli5SRv0X9eyY7WnJqZ9S_OXunsgsxcFk-AN4c34jA>
    <xmx:_-E6Z0xl5M3pXbzpsTi-yX785hDLl1h70udQJK6FS4B_zAzzahveE-IH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 01:43:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e82b5700 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 06:42:21 +0000 (UTC)
Date: Mon, 18 Nov 2024 07:42:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
Message-ID: <Zzrh6xlxfOo9q9gn@pks.im>
References: <xmqqy11kys9z.fsf@gitster.g>
 <ZziAy187d_VU55QM@pks.im>
 <e540c259-df6f-4b65-9066-606beb462f5b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e540c259-df6f-4b65-9066-606beb462f5b@gmail.com>

On Sat, Nov 16, 2024 at 04:37:13PM +0100, Rubén Justo wrote:
> On Sat, Nov 16, 2024 at 12:24:02PM +0100, Patrick Steinhardt wrote:
> > Rubén's review went through all of the patches and his findings have
> > been addressed.
> 
> Yes, this iteration looks good to me.
> 
> Two thoughts about the merge:
> 
> First, I'm concerned that we may not have sufficiently documented how
> contributors should proceed to prevent new leaks when submitting
> patches, and perhaps avoid some unnecessary noise on the list.  I
> reviewed Documentation/SubmittingPatches and didn't see any mention
> about it.  Perhaps it would be helpful to add a note about
> SANITIZE=leak.  I'm unsure if we want to be explicit about this,
> though.

Nothing really changes with this series -- we already required code to
be leak free beforehand, just not in all of our tests. But in any case,
providing pointers for how to check for leaks somewhere could be helpful
indeed.

I think that can happen outside of this series though, also because I'm
not quite sure where to slot this in.

> Second, in the (hopefully) exceptional cases where new series discover
> old leaks that cannot be fixed within the series itself, for whatever
> reason, I don't think there is documentation on the use of the
> SANITIZE_LEAK prerequisite.  Its use is not desirable and documenting
> it could be counterproductive, so perhaps it's better to leave its use
> suggested on the list when necessary.

That's also my take: we should use SANITIZE_LEAK only in exceptional
cases. I very much hope that we can avoid introducing new cases of it
altogether with the help of long-time contributors by helping newer
contributors that happen to uncover such a leak.

I guess time will tell, and if we see that this needs to be added fairly
regularly we can iterate and add documentation.

Patrick
