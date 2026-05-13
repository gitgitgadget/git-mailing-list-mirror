Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A993A543F
	for <git@vger.kernel.org>; Wed, 13 May 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713340; cv=none; b=ipX9UZcBkv4UF/Tnas/Gju9UridEamhfIWTNtLCLYJKsmhIIrBUT3/bKJEB64k9kdJmLHcuG61zcRA0pcaGiODoa7leJvbK7fzj/Qrzneb4touyJiY/u5wOVzu9yeavIO1EJVDPU54l6wChGutp5CZR/9g+bUJS/pGdDg9Ha8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713340; c=relaxed/simple;
	bh=CTKdqBRLYJITU8uUj5MVp/N6Ij6nmFGt+TmmAqDV1bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT1Sa7SpXEyZyoAs98tI4q9yYZs4JE77oQdtni5K/SrpBgedw21WePizMwR2aQXoYWCFu0WsMDlqXxH5cIrMAez2fjXtipvExvlOkIWUJcYxOWOnYuK2/mWxNRDsRm4vUP8F2cMut//lZEWlFRIt0/0ldE2M5lyN6eZEcGLDNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IOMuFOCD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IOMuFOCD"
Received: (qmail 41165 invoked by uid 106); 13 May 2026 23:02:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CTKdqBRLYJITU8uUj5MVp/N6Ij6nmFGt+TmmAqDV1bo=; b=IOMuFOCDTWLy5MK1D3Ucrxw9WecTeJ3ZH66WZoXvj9NzNBCdbq7w2FqMxZpm/RvHHeDbGI7ZjFFWMj+raByzTBkXjowGlyvEWyj3mb0y9sPZLnudggK0lc9YswOetnO157dj4FT186fms/JfeGUY7pGfbdcmp+znWc+mrJVgAJYiGr6tz6qw6ixds4N3P5Mh+LKeCwKxwNh5nhTxu1BOikMN2Dpc1MA1d0AtxE5wakPFvuIKR2kUol+/8UbwjQtMvr1RUIS9gNAX9MOhFyZsJAeQ5f99oW8n7Gea8j/q9m+jpSZOBFu/mC2RIkW5l0XVl7FWiDJT4KB9iardsJL2HA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 23:02:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 73170 invoked by uid 111); 13 May 2026 23:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 19:02:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 19:02:16 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
	karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
Subject: Re: [GSoC PATCH v3 1/1] graph: add indentation for commits preceded
 by a parentless commit
Message-ID: <20260513230216.GA1378627@coredump.intra.peff.net>
References: <20260404092425.550346-1-pabloosabaterr@gmail.com>
 <20260427102838.44867-1-pabloosabaterr@gmail.com>
 <20260427102838.44867-2-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427102838.44867-2-pabloosabaterr@gmail.com>

On Mon, Apr 27, 2026 at 12:28:38PM +0200, Pablo Sabater wrote:

> @@ -1135,7 +1227,18 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
>  				graph_line_write_column(line, col, '|');
>  			graph_line_addch(line, ' ');
>  		} else {
> -			graph_line_write_column(line, col, '|');
> +			if (col->is_placeholder) {
> +				/*
> +				 * Same placeholder handling as in
> +				 * graph_output_commit_line().
> +				 */
> +				if (seen_this)
> +					continue;
> +				graph_line_write_column(line, col, ' ');
> +			} else {
> +				graph_line_write_column(line, col, '|');
> +			}

I haven't looked closely at the patch, but Coverity complained that
the "if (seen_this)" check here is dead code, because this whole else
block follows:

                  } else if (seen_this) {
                          if (graph->edges_added > 0)
                                  graph_line_write_column(line, col, '\\');
                          else
                                  graph_line_write_column(line, col, '|');
                          graph_line_addch(line, ' ');
                  } else {
			...the code above...

I don't know if that just means the continue here is redundant and can
be removed, or if it's a sign of a larger logic error.

-Peff
