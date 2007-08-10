From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-apply: apply submodule changes
Date: Fri, 10 Aug 2007 13:39:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708101337510.21857@racer.site>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 14:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJTnB-0005Mh-MB
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 14:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763255AbXHJMkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 08:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763139AbXHJMkM
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 08:40:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:56594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763735AbXHJMkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 08:40:10 -0400
Received: (qmail invoked by alias); 10 Aug 2007 12:40:07 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp020) with SMTP; 10 Aug 2007 14:40:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HI4op8k3Huw4bqz/2oQEGrFkLS5Rfw9ixC9FWYy
	7cYHkhoVWU+lFZ
X-X-Sender: gene099@racer.site
In-Reply-To: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55534>

Hi,

On Fri, 10 Aug 2007, Sven Verdoolaege wrote:

> @@ -2387,7 +2405,9 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
>  			die("unable to stat newly created file %s", path);
>  		fill_stat_cache_info(ce, &st);
>  	}
> -	if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
> +	if (S_ISGITLINK(mode))
> +		get_sha1_hex(buf + strlen("Subproject commit "), ce->sha1);
> +	else if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
>  		die("unable to create backing store for newly created file %s", path);
>  	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
>  		die("unable to add cache entry for %s", path);

I guess that you need to catch an error from get_sha1_hex(), too.

I hope it is not to much to ask for a patch to t7400 to show what this 
patch fixes?

Ciao,
Dscho
