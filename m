Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAE53A7
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423365; cv=none; b=kfQ5d198UEa9HBeDWaib7g2Y3s1N8IK6Z09F1WSImZze+aY7Se4tPUKadaDgtsQxfekyMMuNJYD9LIJcVjlx2GT04zZfqHbO3Sf4RsOm2G4sUkSrD6BC1SeFX/puKu2e3HnhWbmlT6gwilgLOgt0kwb++qDjR2hMkrnH20XY0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423365; c=relaxed/simple;
	bh=VtqFKrwIhyS9TZHdXchPyjje96S+qmCyVSd6LLan5pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFl+vdEGNzJPFknGxDCRqbAbEfOHjS7QfUksFjQ9MGVd/4LWMhOjm9hX8ICoVPXCVj6v6Wt2CI1i67jjMzu0EuL9Gx/DwYKUE98Pi7AVWhgl+gMk2OZ6lASWmktWYCqqwRRWCrSV38x/Ko1/NQEpZrv/NjoDrTHcqrXiQCPiX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EucK8I1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHnleKje; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EucK8I1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHnleKje"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9212D140031F;
	Tue,  1 Jul 2025 22:29:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 22:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751423362;
	 x=1751509762; bh=ZOv0OXo5xvdZYOo34vDiAxWEd8F+vyWXTgDUBCjeMvA=; b=
	EucK8I1uomZARgwo++wB2pfAfK2Yg5s159JJ+K9+lsmEpgbx8d+2woexB2JvAVgg
	Kw7h9lU1wmDTTiSwsSGvX9uhoDBfC+h12mNqcGI2uDDeWas6KJU55Eg7hbCVp/ue
	sc1poxaTe2iIPMkCtmUCQGsh+046CjaO+dMPuv6cvtF9Jksy01T7+H4TNA3NvzBU
	OmNOHf9ut6MNUDkArR0We6vQKb9T7AoVUfzxJqcwqsmg2Qt+K97AoIcXgCfauQRa
	BDXFO5YM2UNm6bsQDhe2gVGTgjnygtD0aVCJlOLzxEVLSAYyzRbk8ZwLdmgOPcvP
	GTD+YPvumFeYsmLHzkAxJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751423362; x=
	1751509762; bh=ZOv0OXo5xvdZYOo34vDiAxWEd8F+vyWXTgDUBCjeMvA=; b=S
	HnleKjezIZUbbYu9pofj1FoPHgQeupWtLl7dBfsG1K6svYOhG/lya3v10aOOX7kk
	A5pLW8/oE8bLh5922sGXfvs4b7sLsSuWDEw25kJgMuyX5LCU1E51MLORx/RSAhsG
	qKK8zQLew9jRY6A/hDSPtXl6dPeDvAynx/0fV/UFvC9FU5+JxGrBpRLFPD7YPMlm
	kEFtIy9CkgghZk7eZnDMeakI1t8cQASKNPN1xytp2yTd72gaB2B5AauhT6WQDV3n
	ypkta7j7DS9C6koGXt22M27iOmJ3RIbaqvSV0DmhIsxEArD0V/8zdOA1XeUd0Cev
	IzCKQV7uz/vfVr+7zH2Xg==
X-ME-Sender: <xms:gplkaPyaoN_oNjfOney3gu8ZpQySavjnmbkcW1nRgRsT6X0ytiN8kQ>
    <xme:gplkaHSB5jJGRY5LJJ74XDWtV4VIsNR8mMkNLigJunZ697TiWee0xE6HejyYdLb1y
    r1DAZFkgDDxkc-X0Q>
X-ME-Received: <xmr:gplkaJWuw6oLE3yG_8ETGlYyy9ihuCpRwZW-EDCPAMRyxAL7fUIE_SAK8XSDdkOoKvGrj99gciT_KLX8T2V6g5AfhIQ4Om2QnZ-ae5qXmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:gplkaJifavBOx8lI0Gy1QSMBKsX1qX3vWRWArgB8KXDYAonwPMvQOQ>
    <xmx:gplkaBBILFUdslNr8cBkchR8fHluAGiJZ3fe6SkDf1-yoAw2UrUzqA>
    <xmx:gplkaCKrP9wI3Xcryd9s6Q36goRXNx1gVomiZB-b6Vu4JCiD78yZDg>
    <xmx:gplkaAD70aypGpvC8pGMgoq8uQpJ5PMPoBye0fTfae_CjmWOUYYOiA>
    <xmx:gplkaDzjSht1bFfvpLgSn9JRgxa50Er2OcEGVeAcl4kx-2IfukVtooVm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:29:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04b2fbca (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:29:20 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:29:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] parse-options: add precision handling for
 OPTION_COUNTUP
Message-ID: <aGSZfP87vAillq0x@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <7322758a-9310-4892-b476-50dc57d559b4@web.de>
 <aGO-nSyCN7OD9Zae@pks.im>
 <591d618f-1b86-414c-8069-3621e00add74@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <591d618f-1b86-414c-8069-3621e00add74@web.de>

On Tue, Jul 01, 2025 at 06:01:44PM +0200, René Scharfe wrote:
> On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> > On Sun, Jun 29, 2025 at 01:51:36PM +0200, René Scharfe wrote:
> >> diff --git a/parse-options.c b/parse-options.c
> >> index 0dc9b0324a..0dd08a3a77 100644
> >> --- a/parse-options.c
> >> +++ b/parse-options.c
> >> diff --git a/parse-options.h b/parse-options.h
> >> index 8bdf469ae9..312045604d 100644
> >> --- a/parse-options.h
> >> +++ b/parse-options.h
> >> @@ -183,6 +183,7 @@ struct option {
> >>  	.short_name = (s), \
> >>  	.long_name = (l), \
> >>  	.value = (v), \
> > 
> > It's a bit surprising that `COUNTUP` accepts a signed integer, so should
> > we maybe add `BARF_UNLESS_SIGNED(*(v))` here?
> 
> Perhaps, but that would require more changes to callers that use unsigned
> variables than I can stomach.  That's why I declared it out of scope for
> this series in its cover letter.  Later, unless (hopefully) someone beats
> me to it.

Fine with me, thanks!

Patrick
