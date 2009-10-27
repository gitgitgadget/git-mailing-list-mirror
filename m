From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix memory leak in transport-helper
Date: Tue, 27 Oct 2009 15:11:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910271510430.4985@pacific.mpi-cbg.de>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net> <20091015154142.GL10505@spearce.org> <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org> <alpine.LNX.2.00.0910270032170.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2mis-0007Rw-TV
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbZJ0OIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbZJ0OIU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:08:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:59429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754814AbZJ0OIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:08:20 -0400
Received: (qmail invoked by alias); 27 Oct 2009 14:08:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 27 Oct 2009 15:08:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CIKtmWYoCrP+REnI2n/RlkD807jd3EU9c48mGSn
	b2iUrvIMhsrldv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0910270032170.14365@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131339>

Hi,

On Tue, 27 Oct 2009, Daniel Barkalow wrote:

> diff --git a/transport-helper.c b/transport-helper.c
> index f57e84c..479539d 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -67,6 +67,13 @@ static int disconnect_helper(struct transport *transport)
>  	return 0;
>  }
>  
> +static int close_helper(struct transport *transport)
> +{
> +	disconnect_helper(transport);
> +	free(transport->data);
> +	return 0;
> +}

Why did you not leech the transport->data = NULL; part from Peff/Sverre's 
patch?

Ciao,
Dscho
