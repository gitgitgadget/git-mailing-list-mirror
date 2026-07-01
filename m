Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8E3BFACE
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892594; cv=none; b=T59p9QnVNGrI5iG1tsekAKTVZbDZB6zRy+KFy7rh6B4cwfLNE4DtscIo6JNUN6yKgs2/IfjGbOZA3n6Pqbch64WQuKDLO6MXArlPnKsZUVpSk+nTtmUC7vPlx29pXR2M5kEkJBfdQn5NAMwA2TcvcncGr8H6J3pnm1bed2cDzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892594; c=relaxed/simple;
	bh=rL4mFxNQNkL+ZyexngIdJOyaC83a1hBZEFJ44uJjR3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVtMw7cacQOln38E8Dvp+LbK/NgmoNDONU4wYAFECrnqLCsb929L7/c4I5+VKymv4M5J9en0pn7WoQa3ADYmex8rkVyj92CJ18P4ymOhlzndAxjJ9rnBDYSf38RDfeobvm9xBodKJTrwFAzwgi3g0VbqkKpxpaKrzBDqxJKwtME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R7gowXgN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKRZuu5/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R7gowXgN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKRZuu5/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2327140007F;
	Wed,  1 Jul 2026 03:56:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 03:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782892591; x=1782978991; bh=F2Noj36ILt
	q9YELFggvXPRtafCC4YYzvwEEHllHzwSA=; b=R7gowXgNw4juCeAv4qpMqF8Lve
	8oLIgrLIx7zqI1D5beLc5WMiF7u5tiVY5XUh5t07cLUOv3qlGz+Pe3AQvfUIuLje
	FaL74RkG5nC3jhHKTFWrnhidwZ9pm5tLDBc4cQWyoL7B4k02wkDDqq1ra7+wZFOp
	HNBhyR5hHSnFC+CBR51sTjQt0xB6vJwtki0pszH398v3HGOO3p7QNgKSgPo86F7x
	7I7fSfjxFtYWfZFkHGKK1lQyMqs8y25+uwQF5uugPtmWjg10ElxeIn2WWV8sKpJ3
	y+fmBK8MmDdiV8hMfnYguumspDwO4wX6znAscd8GAUXJHHBGK1Ua6nG74OSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782892591; x=1782978991; bh=F2Noj36ILtq9YELFggvXPRtafCC4YYzvwEE
	HllHzwSA=; b=IKRZuu5/Q2dcIe5ljPnHS94Y9STV5N0Gf0ju5quCjlorFXyfbiZ
	tmj0ZspQ5d6/YucIDWaPBealn2aoTX68/eChjCO9nsBcOohC2mQgBtNBGuCA3EFh
	7cR8d4FHOBtr1KPuTq/WLLUBeoDcNpEqtGkYc+VHYAz8WDrEZqeyJW4c6jftM2jX
	xAlbgJMa0f2iKqgmQ04KAY32Czt3w7khxS6LfaKDFJjkT7Bvkvf31NjKQ5MVK940
	edU7eW5+MZe37txQYJYdOt4Fk2/e4JmTcojk+kJkHMZeVo7sxQCe+u96AcymdI/A
	BQU7+iOXHSr0B02M4n1llgBwprE0s7yn8Ng==
X-ME-Sender: <xms:L8hEaloIyD8Onn9Fv3spDiDnQEkvRvT3aB5cfyeaL7S3tM6a74xbMg>
    <xme:L8hEavFhdlBxXODDt-EucQyyHqHU7dIVTyV7Q8eicg9ZfRxizcl3InyMtPqSd2PxN
    ytl_gixiv8aDbQOnzHhDQ0LVNASbmoOI8ThIncLqDMdbtRS2JXWEg>
