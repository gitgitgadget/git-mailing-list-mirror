From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] common progress display support
Date: Thu, 19 Apr 2007 11:03:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191053590.8822@racer.site>
References: <alpine.LFD.0.98.0704181422050.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 11:03:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeSY2-0000Bh-Tz
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 11:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbXDSJDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 05:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161384AbXDSJDV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 05:03:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:49954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161374AbXDSJDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 05:03:20 -0400
Received: (qmail invoked by alias); 19 Apr 2007 09:03:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 19 Apr 2007 11:03:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182ut1+rXw2otsK5OMTu1OzRHfc1gye9f6hO9e7Bd
	tJm4Sdalu44/yv
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0704181422050.4504@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44999>

Hi,

On Wed, 18 Apr 2007, Nicolas Pitre wrote:

> Instead of having this code duplicated in multiple places, let's have a 
> common interface for progress display.

I like that!

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 19fae4c..150f56c 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -588,8 +588,10 @@ static off_t write_pack_file(void)
>  		f = sha1fd(fd, pack_tmp_name);
>  	}
>  
> -	if (do_progress)
> +	if (do_progress) {
>  		fprintf(stderr, "Writing %u objects.\n", nr_result);
> +		start_progress(&progress_state, "", nr_result);
> +	}

It seems like it would be a good idea to change the signature of 
start_progress() to take an optional message, like this:

	start_progress(&progress_state, "Writing %u object.s\n", 
		"", nr_result);

It would make the added/deleted ratio even more impressive.

I only skimmed the patch, but like all of your patches, it looks good to 
me.

Ciao,
Dscho
