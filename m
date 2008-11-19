From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix deletion of last character in levenshtein distance
Date: Wed, 19 Nov 2008 01:53:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 01:47:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2bDn-0000sy-77
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 01:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYKSApw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 19:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYKSApv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 19:45:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:40084 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbYKSApv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 19:45:51 -0500
Received: (qmail invoked by alias); 19 Nov 2008 00:45:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 19 Nov 2008 01:45:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YEm8QgA4YkpEgwusatuZLmwa0de3vD5nsEFaMCT
	HtsoKTUf21rnTo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081118185326.12721.71576.stgit@arrakis.enst.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101295>

Hi,

On Tue, 18 Nov 2008, Samuel Tardieu wrote:

> diff --git a/levenshtein.c b/levenshtein.c
> index db52f2c..98fea72 100644
> --- a/levenshtein.c
> +++ b/levenshtein.c
> @@ -25,7 +25,7 @@ int levenshtein(const char *string1, const char *string2,
>  					row2[j + 1] > row0[j - 1] + w)
>  				row2[j + 1] = row0[j - 1] + w;
>  			/* deletion */
> -			if (j + 1 < len2 && row2[j + 1] > row1[j + 1] + d)
> +			if (row2[j + 1] > row1[j + 1] + d)

I do not understand: does row2 have more entries than len2?  In any case, 
you will _have_ to guard against accessing elements outside the reserved 
memory.

You'll have to be more convincing to make me agree that this is a good 
change, and I am pretty certain that other people are less familiar with 
that particular part of Git's source code than me.

Ciao,
Dscho
