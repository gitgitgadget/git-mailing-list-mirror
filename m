From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: failing test t9400 (Re: [PATCH] git-update-ref: add --no-deref option for overwriting/detaching ref)
Date: Wed, 9 May 2007 22:27:20 +0200
Message-ID: <20070509202720.GN30324@planck.djpig.de>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org> <7vk5viuim5.fsf@assigned-by-dhcp.cox.net> <20070509153831.GW942MdfPADPa@greensroom.kotnet.org> <7vr6pqt1fu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 22:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlsl3-0007S5-1o
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXEIU10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbXEIU10
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:27:26 -0400
Received: from planck.djpig.de ([85.10.192.180]:3993 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbXEIU1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:27:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 7D2CA274014;
	Wed,  9 May 2007 22:27:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSbc3U2aRZKQ; Wed,  9 May 2007 22:27:21 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 1F4C6274013; Wed,  9 May 2007 22:27:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr6pqt1fu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46783>

On Wed, May 09, 2007 at 09:19:01AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > Shouldn't these tests be skipped if I don't have all that stuff installed?
> > There doesn't even seem to be an option to turn off these tests.
> 
> I agree.  We would need something like this, but I have no easy
> way to test it myself, short of uninstalling what I need on the
> box.  As you do not have them, maybe you can give it a quick
> whirl?

Yeah, I totally forgot add such a check, even though I added one for
cvs.

> ---
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index f17be6b..98d6bb4 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -17,6 +17,11 @@ then
>      test_done
>      exit
>  fi
> +perl -e 'use DBI; use DBD::SQLite' 2>&1 || {

Maybe there is a >/dev/null missing here?

I personally would prefer "perl -MDBI -MDBD::SQLite" stylewise, but I
guess it makes no difference in the end.

> +    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
> +    test_done
> +    exit
> +}

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
