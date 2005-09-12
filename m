From: Greg Louis <glouis@dynamicro.on.ca>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Mon, 12 Sep 2005 12:36:37 -0400
Organization: Dynamicro Consulting Limited
Message-ID: <20050912163637.GA22018@athame.dynamicro.on.ca>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net> <20050911220421.GA14593@athame.dynamicro.on.ca> <20050911230136.GA15224@athame.dynamicro.on.ca> <7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net> <20050912105637.GA5290@athame.dynamicro.on.ca> <7vbr2yfp0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Mon Sep 12 18:38:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EErIR-0007ms-Vh
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 18:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVILQgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 12:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVILQgl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 12:36:41 -0400
Received: from csl2r.consultronics.on.ca ([204.138.93.16]:58506 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S932077AbVILQgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 12:36:40 -0400
Received: from [70.29.36.34] (helo=athame.dynamicro.internal ident=glouis)
	by csl2.consultronics.on.ca with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.52)
	id 1EErIL-0005IG-Ux
	for git@vger.kernel.org; Mon, 12 Sep 2005 12:36:38 -0400
Received: from root by athame.dynamicro.internal with local (Exim 4.52)
	id 1EErIL-0005o9-GX
	for git@vger.kernel.org; Mon, 12 Sep 2005 12:36:37 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbr2yfp0r.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8406>

On 20050912 (Mon) at 0529:08 -0700, Junio C Hamano wrote:
> Greg Louis <glouis@dynamicro.on.ca> writes:
> 
> > I could argue that it's a relatively harmless contribution to
> > robustness of the git scripts, but if someone replied that total
> > idiot-proofing isn't a worthwhile goal for a project of this sort, I   
> > wouldn't necessarily disagree.
> 
> We could:
> 
>  (0) do nothing and let people shoot in the foot themselves.
> 
>  (1) unset CDPATH silently while we run.  Most conveniently done
>      by doing so at the beginning of git-setup-sh, and scripts
>      that do not use the setup script but still does "cd".
> 
>  (2) detect CDPATH in the same places as (1), complain and die.

Or (2+1==3) detect CDPATH in the same places as (1), complain with a
brief explanation ("don't export CDPATH; it's really only useful in
interactive shells") and unset it.  That way we'd educate, in a friendly
way, people who thought they needed it for some reason, or who just
never noticed their vendor's /etc/profile was exporting the damn thing.

> Among these, (1) would be naturally the approach of least
> resistance.  It would make things "just work" for everybody,

My patch was about the equivalent of (1), and (1) is what I'd feel
was the most that git owes its users.  Option (0) could be justified on
the grounds that git users are presumably developers and ought to be
able to catch that sort of blunder, but the facts that you didn't
originally twig to it, and that it took me a couple of hours to find it
independently, suggest that that's too cavalier an attitude (neither of
us being a tyro).  Option (3) does qualify as excess baggage IMHO, and
option (2) as a bit unhelpfully pedantic.

> I would probably end up doing (1), though.

As would I if the decision were mine. 

(btw I'm on the list -- no Cc: needed)
-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
