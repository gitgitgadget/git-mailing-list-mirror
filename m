From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/21] Collect skipping of header field names and
 calculation of line lengths in one place
Date: Sun, 10 Jun 2007 09:45:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100942510.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090218.16281.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJ60-0005li-Ah
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbXFJIsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXFJIsW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:48:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750932AbXFJIsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:48:22 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:48:20 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp058) with SMTP; 10 Jun 2007 10:48:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mXzosw+/mx9JU2r99F4Hbk7mwleQFZCgmmDqZnt
	FPKUvjgd5ccjjf
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090218.16281.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49685>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> +	/*
> +	 * Advance header field pointers past their initial identifier.
> +	 * Calculate lengths of header fields.
> +	 */
> +	type_line += strlen("type ");
> +	type_len   = tag_line - type_line - 1;
> +	tag_line  += strlen("tag ");
> +	tag_len    = tagger_line - tag_line - 1;
> +
>  	/* Get the actual type */
> -	type_len = tag_line - type_line - strlen("type \n");
>  	if (type_len >= sizeof(type))
>  		return error("Tag object (@ char " PD_FMT "): "
> -			"Type too long", type_line + 5 - data);
> -	memcpy(type, type_line + 5, type_len);
> +			"Type too long", type_line - data);
> +	memcpy(type, type_line, type_len);

This change does not clarify anything. It is exactly as confusing as 
before.

> -		for (i = 4;;) {
> +		for (i = 0;;) {

I know you introduced this in another patch. This is an ugly construct. If 
you want people to review your patches, you might as well put in the 
effort to make the reviewing more pleasant.

Ciao,
Dscho
