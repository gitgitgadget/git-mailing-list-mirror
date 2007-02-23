From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Limit filename for format-patch
Date: Fri, 23 Feb 2007 01:49:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702230143370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070223003711.6895.24185.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 23 01:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKOch-0002qr-Pi
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 01:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbXBWAtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 19:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXBWAtH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 19:49:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:52415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752101AbXBWAtF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 19:49:05 -0500
Received: (qmail invoked by alias); 23 Feb 2007 00:49:04 -0000
X-Provags-ID: V01U2FsdGVkX1+7lasU3ym7kUjHp36YVRWwbaCxKIzayybZtN8Zv2
	pVeA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070223003711.6895.24185.stgit@lathund.dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40403>

Hi,

I agree that your patch fixes a long-time issue.

On Fri, 23 Feb 2007, Robin Rosenberg wrote:

> +		if (strlen(output_directory) > sizeof filename - suffix_len)

I know that "sizeof filename" works, but in git.git, `git grep sizeof' 
returns > 700 instances, only 23 of which do not use the 
"sizeof(filename)" form. It's just a style issue, but I prefer the latter 
nevertheless...

>  		for (j = 0;

Does this:

> +		     j< 64-suffix_len-5 && 
>  		     len < sizeof(filename) - suffix_len &&
>  			     sol[j] && sol[j] != '\n';
>  		     j++) {

not make this:

> +	if (len + strlen(fmt_patch_suffix) >= sizeof filename)
> +		return error("Patch pathname too long");

unnecessary for the case that there _was_ an output directory specified? 
I'd make that an "else if"... But I might be missing something.

Ciao,
Dscho
