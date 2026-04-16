Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC535DA4C
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373990; cv=none; b=X0s1AEc9abWjgQSDoelttqaLzyb2Wjm9UqiEdMW2IGZ6yqMgOAp7YJJOfZh4j08DRIyBcOtDVgClegvf6CXWoHF2yO/nvQY9IZxe2SrJ+0oc0vg3m7Hn4uj1L9+HjM1gHa16YYx/LBFRYQzVrCSTHgV1M+IJTIwUabZu93ZZzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373990; c=relaxed/simple;
	bh=GPsRKCEbLmS+H4m93U1k2pn4CuAEjhpXhdhhh8qzUZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaoGxLkrWJn7F0Mj71Z+A2O5NjTP5WY3g2m4OHEZ+TwntnunTgW6YpmrEE0cUE+IpGEpTT2GiwHodT6z01nEPnLa6T7HpwdbkdFw5xrTv24VElNh5E1o7bUgpB67ZB+rXK3kL/JQ7AT6IuO3E61sCZCW0kAfw832WJhWrvblNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QauO8cB0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QauO8cB0"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a46260385so94285997b3.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776373988; x=1776978788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9pgxbIegPuHdYaObJvrIkI95i7LC2wPhbNi1Qvlq4w=;
        b=QauO8cB0RR+1Rv2HD/o7ZoXHz133Pcwx1PU8HrYuH5P8T7FQqPm7QkU/zusdU+tWh9
         AUTiz/DvxVkDFOgtnPwygY77E3Ua7ROv4ChTQMD1pBKiAfHIIvS9Covvqdjw5e+tjbJ4
         c+BGaTZyxnmt4TrhG+dTwm5p35OKsTfsaQ/n/1SSo4eGISP1M+14IYEd8poowSm/zq76
         sdHSrEkInr57pIkGjDTAp9h5Yw7WajRFo2JZrcVk0ux2jA4MKmOjV7GkTMr0FJ11lWie
         ou6C+Eg2Ux7WIET8t/SfbAtJaB9DGtpO7/rb/FmY5fWJd99rARG3VeLppT8Ny0cJ2AuT
         WW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776373988; x=1776978788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9pgxbIegPuHdYaObJvrIkI95i7LC2wPhbNi1Qvlq4w=;
        b=nP0RaGIF0uZ+7zD0a77bttuuIv15JAFVSx0wH6f9jQk0a+g/wjYiyV1iVy8PSCnuJY
         oBJAEtmgzdz1+OUTwhswBiOXZxljT0RAnMkMu6aQ+DXyiL0lN2r7lVtvAZsj5ThvV6Sq
         sDlul6Y7iXwJbJafIjimLJJGCsc1ZiPaWg4x3uR+hWjfIDBRbIDXfDeqAyGPt2J+kV3h
         n0G2JZCVU4qX+MoP/8VN7yQpIGXghx9MeIDDmcvGa7CXu7B4rPyVZnh3YBEDDdBKrh6b
         KdRMS+UE0cR/1BoSY/nWzhGsFbs9F5EWiawL+N3dakVxs4ThvqBtBoX4q4NSoB2K0zLE
         zlHA==
X-Forwarded-Encrypted: i=1; AFNElJ/IIjzlw8gqKLLsk7yCwjCj/MveIhSNDbEgv+6PwFpKYUaTWi9JBtjt9WpsmGGdZX4tAUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIlIfAO+CywQFaZI17b85BxOh6ZTr7mgY2T9iuJU9V/VrnrG0
	POAJHkWW8BGj5h+8yfrDPWX9MFRBnnfEhhCwdhARZPgu5AV0zYIJ76lI5wqFFl1HlA4=
X-Gm-Gg: AeBDietblESx+F+6lO90Gi35CghjAc31vmNSP1JFT26tMvMRvF6cFpwbHlar7mEYazM
	QBmQ3XBpPizNUjI6GJYP5G4icPtxc8BiFI79Vjy19UMOs6e0+W3gDVY7Xj5C27ND6Nn5xRez7zK
	k+7DQKR7kmlV7/qXCHrcECnyEbWMXbvUD0PjaCV3D9o4yeBklRirnmixj4qtXRra0fdzUwXEZ7c
	GD8j7xsIffZ1OCRWBUJ7c85xzwZH4tfvCvBoltuORD4sSRd6OglSqsiYTkYK2DMiq8JPdr9jZ6z
	/dxEYYPmCRjBXEYmxhPR3m5M9gvyf+zcyKo5VYUReFJdGtDs2ffHhL8O6sCBlD/nHVWEqClvWk/
	rLaTHbWSwJlv86UiW/da+X94bbekFFe3/AYdPezMY0PkjMS12p4kPX3BVv/fvy0PGWkFYBJJ9mT
	J5ER38wgXr9KDnyfRRiKQV9ntMUgwAEqdMJBL8osT/4gPHIQDoX/mbNADd2JEH+Pt5JejGOBNlq
	7IfU+GkSiSTat/KnmSrC8UiN+jlsAtlYWXaD8MdwuGZ4mYdVYx4RZANFbEImqjijjSDUjiXeaGt
	F/PWCMOP011L7SebtqgykRNuq10=
X-Received: by 2002:a05:690c:c509:b0:79c:ff02:a03d with SMTP id 00721157ae682-7b9ece6ad4emr2184647b3.10.1776373988393;
        Thu, 16 Apr 2026 14:13:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76931a99dsm29859997b3.39.2026.04.16.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:13:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:13:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
Message-ID: <aeFQ45A/2W4WidSq@nand.local>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqq8qam217m.fsf_-_@gitster.g>
 <xmqqv7dqzoeh.fsf@gitster.g>
 <xmqq1pgezkpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pgezkpw.fsf@gitster.g>

On Thu, Apr 16, 2026 at 01:58:03PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Of course, the tip of tb/incremental-midx-part-3.3 needs to be
> > adjusted with this before merging to 'seen'.  I think my tree is
> > getting ready to push the "revert the default" down to 'master'.
>
> I'll discard this patch, as Peff's latest one that enables v2 only
> when needed should make it unnecessary.

Yup, makes sense and sounds good.

Thanks,
Taylor
