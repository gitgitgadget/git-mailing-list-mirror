From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone.txt: Adjust note to --shared for new pruning
 behavior of git-gc
Date: Thu, 3 Apr 2008 21:14:39 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804032113280.4008@racer.site>
References: <47F52145.306@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Apr 03 22:15:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhVqC-0000h4-Ql
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 22:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbYDCUOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760082AbYDCUOb
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 16:14:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:54003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755617AbYDCUOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 16:14:30 -0400
Received: (qmail invoked by alias); 03 Apr 2008 20:14:28 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO [192.168.1.70]) [86.165.92.90]
  by mail.gmx.net (mp045) with SMTP; 03 Apr 2008 22:14:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+L/AEi0w2LQNI9pgLvfEp0un/bEMz/uKrERWV2OG
	J0FbdoBt3Pzfja
X-X-Sender: gene099@racer.site
In-Reply-To: <47F52145.306@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78773>

Hi,

On Thu, 3 Apr 2008, Brandon Casey wrote:

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 9758243..d3ab00b 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -65,10 +65,12 @@ OPTIONS
>  +
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand what it does. If you clone your
> -repository using this option, then delete branches in the
> -source repository and then run linkgit:git-gc[1] using the
> -'--prune' option in the source repository, it may remove
> -objects which are referenced by the cloned repository.
> +repository using this option and then delete branches in the
> +source repository, some objects may become unreferenced (or dangling).
> +These objects may be removed by normal git operations (such as git-commit[1])
> +which automatically call git-gc[1]. If these objects are removed and
> +were referenced by the cloned repository, then the cloned repository
> +will become corrupt.

Please note that if you delete a branch _after_ running git-gc, the next 
git-gc would remove those objects anyway, since the first git-gc packed 
the objects, and they were therefore no longer dangling.

So it was an issue before the new git-gc behaviour anyway.

Ciao,
Dscho
