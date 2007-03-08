From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle: fix wrong check of read_header()'s return value
 & add tests
Date: Thu, 8 Mar 2007 14:06:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081405310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslchio4f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPIJz-0003tF-PP
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 14:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbXCHNGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 08:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXCHNGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 08:06:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:33931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751784AbXCHNGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 08:06:08 -0500
Received: (qmail invoked by alias); 08 Mar 2007 13:06:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 08 Mar 2007 14:06:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JSRgoADEJ4XkDnz9Tw+/vyIYNnHAOL0gRGSjqS1
	JGTkEyYozc6HZB
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslchio4f.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41741>

Hi,

On Tue, 6 Mar 2007, Junio C Hamano wrote:

> Would this work?
> 
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ce96b4b..ad589dd 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -110,9 +110,16 @@ test_expect_failure 'unbundle 1' '
>  
>  test_expect_success 'bundle 1 has only 3 files ' '
>  	cd "$D" &&
> -	sed "1,4d" < bundle1 > bundle.pack &&
> +	(
> +		while read x && test -n "$x"
> +		do
> +			:;
> +		done
> +		cat
> +	) <bundle1 >bundle.pack &&

I tried to avoid that, because it was mentioned that this does not work on 
Cygwin for some reason I forgot.

Ciao,
Dscho
