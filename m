From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 08:14:49 +0200
Message-ID: <20070516061449.GA25273@artax.karlin.mff.cuni.cz>
References: <464A940C.3080906@garzik.org> <8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com> <464A9C9B.70904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Wed May 16 08:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDBd-0002Bg-D2
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbXEPGkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 02:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759388AbXEPGkX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:40:23 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:33576 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbXEPGkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:40:22 -0400
X-Greylist: delayed 1532 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 May 2007 02:40:22 EDT
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 008B35ACB; Wed, 16 May 2007 08:14:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <464A9C9B.70904@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47419>

On Wed, May 16, 2007 at 01:54:35AM -0400, Jeff Garzik wrote:
> Lars Hjemli wrote:
> >On 5/16/07, Jeff Garzik <jeff@garzik.org> wrote:
> >>[jgarzik@pretzel libata-dev]$ git branch -m upstream-fixes tmp
> >>error: Could not open config file!
> >>fatal: Branch rename failed
> >
> >This should have been fixed in v1.5.1.1, what version do you run?
> 
> [jgarzik@core ~]$ rpm -q git-core
> git-core-1.5.0.6-1.fc6
> 
> 
> >>[jgarzik@pretzel libata-dev]$ git-branch -m upstream-fixes tmp
> >>fatal: A branch named 'tmp' already exists.
> >>
> >>[jgarzik@pretzel libata-dev]$ git branch -D tmp
> >>Deleted branch tmp.
> >
> >Could you try to run "git log -g" and see if it finds your lost branch?
> 
> Doesn't seem to..

And does the .git/logs/refs/heads/upstream-fixes still exist?

If it does, than revspec upstream-fixes@{1} would still work, so you can
check it out, re-create the branch and update the ref (git update-ref).

If it does not, as last resort you'd have to git fsck --unreachable
(this gives you all things that are not reachable from any ref), filter
out only commit objects and than remember which one should have been on
that branch after reading it's log, date and changes.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
