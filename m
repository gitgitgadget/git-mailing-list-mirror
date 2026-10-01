Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C73C4167
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860561; cv=none; b=UP1VFVPFGmXEqjcZMG9I2MnyfKj6tyi7tPM6bU9Ap9LK6cXaRWo/eRhs/hrlj7DH2drja0sckKiNFBprHgGahMyc8YEx7asSRUINif/z3+4fwzO26iRwGPXb6PdaxTxZ9wxny6QA4KRI7gLfWyanjD5kXJWJ6mh/ShUpG0hqzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860561; c=relaxed/simple;
	bh=dIFF6OmNvny8/uuU0tXeY8iluMivpCe1Fci+evOwd3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oclFQQvdAIaUTc241dqoRSGGOZ9KLWrlDwPwwyIj4tAfWgBdA2e0LmW4MaZMvx3QX1CYzd3eEB9YbQHRngCvsBwzWjqoLZlHMfk2EVYsntH1gwgajd9fJZz8DaxpXDan79vdI8O20HWdwe/nh5Pti396m/ap5j7VmyPSeXakP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WWnIjuFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MR/smRhT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WWnIjuFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MR/smRhT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B5D2EEC01E1
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 09:15:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 01 Oct 2026 09:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790860557; x=1790946957; bh=xtpdERkuEN
	a0uErwvZucJGY6sHZubvu5D/2W9Xyk8cM=; b=WWnIjuFR7peN39QKl5zjpQfZsu
	nyeFInlX9X5nC17qX5a8+v2FO3/n/2XZrtICSeBVyv83/33StmQa4nqxO7ocShfO
	LaDO1UYNgIicCFlrvh1XlrqkebYZfZwjjtiTFhuHwPHPwjpyGG5n7MGXN9NXL6/Y
	DP/3RhvJ4FVC1RygBZxfAMzkkp5MqMbLVbao6DmbXYW2WULbdm3Q58FyaSpd7PVi
	OUJFAtKeS5461nweUXlm3Ou/eLuLH3Tv50SshmW4XXna6dyUsIAwQfQuos/I55P5
	4k7h7eVPy+UU1ET5jkzG9I+mN7DNPmwRbUKW+t8WnyrI8H+8ZQeq11Oy0vbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790860557; x=1790946957; bh=xtpdERkuENa0uErwvZucJGY6sHZubvu5D/2
	W9Xyk8cM=; b=MR/smRhTaAO7Q1friohBarOSWTyJ2huxc0fyRCgH7aWYsOyT62G
	79HFSFD+L/VhFkgCfdv9lqs95/z85JwZkfv22vcPQi+DAQExJiDszJCI09Vj49AJ
	rHclK95o/L9emvd4NkMqaSsnPm5950TMp3wpzqPmK3xHBOlIPZm8tK6fYeuDtsb+
	gyD2iKSHBmZiUOwU1O4YdKMSBT7rRo0JmFjBhHBCOnTvVlERaJSjUgIl61xhKtKI
	DE5VJGXtN4v6+IWUyoa2f55mUnaOzASjTQMGzRa36nQv6kMQD6mZ0IXV6xYZoeel
	qwDO2C3IrkWW0MYwcdKaGr6+phA6XT5fE2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790860557; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:W/t0GwZsapdel2LOZmKovRvJHwUHD73v8CTnP9C7RyaNdSL
	xQIBssaVPXg40yFP7GaHaKynPizF1KNfE/Kit1aaCwls0QFVMZWOacrpNON0DAxP
	gz+e8pp7wwWjnGBle+S1g40XXhEZ3+UQJusEOPxBdpgteYTUZTkVGgl+MPSxKyWP
	Gs3k3gzaDCxuoCGEMivnzlNmwWMLle34MlyjInwgsfcUtwPps9cWPsJBY4/pfOmn
	a/wMi0u/I2f/sKMzbM9O+ASkPGmS0XNV48pX6VX5Mpv6NyaUyc/00kcTa+DkGffv
	y0wORXmaGYiGg5iK9LG4R4mL5OwZlC1wnc4BlCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Yq+Am+nz9sFuwIIv58GoBSb1nOyUxAWDHdyf+hIBoGk=:dIFF6OmNvny8/uuU0tXeY8iluMivpCe1Fci+evOwd3s=;
