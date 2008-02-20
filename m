From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone.sh: properly configure remote even if remote's
 head is dangling
Date: Wed, 20 Feb 2008 15:18:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802201516570.17164@racer.site>
References: <20080220151017.17840.qmail@767a223c93e1c8.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 16:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRqku-00006o-GH
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 16:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763882AbYBTPTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 10:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763795AbYBTPTB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 10:19:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:51850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763674AbYBTPSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 10:18:55 -0500
Received: (qmail invoked by alias); 20 Feb 2008 15:18:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 20 Feb 2008 16:18:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cbS0BICScwbVKBEuIHyYl6wyOLnIYky2BVJ60Dl
	h1vbea4VXtkPUS
X-X-Sender: gene099@racer.site
In-Reply-To: <20080220151017.17840.qmail@767a223c93e1c8.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74517>

Hi,

On Wed, 20 Feb 2008, Gerrit Pape wrote:

> When cloning a remote repository which's HEAD refers to a nonexistent 
> ref, git-clone cloned all existing refs, but failed to write the 
> configuration for 'remote'.  Now it detects the dangling remote HEAD, 
> refuses to checkout any local branch since HEAD refers to nowhere, but 
> properly writes the configuration for 'remote', so that subsequent 'git 
> fetch's don't fail.

I like your reasoning, and your patch.  Except maybe...

> diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
> index 822ac8c..59a165a 100755
> --- a/t/t5701-clone-local.sh
> +++ b/t/t5701-clone-local.sh
> @@ -63,4 +63,12 @@ test_expect_success 'Even without -l, local will make a hardlink' '
>  	test 0 = $copied
>  '
>  
> +test_expect_success 'local clone of repo with nonexistent ref in HEAD' '
> +	cd "$D" &&

... making this a subshell would be nice, so that subsequent tests start 
out from trash/ again?

Ciao,
Dscho
