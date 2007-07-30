From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 3/4] guilt-select: Select guards to apply when pushing patches
Date: Mon, 30 Jul 2007 15:34:18 -0400
Message-ID: <20070730193418.GD17253@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <11856954182318-git-send-email-eclesh@ucla.edu> <20070730041231.GE22017@filer.fsl.cs.sunysb.edu> <87fy36cr25.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFb1L-00053O-UG
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939230AbXG3Ted (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939243AbXG3Tec
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:34:32 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54259 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939230AbXG3Teb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 15:34:31 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6UJYI16019267;
	Mon, 30 Jul 2007 15:34:18 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6UJYIGh019265;
	Mon, 30 Jul 2007 15:34:18 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <87fy36cr25.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54257>

On Mon, Jul 30, 2007 at 12:02:26AM -0700, Eric Lesh wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:
> 
> [...]
> 
> >> +if [ $# == 0 ]; then
> >> +	if [ -s "$guards_file" ]; then
> >> +		cat "$guards_file"
> >
> > Later on, for the -s option processing, you sort (presumably to have uniq do
> > the right thing), should we sort here too to be consitent?
> >
> 
> The $guards_file isn't really meant to be handed edited, and
> guilt-select itself sorts before it stores them in the guards file.  I could
> sort it again on printing, but don't think it's necessary.
 
Duh. No need to re-sort.

> >> +
> >> +case $1 in
> >> +	-n|--none)
> >> +		rm -f "$guards_file"
> >> +		touch "$guards_file"
> >
> > Since guilt-init doesn't create the guards file, I'm thinking that this
> > should be just a rm -f ...
> 
> Should guilt-init create it?  I added $guards_file to guilt(7), so not
> seeing it might freak Documentation-conscious readers out?

I'm thinking that it would be nice to have the file created when the first
guard is set, and removed when the last guard is removed. This way, if you
don't care about guards, you don't have to ignore the file (if you have your
patches dir under version control). This also happens to be the nicer way to
transition from pre-guard patch dirs to ones with guards - in a way it's
cheating around "upgrading" the repo :)

I'd like this lazy creation to be documented, of course to not confuse the
handful that actually read the docs :)

Jeff.

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help
  you shoot yourself in the foot for free. 