X-ME-Sender: <xms:DV2-ai-fInZxaYG5w6mtaRMU7KhmEJ8kcKVIiqXXQAlvpmc9bEx9mg>
    <xme:DV2-apvBREztNF5SU3Cu4exZgJcWcvZhxsfoq2mfcITn62WjKMXXIC_xSRsRlYEuI
    6M8lkDXsv9_sLrsEjc1m1FEWP5p7Qb76PBUpj6Yh7iPSiJcCAdpz1ud>
X-ME-Received: <xmr:DV2-atC-BZKAcrjktetXAXaRhhrjBOoBSqamKzzpYwBV7UXnLDmNlXZWX4gE6GgiHkvFxA>
X-ME-Proxy-Cause: dmFkZTEVFQhlVSvMEVsA/AkNBB/6CmUt8YqrMmbfFj3QB7it98zMK06QtT+rG4bSWfyeGC
    wnaA6CADsCC6EDezpXBleEct1OTg1KrBZJ29YsAW7FEPmbrU4YLPmOc9hAeB3vqt4UsAmi
    Fcdt0YVwg/c7N7lxY0vGF/OFSWhuqjjlHKu2J/Of0Dvk+aSpmBpblAzrpxOuq8Syph8keq
    FoUKviNz65OG0Ss6tkk0T1sOWhRFh/N6/ZTOG80OeFqxwyHfslmMooC2g/R2SZdWOvTi/5
    Ly7pt0nMcntrRAyCJwUo3JVAO/mW2e+sF+9C3Uo0Qt5Uo64KpUja32hwqRkznFuapKQCWY
    /yWmMsGUBbxjOOG0l6xveUWf7UAuroWodNBjZeH5ILBYUy6EZgdAJc84ZT4C7smFbNsv2q
    8vqlRgN/0IUMTeGRnZ1WH15os9XHs9s2c6Nx0WKYx0BhZKUbpz2TY7Q4000CtqsutmUVUG
    TCRTp1KgNdNpQThoXwUnB7cH02Cc0+XRu4w3th6pMH8/DPrLgLWRAnTHdywhKtCLT7Hje8
    +BvpV/VyWrGeCq1iOHvUo1CzEsm/hD/SFlefj6R23O6f8LPYxItW83aC3D5kqpegyeg5IJ
    PaAHgWz1p1XMBm8mlgUGPT45TBZAF0q/JXNcRF+k457f46dbA69hFDC5UkbA
X-ME-Proxy: <xmx:DV2-apUswXaj-hFJAMnrJgiVGx2pkUU7BeoEJZ6UqrCmlYaDumS1vA>
    <xmx:DV2-ajAP6xqEz50ZrIyQ1ad27VqeBERsyZRvBvp9YVmVcAYNeFSW-g>
    <xmx:DV2-ak_lkJQPvM2fwLrn6-J6kj9VuTg4nlZtLlo99urAus8ZAvD9ZQ>
    <xmx:DV2-aiGwdd4n_6rLWGUDsxkYKDZ8-6_jIb6qBPpHURfAu-h7PqjqhQ>
    <xmx:DV2-ahegt45dxiqxK4HnuI-mPOpj48WOJbHSjK5RU6BA2bGFeY6I4L5i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 09:15:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8565596 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 13:15:54 +0000 (UTC)
Date: Thu, 1 Oct 2026 15:15:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/7] xdiff: NUL-terminate buffers read by read_mmfile()
Message-ID: <ar5dB4p6pQITEUq6@pks.im>
References: <20260930234348.GA1340390@coredump.intra.peff.net>
 <20260930234413.GD1347555@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930234413.GD1347555@coredump.intra.peff.net>

On Wed, Sep 30, 2026 at 07:44:13PM -0400, Jeff King wrote:
> Since an mmfile_t is a ptr/len pair, our read_mmfile() allocates exactly
> the number of bytes we claim to store. But in many other places in Git,
> we add an extra NUL "just in case", which can help avoid read overruns
> due to off-by-ones or the use of string functions.
> 
> I don't know of any path that would benefit from this, but I noticed it
> while converting ll_ext_merge() to use read_mmfile(), since its original
> code did add a NUL byte (even though I cannot find any case where it
> would have mattered). Let's add the same defensive NUL in read_mmfile()
> by using xmallocz() instead of xmalloc().

Nit: I guess this is an artifact from the reorder, but this sounds as if
`ll_ext_merge()` wouldn't append the NUL byte anymore. But at this step
it still does, as the change to `read_mmfile()` now happens before the
change to `ll_ext_merge()`.

Patrick
