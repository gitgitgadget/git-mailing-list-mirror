From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible BUG in 'git config'
Date: Sun, 11 Feb 2007 18:37:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702111829230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702110613q315e1f7es4ca1a88b92e4c3e9@mail.gmail.com> 
 <Pine.LNX.4.63.0702111720260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702110921l710d62cr6c82baed1b678ab2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 11 18:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGIdv-0005cF-P9
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 18:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbXBKRhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 12:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbXBKRhc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 12:37:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:53972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750753AbXBKRhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 12:37:23 -0500
Received: (qmail invoked by alias); 11 Feb 2007 17:37:21 -0000
X-Provags-ID: V01U2FsdGVkX18TgN9JJEET8NzNOC1fCwlMWzYdnHgFa3SPpqpeel
	lUvA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550702110921l710d62cr6c82baed1b678ab2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39298>

Hi,

On Sun, 11 Feb 2007, Marco Costalba wrote:

> On 2/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > 
> > So I am certain that you made a mistake when you need to ignore the
> > settings in $HOME/.gitconfig.
> > 
> 
> Please do the following:
> 
> $ cd <git tree repo>
> $ git repo-config --global --unset user.name
> $ git repo-config --unset user.name
> $ git gui
> 
> Then go to Edit->options, you will see empty both 'git repository' and
> 'Global (All repositories)'
> 
> Then exit 'git gui' and type:
> 
> $ git repo-config --global user.name dummy
> $ git gui
> 
> Then go to Edit->options and.... surprise! dummy has been added to
> both panes instead of only in 'Global' one.

I don't know. If you want that level of control, yes. But as has been 
suggested before: .git/config as well as ~/.gitconfig have been meant to 
be edited manually, but some people really need a special purpose UI for 
everything, don't they?

As I said, for this you should use "GIT_CONFIG=$GIT_DIR/config git 
config".

> The bug is not in 'git gui' but in 'git repo-config' that when queried
> for user.name if doesn't find it in local config, silently falls back
> in global config. This is not documented and probably a bug because
> documentation of --global option says:
> 
> --global::
>       Use global ~/.gitconfig file *rather than* the repository .git/config.

Yes, this is probably a bug. But it's obvious that if git-config _without_ 
--global would _not_ use ~/.gitconfig, that would rather make ~/.gitconfig 
pointless, wouldn't it?

So yes, the description should mention that this is meant for the case of 
_setting_ variables, not _querying_ variables. The original poster (Sean) 
probaly though -- IMHO correctly -- that querying with --global makes no 
sense.

Ciao,
Dscho
