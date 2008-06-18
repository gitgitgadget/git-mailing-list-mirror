From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix approxidate("never") to always return 0
Date: Wed, 18 Jun 2008 16:06:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806181550190.6439@racer>
References: <4855A3CC.2090701@free.fr> <1213720497-9093-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Olivier Marin <dkr@freesurf.fr>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Jun 18 17:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8zHv-0005f4-5W
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 17:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYFRPIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbYFRPIg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 11:08:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:35173 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751773AbYFRPIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 11:08:35 -0400
Received: (qmail invoked by alias); 18 Jun 2008 15:08:33 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp050) with SMTP; 18 Jun 2008 17:08:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZnswpRELZzoXyOG1lw5+b1LROPtcje8EAojM2IB
	Lz7cSgLaUVLC1+
X-X-Sender: gene099@racer
In-Reply-To: <1213720497-9093-1-git-send-email-dkr+ml.git@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85382>

Hi,

On Tue, 17 Jun 2008, Olivier Marin wrote:

> diff --git a/date.c b/date.c
> index a74ed86..1a4eb87 100644
> --- a/date.c
> +++ b/date.c
> @@ -682,10 +682,8 @@ static void date_am(struct tm *tm, int *num)
>  
>  static void date_never(struct tm *tm, int *num)
>  {
> -	tm->tm_mon = tm->tm_wday = tm->tm_yday
> -		= tm->tm_hour = tm->tm_min = tm->tm_sec = 0;
> -	tm->tm_year = 70;
> -	tm->tm_mday = 1;
> +	time_t n = 0;
> +	localtime_r(&n, tm);

I would have reused local_tzoffset() and been explicit about the used 
date, but your version is shorter.

Ciao,
Dscho
