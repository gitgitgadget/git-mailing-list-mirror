Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72035CBD6
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315843; cv=none; b=D9RrWlRfpX91CIuz5Jf5gtma1ZMFvpV2K/5JeCbb6RXQJRS4l/b7s+w4gz1Ws6iDTF8oGtXE9JgDMVMX8+/rR7Q8jL4AWkX7hm0hkeNuVPTqvxaGd5zxaK5rnCBwn1eHzKG62hn4c0X4kYP3O1itH9SM9PR/IMtHOIkODrLAqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315843; c=relaxed/simple;
	bh=7gfAaNKA+MxwB1cVJTzXNA3R1HS4dSelv/pkRvM4tJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9FCuSyMXgbDhAM1uNCgRnUEbSVP9ATF8rUqecQBoGxJWxndj73skUdfgvAm8hkX0547fKOSJZsabA0OmHTipE2wo2D26cXFjQs3soNsM1/7jaTAF5Qz2qnMYRdl8/6ylluP7ZfimwiKCdkThK0x7JnKrXmCuv+uP/BCYG4A7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=COSjkllE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejXw6Ys1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="COSjkllE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejXw6Ys1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65CD314000E9;
	Mon,  1 Jun 2026 08:10:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 01 Jun 2026 08:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780315840; x=1780402240; bh=y9cC+kCN2Z
	4dghcnJ1EYKeIhH04XLmHQM6XlWxIHEao=; b=COSjkllEOcFZRCe1UcRBVmdlX8
	WjQQCBUT9M+qV/YB244GR2JGxauOKnsTAZFma19MWP5EjnkRNGbHwBg1/RnG7rJ2
	hfw+4tMyHbg0+QJcJv4awFdu/HAX73uyOVTmKTJP051/ZspEdpDNOFH55RtakGkx
	Ij2lz5WFTUF2lXPd0NVBhK5bM9xMZ0cOKgRjecqpfLSBDVXSfEq+3iG4cDt/DP0t
	3SnzJXXy+o84Mnw8iqOffFZTdqhy362CECaMAqVTku28VD2+rgzP75Qgfhhkwted
	jciFeOt4Qzd6N69zgQv54Fc7uNVwzzDY5G2OP3LzU+/o0x3bwJbvFeplaA1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780315840; x=1780402240; bh=y9cC+kCN2Z4dghcnJ1EYKeIhH04XLmHQM6X
	lWxIHEao=; b=ejXw6Ys1pHntx+4Ji1koz10Nosssz9Q/0diLTgLLlTqCfGpqT+D
	kFr4C8qBbQH/VINJyCxp3Ebj4fo38wl1E1X+YST1BlpKW6KtmL9xGIuQmr/1rDE1
	O9gR8zXJIxnhcYSvlO/ROULFY5JpAAx+3jNSDwJhiyeIPxWmqjwBLzFwpEsvs6Aq
	4qWF8qtgF/3Q4VYWTG8i8/hA1kuXBgtF5JrIFCa3oDGq48MpJwfgasPgxIdR3lkY
	GZrAjAicykOcOf3y5b+gnCs3AmtW7XnosPfF/RwaDN0G2N0w/oiFv4Yox1MV+Qjq
	VY3BZHiHWAT6s4Z3IQ7SyP3bT9zb1IIu3IA==
X-ME-Sender: <xms:wHYdall2VD28lGca5an34Nd2aOceSeZikIchSOOVetW8WE2PH1hKmQ>
    <xme:wHYdam356R_uzs2ZSbUuedJOv9uoP2aK4GP42lRbnXZ4sFQLxACSA-k2njH4uK0hz
    pC8o0XQIt4v6tRPnjY9VmLHeKEwQ-D4t-TqfHZ5zZtEdVn__1VE>
X-ME-Received: <xmr:wHYdapQXfHeQlzWKX82G2_P3CEHM49IsNbVvdvoaOY0Gu555v7xd_Jr6FFmmz0vins2LiNdPmJRILN6-c_MXKWjWL1_TpiN17fuQ7iz7Sn5_>
X-ME-Proxy-Cause: dmFkZTE8bYz7R3Yub0XMEuDj3FbHz8nyVG5lVGR2ISJQMKfE+TxwPcIyZYzwymc4zw//LR
    8x111D4Un5b0gTn8W7w/EIKB0nTtrvoRu0HqQXgPn+BZzIctbf6ewmdY8k4s0MEuW+PQvG
    LNnM111A0y0SF+g3opVY2b1BVZquEFevj8xzJdyP+EsDBqmILbHz6bD6vKpFfqZQIp6uuB
    ZDqZ0F/mxCK1lbFVnMYyFWo80F24Q2Vitqm/AaeVQ8n3t5RR37VGerT8W0dalrmMj2QJqk
    B4gde0k1fNESIrOBqxVKt5fLRE7TyxplywGtznO15kiMHlpd5gDZcTEpatGIM0FcAqCVIf
    dys/SCgO0MURP0iaHc9yDejLzasPW/35/LmsZqHpweEV/m3Ovm8FXKxRieT0ZnmEHurvMJ
    NcD0EpYR3I+ZV+v+5R86TO+TXWYNWgMSVQAPJ/b0yV5rMD4Fpots2jBQ0tj3NGE7sx8c/y
    mEqcIMSKQZeOVSaEC1YpfjkOpbCbGEuCDGzFJadmDbzzksulscGznQ8H9VnRJ2DOGk71n/
    V217jOIh5gd249Kcg9bFsK0WAcaUpvMaJ+X51UW3V+UU4qsQc9ZgdnaaMxBEkizS5NfTfQ
    elMwpdP1PLMwn60DX6kqXyfxCPzknR4Y4S2B25GiR16+vkZM+RR4crbU7cLQ
X-ME-Proxy: <xmx:wHYdagtLT5ku_S_TioZDcvjSfLTGZQwd2m62jw7WsZ2C7Ep2F3JDGw>
    <xmx:wHYdamZTGSZfNH7739lQ-vlPoZGjEtBZ7Hm-RAzWum56xIkKSHmpZw>
    <xmx:wHYdatsRVu2NVJc0EP818Z4-n_J47YexTSngTCpDYMlhiWoa8G06Yw>
    <xmx:wHYdagEPKZ2z9De7RQIQAjkKEl6tar803yXlaErjxPoyjvy_aV6BaQ>
    <xmx:wHYdag-liPH6nSFEggxJT2G-qkrPofD4pRKWjYR9ogWkBUYsACQ85up0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:10:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b81a0449 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 12:10:36 +0000 (UTC)
Date: Mon, 1 Jun 2026 14:10:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah12uk7IFxS92OR1@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>

On Mon, Jun 01, 2026 at 11:31:46AM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Jun 1, 2026, at 09:56, Patrick Steinhardt wrote:
> > diff --git a/git.c b/git.c
> > index a72394b599..6bf6a60360 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
> >  	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
> >  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
> >  	{ "init", cmd_init },
> > +#ifndef WITH_BREAKING_CHANGES
> >  	{ "init-db", cmd_init },
> 
> This can be marked as deprecated.
> 
> 	{ "init-db", cmd_init, DEPRECATED },

Ah, indeed! Added locally now, thanks.

Patrick
