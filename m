Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FFE3EDE67
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563918; cv=none; b=HYAf3fq8ubKHCoFgFazdhQChItmdaHkWX1kil1kqZSqNfsWkN3MsEL++QHS8xw35OakGW+etvez2K1WgUPOz5DAV/kRSAwPqanBU6I0dVYqHM41wXIfSLqj0AX/noMWIfUFXvK42mkJDemrmG1lWsU8W1YZj5bYCpUi7GS8dqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563918; c=relaxed/simple;
	bh=bnOxHyi7N7kxAzHqS8Xr5UcxEM7clcaWp2eza4/DrrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlicfHuZhNeWguh+ux23h6sK77v5VHlo7l6lNZPhHxUL7R1io6l/eCc6fQruhIG3sr6Q9qI1dPS58tp741b3qZt5L9svAgMgvPKtldV5mbAIU6Zu7RUXhzkJ1cOq9kINMYzU3phHdQhiSFeTNM/gu2yRbUmry4euR1TXdfa64Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vqFwwUAj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EhAUeNq6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vqFwwUAj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EhAUeNq6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C40F5140011F;
	Thu,  4 Jun 2026 05:05:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 05:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780563916; x=1780650316; bh=ZN2AxtRm+5
	iTlwkSrKu7eD97DHqwSF+V+VSd0xI7isk=; b=vqFwwUAjPDHwTqPzdRWWvP1aRt
	9pRFo5QtJoiNW2vmPABi8SaOalvqn8t0vj8g33qOczyWB6CAlhbt6SrIkjgX0Bsc
	2SLyJCbsHY1BjnDrSOsxwPXLgRm+D/V7mE/OmQvcuOt8sni+7ANwtskuQcZ94PGQ
	tVhQbeJjfsHHq5ZYXyCoc0cvdOCKxmx0focKHHUVu+hNEacP6xTyFw/lVOgRjohh
	m8gIK3SsHXq18JKFsD/Wpcb2I8lG/digABFB/QgIf7t7Dv2VQtujHILeujrStzcO
	YRf0h/q/iEza3mcxEbYWdEPtcKk09rFRuS/JXICvJtdBhurKNKGxwza07yDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780563916; x=1780650316; bh=ZN2AxtRm+5iTlwkSrKu7eD97DHqwSF+V+VS
	d0xI7isk=; b=EhAUeNq6vl0v0t3ogfByfHWb036OBj4udnB+Z76KQE+6iyY1MYk
	AfNTVMpKgcrkBltpW8HQRN8YcNk8ECNZtTc0o2TCamxvhYIH0Fw0qjPXdUWCADTL
	QYeQRdJ892U+1dOuVvA+EPvJbhsABDF2fAUj48iIhiwHaKnt1x9efYEJjIpGhpJp
	8ZVVxUyQPgjDoWtn74yCNf6c2SEze6J2YD4DCzZoIsTDJro7x3SL0U+J/g4aNDBl
	rfhYf/2p+FcpB80bSoPi7uGUb1ER0WaWzlDqTSUC371euo/yEnh96KdTSdAzgZ/H
	gmS9ZKUNj7u/JUM5S+l4ciuww9P1iPRTPYw==
X-ME-Sender: <xms:zD8halbD0_HPJpJLhJWGdCq0vb2tI9T4SVdlMfEATKEKazETUaHDTg>
    <xme:zD8hajYwIENKql4heg7R3R920E60K_QsGDGf6HaOv864LzyKSCWvo6MIxvjtsvjX8
    HwiX8C1tdgvebtcUo2m-wxabbIQdFkA6yvyRj9ijM5FItvYtdlM>
