Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF353C07A
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166764; cv=none; b=CV5faPFbJTi15NF/ZKknyqLjFtkIpJ2Y4VYhVqLyJGssiTF/1Yas/Qfft7Zs0oenoX2guvgmmSqQC8sPRrNhwaAvFRG+GrcXCyMhGNI/CAtlBbX/OYEvdWUBaKx81akmCaUkqJ08rVSLNnoTMjiBRse+8DMXkoN3hn+oI9s5XWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166764; c=relaxed/simple;
	bh=qowL2i6R+6bzDJ5TuMN0dyhwThrCth78N/oGqFDdIlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZF/ZJvcKznkqnuHX3pDZdU/5GbO52FelvH78V3B0iaX27pAR5ZCD3qtyYWIHw4InReDPRdgWPRYfxOLEgSwiVoj79zBXrPecNl5WjIWfIhHLPto5/zOyPACZpzQR7oPKagc3UErI+UBOgni2rLodmV0fhwCiyua5oZ7tOuT8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cLkUnmrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYSC+wZ2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cLkUnmrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYSC+wZ2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66B997A007E;
	Wed, 23 Sep 2026 08:32:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 08:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790166755; x=1790253155; bh=VnmrsDWQZM
	hdbHBI30Bm+Y0Rd6/BS1Usjv/tCWfpPCs=; b=cLkUnmrCgN7BTmeANbJ97s5gbB
	VX1dscGQR5sWA555ap4LpF+zrETYxiW0IXltkQTsbwp8MhtZeNHG5BmWy2oFWgEY
	TcK16Sgy1Ql1ihA6WOugbeh+T9h2J0HiWJmpTOcjTXKdGz1pBFvWVw5fWFwE6bA1
	d+2xb6WohQIQC8jKekBUbeICkBoVhe5eSLZkEq6Qd55KkighZAWUDkQYoe3mbGR3
	KDJHHw1uVaWTp8at7/zZhr88fxxjuPp/C6veKYcdtSQJA0zzvIGkUwMTSPpDPnXe
	KvtXzSFZAoKSrVcKZrItXqEWg0iDLJy9WO2mQnWsVN+Eohp7D2N/osID3fxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790166755; x=1790253155; bh=VnmrsDWQZMhdbHBI30Bm+Y0Rd6/BS1Usjv/
	tCWfpPCs=; b=pYSC+wZ2ja45chPIhi149dCYTmB5aZFUisijnbMCGVa5bBFmIhG
	XCTynW7Q0QPYWfFPYD5hZNz3qk1Iz3TXprMjEQK3iocmeaOluMUAasqJ8W/RDJx4
	9+SBlwrMlmGlRj3IqLCJmq8h//ecGBSV3AxCSHyCMh+FMtT+GapnH+qKOqoIVfmK
	YSocI0zC9IgIITzgYFVAkP/Q8U7MSkQqngUQhGuMT+iJAwn4gFWx2Oq0pNDGQuzO
	z8Ddxzp5v6C3qWfv+TkEEZwrIrvJFJRSXr6eY/zMBZx9b/g+HWtSHHbbp6uReShI
	qXm6qkVT8JDvyTsxdrgI6g/+Hoa22Oxbw3Q==
X-ME-Sender: <xms:48azag0RRCKqKPAfmUSjiC101oN0sSBN_UNvvlRRFXqYx1r87Amriw>
    <xme:48azaijoGm7aKq56iwVEtVlN3CPSZciZbsOiDexEc9yo6Iy3pDmuREn4V-vN3IgPV
    qGVo7dWc6p0FA6augzLSAt8KNjNS8LliHu0kddtBT40HTOZhU0aGUsx>
