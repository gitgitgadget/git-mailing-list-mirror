Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BDB262FC1
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040928; cv=none; b=g0uxkAH2/Fl0mm3Ek0x2eNkmtmwN7Md7I+JYnYDMLkZTpufus4etxiAS0djTw+dbueN41sjcqK6exM7Zz/h0vJwUjQ84BTHcMobQ9dQu2haaYkY5quk3RQCNbL9A2ipXegMT8FG2dDP1eHF/nfozGhxRcv3ramTjgZHZ350NO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040928; c=relaxed/simple;
	bh=eo7WNM2Egv3zm8B0e2DK1d9j1x9ECTChkNfnMnCxva8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwZNtCECJ8Eq+mMTGELpCzdC8EUXWYVLYKSg1caCEgEG+BSIOpPpk2H/xv+tD52DeqUH07H9IFroEtIIy3hglZl/oyDnJo48bNeZdZN5ssB0M7xfV9qrtoZ57KxUa4orsAGo9gj3pgwJ2mjoXdOmkyWWpn3kq8Mrl604dEl433U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gxj6CatU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gxj6CatU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927b1620ddso6593527b3.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769040918; x=1769645718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eo7WNM2Egv3zm8B0e2DK1d9j1x9ECTChkNfnMnCxva8=;
        b=gxj6CatUWqmk73kDpgxrn4S4OL3257H5wnlRbRhUhHFkp3rgWE7LEGwaMhU9nXiSBD
         gm7Q/HcQ4H9elXi7wz/ZogC0mDyT+nz8It1IlMH+BTooKWooYhTJRKmHMRm85wemghyt
         gOINp+oNd0/9ZInxrOMBhBULAsJoUE4AwYU7pLnxzbh2XAycjhdl/HKefr6VDbE0Uuez
         W7hg5Eq2Oxg1Z51+imn3nJS8wzO/J4p6qizVZjkKcCg47FYuGjeyRfG/lPGFKNWJULuq
         iHDGktLbbUsNK5129TbCtiH2MyNIRCMuyrxUTezlM0l4Gpw+NDaUu+4qguwctXhNen28
         trfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040918; x=1769645718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo7WNM2Egv3zm8B0e2DK1d9j1x9ECTChkNfnMnCxva8=;
        b=qfAaey7E98StlznPTH7PCZDxr0mjNobx8dEUuboC/R5ZmgUUPhj7/L8tyRMB9iaA/R
         K4wGLuOOzQcWHhcmRhv7T03k5mEytod469WKykdFuRx3We/RBaF23zIJCQ9vOAaU2PFG
         Jwu/VHaS+JN1aVCXckd9QRbZfZ5mNqDhifTtOFSABKc3hBJtH3jI6x4EOx9NVlWY65cz
         2MHSlRXxiN+xMDznRZUioN6wcCetFmEPLTjndiF/7a6RW2W0ScG2BiCZ6WBRg23wM/2I
         9JrOia0oA4C3Zo3BxvL6zvKEa2navDRj+jJ7nOIuwKmDWrCSM78UzdjSj94XRGOdtWI7
         JFrA==
X-Gm-Message-State: AOJu0YwbC6bZFCXEq1nmWvcExibAn1pLXPLmv7/GHE4pmmpXtvSDJ0cF
	vPCk+NQw3qzxGSSFQO1patiVNxtsDVqqp63KcOIucP2ABVZYnYjfV9K51Ue7bCmOB/A=
X-Gm-Gg: AZuq6aIoLIDM6F84dkS8W4YAr2uKEQa1QDPTWDSrNUDz4Q6J2+nYJJHeHbeZWtqlJoL
	Kgl6kPQdI8z7HfLpl594q+mPDmQ0JmmF+ilJLwupu5Rh7THrtBv+EVighFXNnKXFraH3zVHdn6m
	3ofbmQA4EBLBCc/GSetdykl3TOJ4lVPt/WsUpeFkk+hBo8Db0FV5JSLmddVgaevgFaTAWnnWKgx
	WWa+od9oHC/BOMqJ4Yitha51kewCzlReT4s3aFYLdBp2i1gjOFn4Nl8+uQL8lnCXwDc+WspN5+h
	+j7Qzf1GYjhXlcyEW/78i1LpI7/2iTozjNfx9pWW+pwQ8qAoiGCACdYTIMriTzV0SMsCkJ9cowQ
	9gH0neIOOkNXirMvt8qGdChTdjU6xdPVUHQxKRqXVi1VmGVw0S/EAcSLgQr1nQMqjHR0Z3t3bGO
	YWR0NbU4sTNlZcuntV1Fnni63GpFla1Wav9uxLVtIYrLUbrD28bEe2wVFr4KLO98F6nIK3ITI7N
	CposQib0o1K6EpYVQ==
X-Received: by 2002:a05:690c:d8d:b0:794:105c:d684 with SMTP id 00721157ae682-7942a7ff8d3mr11290657b3.30.1769040918313;
        Wed, 21 Jan 2026 16:15:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c686db17sm72698437b3.38.2026.01.21.16.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:15:17 -0800 (PST)
Date: Wed, 21 Jan 2026 19:15:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/14] object-file: introduce function to iterate
 through objects
Message-ID: <aXFsFAV/1J9DLQRY@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-4-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-4-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:20PM +0100, Patrick Steinhardt wrote:
> Introduce a new function `odb_source_loose_for_each_object()` to plug
> this gap. This function doesn't take any data specific to loose objects,
> but instead it accepts a `struct object_info` that will be populated the
> exact same as if `odb_source_loose_read_object()` was called.

This may be a bit of a tangent, but I wonder if we are over-applying the
function prefixing convention.

In general I am really happy with this convention, and it yields
organized headers where functions are clearly grouped by what structure
they operate on. But I have noticed a handful of times where we replaced
a very concise function name with a longer prefixed version.

I think I don't have a clear sense of what the benefit of prefixing is
in this particular instance. Supposing for a moment that we don't have
an existing for_each_loose_object() function (which I think is the
end-state of this series). What does the name
"odb_source_loose_for_each_object()" convey that
"for_each_loose_object()" does not?

I think if there were multiple ways to iterate over loose objects, it
makes a lot of sense to prefix them such that they are grouped to avoid
mixing interfaces or using one API when you meant to call another. But
my understanding is that the intent here is to consolidate all of the
different ways to iterate over objects which live in different
odb_source implementations opaque to the caller. As a result, what other
way exists to iterate over loose objects?

Another aspect of this is how approachable the function is to newcomers.
On the one hand, I can see an argument that prefixing makes it clear
which functions belong together, and so if a newcomer is familiar with
the concept of ODB sources, then they should reasonably expect that a
function to iterate over loose objects would begin with "odb_source_".

But on the other hand, while a newcomer may be familiar with the basics
of Git's object model enough to understand the distinction between loose
and packed objects, they may not be familiar with the concept of an ODB
source. In that case, the prefix makes it somewhat more difficult to
find the right function to use.

I think there is a reasonable argument towards prefixing in the case
that we want to link against this function from outside of Git. But
AFAIK that is not likely to happen in the near future. So in the interim
I think we are left with function names which are a little more verbose
than the ones they are replacing without a clear benefit.

To be clear, I am generally in favor of this convention and have been
applying it myself especially when splitting out the repack builtin
implementation into their own compilation units. But I wonder if we
could relax the convention in cases like these without sacrificing
clarity/organization.

Thanks,
Taylor
