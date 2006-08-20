From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository
Date: Sun, 20 Aug 2006 19:24:58 +0200
Organization: M38c
Message-ID: <20060820172458.GA21362@nospam.com>
References: <20060820105452.GA19630@nospam.com> <Pine.LNX.4.63.0608201519360.28360@wbgn013.biozentrum.uni-wuerzburg.de> <20060820152404.GA5679@nospam.com> <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rutger Nijlunsing <git@wingding.demon.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 19:25:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEr2v-0002uk-7W
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 19:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWHTRZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWHTRZE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 13:25:04 -0400
Received: from post-26.mail.nl.demon.net ([194.159.73.196]:49346 "EHLO
	post-26.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750901AbWHTRZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 13:25:04 -0400
Received: from wingding.demon.nl ([82.161.27.36]:54748)
	by post-26.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GEr2k-0002yG-5x; Sun, 20 Aug 2006 17:25:02 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GEr2g-0006yE-UJ; Sun, 20 Aug 2006 19:24:58 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25758>

On Sun, Aug 20, 2006 at 06:09:34PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
> 
> > On Sun, Aug 20, 2006 at 03:20:19PM +0200, Johannes Schindelin wrote:
> > > Hi,
> > > 
> > > On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
> > > 
> > > > You can also find it on http://www.wingding.demon.nl/git-rev-size.rb
> > > 
> > > Ruby is _so_ mainstream. Could I have a Haskell version, pretty please?
> > 
> > I _knew_ it... Please go bug someone else. The only thing I did was
> > help someone, and for that I choose my own tools since I do it for
> > fun.
> 
> Fair enough.
> 
> -- 8< --
> [PATCH] Add git-rev-size
> 
> This tool spits out the number of trees, the number of blobs, and the total
> bytes of the blobs for a given rev range.
> 
> Most notably, it adds an object hash map structure to the library.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>


[Hm, the itch seems to be contagious. Better watch out...]

Small comments:

The 'git-rev-size' name was chosen because originally it understood
the same arguments as git-rev-list. You might want to add this popen()
back, or have some other way to share those (might be simple in C). Or
is setup_revisions() enough to have the power of git-rev-list?

If seperate commits have to be given on the command line instead of a
range, the command line limit is hit quite quickly (~780 commits). And
if you'll be using xargs, the hash / cache will be less of an advantage.

The original request was 'for each commit' to get an idea of the size
growth during a project.

'builtin_rev_size_usage' is not referred to in the patch, only defined.

Signed-off-by: Rutger Nijlunsing <git@tux.tmfweb.nl>


> ---
>  Makefile           |    4 ++
>  builtin-rev-size.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h          |    1 +
>  git.c              |    1 +
>  hash.c             |   50 ++++++++++++++++++++++++++++
>  hash.h             |   12 +++++++
>  6 files changed, 159 insertions(+), 1 deletions(-)
[snip patch]

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
