Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AA3A4F5B
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476493; cv=none; b=i5An9mOeF13G0mDHX6L1+tKetD8aMRhL2NPWnd01YVIrSzexury4tELzPHo4/ysB9UVcghx1znNZzJQ292PlH81H+WBuWJGF6MscQTxX/Hol9uC+YZl9Q0GRYu46KlshtjPv8eVu7FAyjhQDFXM9iOiz+3h//DssMsIgPQZ5pkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476493; c=relaxed/simple;
	bh=Pweo/vXllSdTqwjFbQ1uWc9PnBUES1xhiq2GNnKnUjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKby4aoqQcANjZsFMDKXOasq1rEyBNtvJ0XkiSEiHPZbtdoNB9tEoS5snOkpTAjXNzYDv4Z5X43WIUiS0T4dwiheh478PqCiBDaLekUVlnY6Em2FANnV5aFGVoa/66hDRJGqpll3+uT3AU7KMhKNodwm5+diPJVmeYFXMBGvxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YAqRHoGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dng+QHgu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YAqRHoGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dng+QHgu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B47D7EC0139;
	Tue, 11 Aug 2026 15:28:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 15:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786476491; x=1786562891; bh=nXf9Nv5thD
	LaW/qbPVkjFyMX7euX1v1Tt9VCKv3HPLk=; b=YAqRHoGKeYeUq197yrhPL7u1ft
	C/kulsrC7gy5E8y3+j7nw3c8165MHnKXGn8fIMZ1LlDIvMPcYao5Lb65X2pZinPm
	nhhTj+5Cax6k/EfcMC4eN1RDrYRqcDeJPtMbk15BhizybZm3oUsz8tx/UZn6+DBg
	n7wSqeOUEXRN/e88sI/ZYEaywDIP5fKNL6NKwk8WlOTgJ6Kuy11icBs/CXt3zN/x
	YYLUiOQUqE/OeLFWwfjj7v0zr98nFvX9pHOo9V7Hte1bEeMuuDPK31mthoK14HTB
	CzJHcnhoAY+0s/wJI7qt1/bQ0ETwf4l2aqSVNZ/C/fqZYsCudQNncen1TgKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786476491; x=1786562891; bh=nXf9Nv5thDLaW/qbPVkjFyMX7euX1v1Tt9V
	CKv3HPLk=; b=Dng+QHguF4lZHvIqX9LURxmjwZ6uUFmTm1vRZaNfJup1Zc53kCS
	hG1OwCWa9LzTselm7/WAGVGn9sV2aystKbvdMi9q01rT1BhUOP6VFhyW3S3Kg4z2
	MB12shfvn9Vs9jWCQWQJJva9TOo0g4498xOxw2u3EdsP/5bwGcoyVV6SojPbJXYG
	TzxUu/EQdmcwMOp3GZGlI/p5odyR9fa/Io+H/0I0O8hbsvdTCl5oh4NTnqmDnQZ3
	UrH9eaAeTHsAovaqXpLk/ZJJ3VFsqb/L008P3PRXB4BRW8+YGygMIdRbYLPJyFV/
	ep5FKc/KPVQR6rIyWNfYTK/FOtd2HjKLYCQ==
X-ME-Sender: <xms:y3d7at6CQtXYyHXq1_ZfLh82g9LO4lKyqg6iej-w4fwevoOHr6KGxw>
    <xme:y3d7ault_q7EgNmY745CuWh2YYtCkWm4IuMISQDkpHRckk1mR7PCPe7CfncSRKlZl
    qnXP3fRvxpNqVdPlhEuSavilYM9pZUikgLVREdUJ9rMPjCZ2v4N>
