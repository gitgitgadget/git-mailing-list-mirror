From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] GIT_TRACE: show which built-in/external commands are executed
Date: Sun, 25 Jun 2006 18:10:20 +0200
Message-ID: <E1FuXBk-0001SG-3n@moooo.ath.cx>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net> <E1FuV62-0004Jd-Ve@moooo.ath.cx> <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 18:10:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuXBp-0004RM-VU
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 18:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWFYQKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 12:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFYQKX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 12:10:23 -0400
Received: from moooo.ath.cx ([85.116.203.178]:49865 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751133AbWFYQKW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 12:10:22 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22637>

> Hi,
> 
> On Sun, 25 Jun 2006, Matthias Lederhofer wrote:
> 
> > With the environment variable GIT_TRACE set git will show
> >  - alias expansion
> >  - built-in command execution
> >  - external command execution
> > on stderr.
> 
> Nice.
Thanks :)

> P.S.: Now we only have to convert all "git-" invocations in the scripts to
> "git " invocations so we can benefit from it. But that would mean two 
> forks instead of one for the non-builtins. Hmm.

Why do we not use this policy:

git-* is guaranteed to be the normal command without any strange alias
expansion, default parameters or something else a script does not like
to be changed in the commands. So all scripts use git-*, this will
prevent a double exec. The path to git-* should be obtained using git
--exec-path in the beginnig.

git <command> is to be used by the user if he wants aliases, default
parameters and other fancy stuff.

Using this policy the user can always get the normal behaviour and it
is possible to shadown built-in commands etc.