X-ME-Received: <xmr:48azamTRZverZ0i3NvfuiuJnVRJwM6bW9YSH9fnGVA2k0du1IaO9cQ>
X-ME-Proxy-Cause: dmFkZTEA7kD/ocoaBQWTrrPcbvWRE4CwRbVOHMGjbQ2ThHnCNFcwRdkte+MKtB8D89e1F7
    2BEC4yXFDZlPJ8x4mgq868RvDGhMtpeR6nX3nTPBOkVMFFlDLt/rHyvp+U4vfMTQR1k3hx
    tETODjhYf0URk1umI0wbVjuWyGmx125g+xM5YTPA2AWrjpHt0dc/KQ2LJNIG19UiME3tzm
    ghMRU4vzMLOumNHFPlagONMyII2g4b0bgvcwp0zO4BkReaLGKDYIXcQu3sLANVDNRtXZsf
    +fSp8/Lu8e/DNoVgdkSSoV6eYc50FkTSGVCI86x4cbXK6H/Gc5OeBRGOesTPj2j7p84qIt
    a2gUYSNLbphDXaCIzxz2bXWdV9DtHaw3+2sq/e1vYUVFmt9C6dIAOWWSRW1MbE6pJ4sBcZ
    RZTN4osh+qHboPQQqwT2oCwn8LPPjmS0m6XhpxZ0XADUzKyynOvTszTspJal9StdrB5j/e
    GYOC2UFN/sg3n5g/w1bGnW0E+8Ce1M98CTw2HJnhQhCb5sLmaj/gzbIHfG9A8CMhB9DWG9
    /ND8B3lO+Tgidp8PYXyCcflMpk/BS5zqJ0ybRoiFrHFnEHG8k1w32/nOQe5H8fSWII/h7r
    7G4oxZ5Dofn0mDeR1NFkcOSL1wA2hqdKgysfwnX6Zl/8IUMBPtINVEjVqtvQ
X-ME-Proxy: <xmx:48azajiD4V_sbjH48MhHC7_Hne0xzHkA-xFjO0OFQAWDaZHdV64pjQ>
    <xmx:48azam6q6mAgy2YiE6ivnlRYdLtpvSNTphWsFTKwwHAhkZinXL8H_w>
    <xmx:48azagDmAqWwrhyjZk8bjywUftAPQuUWPwdBvfM9dllVmNS3lbf35A>
    <xmx:48azatb3slJcxqBCcmPsbZ7CoN3k7DoAdYqvtcInDpsoCOrAqYCI-g>
    <xmx:48azaiqK9bYIasiojdBXvhcBobeZ85UOBlMYN7m6RIZlDgfc5YR61BrL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 08:32:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 513eed0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 12:32:32 +0000 (UTC)
Date: Wed, 23 Sep 2026 14:32:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH 1/3] imap-send: prepare for OpenSSL 4.1
Message-ID: <arPG2yDxeVTPwpTg@pks.im>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
 <20260907211210.2621693-2-dev+git@drbeat.li>
 <ap_GvB8Lonkn0nEy@pks.im>
 <872286d0-7786-46cc-b26f-16f6d487e608@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872286d0-7786-46cc-b26f-16f6d487e608@drbeat.li>

On Mon, Sep 14, 2026 at 11:10:36AM +0200, Beat Bolli wrote:
> Hi Patrick
> 
> On 08.09.2026 10:26, Patrick Steinhardt wrote:
> > On Mon, Sep 07, 2026 at 11:12:08PM +0200, Beat Bolli wrote:
> > > OpenSSL master (to be v4.1 after the release) renamed the function
> > > ASN1_STRING_length() to ASN1_STRING_get_length(). Map the new name to
> > > the old one if we're compiling with a pre-4.1 version.
> > 
> > I can see [1] that the new functions indeed exist now. But it doesn't
> > say anything about the old functions, they still exist and don't seem to
> > be deprecated. So why do we even have to switch to the new function?
> > 
> 
> The very page you give below contains this text:
> 
> ---- 8< ----
> The following functions have been deprecated since OpenSSL 4.1, and can be
> hidden entirely by defining OPENSSL_API_COMPAT with a suitable version
> value, see openssl_user_macros(7):
> 
> int ASN1_STRING_set(ASN1_STRING *str, const void *data, int len);
> int ASN1_STRING_length(ASN1_STRING *x);
> ---- 8< ----
> 
> We also don't define any compatibility macros for OpenSSL, and the build
> failed because of the deprecation warning that was turned into an error
> because of DEVELOPER=1.

Ah, I missed the part about OPENSSL_API_COMPAT. I think it would make
sense to explicitly point that out in the commit message. Thanks!

Patrick
