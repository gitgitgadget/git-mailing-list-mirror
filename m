Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFC3DD523
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492886; cv=none; b=bGSYaXwZoRwMDz4IXYt6nC11rGG5gda5w0zPSJYCj1datsvxT6z6TQzi0e/qFDoWhvCCTTYG6EXtoQltkqk6BuD+f7jd1lqrVn7c3g+sfE+6bOnU2Awtbmthwx/nZwlqB8wUwEx0FKdKXYn06lp0hwUmHOOlqvv07QuhqXxk4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492886; c=relaxed/simple;
	bh=BlCci8GghtH2r1ZN/DP5WmN9TnYhVsrU4kk0NjDK6Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ27WBOOyZhFHzv46ss6T7O/NI7yc8doJgH6mb3wfx4ftBn9GNGLJE92qKddjzme3oJ/F9426HfT8M9sMnl3necwcuQ38UYSSEg89dIbv45bEDVXqvlivjEfJIOSADEgOhlVl1DkOGl7ZZjnzyBg58oBpxgw7IOxw7lkbbxCSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e3m34GDg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrrwK/rc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e3m34GDg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrrwK/rc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D04C1400052;
	Wed,  8 Jul 2026 02:41:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 02:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492880; x=1783579280; bh=OG7OLjn23S
	l78F54seTVFphOzGRJE+MlOUwrX1qeMTc=; b=e3m34GDgw5kEWb8qLSbqSf472s
	k4IJ1hBOOrvOjwk3hk/aOrS4XAfeUqlcbZXt898BuqJBPdX3V7KYuNmtbg691lHg
	Irz/4VNAjTix6AOsdlySMDUpSS0Xc44nGM9U0RsynNVHjzNezQwz2OaFGHow/W/2
	E1BzgBFxtdowHsztF/LTfUJij1M760XElMiWq3m10Ckj8B7nmjQB7Ur/cAsC2g02
	1OJOKTmq0/OEpEu8Y6M3QTyIxqUEthUnF03aEudWMByBx5mnWlv4sRU1bRMHSLvh
	btnVV0OTcslpsBx41n2Q4ygis8lLGuj8YXAfTq2f4TeO8p1IUPPQBMku5kYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492880; x=1783579280; bh=OG7OLjn23Sl78F54seTVFphOzGRJE+MlOUw
	rX1qeMTc=; b=DrrwK/rcOB6J3ipTDdvTQYwgykC+sEp2PkcmA50RD83TIfFXbK7
	qtagXPkmgx553NwpRpuceiAnRzUplAFBK8q50gOEca0b9WdV3U9b9rV4rKoIoz/+
	jV/bRo4CufvCgDhMJPbO3snEhNS5XpGGq/5B2/dB6C0nw5tIdOhQIejdtwkUl+Ul
	k5K8oNy1Ds97FNofBAYnX1OMEnjPX9cr3MAT2Lhf4Fcs0Cj4OKJeB6QtkUixlzmZ
	EqzmPUlp6l7hMzHQei1BJh/vvRSmoeum4Ez4hFY7+h5GIHDHu99uPVFcYF8KvudF
	a/QSmlr4UIMoDFTD0R192+kGDfCpoEMhDnA==
X-ME-Sender: <xms:EPFNalvlprE49dOXwLK3A5jRS6V4h2y_pSin1bwLHhvVK_Uxq7ZHEA>
    <xme:EPFNal5h1aHPMK2IddT61VC9kCBia2e0OqC66BLGSjqFvJIRrxDUQ8T4MbxKX2lFz
    HWP1h7BKfPBMFwEVYhwD0lbRlDYc2HaA1G3Eid7hrF-ub5FDeGXQg>
X-ME-Received: <xmr:EPFNamLxehhXmoATFAVvTEoijWwmXLnOJo2XjUpI6_1vpo5Say4pcS9bVOrlOMol4jxvMMAJBmm0Y8bpb6wrgEdXaoTkW8NbCX76NwoB>
X-ME-Proxy-Cause: dmFkZTEJVBO2g82wtc7/fbEgQn4DOPI0WF2VkrtuxIPMUXcvbVxBmZUWiIZF2v/oJqOIZb
    5lk5WNv+Y7JSx0KdOF/WDe7+/hzMQBqmvp51smh0GcSNKDmay+2OF/JD9RY1Sg8MGTs+v2
    1pombUfjC9z/jgep8fkDJVWhpKFmANI1/b/6NwVwNRBoghAPs0yp5ffY7UmBqh3dwSlpqV
    EoVlnblbbcQBaJLafeo2gNSp+MVavoSJ3O3kRSHXHytYt2dAUyQcunJvmEDgI2sczXYoEV
    F5iw16oMy9AXauntnXI3lCamHBQzuGKTOgB0UGk6Sw4svZFX9EJty6EfAtPFLvPIkV3gD3
    dhejkIryE41mXyJmbeq2nmbjYSTG/OAKm+d7xOmU0m0fmcx9k3ahjHrOXB9fqwHl7d7Lsu
    OkNS5xV8D0gLRzVz6rNFRb3K2Sfzi3kZ2N/7A4X3rNZVKXY7xM8u0qH8pnqBXFJ3Hiyyfz
    XNBtJuUU96bL7V5jB/JQ7BG+/bKXrtaPJ+MXekTCFnDaPhvyIjUoEHWi2jYv4gJdHkV2kj
    K71x/SluVReFXJk3MVbqKn0TwKIWIlPpn8Y6Br72UYuHukw48rE8TZ8VFas01A7CnuoigQ
    A/tJnQrQEdTpsNiKf2EFarbY5bV0glrBu0MEfVBILDuOwY743PtjRsgVxYBw
X-ME-Proxy: <xmx:EPFNal5WWUyK3y7lAF2OjBYbEiJrhNjYzj8pnPBTXh4sBxznycacbg>
    <xmx:EPFNapy1q1J6ShAb6tvLyo5oNi4Ldjfx00whhrTX2RjwxzmuuUCK2Q>
    <xmx:EPFNapb8pzbazupBCxCSqu60jq8O-ApiEYICO_5kqEM10psnCgKvJQ>
    <xmx:EPFNarRZkI7VLL0VC-K-Bf-z6eJp8HuucuP51wGu3XdPc5ry8EY5sA>
    <xmx:EPFNah4t6dfnZU1di7uMaSMUDoRLSLZPnVYYrMqjnk8taufvorbCr8M3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24d3b003 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:17 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 02/11] object-file: rename files transaction fsync
 function
Message-ID: <ak3xB-18mCVWMUVn@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-3-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:03PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index a3eb8d71dd..d68824bb44 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -518,12 +518,17 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
>  		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
>  }
>  
> -static void fsync_loose_object_transaction(struct odb_transaction *base,
> -					   int fd, const char *filename)
> +static void odb_transaction_files_fsync(struct odb_transaction *base,
> +					int fd, const char *filename)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of_or_null(base, struct odb_transaction_files, base);
>  
> +	if (!transaction || !transaction->objdir) {
> +		fsync_or_die(fd, filename);
> +		return;
> +	}

The change results in a tiny bit of duplication, but I agree that it's
easier to reason about.

> @@ -531,8 +536,7 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,

Somewhat funny that the diff renderer decided to put the hunk header
here instead of showing the single line that's now missing from the
diff.

>  	 * before renaming the objects to their final names as part of
>  	 * flush_batch_fsync.
>  	 */
> -	if (!transaction || !transaction->objdir ||
> -	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
> +	if (git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
>  		if (errno == ENOSYS)
>  			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
>  		fsync_or_die(fd, filename);

Thanks!

Patrick
