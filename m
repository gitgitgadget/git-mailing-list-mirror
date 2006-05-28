From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] new environment variable GIT_TEMPLATE_DIR to override default template
Date: Sun, 28 May 2006 20:15:09 +0200
Message-ID: <E1FkPnB-0005yW-UY@moooo.ath.cx>
References: <20060527132554.GC10488@pasky.or.cz> <E1Fk3yR-0006Gd-36@moooo.ath.cx> <7v4pzadpfr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 20:15:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkPnR-0002rk-GY
	for gcvg-git@gmane.org; Sun, 28 May 2006 20:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWE1SPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWE1SPS
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 14:15:18 -0400
Received: from moooo.ath.cx ([85.116.203.178]:50371 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750839AbWE1SPO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 14:15:14 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4pzadpfr.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20885>

> I like the part to let git-clone pass --template down to git-init-db,
> but once it is in place I doubt you would still need GIT_TEMPLATE_DIR.
> I'd rather not to introduce new environment variables if we can
> avoid them.

I like the variable because it makes it very easy to change the
default template directory (so I don't have to remember passing
--template every time I clone or create a new repository). But
aliases/default options (~/.git/config thread) this would make this
possible too.

> Here, $template is either empty string "", or "--template=dir"
> after argument parsing.  But then it does this:
> 
> > @@ -203,7 +206,7 @@ trap 'err=$?; cd ..; rm -r "$D"; exit $e
> >  case "$bare" in
> >  yes) GIT_DIR="$D" ;;
> >  *) GIT_DIR="$D/.git" ;;
> > -esac && export GIT_DIR && git-init-db || usage
> > +esac && export GIT_DIR && git-init-db "$template" || usage
> 
> which I suspect would make git-init-db barf if you did not pass
> any --template=foo option to git-clone.  Did you test your patch?

Sorry, I did not run make test and did not test it without the option.
Shall I send a new patch?
