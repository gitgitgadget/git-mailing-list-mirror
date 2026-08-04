Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5E3CFF66
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853879; cv=none; b=L7x0aQJiS0XGNKmvVFCRtPugMFWkFVL6WagYle2ftItmZ8E2fCwQIr/Y4PtohVV0dyCXnAPF72cBS175vs+MspkUcRSyLI06uXPFNI8cU3poK2IxLlvGcx4WM2cAilHN1sM5wE+J9D241m7DcSC6ki4kWQwApqoxM1SOVqc78eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853879; c=relaxed/simple;
	bh=tQCB6iCLzOglmOLsKiNlUkh/j3ZAkMN7bQ9XFxPxjgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkrDVYRWVbynIH7szemugREiSuJLDs9HjWEQvdTvpwPiA+XAJ4ou0Lo9drZ3K1u93rHqm2BBY9fyLMMrGq2j3/yh8vPB4vgbfTLFmUvYhGCHJpKLi47xftg0XRFV1dlnPfSWbWOJ50R4bKmze7v+PW44SnMbeVktVe5ltF62MRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iSse2QoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjI9/y2Y; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iSse2QoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjI9/y2Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13F061400131;
	Tue,  4 Aug 2026 10:31:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 10:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785853862;
	 x=1785940262; bh=69nWiD7hCBvTcCpYKumu5x1nhif9I3nPeCUEueURV6I=; b=
	iSse2QoYJPzdPORogeYv09Txjl+sNwUPYWCIusHN1kgX3koNuwSzlKSxsEUlcmpr
	GnQZwMR0twnMgkMetBD+ivOJLAD3yJtVBvwcGsKsgsekMoOb2X9qDP/GZ131zWfT
	pO61YoUbDj0X3BN/LCxyhClAmArWoXH66nmv46raa9hyceQbgwElq/66CvZQIk8o
	cLm86fE2j8xxpl6gFB5+242eImMZPKuA7/jHMW+24wCvfEIUifPLZXCOG3PUTFe8
	qj6MfXGI3/BCSbfFUYg2Hvp2Ni334W5EXkM7NC4yahuSRHxVnr3yOv3WzuOlCDve
	nTZWf+XVTfotFXK8k08/tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785853862; x=
	1785940262; bh=69nWiD7hCBvTcCpYKumu5x1nhif9I3nPeCUEueURV6I=; b=B
	jI9/y2Yu2UBC/Ra7Tl/bLlB2gMJsNPeJ3EBisGQUmhKDwEdNZkyoxDTgTAIjJRU0
	V2mOC+bM59RJVHLuR7EITJ0R0Wes/h1a4S9cZvqeSSf3U4ldZSg31gGN00apilTY
	dqxyKsKq83WfpBfo2iilA0iZSkP3hGoj0zGfEtOWD4a5w01tpQy6VyPjfmc+iRVK
	00wfURUVbRTSzVZmfyhk4Pci9JvlsY+8KFV9Ib9V4EckNBPG4ImLjptBKXH8YNHR
	Ur/rWUleMPi4NhQMh+XFcBLVF7I3hw5ufQCQlNx/DolR8usdROuTSquDgaxZHEH2
	w80OmfXxgXJexeZZWMcBA==
X-ME-Sender: <xms:pvdxahoITEwfePZdnVPMLGQqn1hAXAWSWIwKHde_W7-eINfzzfIq1A>
    <xme:pvdxaqi1y-reUMLFfTkR9DRc7RqdkBET3P-II_i5iHxbgzJIVkB0Y_xTaQIJ446hL
    pnNFLqjlkqdhx6wepGk8W_Lmy8daAa6sYrdSA_lXezBE9dcgAuZ9A>
X-ME-Received: <xmr:pvdxamjb48eba_WUN-l874KJg2kHfoCbDvv6LA547wqboWICdSWbxcpanmS9n7EG0CWCJiksIK7FZb3I8iVn2Z3sFtpGRuakJGcnugkL>
X-ME-Proxy-Cause: dmFkZTF3Brg0dI3QO/zTnnmlrjkArIpQTLaTXUd5haVI+Tb4s/YBXEcA1i6lJEBW6de3d1
    kqJJFo10gijIskv8Fs2VUzlemUXXYuJTicQ3JNWOLyR2b7AhqYs+5iJk6I8hBCIvAoRTrN
    63JEvj46eo7g4kQspd3mBjMHcthc5fXQReaRzK2h1GboGFK17ZM14MS3H1BAH1J5wQSP8G
    FLjlRaVV9r17vMfqrPoEnOEN9gzAMHivA1pWOpJvULf9DN3nbcJyUEb4seqGGQEjbmKoJc
    k+YJDJFs4+hYVXCvTkx5wGl++JVCVL2rGiX5hNxDTKeXTfrZm+pVDIZHmeXqhkdTl43Zd8
    L96qU4sJ6PWrhMkJAOREMoo7tFuSRAbuLBgZBXxsJlhHKzwIjFDzBkaszH94TGliAthGD3
    RQVjxUKMsQFFdkniUtiqw43ERM2/q6eODEgCE14PtRyvYYqi0uBeKy8OfUSoN/TdQl/0dl
    GuPimIlbC3r1FscOaVFU1hqiM4OU4rlznP3abq/IoXgiSWOPOcpbPYAkSVmJtxdOAUmzgR
    +UsQZ/OW3m8cEuaM0W7IifqPWxgwGTtLzJZnqwGH9BiVEQOaHkkEt6Ayts+szZ2ICFBzf9
    0clRN6rcnqBXY08PL+laNqUPbPOGlS8D4+RiKaN7RBvoFhvsRgJj4AIV9NjQ
X-ME-Proxy: <xmx:pvdxaogFpcwKSK5pCoZMBz2kv9d0D1CYx98gUJQ0Fh2VLGAnKqaeZw>
    <xmx:pvdxauJHsaNTVc1KBQpsafKUPQiYYLrmbj0_ieT9vHw-LPK6yDqjMQ>
    <xmx:pvdxavEAZT3kWWcWfhaR6MIdUQsYC7L7RXIeLebvt_2Pyep6ipOGCQ>
    <xmx:pvdxaqQ0PxXN7YM0BsJb01GKB7FKTZu80BpGxYFrXSkk6RUz863QQQ>
    <xmx:pvdxaryhpluSMTm9wpvppFsRGjHix9EwTTDO6joYTTh1ZvJN9_4Shh8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 10:31:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 68d81ca4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 14:30:59 +0000 (UTC)
Date: Tue, 4 Aug 2026 16:30:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/2] doc: refs: put ref migration warning under the
 command
Message-ID: <anH3oN3JRaG1eEfK@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <xmqqbjbncdv5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbjbncdv5.fsf@gitster.g>

On Fri, Jul 31, 2026 at 09:39:42AM -0700, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
> > From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >
> > Topic name: doc-refs-migrate-limitations
> >
> > Topic summary: Put ref migration warning as an admonition under the command
> > so that it is visible.
> 
> The caveat only applies to the "migrate" subcommand, and the new
> placement gives us a much better logical organization.
> 
> > That’s the first patch. The second patch adds a missing `linkgit` since it
> > touches that same warning text.
> 
> Looks good.  Thanks.

Both patches look good to me. The indentation feels one level too deep
on the firstr patch, but this is a tiny nitpick that we may not even
want to address in the first place.

Thanks!

Patrick
