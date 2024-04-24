Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0E15699A
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993435; cv=none; b=PwDfpppoLxjX4yXDVc1lHD3HOq3zcIiRJaJPllvOOZ8vOV/RpmOYOzEnI3H6N5DaACoSIQZ6HWOjOFI913DKRXsWhWvHZE6aNtf2wpeNdNwnpIg8dOaq86sTYTEMP5sV9SiBZNnROFlsZ+t//F8GT933IJJAE9Qpm2zv8NdS/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993435; c=relaxed/simple;
	bh=ScWEx2a+i/YyLPa7sN1jOU24TdyzBUsgd0lw1Oqq7wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oti41r2jzb3jWz6fypWx6VF5fmyUtMWt6a2/svpJls2OveUVSRBHIaUJNkC5yFgkiQka7VtZMJ33aLzIzEVPDAnqWrTA9B0ZzFhElOW64aCHEN44Td7YpuOhic1oBjkpxfM8jLP1O9gTqQtRkNQyC3Yzxes7eNB5dJydZEKUZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjzK-0006V5-Qz; Wed, 24 Apr 2024 23:17:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjzJ-00E9Bt-RR; Wed, 24 Apr 2024 23:17:09 +0200
Received: from rhi by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjzJ-00Bfbl-2R;
	Wed, 24 Apr 2024 23:17:09 +0200
Date: Wed, 24 Apr 2024 23:17:09 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: add docs on how to add subcommand
 completions
Message-ID: <20240424211709.ppljgyxzu2rmkamw@pengutronix.de>
References: <20240424210549.256256-1-rhi@pengutronix.de>
 <20240424210549.256256-2-rhi@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424210549.256256-2-rhi@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

On Wed, Apr 24, 2024 at 11:05:48PM +0200, Roland Hieber wrote:
> It took me more than a few tries and a good lecture of __git_main to
> understand that the two paragraphs above really only refer to adding
> completion functions for executables that are not called through git's
> subcommand magic. Add a few sentences for that case.
> 
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
>  contrib/completion/git-completion.bash | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ffcc55484bcd..f0c8353c1cdb 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -40,6 +40,13 @@
>  #
>  #   __git_complete gk gitk
>  #
> +# To add completion for git subcommands that live in external scripts,
> +# define a function of the form '_git_${subcommand}' while replacing all dashes
> +# with underscores, and the main git completion will make use of it.
> +# For example, to add completeion after 'git do-my-stuff' (which could e.g. live

Ah, of course its s/completeion/completion/ …

 - Roland

> +# in /usr/bin/git-do-stuff), name the completion function '_git_do_stuff'.
> +# See _git_show, _git_bisect etc. below for more examples.
> +#
>  # Compatible with bash 3.2.57.
>  #
>  # You can set the following environment variables to influence the behavior of
> -- 
> 2.39.2
> 
> 

-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |
