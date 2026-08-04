Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2113EC81F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830606; cv=none; b=XAPXXuga6ATPytyQ1F5HSu1NhlpF3IzVllZh7pWVQiw6hpgYf4QueyEIQ4zwPccUjdgjM2gu0XsaV1yrUbk9SZ5ZklMgPgTcI0MmBoFxnIxOyCT1rtLK3g2MiPOT9b1CB8kZHmTIjVEERAuJBi5bd1yjbTUOASHpFzwp/OsG3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830606; c=relaxed/simple;
	bh=nyOXCO2OEYrSF6DvMpAzBpU0kVKCP4L3qnqa08eUBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EULsbv1ail8Bwkyemmc0b1LzT7QGfIuu0tDovzRI6s6s0uSa/E8Ktw0hfyw7LpDihDHLVBPgeQhGtUcUfJhTTFo4fYrFbTL+pIMrmZq2qojsD2XIeXD2+fJklZ7/o0aiAFqMc3dBxzHAPmbJelj1WZTGR2Jkp/ZNtK60N79FF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTl+uY6/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfjAFTiK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTl+uY6/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfjAFTiK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 738A27A0045;
	Tue,  4 Aug 2026 04:03:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 04:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785830604; x=1785917004; bh=9eD/0IjjSB
	cqOyJGyNgZ/+uc8WlB04kxPZS/DXvYKtw=; b=KTl+uY6/aFLyA92yL8f8JtVzIZ
	zvh9CXGQ2MP5bx9Tvr4aujNNPJgHEt+QlnNkCMt/Tw24qEL+2bzOp06yuXMIe6Tm
	MntGs2E/MLgpxxEWzps7y53MqiygL1c3XFfaMnUld2EwIuBfbU0MYIrjvKgCT2zj
	gcDX8+sCmwqF+3X4vDmp4F1HxX0XHmwbTUEOAw+B2NsIKi7o0rNKP3E+tZspVtX3
	KviH5L2oM5ZXPDn/NLMP4ZTsFBV2nR1Y3Wh3PwPU+aNvCHLAvybs8EaP56Pmq0uJ
	MkpAsw5KKLiP3SJnYlj/nMIL8IrC65HHJVXch5wgwdE0x1pNZMhXkOspipIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785830604; x=1785917004; bh=9eD/0IjjSBcqOyJGyNgZ/+uc8WlB04kxPZS
	/DXvYKtw=; b=CfjAFTiKgfFpO/LP4hsUsoq89Pa75+L/RC71+1HFujoTjNl8TxB
	+8nwvDa5tc70x5v/uvp37lsrqIrEKF9tVFSEyNK58GlAHeHvb4mLvueqZW/QyoH8
	rGqWi+t0EjCme4Y1tus1KTm22qFhBDDNkG9jVMy2nWkJBIRkB0eaWP/rAfd4q8vV
	NrCeAJeqL4g2PJbsi/IDeUssSmJLvwWarW0mg2ITXUNQ8EzmoNI0hEnQpCvOGmV1
	/s/u5+oozecwBlPW9IAsnwfwuxTnvMNurrLGi01BAGyVthxBqzyBBb0jVqNJFH41
	nM8s6sT9EL343y6cjL9CNzIvAWbPO3CofFA==
X-ME-Sender: <xms:zJxxapTRUHx_HYC_tiRehYqhsTuIMgqRLMx4Ns5P4uC6V6NoVCMaEQ>
    <xme:zJxxaqMr9sizM3tcIKdwFMNoJLCIKbstaGk9OJZyV8-WUSwg3kmlZxu3XEuRxpxdg
    O_DiI7G7B_jjazWHuvw4R3FqIQKNPxVpR9ywhpJdHExshYVcyrzXw>