X-ME-Received: <xmr:L8hEavlBEBsKjYOzCBt_7uIzEfOxFtRK41Myn43crt34TylAwLtq5V1Z38aDVj_y2jfuFJ1ebQ-zLA2P-A0swRAnWDfKJChvjbx-Z-RCrKY>
X-ME-Proxy-Cause: dmFkZTGutH4VPekMr3nGBRJTNuUCkDt6dctaQ67FtHfh6nPNO6kYnQb03KlxMUA9+/EjCl
    iLm3qaFJ4D955OVwUbFbOgfvWj3VIVUmQbTGFUnj47S56ZK94+vffgw4msEYSu/pFs2hXZ
    Hl+M1+BH2bvahlSJ3QQ6H3hkp0aFQiqka75hiaG0P5rITlEKP36DXB9wrfdH54n42Gm91F
    WIgUPu2P9qC5doSYFV6kumGoPh+D5WvGs9htUY6nurHZ0w7GLl+9Fy1tiljb4QdjMFeHy3
    BLFelF/6OTXyeDrg6LbK3SU5JcTG1uk7DJp7nngRRpzciFiislg9jl5e8hOa6CfeoK9VjO
    AZOT0T4okkJ5w9UN7M+Kt9BypU91c4ixeo2xPCwnoeNx37EvFDCp/HQtDOufdxeocv4tdD
    H4rMSOMIo2lmMlNCd0DrVdHlL/FUOMQuodn5xix0IEruPuoYsYrG0ktji2f+woD87ie6rs
    0AdLoc6RBEYxVZwYrwe+vCxMqZI3NUIYYY9mj4nn8ObkIQHExlDwaLJGVkn9d8aRW+BriO
    sNW30q2uBYyXuGDax2dZe9EdBYp1imzS3zbTzcCxA6OYwfvlrA29KMoNFubzs/RjoxAx1B
    8Ioaoagj6Ks28lgFgv7qU9bECVUSsPjFN1TYWjJ2321AvG0GCvzf41rQ+M2A
X-ME-Proxy: <xmx:L8hEaqlQiMnUPSlgJzGFTh4-OvtDzHpu_fEIJQc41Ov0JuabA0jMLA>
    <xmx:L8hEaoupr5uHC9A24wGqkAesMnjAklGbDnmM6Jj9HzmhEjM1EzMKiw>
    <xmx:L8hEalmT0_ySvxk0tJriXqFAH1jfq-D_-Dh1Lc4O5pYyFOLLBcGmSQ>
    <xmx:L8hEaru8Vi64RMhs7kznPWgsVyI5kb6FbYU6Dk2Q3jUTUGrzqzPApw>
    <xmx:L8hEallXcZhTRz3EgCjBXOSBipYEC8NTVIk0WLGdYSSw_oHEdrxL8BoN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 03:56:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 081eba9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 07:56:30 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:56:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/13] run-command: avoid close(-1) in start_command()
 error paths
Message-ID: <akTIK6j9UY4U4x80@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <d7bcdda31276b5a17f11c307deb0f99ae1dc2861.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bcdda31276b5a17f11c307deb0f99ae1dc2861.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:22AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/run-command.c b/run-command.c
> index e70a8a387b..ce84db8782 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -706,7 +706,7 @@ int start_command(struct child_process *cmd)
>  			failed_errno = errno;
>  			if (need_in)
>  				close_pair(fdin);
> -			else if (cmd->in)
> +			else if (cmd->in > 0)
>  				close(cmd->in);
>  			str = "standard output";
>  			goto fail_pipe;
> @@ -720,11 +720,11 @@ int start_command(struct child_process *cmd)
>  			failed_errno = errno;
>  			if (need_in)
>  				close_pair(fdin);
> -			else if (cmd->in)
> +			else if (cmd->in > 0)
>  				close(cmd->in);
>  			if (need_out)
>  				close_pair(fdout);
> -			else if (cmd->out)
> +			else if (cmd->out > 0)
>  				close(cmd->out);
>  			str = "standard error";
>  fail_pipe:

Right. There's a fourth site that does `close(cmd->out)`, but that site
already guards with `if (cmd->out > 0)`.

Patrick
