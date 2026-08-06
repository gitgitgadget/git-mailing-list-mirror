Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A74385D79
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993520; cv=none; b=H2Jf5Ze+jyHUcBu/mjC0VyyANmGgDCJHuBCEezAxKwPh5rYSHBPSdB9O/WPQtffj2fIR15j7GT8sGuy30TEv0QPFRBphqIlTPYzv8YggtOibwc8JMWEhrjRZt+vqDZ8GCwP6z8qkz0WbQVMP9rmKuhOgB242olXDKFE1jqoCDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993520; c=relaxed/simple;
	bh=uk4K/vQ0JeS5CMRdg7XCf+0gtSLW/T4MbXEpE9Y9ru0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZJPxMRe4U6lZiUHacSZjCJb50gcqjsFRSvcn+Oqsk294fFQaSLbk3vC/s6LO+QjwfnySzi/55pxqRS4TVaZxlS02Hok/KxiF5HfgneJWsBXlruX4zqT+39a19aoZXjCJm79n9zmKRKdO4nKtik2s3BtiGtC4om2ZS5JwGPumiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MWT8YlLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZROUAV3n; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MWT8YlLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZROUAV3n"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C18F914000FB;
	Thu,  6 Aug 2026 01:18:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 06 Aug 2026 01:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785993517;
	 x=1786079917; bh=uk4K/vQ0JeS5CMRdg7XCf+0gtSLW/T4MbXEpE9Y9ru0=; b=
	MWT8YlLl1BTmHn3LHxMcLE+FfYwXGAhKiww9NV04cscwCXGukCYMEWr247ioxCFD
	OngyhY0mZIa4zztwxVhGVBGchN1ZlZL7mZMAk+HFYmzD/6UaRAnh/djILgGEilrM
	GVCrhhIrFYVDmULOrgZABSuiGBgLv/59ha3rbr8dmz1GtVK3N2Rb1YIrybAewerH
	974eFKl+69kLcAiJQyMhOknxRHaTUpDdde2wdzflhXW9GoWxu5MB/qt/IA5NjSVh
	B86zeOBke4ju4a7hN+BJ28FTbT/HauLYwLRz0u0K3iMkdZaUlFomnfdk0FhzZ2oH
	4xd8P31C6A8uqbqW7Z8nTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785993517; x=
	1786079917; bh=uk4K/vQ0JeS5CMRdg7XCf+0gtSLW/T4MbXEpE9Y9ru0=; b=Z
	ROUAV3n49WLAA+DAxi93cYoCXA5GaWvan2s5VLimZvZynO3jGTqCuRqbra27TVXA
	EWoKhGnUYQdvm6HEvgPlFJ7Nqqxfg18zBBdW8cG61QPc4awceTHoa1RxBaSkwey1
	SQ1GVzNzkMPhNWPr/V5GrDDOf6g8rMkn738xo357xzJTcR+uUAJilAf0o2YOAlC3
	iYKMdf6HXtKxnJ6Ovb+uAobO2NmGKPsSz9GgN0pOG7nzM4KacU1LNMrav6507Aq4
	l9wookZeCqTIcLe8fb+QdLZmk+GWcVQT2/Ulp9A7bBl3yUQmQzniofQlzyxteOxF
	IZWpMzqOw4p8Yd+Wp0Wyg==
X-ME-Sender: <xms:LRl0amGq3xlmdcVGpvNIrJOVyQLWs002r62uVbqiVTrAdKSRSDK0tQ>
    <xme:LRl0auVx6YmV4ilckbBdkvt3VXMpqMrRv2qVAI5qlpEKRFN1zrkx3WOjSRDYJB0ue
    JGOoN3le3IXDkAWO2v_1GXkhtraB8zS-SajX8WDzi3aHHjT8bFq>
X-ME-Received: <xmr:LRl0alJKv3dur6Bs_YjZu0NQiRw2BrKxj7sXih8RBlQqesbwB5bHji0uhxBzrNwTL8ovTdeqxvHIa1ITfrf7vslspoJu9o0CgjfVFGj0JnM>
X-ME-Proxy-Cause: dmFkZTFLv0CiVclCgLZQK+YTTasBBO/QxeVMOphOOlkkeJgxVFNr/unGf1jIasPriFMiIG
    CURjPjqP25mfkf06Pge/qDUBOoWMLQ1nHDv6irl3F6OTJ2cds6zKeei351KhDMY1oRVKVg
    jwrIX/RtbcLen0LevitfoRPkxsBLVtyh2tPPaUY+CHJhSqMFXcSg+fGITF1BGLeCJf7nxr
    27yvzOj4uWiut3cHSrE6tEYCAuA9ECdtyQ9aQzVxRY8bwBLMvJ4hFoOq5OIhJ3nVi6bPUP
    5hROcIKdTRcy0iaxOzJzqQjT4jfEU49vO1T9QTKABgoROVwaVLyToNZqiCI+s/ovapmtm3
    nM1EgY9DfmztGbyuWA2jMSu1C0NMdwdoEWxztsZeXjI0sNFmfo5S6K8CxwHRMahAu81kUs
    F+8qxM5Z5f1nq6kAI4vwtKUZYLq/F7nEeJdnJr5tcEa3QhuKt6RyNydUba7EryTUUqAIAi
    6EduXtwvUOxnI85xnVZZGd1dd7AeRmHLfMB1EC3EINYkeD6ctWXye00ChTHZZ+yjgdICLD
    NylwHvHKklEFC0n5i7wkAFREuWKW5BozG//3I1rcrRFBmo3pa4sFaiFcp1yF5r/cjSEk0+
    PgexfVg5tU25Hcr5ydB9gZWS4yOi4qQadpgS1u164nWmzbc/XhSum0HniqIg
X-ME-Proxy: <xmx:LRl0au9e8FG5DRK9z_EtQyop6sHv38NMSh9I66IrYR75K3OkBsyIgA>
    <xmx:LRl0aoJbOEwxZidfHehIDndW-igXUSKggjwQpfwMFMzFkIw0cxt1yQ>
    <xmx:LRl0ajkQpHw-Zilz6I8n9__C6sRmPDRZcpRJOQlNb-mx8ykabh1RsQ>
    <xmx:LRl0asMx5WJakDzFAARZuaBu-c-q-_Z3RP-g8okHyNzeM9-kv6KkgA>
    <xmx:LRl0as48B764OiSc7hco_ZO-PvqHRudFbEmBMLjtZw0RSr76WgO_u54E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 01:18:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bd32980 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 05:18:35 +0000 (UTC)
Date: Thu, 6 Aug 2026 07:18:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: add 'git history' subcommands
Message-ID: <anQZKJLIiL1MP_Nx@pks.im>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
 <anLV__4THdvugj8f@pks.im>
 <xmqq7bm4sfvh.fsf@gitster.g>
 <6a8e934e-5ccc-40cc-877b-d1f1752888de@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a8e934e-5ccc-40cc-877b-d1f1752888de@kernel.org>

On Wed, Aug 05, 2026 at 11:20:58PM +0200, Vincent Mailhol wrote:
> On 05/08/2026 at 18:15, Junio C Hamano wrote:
> ※ The fact that I started to look at the 'git history split' completion
> doesn't mean that I am committing myself to implement it. I will do a
> best effort try in my available time. If I get a decent result, I will
> share, if not, I would ask you to bear with the current patch!

Works for me. Would be great if you could give us an update though over
the next days to say whether you will or will not submit a v2 with `git
history split`.

Thanks!

Patrick
