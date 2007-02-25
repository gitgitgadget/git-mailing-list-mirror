From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Update tests to use test-chmtime
Date: Sun, 25 Feb 2007 11:23:29 -0800
Message-ID: <20070225192329.GA13535@localdomain>
References: <11723651923476-git-send-email-normalperson@yhbt.net> <11723651934078-git-send-email-normalperson@yhbt.net> <7vzm72vhl4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 20:23:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLOyG-00022h-Ed
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 20:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbXBYTXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 14:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXBYTXd
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 14:23:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:32912 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbXBYTXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 14:23:32 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 98E657DC094;
	Sun, 25 Feb 2007 11:23:30 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 25 Feb 2007 11:23:30 -0800
Content-Disposition: inline
In-Reply-To: <7vzm72vhl4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40567>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > -case "$(date -d @11111111 +%s 2>/dev/null)" in
> > -11111111)
> > ...
> > -	touch -m -t "$predate1" $rr/preimage
> > -	touch -m -t "$predate2" $rr2/preimage
> > ...
> > -esac
> > +now=$(date +%s)
> > +almost_15_days_ago=$(($now+60-15*86400))
> > +just_over_15_days_ago=$(($now-1-15*86400))
> > +almost_60_days_ago=$(($now+60-60*86400))
> > +just_over_60_days_ago=$(($now-1-60*86400))
> > +
> > +test-chmtime =$almost_60_days_ago $rr/preimage
> > +test-chmtime =$almost_15_days_ago $rr2/preimage
> 
> Very nice.
> I've been wanting to get rid of this part for quite a while.
> 
> However, is '+%s' output portable enough for this change to be
> an improvement?

Looks like not.

> I would suggest changing "test-chmtime =-200 file" to set the
> mtime of the file to 200 seconds in the past, relative to
> present.
> 
> ---
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index d5bb6ec..639d45f 100755

Your patch looks good to me.

-- 
Eric Wong