X-ME-Received: <xmr:y3d7auR8o8Jx6LYnuGphip3Hldam9HrjRu6qI6Qw7FpRJHDR1_QN_U-Eee7LlFfDKYxGZQF-mQ_bD796NHLGpSvDSuJof5c5Yw>
X-ME-Proxy-Cause: dmFkZTEaoI6AHFiBzto462e1FIvvjpCXnc5BSiX7zNrWpJhaVCF8Q3y8gvvOB5E/HekLoJ
    d0oAWaKV/D2bj8y9nDeNUq0o1KT3v5cL7eHfpOy95Kwas2Rth8saXLrjKtJeicpuCREc7i
    oQBjN6447f9/InN1NdbAEH3L/C/ihj8MW0Jm4jrFHmrlG1ejynmiRQhb0pZ9hnJ4LPZZGp
    aWmwfUz2wKQZXTJeReac7w/5+TzpDyVgJjy/kE8a6Fo3lmlXMvwCVpM76KBBCuZJ5+7+b8
    Z5+IXK4f8Y+i5L0Hi2SaZAhO33rqNxLxjELSmJGqNCUUi5sYE9U19WNitlroiGD0UhWfcg
    vHl3S0jD1zkwRjwJCzjGXCixtLPlZIRvS6iEuRs/wEDWE8UsA6/U0BltG6hUo30qf+aIxn
    JDqgZM7/ZC2iH2ximpcaiplrCvNLGcKtrqd1Fmcrw6/nX936vJtpQJH6YBR5LmE6uj15Dp
    w+JBNAJc+FWb/3zdDFq9Amt32Epdz/HEVLX9gDtx+z3oY+xYyoBZiFDx5lkzfgT7sdlCO6
    tMFpAA18+zknymL2PiZaJ7xyGdDqFm7fm1VyTIy2eA7+/4uCIPnk9MlgByLwRa68HtEJMk
    TigFqbZXJgCtY/Svg1WTCytRUFYRCtcTTuAfNgfbsuc2IT5itfRf0ThvTTkQ
X-ME-Proxy: <xmx:y3d7atF07n9ekdBeqwwTZ2R4OhukhfxE8NNEznXo75GAYjpefWejaw>
    <xmx:y3d7ajFSnQp5P95lVY6uHsS4Rf6S_6GrGgzELUootq9EmVcwJA1L5w>
    <xmx:y3d7arQjMK_yEMBHaSLX_FKEJkljIEyzMivjv3HP_FJwHZWFU7F0IA>
    <xmx:y3d7akJii-f7ldL69A5H6vG8hIUUIVFjeGN12Fg9cgIDxumX5qzJBg>
    <xmx:y3d7avoKs5Lk0Ha1Lc47oTJU3vBu-evGC1isoTwrY1bYr-YRdEmmns9z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:28:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260811170200.43097-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Tue, 11 Aug 2026 13:02:00 -0400")
References: <20260811170200.43097-1-ggordon@gitlab.com>
Date: Tue, 11 Aug 2026 12:28:09 -0700
Message-ID: <xmqq8q6c1mpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

> CURLOPT_SSL_VERIFYSTATUS has been available since libcurl 7.41.0, well
> below the 7.61.0 floor documented in INSTALL, so no version guard is
> needed.

Good to see that the author paid extra attention to compatibility.

> +	/*
> +	 * Ask the TLS backend to check the certificate's revocation
> +	 * status via the stapled OCSP response. libcurl defaults this
> +	 * off, and no backend except GnuTLS consults the staple on its
> +	 * own, so without this git will happily accept a certificate
> +	 * whose own staple says it has been revoked.
> +	 *
> +	 * Off by default because it is fail-closed: a server that
> +	 * staples nothing fails verification outright, so enabling it
> +	 * globally would break every remote that does not staple.
> +	 */

The comment may not be telling any lies per se, but it is dubious
that this belongs here as an in-code comment.  Developers hunting a
bug they suspect this setting might have caused will need access to
this information, and they can access it by running 'git blame' to
locate the commit that introduced the code.  As long as a solid
commit log message explains how you arrived at various design
decisions (such as 'off by default because'), they can use that as a
starting point.  For other developers hunting different bugs or
trying to add their own enhancements, the comment is a mere
distraction.

> +	if (curl_ssl_verify_status &&
> +	    curl_easy_setopt(result, CURLOPT_SSL_VERIFYSTATUS, 1L) != CURLE_OK)
> +		die(_("http.sslVerifyStatus is set, but the TLS backend of "
> +		      "this libcurl cannot verify certificate status"));
> +


Thanks.
