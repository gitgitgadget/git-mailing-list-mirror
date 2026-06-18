Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626602E7362
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764285; cv=none; b=NNsGLCsfhBMnBA+0vb2I/vXiK2w8SmuNncPqICd5Fi/Y04qOzPDAmdePsElqhfUMyjyJP+Dul+XwBuqiaprZMzyZ8C7/NQe7zX0ZznsIb2axQ4JpD7wGBSGK8n2ol4xSVnRKZZoTej3Zruib3uqwkXqRoyWgJe+0mGE0ROoNlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764285; c=relaxed/simple;
	bh=d1HWkUjz0NLhVDTSKcdzcJ0cR9TuNceNU5nMzZUF39k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT/2186LchDR4C7BgkTTN/Vi3++6itO6HJ8wqeip1XANyOPvL6z4Y5m7MhZhy+UeDVnitrQiMq3C3CnMpGEdn/0gm33ANBfHJh3fDZcv0wiDdlLLQ8sF/aYRoWD0L5xL+5u16mCTffmW1wM7lztkbITQe5Vg9/L6yhn0m2mjfVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NqCEGTKH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4pbpS5U; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NqCEGTKH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4pbpS5U"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C0D07A016E;
	Thu, 18 Jun 2026 02:31:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Jun 2026 02:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781764283; x=1781850683; bh=KGs0F/Jzop
	6J7+t516CINyPnW3jnqJO9dM1NY48cCaM=; b=NqCEGTKH/ndjjkqM0XhhbmLftJ
	SVc3UnhFtQrw7sJPqFGXk7jDWhKY09mdqXgXz3OLapL2KWW3gS94R7gYM46ryB6k
	YYC5bdmSIh2JzZaR1SuP/+eOdn5Vm5ZGlwB59foQhGnH8aKo+QmFMBpfGicnwLh1
	q0mahIhitu+aEwEuxR+ohTf2Zr4yZ7VFGCGNFpql+FVzE2sww5882vY9Xvg8Uw2E
	J/YMnHKdm+S2ibo3m48znIk0FJpcwdopAj3Q6Eyb0uZuxNOX/pv6FJB63nHMX+B1
	7JiEv7dTFQCdkbfyLt4GMfhbhTOhI0SanJjoIFp68n73ZI5YGuW/PjJ0dHIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781764283; x=1781850683; bh=KGs0F/Jzop6J7+t516CINyPnW3jnqJO9dM1
	NY48cCaM=; b=T4pbpS5UPwxS3IVNlywWP4Mefyi3RHzMUjtC2+EmHqv/hMzgF8t
	l90E+Olp7YpGf0ObZQDX9KbBYy6fAv5aOb1ponE/Cd5GZwVC7h+yjiKAJM6F08ST
	VLgVfYoKTJI+JTo/PYbQ7hNTxyx7PvDtqsbM34kfCpw/ZLfopCYShbvR7DxHZI08
	eYC0UGJ7UMguNiaQHmEfkLuSxTCNPItQpY95XguTu82xPK5V90y80+JudrMckj2E
	sOmU8W3jyW0pK3Hs9brsk5XJBlFyf8TGF57Ev4OrgYLgg09DAqa3XiWy9nCmUveJ
	i5l9Kw4BCTIPqykamfhkxRb3yjLcviwT76g==
X-ME-Sender: <xms:u5AzarT76I96gdqKPz1EQrY1AL-yRxSLS6tyZCJX1JHelA91-z-rcQ>
    <xme:u5AzajykdR097jBD0ad46IxbrbimG30uwAaduRAvBv3TlCCa06bDcgi6KN-Zsby0E
    -ZVr3kRDM00OBG2P93UUr1AEzVLWCpzxEhfCLPowgpCeLAAT_GQ>
X-ME-Received: <xmr:u5Azal3j3hmOhqJCoe_SzL1_fuWQi6l1bjEjG7mlPyBGXxPJWcFwoJmyff2U1yBo5DylfazPr4JUTzdqcLtqiBY2s2993L1VXiKYLk-1Yg>
X-ME-Proxy-Cause: dmFkZTEj/mWKqsLrNFnDZ22C3Ly1R/uA9KSPvuSFdb70L+eGtFwG8q5uOkN5qSiKXWbpyk
    /iDfocD6E0IV/DqaivBe0dzzqAKyrcsGszMCx13dHJ2koD+gme7/1rfQr6A1Bsa/tCzokT
    fwwpraEGnb3HjSHoqbWwSExGAwk0qAqFFxZ/RKahWDTve5l/uwTpMQJCpZkB2ElqUFsJ75
    WicIUfUTCO7zGAxpRFCxkAP0Nt7Hiu60tpvUjdMXV7wEBUYOuFQBY+KGF5kLc4pqGnlXuk
    Q4fTnNSHIYPBabDpGRErNSN722VgIne/bYi85Z6Ov78hj8hnJu8ouhcBZ3KgqmLCZGUjNQ
    sGI8paCjqofPu95cD+9f8gHeuzYX2OGsZr5XqWXWWXPi9ITJlk1zcQikY5h285baoHsQc2
    /pUJ1YRFJCr4lez/p0lZIcRMN3aOf/wQFxG1yqYmju32xKLwZAMZHb620Y6P+Yr/lXMaYV
    PMvSnHZcibnWLc59rNWbNykVjkGJzZD54JM44YAsdcOHdgsEe4pgnOEqmm72l9Rj7i1Koy
    7RUfvIUypUI1Uq1bElPK9S2g7MjCfHKZ6j5Gb0rydoZUS1oB6/OcZw1WI7ksmIkn+yAw2c
    IVaF1q1yRCs2VblWQ0zREiess7k7IPC+giBGWvEg0weUTmr1GjK9vPBneBWg
X-ME-Proxy: <xmx:u5Azap5qCF0YzS-KuiOf8V-kUizHSbN86YA1ggKbBRJoKgq2N2HhZg>
    <xmx:u5AzagWPSCfvxQtW7nzsVVmWI8ms_CTvq5C4H2ZXhRaEG6vOHYQ5OA>
    <xmx:u5AzagCxlWd5Fp9xxSltdBY3MFqcWrifKFEg4-DonCj9-58PavPpIQ>
    <xmx:u5Azan5wrUvNAKQKIbtWoUISvUroOLcCRuEchvoy1cN90MvQkvx70g>
    <xmx:u5AzantxoIN0E_lXN6cpaO47wtHwR6-dxtVHVUIglWXlrrVJmYH6ngB7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:31:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12b06f42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:31:21 +0000 (UTC)
Date: Thu, 18 Jun 2026 08:31:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Support hashing objects larger than 4GB on Windows
Message-ID: <ajOQthRjhD3hRM9w@pks.im>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
 <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>

On Tue, Jun 16, 2026 at 02:49:51PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Philip Oakley has contributed these patches ~4.5 years ago, and they have
> been carried in Git for Windows ever since.
> 
> Now that there are already other patch series flying around that try to
> address various aspects about >4GB objects (which aren't handled well by Git
> until it stops forcing unsigned long to do size_t's job), it seems a good
> time to upstream these patches, too, at long last.
> 
> Changes since v1:
> 
>  * Rebased to current master to resolve the conflicts with
>    ps/odb-source-loose
>  * Dropped the !LONG_IS_64BIT prereq from the added/touched tests, as it is
>    now no longer needed

Thanks, this addresses all of my feedback.

Patrick