X-ME-Received: <xmr:zJxxasMOx4S3YiwQrThpoHNoLQrEfcmyYPESJk4G8-WNrSI9ZsLshucBQcpibbGlx9xNZc5vg5JC_G4j0lkdCHHk6XrRfI8MSSJ3XGvM>
X-ME-Proxy-Cause: dmFkZTFtS23iDodEFZ5RDT+c2iRhG++4MgU8A6ydGisgJXXy+qcuaiWy0iQ5sAXAqVpJ0v
    TpMfKz07fltuZK2Xw311xulspJ/WR53VMk8kT65L9ojvf2JN9OOmx+z8fuBg0hL+jDt8Cv
    0a4LeHlIW0iuwlXIztxakFx+CbwewCtzXZk89hzhslQ9cz6nYsiY4K16rL6z6ZomI69nHP
    923pjMAWq1TdwcH9XHdrEL/5TjvWtmyVyHyL308Tb2BtkmMOr5xWg5Pozu4reGz2n8y5VF
    W5889I3e5leJ2/CxUcw1a+HtobRlc7jm3DS9avXawA5NvAyNzbP7AmVSpLWEnXofzC3MOD
    ihNu/J5J5JyRIDO/xN/63FeQ4tajIYDRk4n8x1uverCn1eDF2IBVKVgGWOFq4nmeWuPheF
    VzAH4/OCQX58b1QmFf4At8GMkgOtsxOFK7YEVc9ErWABRxTqtouvW9D/PxXazpTARp55zE
    Zr5UPjvQJef5EnHNwiwKtK0jVEky9zD+RHi6Tdmt0bkTkL4wkDp2B6SzVIK5qXVSJ0ivuZ
    sx17YgSijpXscHf+jwkSfopqaJgZn74sAAgqHI2dFaSY4kNiOb3T8Ea8kuxeftYMJ997Bh
    bfVPbJxF2ZG0a0wdWmbQ30n2aitmbZh/z4F4yuOxkXjTnaI47X7V42rCNs6g
X-ME-Proxy: <xmx:zJxxaqv-kv5A0N8YDHvowqNESPILADDS-koisv9pKSlmXMjbj4IiOw>
    <xmx:zJxxamWMae-fx38YvjIyIFWRxbR03ADv77rsQdoFwgBt6VOP61xqIQ>
    <xmx:zJxxaisGwdEUQ3eE17rvR_m-wk_IJmcm30eMzkgChHRQ4IVu1W-pBw>
    <xmx:zJxxaiVMMSLwBD44kmAt6jpBVb-6kVOetwErje5TtTZzVsdNASrxTg>
    <xmx:zJxxaiI9skatEEGIqK7KKCQb4svVaR-BfN51eCvq7y2N5k7tT0eqLM-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:03:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d31cbc0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:03:22 +0000 (UTC)
Date: Tue, 4 Aug 2026 10:03:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 3/3] t/README: document writing concurrency-safe
 helpers
Message-ID: <anGcx4lRyy3jyS1D@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
 <f158e1f92e9c586fca34faecaef23f9581d65478.1783704657.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f158e1f92e9c586fca34faecaef23f9581d65478.1783704657.git.gitgitgadget@gmail.com>

On Fri, Jul 10, 2026 at 05:30:57PM +0000, Michael Montalbo via GitGitGadget wrote:
> diff --git a/t/README b/t/README
> index 085921be4b..a9d425f392 100644
> --- a/t/README
> +++ b/t/README
> @@ -854,6 +854,38 @@ from the test harness library.  At the end of the script, call
>  'test_done'.
>  
>  
> +Writing concurrency-safe helpers
> +--------------------------------

Nit: this paragraph is quite specific to lib-httpd, so it would make
sense to mention it in the header here. E.g.

    Writing concurrency-safe lib-httpd helpers

> +Some test code runs concurrently: a test may background work with '&',
> +and the helper scripts installed for the web server (in t/lib-httpd) are
> +run once per request, so the same script can execute for several
> +requests at once.  Such code cannot assume it has exclusive access to a
> +file.
> +
> +When exactly one of several concurrent processes needs to "win" a
> +decision, a single atomic filesystem operation can make it, rather than
> +a check followed by a separate action.  A "test -f X" then "touch X"
> +(or "rm X") races: two processes can both pass the check before either
> +acts.  Two atomic operations avoid this:
> +
> + - "mkdir dir", which fails if the directory already exists, so that
> +   exactly one caller wins, electing a first or only request (see
> +   t/lib-httpd/http-429.sh).
> +
> + - "mv src dst" (rename), which fails if the source is gone, so that
> +   exactly one caller consumes it, claiming a planted one-shot marker
> +   (see t/lib-httpd/apply-one-time-script.sh).

A simple "rm" (without "-f") should work as well, right?

> +A "$$" suffix on per-request scratch files keeps concurrent invocations
> +from clobbering each other's fixed-name files.

Nit: it might be a bit easier to read if we explicitly mention PIDs
instead of assuming that every reader immediately knows that "$$" will
expand to the PID. E.g.:

    Appending a PID to the per-request scratch filenames keeps...

Thanks!

Patrick
