From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Refactor struct transport_ops inlined into struct
 transport
Date: Wed, 19 Sep 2007 14:11:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709191409590.28395@racer.site>
References: <20070919044931.GB17107@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 15:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXzLx-00020D-QX
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 15:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbXISNMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 09:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbXISNMZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 09:12:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:42341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849AbXISNMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 09:12:24 -0400
Received: (qmail invoked by alias); 19 Sep 2007 13:12:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 19 Sep 2007 15:12:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DxltgwlIDHjTQ/dbUnkn88sMn314JV7DwFxMyPx
	NXyF3FUhgci4KO
X-X-Sender: gene099@racer.site
In-Reply-To: <20070919044931.GB17107@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58711>

Hi,

On Wed, 19 Sep 2007, Shawn O. Pearce wrote:

> diff --git a/transport.c b/transport.c
> index cc76e3f..d8458dc 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -44,8 +44,6 @@ static int disconnect_walker(struct transport *transport)
>  	return 0;
>  }
>  
> -static const struct transport_ops rsync_transport;
> -
>  static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
>  	const char **argv;
>  	int argc;
> @@ -431,18 +406,31 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	ret->url = url;
>  
>  	if (!prefixcmp(url, "rsync://")) {
> -		ret->ops = &rsync_transport;
> +		/* not supported; don't populate any ops */
> +

That is sneaky.  What are the reasons to remove rsync support?  I know it 
is deprecated, but I'd still like to have it, especially for initial 
clones on small-RAMed machines.

Ciao,
Dscho
