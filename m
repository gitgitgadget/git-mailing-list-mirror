Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA738E13F
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993318; cv=none; b=sW2GYiDEJfCss/DHIpGceYF/lp4kyC2H7zaasjZTYxAdHSmmNrOLMQD1LOrfCLdmj7lMj6k8xVeG2UkUCaKjpS+ZRrOOiPLErU6BFXUlpqhhca2f6CbypcJUH23CAMOcneO6amZWZqaNe8jVyYqKGvP0aP0QfmZwP3n3YohoJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993318; c=relaxed/simple;
	bh=4mCz1Kn0G4kFPIeQJjGNGill1XBCMRmqssaDDvJER8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k719E0/RfcPOtAolH3Z2Ie/Z9Ob/9/30Bu0R30VKMBBlhRbnuP0xPODw02k8YPH8QX5cYrkJIRdrWEPfy33Ss8B12Z7EzDdKAj+HlBd9alCUKn1ANNNmHJi02mwmr6xWh8ZB6QlByGox5Hme7vS1s+uLJDvKYUZmywPVsofI7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eCCe7Nhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CIpVTXLe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eCCe7Nhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CIpVTXLe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 322ADEC0107;
	Thu,  6 Aug 2026 01:15:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 01:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785993314;
	 x=1786079714; bh=IKgSgXemsvSlri5U3tObmhr5omXeIlxhyHzs84YB+4o=; b=
	eCCe7Nhg/SUuGYo3eVK8pkQ0AEB4vvg1eNv1f8pbIioJhFiAflhUVCTDuExEMOjA
	e2d8cwcGsXRO973Y+E7xst3WDe9+RsO73E3vzzSkVHH9IrfaHDpVqMsybPpdTSvI
	mhQp7RJKkj6a+/hV+PgUMcqdnjuyl9v+NuaHh/nmzJQpb7H6U+f3QZbIl0uiNb7F
	k3ylykDS/jGpbmSRzknD4ntJs/RZK6q+XiQTKlqtmx9rfXRzBTtzZUFu3oIT3ssC
	8oBmwCNtjwpTZVI5U31F1AgMuPT0gzWPX8Mri+KqAVaY1Ib8WipBmzefjxov2WsF
	axtAyfqroVZoV6OUWjadHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785993314; x=
	1786079714; bh=IKgSgXemsvSlri5U3tObmhr5omXeIlxhyHzs84YB+4o=; b=C
	IpVTXLeA8KPtbb5Xq9T72NA8B11YUr+oFTwQvt20YcKJ50px2eQxTk0aVU95ifap
	RdKvGg+cEB3yUo/niiSI1j8YamdIy6ahrtiPcb+ZQmkobfB9/fGBRc6ncJprGpDU
	g7BRtpkanUTQpKXBE/fenD977Yf4PFLX6+HyYt8rExZecLDjiAA36A+1Ed5mevot
	YlfSa6mzaSDAqbwfY35OWaotmAJz3uIjzm45wvJC/5s/jxXOniYrThO/DbMKZjHk
	EVqxadN05PnTx/6OA1pUrMPrZ5G6iTXzN4/IpHKmyx7X9vpPuWa/dn6eSTSRP8i7
	aVpwwh0Z6IcvNxDhWm1gw==
X-ME-Sender: <xms:YRh0aofY7lXCReZWGoFyBR9BsbixwyyiF2y9zIEaEfcUD2VLnwacXg>
    <xme:YRh0ahM83j7xal3SXGZF9wkjfdfQDK_9xC5zZgwuCNUsyCCI5BBZdlAVh8_e-17Ek
    y4pZzoro8mjgscYmZRynZbdOrGCPZjH7YtcyYFy2acO9kLY7uTYjqY>
X-ME-Received: <xmr:YRh0auizBrhL6vVFJn27TGU2csUVuuRAr5mfYJ1mJK42CnMMXy7JtBK6vNwRlQqpkoVW3m8JpTLaF_riP8KpfVW_H5bRzoMORcDmLLHrJGo>
X-ME-Proxy-Cause: dmFkZTFLv0CiVclCgLZQK+YTTasBBO/QxeVMOphOOlkkeJgxVFNr/unGf1jIasPriFMiIG
    CURjPjqP25mfkf06Pge/qDUBOoWMLQ1nHDv6irl3F6OTJ2cds6zKeei351KhDMY1oRVKVg
    jwrIX/RtbcLen0LevitfoRPkxsBLVtyh2tPPaUY+CHJhSqMFXcSg+fGITF1BGLeCJf7nxr
    27yvzOj4uWiut3cHSrE6tEYCAuA9ECdtyQ9aQzVxRY8bwBLMvJ4hFoOq5OIhJ3nVi6bPUP
    5hROcIKdTRcy0iaxOzJzqQjT4jfEU49vO1T9QTKABgoROVwaVLyToNZqiCI+s/ovapmtjR
    T6LJcATgPQNF2vFuyNG2639TSPqwN61GQVuH9j0zH3bYJEjflkvefj3BpNQAi6EiqAJcGb
    9L7K/NYLkRo9jn/ftOeAcuIKkVZklXdEekecoveWlhT3ZQk/muYPnz/eY9130XrC+JcWuR
    OOSn72CmBGjJR0e3sOZ2ivRsPM3QciBL0Z1wAW27tjcpFT/8LClL5kPLsGG/F8slRPu19T
    mazlj0h6TtbnkPS3Bm4tN7hLs4L3oFSlViIqlXslQSiHnFxyWCGXDvP0X0TLp4YYT4ozS4
    WJ7drrHhpHDeP5VmHe6c2VhNCWNXSOM/nlFpGeHr8OmBOQ72nzF0bzoSA0gw
X-ME-Proxy: <xmx:YRh0as0XfUMFgVm7E2oUesp1KeOxJB-1yPnnPyY7GIqoCA2BKuYKkw>
    <xmx:YRh0agiG4oPxFjrMprjPdJbjJMwfgwj-h1WODpQGOwOtvt9jLavBEw>
    <xmx:YRh0akeP1HkGHv0zPGHsRh0rw0p2tZ2AveBY9A8emEaIvRAReaqJrA>
    <xmx:YRh0arnemQeqPjtKQ_3n4u2CM4kd6aD_iD_ETw-V2atpVHu2hpMiJw>
    <xmx:Yhh0aiDMsuWM_u61jWLUNinVJ9zV3pRIDdoCy0Up0fqWGj9I1Rd16rxV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 01:15:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdf72caf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 05:15:10 +0000 (UTC)
Date: Thu, 6 Aug 2026 07:15:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/2] doc: refs: put ref migration warning under the
 command
Message-ID: <anQYWlv3UhpS3iE7@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <V2_CV_git_ref_migration_warning.b20@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <V2_CV_git_ref_migration_warning.b20@msgid.xyz>

On Wed, Aug 05, 2026 at 09:02:34PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> § Changes in v2
> 
> • Patch 1/2: Use Warning admonition instead of Caution
> • Patch 2/2: Add Ack

Thanks, I'm happy with this version!

Patrick
