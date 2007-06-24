From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach rebase an interactive mode
Date: Sun, 24 Jun 2007 15:33:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706241533030.4059@racer.site>
References: <Pine.LNX.4.64.0706240001150.4059@racer.site>
 <7v4pkxydim.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 16:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2T9Z-0006LZ-9o
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 16:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbXFXOdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbXFXOdQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 10:33:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:55973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755314AbXFXOdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 10:33:15 -0400
Received: (qmail invoked by alias); 24 Jun 2007 14:33:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 24 Jun 2007 16:33:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192W2AsXDt2t2WGyEMUNm3UAGhhvUrTnaMJ+Ss5AW
	6tAVXCbdHXW5Aj
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pkxydim.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50798>

Hi,

On Sun, 24 Jun 2007, Junio C Hamano wrote:

> This is just an idea, but I have been wondering if it would be useful if 
> we teach rebase (interactive or not) to handle a merge from an unrelated 
> (wrt the rebase that is being performed) branch.  That is, if you had 
> this development on top of the origin 'O':
> 
>              X
>               \  
>            A---M---B     
>           /
>   ---o---O
> 
> that you committed A, merged X and then committed B, you should
> be able to rebase on top of an updated upstream 'Q':
> 
>              X
>               \  
>            A---M---B     
>           /
>   ---o---O---P---Q
> 
> by 'pick A/merge M/pick B', which would do:
> 
>                      X
>                       \
>                    A'--M'--B'
>                   /
>   ---o---O---P---Q
> 
> Note that A', M' and B' are different commit objects (rebase
> rewrites the history) from the original picture, but X is the
> same commit from the original picture.

Yes, I think that would be useful. But at the same time, I think it should 
not be the default. Why? Because I will use rebase to beautify my history, 
and that looks mostly like this:

--- A - B - C - D - E - junio/master
      \       \   \
        M - N - O - P - my

So what I want is really clean up my side branch.

Therefore I would like to have this --preserve-merges (short option -p?) 
_after_ rebase -i.

It will get a little tricky with different merge strategies, and saying 
which commits have to be rebased (A in your example), and which will be 
preserved (X in your example), and evil merges (merges which have fix ups 
in addition to the merge), but doable.

Ciao,
Dscho
