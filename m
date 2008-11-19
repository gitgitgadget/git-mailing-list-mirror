From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix deletion of last character in levenshtein distance
Date: Wed, 19 Nov 2008 10:57:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr> <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de> <2008-11-19-09-42-45+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 10:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2jhv-0000J6-IT
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 10:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYKSJtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 04:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYKSJtd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 04:49:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46606 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752465AbYKSJtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 04:49:32 -0500
Received: (qmail invoked by alias); 19 Nov 2008 09:49:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 19 Nov 2008 10:49:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/aNY1kTI/qBVdypI3OjtnrT/BrgLGmCU/VkEK4q
	gEDr0rzlqr0x0l
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <2008-11-19-09-42-45+trackit+sam@rfc1149.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101320>

Hi,

On Wed, 19 Nov 2008, Samuel Tardieu wrote:

> * Johannes Schindelin <Johannes.Schindelin@gmx.de> [2008-11-19 01:53:45 +0100]
> 
> | Hi,
> | 
> | On Tue, 18 Nov 2008, Samuel Tardieu wrote:
> | 
> | > diff --git a/levenshtein.c b/levenshtein.c
> | > index db52f2c..98fea72 100644
> | > --- a/levenshtein.c
> | > +++ b/levenshtein.c
> | > @@ -25,7 +25,7 @@ int levenshtein(const char *string1, const char *string2,
> | >  					row2[j + 1] > row0[j - 1] + w)
> | >  				row2[j + 1] = row0[j - 1] + w;
> | >  			/* deletion */
> | > -			if (j + 1 < len2 && row2[j + 1] > row1[j + 1] + d)
> | > +			if (row2[j + 1] > row1[j + 1] + d)
> | 
> | I do not understand: does row2 have more entries than len2?
> 
> Yes it does: int *row2 = xmalloc(sizeof(int) * (len2 + 1));
> 
> | In any case, you will _have_ to guard against accessing elements
> | outside the reserved memory.
> 
> Why would that be needed? j belongs to [0, len2[, so j+1 is always
> in [0, len2+1[ which is ok for both row2 and row1.

Okay, I understand now, _after_ having looked at the original 
levenshtein.c.

IOW you could have made my task of reviewing your patch much easier.

Anyway, here is my

	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for the bugfix,
Dscho
