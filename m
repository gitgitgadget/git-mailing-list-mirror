Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC73448B93
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823013; cv=none; b=AQ2hVMXstXX6LT8hzw2PnsO4mb8liWL9ZPy1ND6eMlhstTgqe2gkHkEyMW8aNybWuavDn0s6PfUG7n/dJFtkqJ5T9Rx1bQSvNg2ze2lX4yo/a9sJsgIf3nhQM+twCL4cvr9mbB4fQ4OHQCZKu6KEzXOENw3nukaeGT6IeayaZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823013; c=relaxed/simple;
	bh=dR7RYxqWNc272XNALbDgCcrIhfiTeGVTzXo8rgmz1Fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2kcVwzuVjxzeChYoUotTYVDlesvntn3HN4bY87I3IaoUaQXaWwaPsgKUp8jOnCObJ2T1+ebRdj0YEXMJ6pJeHFs3i0maGM77Cl+cPY8uxiwlb4K7Gs/btcrJdqdsgUEMgLm57SQj20jBwieN+2QKFtXyaIueVttqS8YFdnSV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NJdNsCOK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3WeMR58; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NJdNsCOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3WeMR58"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 10B0A1D000E6;
	Thu, 23 Jul 2026 12:10:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 12:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784823004; x=1784909404; bh=dJWBq85Otf
	B0Z3zH8k4s3rnGCmzSEPaN/Ws5+fgNd5c=; b=NJdNsCOKsr3C04pe1E1k+pHxum
	FMY2B4Yht8rhRjD5PZmmpzxY80p1ACI/3cm+sND+hWbv4CEvMcT+a5rxQaXYpJZk
	3ZJrv3pxO9GG/eES5PSvFT7Hn9Bh+skAhFS24K6AMpoh1B2VguKxji05iMDhyGtU
	D07dftWxZk8QoiSuJcSWnuJyhF6QlLaTNrX7gGhq396nEJRdF/EmlAmhQTMfxQ9T
	9GK+5iDTNBkBHcVGMHjNMk73UBcU4wbzcbc/XDkHs3/I6HJV22cTGYjLpJ76n4nD
	R0VrKdhiKV41LGIqsROtWiDlMTGMec9V5sZP119V3TZuxbKLHklJ72Fvs6yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784823004; x=1784909404; bh=dJWBq85OtfB0Z3zH8k4s3rnGCmzSEPaN/Ws
	5+fgNd5c=; b=D3WeMR58YuYBO5f4cBnDOfE6Hhy37h+q/Uo6UKnfEN4EKgARj6v
	WtZRj5iRJXSQ/rsW+U8EKcKhKOBBMgnR4iqDnuQJC4nolp3bt9AlY1282nIqHcQI
	YMrYjrjKnjyYKMl6s+B/DKZZJVCodxYku3NQQHaGrq/Bpvocog230+l0mw0FcYQU
	G8bpOjuknQ49EmGsZUtDOXpZRel+h21u+pLYGlZN0FZ7QrEEFbx9dSVNolhBmWP8
	niUMGESOcClch4kYAv/SVdrSrK3jojdqBMsFmm+O/fUa0iP9vOUO4DOukAs6mTe7
	TbfI6sijXMamilwW+x/LrPhfGFlbRRPfZbw==
X-ME-Sender: <xms:3DxiaoAifrA1s7GfMu6uANGrvqfdpp066-qBVi7__ztAockZHQcsog>
    <xme:3Dxiah-ohfh2kEQczAl8Ehx_fCpWDJPHJmdMfdnUVYfNW2WC8QJQHo1xr0uDE_15i
    BXe2gIjKog54npNicZ82s8CLo423yY5q0MWGdbDoL_AAkuS-_Rk>
X-ME-Received: <xmr:3Dxiao93BvmRBxUurOqe8XmDy6jEAqw6e2wxTB-wMXhVyUkwR6RnRq2MLrYsqJvPaCPo3exS6op0o-beeoyQTFLflOs7j4jv_w>
X-ME-Proxy-Cause: dmFkZTFOSKJ443jz2gNx0t9+sLsnO4ZfLoioCmkhk5yBSuu6wkxgpbf+0FuIqh/sYcM5rb
    x6Yj+e9GyeEjd6CKBykXmFiCoiyMr3GWuo2T2w4se03tC+mTwiu8Y9njmuLwjNYJU8590Y
    54IyWboP+Mpar/lsbUFJ9Y3wmHUPNuZD06MFh7xAwVoaIOA7JZbHWrbqWzY0LvibinKxo7
    kXsmNKtZ2gV7w+2Im2s+ZdkcuA5Vbi9qsJInNzdL6HW/SkYudRIBgWuiPa6nw6Tiducvr2
    qfDmzICXwPMFMUdi+wyAVX+SA2rG7JNaMvkxhjXhfS+hgREcNKxIQmvD3DTpfB+PcGntg8
    WlKm4VrxVuS3N6LJWUl44RyY4o4YIvx7Jwrifc8eoGwb5VAmfLhxXLrryzSukWGndeLRDh
    R84EFkuRYz6B9dY47mpgy++CTvfVUgwmlzyS2lLPZ0ig+4cRnFESDj6mDE0dMRmkLD2AXm
    Buy1Czo42ZbpalhMuioNsrcx+dtXG/C/Fr1VdJAq04AUUgnwsODVgJaMvAIBaP2hShd3RK
    OC0tk4ZjXmrlPGbfKpNnEMRtZwgd8Y5/YutavSw3rMldFtlIWh0qCpD2XFlOf2/pq/UJi/
    c2FHieHl3ETPemscCP+/B+DbNd67yFLEK2mw9vVx7GM6/i1HdgZQuDD+hxrg
X-ME-Proxy: <xmx:3DxiaoflyfkhFjEWORuewEyHL7UIRPSj33lWySw_qC1gPuXh7c2dlw>
    <xmx:3DxiahGAA9TH46nTd-HsoGuD-SR4sq0MeC2K4Uwm5BO1y1snc_OgMg>
    <xmx:3DxiamdOykI0gj2Tgq67HVTOYoSvEY8Yea4JxdFVt6nPvudzBNSZTQ>
    <xmx:3DxiarH1WjlaZF3L5Dop9tbGC6O2nDz7sYPpFyVdgQxNWvVZPt0yXA>
    <xmx:3DxiauOM0pB6qv9CNppaDhu3ArLskkph01B7IBRplrr2Y4GX1GTakgaE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 12:10:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Friedli <adrian.friedli@mt.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH resend] builtin/clone: fix segfault when using
 --revision on some servers
In-Reply-To: <xmqqmrvhlnjv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 Jul 2026 08:43:00 -0700")
References: <20260723144318.69007-1-adrian.friedli@mt.com>
	<xmqqmrvhlnjv.fsf@gitster.g>
Date: Thu, 23 Jul 2026 09:10:01 -0700
Message-ID: <xmqqfr19lmau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I do not know offhand if that is the case, but if it is always wrong
> for guess_remote_head() to return a guessed ref with NULL in its
> '.peer_ref' member, perhaps that would be a better location to make
> this fix.  What do you think?

Never mind, scratch that part.  If we are fetching without storing the
result in any remote-tracking ref, '.peer_ref' is legitimately NULL,
and if we are storing, '.peer_ref' names the local ref where we store
the result.  This should not affect our guess as to which of their
branches may be pointed to by their 'HEAD'.

So this patch fixes the issue in the right place.  It would still be
nice to have a new test to prevent future regressions, though.


Thanks.
