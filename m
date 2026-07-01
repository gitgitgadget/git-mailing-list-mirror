Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB043BFACE
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892590; cv=none; b=jpjV+aD6QdiNA29aVzVwBAtTE7JMTr/IrAaatthY+JfkFUj3W9J8Uf66l73yqGSy1NM6tsf0g4OYR0wJWi4LSdHjXtc34td884ihR7qHdv+vpmUxga/SdANHtR2ao5StiICx1wnnNyEYWI5uK6/VdoWwTs7HSv7MeMXAI2zyC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892590; c=relaxed/simple;
	bh=83dZERTdJbKC//IARbdtOVmNl3S5yPOINqkSA/pTKuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNndq1Od7foAFreaUExBEzes20Jmw9OkgB4YCmQfs3N82BD7jpnbAwzkDknR8APaKBaYZX0mqT+Q/HhzqwiPGgvyzGUOQya/iNqEZwOm7n26/frPukLf52QuJKdV7lTNGBNb0kT2ByV4trEHtQDsMHNBE2/nsHmTD71vEDAKEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jh7pQyx9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVY+IjWv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jh7pQyx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVY+IjWv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07CDD140007F;
	Wed,  1 Jul 2026 03:56:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 03:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782892588; x=1782978988; bh=kiU/CX9xpU
	GFrof4rRpqkNWjTtc5jA4jdNToYcHkxN4=; b=jh7pQyx9LDcP7WJtacO5lVSpfD
	6eckfFLZz5qCMgDkOdTE5kG9fg+XumJw7gRLkFwbLGeaZTtMTbRFpCDfTPeO5JuW
	5MKCjBVilyEnMxxTDITDcSZ1KmxqQkuSJbuuP9m9UDpgHunWrCMvFYiqdBjZsR2K
	j8LRLVgPSwCsQHs/Cq/tl9mmG75OQLB5LvPumTkZJnlgU+AG21hMfNn6XSlk4gGi
	0g6gJ9zS3AhLRaTs+miXaK+kIWciP9xdA5wxXwZEjphUOxKr9lC46pYeFfA2HpZG
	y8mj5pz8O0hDzbphIbMBwTwfCcjSSu69SjjjPGWMQEkK6IPZQQLhDq+g0NKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782892588; x=1782978988; bh=kiU/CX9xpUGFrof4rRpqkNWjTtc5jA4jdNT
	oYcHkxN4=; b=fVY+IjWvePlE5Xs9F6g2EWCJFsluYWoxlPosbeOt7RitEwsJ6hK
	qaLdBRMzV6JxLUycDsrqcF1sZDidSDJH6HcW6zYw/OBocO2jJSw/suxCmBRCIbqJ
	LIhbvJKcS9R4mT1LFhGpyzzVUTH7LzF9O132P2IbOy3VQMALihPfAvOKpkZgJIa9
	L6aUJWuTVaxuCjnC7dZSfs9QZUHxNVxPaVZ6munZrvlXYJgH89vGO5w/zkURNRNS
	ATn+TwRytTk3FP4Mh7UEloKYeZxEkFIRFuWDAbKp3JqKaCxdcl4Pv8Cp88y1+o7x
	SpFBsnEXn1t3KIUIk4JnODYegOVxL0UVnCg==
X-ME-Sender: <xms:K8hEasWc5KyBOpaWzCrjaxE-epLxcuQJwRcgYftlBRlr-uh9RXLRQA>
    <xme:K8hEaoC1nQ8T9BhJJkKXaFEAhvEsqHrpQppmNE6Bpd7Chpb_YBPxyO5RXBYnXc7FR
    OjM7_al2zg-qyKjoQJ5ghRE0Tc9nWEPMPcXgS6PQSQrSM0Cgaz9ug>
X-ME-Received: <xmr:K8hEatxPtd2e8gFNBKTk9fiSr4ThTKVUmdspjxZjzxg44YaWM83mnwtMH5zIqkyFM2LKzbttAqrRXIFK7u5qHdLmgHirmfxQ5l_kKU3QNxI>
X-ME-Proxy-Cause: dmFkZTGutH4VPekMr3nGBRJTNuUCkDt6dctaQ67FtHfh6nPNO6kYnQb03KlxMUA9+/EjCl
    iLm3qaFJ4D955OVwUbFbOgfvWj3VIVUmQbTGFUnj47S56ZK94+vffgw4msEYSu/pFs2hXZ
    Hl+M1+BH2bvahlSJ3QQ6H3hkp0aFQiqka75hiaG0P5rITlEKP36DXB9wrfdH54n42Gm91F
    WIgUPu2P9qC5doSYFV6kumGoPh+D5WvGs9htUY6nurHZ0w7GLl+9Fy1tiljb4QdjMFeHy3
    BLFelF/6OTXyeDrg6LbK3SU5JcTG1uk7DJp7nngRRpzciFiislg9jl5e8hOa6CfeoK9Va0
    Mq3Mxb+FjpZaty94TCe3QwCS5VYosAN56bo1EdD8bk6fX94Dfb1lYc/wmsYHRedJ54fjSk
    ixEux/MLiMxbmhwFT9qDBq1DeN9IqddH4efc6lVMuL20RwCUNqXtgNd9ocqzhxx29dXxau
    IRYva9CtWJBt2Tj3WHG3Oa6yeSkjLxH74M/o5EHs3kY4vRM6RZAg2X4Agjoh9XiIDxp0iV
    zg/ijEWRd8edLTpSRFhPckYD1koiRCQ3KymqnIPVmeg0eOTiMu/2JSiz29RszB2+rlArEp
    qvnKaLAM4yYXAbHlWg5fEFQPCfdTiZeR9kRtl/kEjD9HCLLjs5iGK08w4Lng
X-ME-Proxy: <xmx:K8hEalAsjZvJuKVp1QAPuaFidyq7kTK81cgjbBohht_9FCqBPIyOgA>
    <xmx:K8hEaqY5DbUB0gPcITyDeH7HZjg-W_zt2NYa95aeRLeUep3J-W3Uyw>
    <xmx:K8hEatgwBhz4-YhbxfUh_eV2nlKVu-3BeHAlqqlBSGfOo4erPsWjPw>
    <xmx:K8hEas7ld0OmfP8z3SihiK5_vd7YOmGVLSfWYFOkxZh1qGQwz09JJQ>
    <xmx:LMhEapgpIQu79dc299SL9JOE0tzF9aMDO3fBAzWjtcWmrpgu-Nj7IozK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 03:56:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48798ef3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 07:56:24 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:56:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/13] loose: avoid closing invalid fd on error path
Message-ID: <akTIIaxwqqFaVxj1@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <a1cd229e33c0ecf8ccbef9ab07b4b93896eae22e.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1cd229e33c0ecf8ccbef9ab07b4b93896eae22e.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:20AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/loose.c b/loose.c
> index 47b7f5ec38..2c6db45245 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -202,7 +202,8 @@ static int write_one_object(struct odb_source_loose *loose,
>  	return 0;
>  errout:
>  	error_errno(_("failed to write loose object index %s"), path.buf);
> -	close(fd);
> +	if (fd >= 0)
> +		close(fd);
>  	rollback_lock_file(&lock);
>  	strbuf_release(&buf);
>  	strbuf_release(&path);

Makes sense. At the time we hit the first `goto errout` we have already
assigned `fd = open(...)`, so we know it should be either negative or a
positive file descriptor.

There's also a second call to `close(fd)`, but if that call is
successful then we would not use the `errout` path. If it fails we may
try to close the file descriptor a second time, but that's probably a
non-issue.

Patrick
