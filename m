From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] rebase-i: keep old parents when preserving merges
Date: Wed, 16 Jul 2008 23:51:11 +0200
Message-ID: <20080716215111.GB18558@leksak.fem-net>
References: <1216173109-11155-1-git-send-email-s-beyer@gmx.net> <7vd4ldpl3k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEv7-00045T-17
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbYGPVvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbYGPVvX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:51:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:58709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754605AbYGPVvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:51:22 -0400
Received: (qmail invoked by alias); 16 Jul 2008 21:51:20 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp044) with SMTP; 16 Jul 2008 23:51:20 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+stFxTFxesJC9RVw4C9j+rbSksDJxW4X2bAHAHaq
	XH7UFdrp32iRDE
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJEtz-0002Ty-Ab; Wed, 16 Jul 2008 23:51:11 +0200
Content-Disposition: inline
In-Reply-To: <7vd4ldpl3k.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88765>

Hi,

Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
> ... Based on the discussion thread, here is a rewrite of the log message.
> 
> > When "rebase -i -p" tries to preserve merges of unrelated branches, it
> > lost some parents:
> >
> >  - When you have more than two parents, the commit in the new history
> >    ends up with fewer than expected number of parents and this breakage
> >    goes unnoticed;
> >
> >  - When you are rebasing a merge with two parents and one is lost, the
> >    command tries to cherry-pick the original merge commit, and the command
> >    fails.
> >
> > Signed-off-by: Stephan Beyer <s-beyer@gmx.net>

Ok, big thanks :)

> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index a35212d..0df7640 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -174,6 +174,8 @@ pick_one_preserving_merges () {
> >  				new_parents="$new_parents $new_p"
> >  				;;
> >  			esac
> > +		else
> > +			new_parents="$new_parents $p"
> >  		fi
> >  	done
> 
> Reading the surrounding code, it makes me wonder if you also need to futz
> with variables like $preserve and $fast_forward.

No, I would not see a reason for that.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
