From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Wed, 5 Mar 2008 21:11:11 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803052109070.15786@racer.site>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1347502529-1204747877=:15786"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWzyK-0004Io-Io
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYCEULS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 15:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYCEULR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:11:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:59847 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751026AbYCEULR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 15:11:17 -0500
Received: (qmail invoked by alias); 05 Mar 2008 20:11:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 05 Mar 2008 21:11:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HNQtnKfsHpb9tbRbxvQ8CKu9F6d3M0LY1LXDdvX
	4InGq3w+4uejXR
X-X-Sender: gene099@racer.site
In-Reply-To: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76256>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1347502529-1204747877=:15786
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 5 Mar 2008, Santi Béjar wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4027726..d7e5b6d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -914,6 +914,11 @@ url.<base>.insteadOf::
>  	never-before-seen repository on the site.  When more than one
>  	insteadOf strings match a given URL, the longest match is used.
>  
> +user.default::
> +	If false the defaults values for user.email and user.name are not
> +	used. Useful when you want a different email/name for each
> +	repository, normally set in the global config file.
> +

I have to wonder: why do you set it in global config file the first place?

And the answer...

> diff --git a/ident.c b/ident.c
> index b839dcf..0f62a94 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -75,7 +75,7 @@ static void setup_ident(void)
>  	struct passwd *pw = NULL;
>  
>  	/* Get the name ("gecos") */
> -	if (!git_default_name[0]) {
> +	if (!git_default_name[0] && default_ident) {
>  		pw = getpwuid(getuid());
>  		if (!pw)
>  			die("You don't exist. Go away!");

... is here.  You are actually not at all talking about the global config 
file, but the gecos information instead.

Ciao,
Dscho

--8323584-1347502529-1204747877=:15786--
