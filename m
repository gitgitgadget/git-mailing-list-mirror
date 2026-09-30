Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BB4E4C2B
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774396; cv=none; b=FEeOtlbzmu9xVt3e4OQKBBGf4jFmCCQ39bevw3NJJxBg7nlQy9n1OGc8ucoWmHWOSactoq2N4sGZACb6qRq9TimWnxuoTK1t7s/vAz3rlC/WzmnSbISCCrZl2xHaVv9TQ9ePbB1szcMp3VJCgIzcal/G+Yb4IFWBfDF5dV35umw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774396; c=relaxed/simple;
	bh=e7p1NcbRHoGXv6zy9nx25NvxOR7cE/4Szbn7WQOsX74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upt0DNOyJTuaxtSlydEOQrtBPVfuJO0dXHfo3qjngRoENseYWQ2z0ZQAzrNtNIgLWokBbUp5iProI3GLA3G7kDIJ6JYaK00FFUkp5Wfn+yfRnsdth20DcMzoLaAAf7dgBahcsZQgLA3mWbqmWDXAOblpLddbQz9cqngUE6v8UI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VOnoCC+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXk1rEYN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VOnoCC+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXk1rEYN"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 57C56EC02E3;
	Wed, 30 Sep 2026 09:19:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 09:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774378; x=1790860778; bh=9nJm+2K7hj
	Hq6s35/vIyhpRyDBPNfiyUPptHLyrJ9cg=; b=VOnoCC+r5eTyJDfvlBSccIcE5J
	h6safnM5H+X0d+TzHFjcPjNPrTErJYV6Z5VZG3WXmietztb6ZwfGMNCSrVNC/yi+
	o7iN7PM/eAtS4GNdWxX8Mpk/vXwbChqxM/aOtSpdANxTsJ1hzbi2coCv/0xozyng
	b8Wt8/ZbLgvPfP031YhS+tIL45cjxEI/5aufjOsmAE4Cg4K+aAxwK6fF1hMpAyta
	Jm7lyHWPDWT/EAb5VyPjGnX2voOyhFF/45lSMcOyQ5qM1LbaqdWKFkONTSeyNlJO
	3jr+nZokWbyYKNhbL09NSVPFL0xzxLdWyV4Ycup9R7T8cyka3O7OlWhsm6Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774378; x=1790860778; bh=9nJm+2K7hjHq6s35/vIyhpRyDBPNfiyUPpt
	HLyrJ9cg=; b=HXk1rEYNHR3Zcrj0nFSo647z2GPd+zneBOfUojt/UWBZT2dYaw3
	K2h4RYHNpl7RW8ooAz5WxJq8Z8MMM5opPQ7kdOKsJpD1KJV9Odl8klwXKi6RN1SO
	qRa9BCjBsubAV6eK7xB9qboQUDMh9miEpymqLEn9xbhyXKXyaNT4NzOAXFvHKGkL
	mcHC+d5A/2RIs3x3vIVZmpAMlSr2c2o/jg6cP7R+rtRuLDXwgkN3eiZtMyoTjMXr
	UVtQX9d1L90WbhVfFRXa+sy7G41gqzb+7gaWc4p0mC/626tnEYqEe4XuQtBrVBhE
	IVo5TgyQ7u/susjJlazbRVS3fv3TQOaWUvA==
X-ME-Sender: <xms:agy9avEefFelW4OmBdup7z70hFuLlIAxswB9dmBC_I04RB2XHrLOzQ>
    <xme:agy9ajyqo_kRK0-0hHSXUx4O6aEKqyJGsJvFuU0r4td_sPzNZQsZt_X-R0_N_xwBD
    SZu6kTbVjp70bWoUAT3Qz60EbBYRCMeWLWVeqtyyf0Mq5cOT4EMPtM>
X-ME-Received: <xmr:agy9auhrb4GubuLnfSkAU-6xfh-6Z0TTeYCX8WVPpXSo0_N-WqVblQ>
X-ME-Proxy-Cause: dmFkZTGRxoNI5OfYmt6BV/YJPt3V5oLRCrmyYHFkdowNsPwOCRukWmwR61Vi2ze3cWZkFE
    K6HLy4XOWPl8eGYuHxvLdyxzfKfMN8CTFDHljg3raeOj5uRalslhmXdm8ilbKF0kJaVuRH
    1drPBBEp7MkrzusLSUJhlRCJiYXzcqmIE1ssfl4jrBlvbAJMvtvXR54D6v+ACHPH9CuRsJ
    CcFYJ8ONL6+g7bpH2qxUnm7+Sw2k9xFTr9wBdozKRtO9EQQwfV4ddVhb43WTEQHMk979kD
    sVgYoZNUXN0bshF/QJ7PpF3rXZ5FAvpJfEJv47n41z4eJmwX0FJciUDrxCLPjwwdShp7b9
    9AlEOrDcFRfOz5wKJH3q7XsACOT6+cKi4mTAiPENZLHI8jPnljJ2zLYqkj7ignUqBg4EHh
    Q3si0RInY6kFAAgnrBI/Cv+fWs/xMaev5gzaSmuD8Bl6kHOjg7Zzz1xnLLX9svvfkUzC5M
    +EbwIF6d8CIm5zmXyAQnEz15x1UPi7uAqElxk77dCxiMI+i4OoJxWOuGAt8WjHltrBKDdx
    V/eVvphRWSsN2Q4sDKoceGeGNhslx5vuFmKR0qNgWePMg4Yci+BqUDt1mUlNba7wY4P27m
    Jp8GJcUrVzhplZO4zZQC9hy7wIznQGm8HfVkz8J7xxlTCucKcoYwC8xMaQtw
X-ME-Proxy: <xmx:agy9amzlDcotWVsVt78Szmk-L6tE35tmNsJcdDq7dMf43BSHkrSfxg>
    <xmx:agy9apIy-xU_TQvXL2guMSECCm8M-ZI9Zgj2NlJF-ly42tY4nhjByw>
    <xmx:agy9alQ1jVBjvceUxnejTZQZ3yAzIySi_IGYs9hbSNymhmH84LhPMw>
    <xmx:agy9apo2TJlrVWWK-jaY9L0ZIIbgbs0mEzRfD3k0jPHTjv8GIc0PZw>
    <xmx:agy9anz3edX8FdyDd4ccJ1zoReVK8_VcoUym_l0-9aTWz6cBA6tAIgiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:19:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e48c12ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 13:19:36 +0000 (UTC)
Date: Wed, 30 Sep 2026 15:19:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
Message-ID: <ar0MZkCygtK4Qa31@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>

On Thu, Sep 24, 2026 at 02:44:17PM +0000, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> All of the info about merge conflicts has been moved to the new guide

Pedantic nit: missing punctuation.

Other than that I agree with Ben, one part that we lose here is some
context on what a merge conflict even is.

Patrick