X-ME-Received: <xmr:zD8has8YtzOMrHWLnfEGQsTjMyWuPth8_ImM5jJFP9YGcfo8z9oMsFqqxGTI3_UX-alwexgrSdw-WBGUfVm4OeGIzNsybwfEKMLZdTlqqP0>
X-ME-Proxy-Cause: dmFkZTEvkLzGHAZJgZFOjNbdHF5R9wyg9G8yBpvHjhcKCO+x6ER46TQe039xFnGi3JLVUn
    ApjJYYS9M80Cb0yiGTucablerUGmYy1TGEQpFCQwnnfm0+hSjsuQsyfK9BSq3mBNckNKh5
    sLP3QpdIzlHmoxvpIKctkUHbFTBovpYkQsR2ZBtzFoR2cWMdFFjL4KHjw6EfXRiUU7ibuO
    ZVg3SqT5rtoaxSozCEj7HW8u2i2PcjNr04Yl2BGweICIdFy+aLLCp9yEarQ4iDo05bMWjx
    cQXKLMYc6NyE1bnk491Fnn8kXcSQ3Kcn5HixFeTAmM+R2g4kd0ATc7FA5OftEAhoHVKQtZ
    F51eBPTF1ZLOmwG5I1I99tIhcGuCXVsCbcEeKoijeXs7rHQfXqV7Yx/14ESdD2X/0J/JCq
    7d2DgCWULVepkeIyrEN52k6NKfv1AIIPgjfgjtAJ2G3eHkSfh/cTxofiE1evfrTNJg5SWF
    WYe+vp/bnHP+0VkWAz4pKDVMK/QdI/ckRZtamnvzIfdU5sDjwB/MqQQTrmshPDPh1gPVaR
    B8EQDD6SnasYM5lQOWdVz39s+LIsIG31rjV4r9Tl0wKF7dkE+XvGVrFg49thjjE6zSbs2P
    50Cn9n+z58DTjHfdHN3fqASuQNfof0S0P7FYnrDpS//Sx9se0RXNnbdWZBfg
X-ME-Proxy: <xmx:zD8haiiYM78X-fVWxArvOtOCpbjpHr7BbwQK0IUGV61Saa76DgQ4vg>
    <xmx:zD8hasfuzGVFfpJjm_F1BMHs0IMbqn5QUPAr57x3eZ2r7scisqwddg>
    <xmx:zD8haprC0napxehsGmQppd7yIINaHw1azh8VJR9K-xoEwkgyZntrkQ>
    <xmx:zD8hahBLdmwiI4q7mbVbkpzvwW3u_dIPyTuSTyWtrtExuGjJ0dvDPg>
    <xmx:zD8hase3tNhktSiMqBP4GtUDh-xeRUdODGCpn9KIKBEIGb80tP9Ev6RA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 05:05:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a1f6045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 09:05:14 +0000 (UTC)
Date: Thu, 4 Jun 2026 11:05:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] doc: replay: improve config description
Message-ID: <aiE_yGhjXuTmVHZf@pks.im>
References: <CV_doc_replay_config.709@msgid.xyz>
 <V2_CV_doc_replay_config.767@msgid.xyz>
 <V2_doc_replay_improve_config.769@msgid.xyz>
 <aiEa5EWeAaaMsqRR@pks.im>
 <fcc2cf52-cb10-4799-a4c9-eb5916187075@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc2cf52-cb10-4799-a4c9-eb5916187075@app.fastmail.com>

On Thu, Jun 04, 2026 at 08:31:57AM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Jun 4, 2026, at 08:27, Patrick Steinhardt wrote:
> > On Wed, Jun 03, 2026 at 06:04:23PM +0200,
> > kristofferhaugsbakk@fastmail.com wrote:
> >> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> >> index f9ca2db2833..4de85088d6c 100644
> >> --- a/Documentation/git-replay.adoc
> >> +++ b/Documentation/git-replay.adoc
> >> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
> >>
> >>  CONFIGURATION
> >>  -------------
> >> +:git-replay: 1
> >>  include::config/replay.adoc[]
> >
> > Not quite sure, but was this change supposed to be part of the preceding
> > commit, where you also added the include?
> 
> No, because the conditional is only being put to use now. That was the
> intention anyway. Maybe there is some reason to put it in the first
> commit?

Probably not. It just read funny, but I guess that it's my ignorance
about the adoc format that was also at play here.

Patrick
