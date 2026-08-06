Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160B3C13E2
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996928; cv=none; b=SK7wOUA9X3RyKvcNzGSO3FTUfUO2mrHsSbnNYuGOEUCs4Su5ONloqEM9G43foASOlsT0sOW4DPAKAFvKcXzS9deYiZhsXJhnSBWB4G3gaNApzUBcijASLFKsyDZ7iTIfl16FBwtthUfFfnbfTfoVdySrdqp4F5aAJ5gmQKXfiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996928; c=relaxed/simple;
	bh=TaRmZJc4Wsa8+fySWo+sXW9sylYSWRbYCINu3u9yOtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBb3kjQlz5LdGjlcANj40tuCr2Bct2BsVKoLlzVqxXYPPms85cY3vWVNfpz4/RlodD2GJzrMEOvQFJ56xItF4sntOJoss36s36xEonjfML7TM/oxizs+UjYPRX43OZJ7TuB6Q8znsBYn0gJIL4i0ou3jJrbDpDtFFYgkBN7gmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V76tBgf3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RfnIkeDV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V76tBgf3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RfnIkeDV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 133C61D00152;
	Thu,  6 Aug 2026 02:15:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 02:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785996925; x=1786083325; bh=984kve0PNS
	BZKnUL1x9dfUCHOtCeGfPis5sCFNG1NA4=; b=V76tBgf3br73xx7ItNfbU6ulNc
	fdymnXkAu0eh///KPlzdzfOpFCN/h53S1arjuLDVFmXnowKNdnhb4j3J8pQftb9u
	oXZxL0DEeKAAubcGPGOx0A6YayLZebNbxEU2iFXQpQap/0k8hrBgxydvz0KXJXLD
	V4ezy6K3X1T9P/IxiKGNsiV/2o4rsU+WKHaAl+VujyKzTA8hszLOcmkm+1BPQeC+
	b4T1CGyPyEz5CB3YkPmf+GjP8FhfmqKRu9PFGL72T30VsLFoJhr7ITvvydxRD+F6
	IXg2kP7pyFlukawGayOQy+yxr+/Xe6s3LOtsaXC3ANTieIvePn6w59/G3dIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785996925; x=1786083325; bh=984kve0PNSBZKnUL1x9dfUCHOtCeGfPis5s
	CFNG1NA4=; b=RfnIkeDVt0ju6xBacVLvBRgJnd1C5NWXrECHCu9w0e25JqPWCPd
	Du+kItHMYjzT0XaSuHkXc/b5jEy/lk7D7uDdU5SMyH5FZyvDgqvuKbqULbKH9WDR
	DQmBiWbHj8fdqSOSzSmXziQHcL/sk8Xuw1+V6bOUfva5IpVweRa5HOTVrvX86MeY
	xhDnA6MYPL02f/qMyOQUg2ZRUR41S/QUbmd8sdFlTayT3eUmqzhdwSK9e1m1OHVr
	nXGiUhEIaclxaPxj3HmClGVNEvTpKB/FqbTH6Wrb1JL0rPXPfU9A+2g0o8W0B5F9
	MSYPaawUq+tlTUSwx0FEAsdO1O6xJ+3XtXg==
X-ME-Sender: <xms:fSZ0auz4mJ9-ts3cVkRwej-CWUJaeRopVhFpEgFsnYQKoIE0EH1OVw>
    <xme:fSZ0ahv8JzfVgq8QOyxy7Srom6h10FSyaSZvTajZdmThDlctb0NIhPWyK2NZNNotj
    24fODc2aX1lydyLc6IeNgQ7Mra9sPX2tSz-9sWR3JbuTRCnVTZg84o>
X-ME-Received: <xmr:fSZ0atuh6G_5_Zny4GGfb_I6nQusuwVTkQwJbQQTtiyYI5_QGGVIzejd5GEJaL4jNFJ8-P3k2n5g9yI5h15r8zGjSL2DuSa1ySY24zTbAmA>
X-ME-Proxy-Cause: dmFkZTE27aNphyshxc9e81BbGcgZp5BOX6AIg2fYGp5OxZ0MMGZ/ZpBK8NChoLrTBmOREY
    GAzWEK968FKGGHeOANHYstPhKix71odbt6aUnS0eiSgv8jRh/4aT8drxqHpBWSY35nXtFa
    /suOEzlbQVyAHYJSu81Qxeu5NZznHtD+qmKKlrAVfN1wWswsF0v0t5MNbfADTUziFariC5
    zsKtUc71/KwBnlT3LDFjouzZZkE3AYlPDx18brQsCHEoyjcpaVCW9g7DNw38c5aA1OX89v
    f25t0NIgmex1LczA/JHwZl7ApY6hNvCQoMC9W+Cu3RkNhbEDMVTvdBJkcXqMwYo6s86Bjz
    tCInvt7R+piKeIvRG+2R1k6E+t7DQWee20IJ3sBG357rvH6lzIp+xU8IKk8o0iAu8JMC3l
    hX1SXrQ+ZcZdN6ElWQbmYpb7jeBYfIF9MNkitHDvb24zdK+8lcbOv8epboC+rQKnqIWVFe
    Ih0LBaVRLeaoq6iqi+9RgEdAnKmFC1j8U9GOQEdilV4YRiiG2K6S0m66UlF/OsvPXI/FWQ
    NMsb4dG7IYKj6QQQgFsjBfwQDTaDcC9MrwxrQRIgIMIwS1PSrqJkDdQjn9L3izvHICX5+2
    s/duTivwo30m3dXUcRYfNxBiQkQpKK9nSXYYnH/W3XzbDRC3/oL9qTy6Ne9w
X-ME-Proxy: <xmx:fSZ0auMvJrDhbG24-FR6Xropczw0jhbo01q-ScS7pjDV8cSFz6T3cA>
    <xmx:fSZ0aj3R7bi24RmazFXbm2NVrW8fCSJxVIEZ1XBQzQllaQ15XmBalg>
    <xmx:fSZ0aiNmDDwroh7vFRJ0KjNvEPtvI4MRMy_1RNEUEz00Wx989kpR8w>
    <xmx:fSZ0ar34IaVGVmEEfxOvJeR2Fkne28uW7WCN3AiZ4r3q9yVSQGeMCw>
    <xmx:fSZ0aqPK1-KXN60uZCOYMA43WUCWuZmuSBB3vSjgq9JtvqccD5J3cgSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:15:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b872cc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 06:15:22 +0000 (UTC)
Date: Thu, 6 Aug 2026 08:15:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/12] diff-delta: widen `struct delta_index`' size
 fields to `size_t`
Message-ID: <anQmePZ9FcH_Y1nW@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
 <0012c1007bc5d0e6ab143a0ab8201456e4f33a24.1785946479.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0012c1007bc5d0e6ab143a0ab8201456e4f33a24.1785946479.git.gitgitgadget@gmail.com>

On Wed, Aug 05, 2026 at 04:14:28PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/delta.h b/delta.h
> index eb5c6d2fdb..ab0279168c 100644
> --- a/delta.h
> +++ b/delta.h
> @@ -28,7 +28,7 @@ void free_delta_index(struct delta_index *index);
>   *
>   * Given pointer must be what create_delta_index() returned, or NULL.
>   */
> -unsigned long sizeof_delta_index(struct delta_index *index);
> +size_t sizeof_delta_index(struct delta_index *index);
>  
>  /*
>   * create_delta: create a delta from given index for the given buffer

Okay. At this point in time there's still at least one caller that
assigns the result of `sizeof_delta_index()` to an `unsigned long`. But
at the end of the series all callers assign to a `size_t`.

Patrick
