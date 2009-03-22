From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Document and test the new % shotcut for the tracked
	branch
Date: Sun, 22 Mar 2009 18:40:16 +0100
Message-ID: <20090322174016.GE8940@machine.or.cz>
References: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de> <20090320111656.GA8940@machine.or.cz> <alpine.DEB.1.00.0903201247440.6865@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 18:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlRgI-0001LM-7J
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 18:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbZCVRkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbZCVRkV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 13:40:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44773 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649AbZCVRkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 13:40:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7D43C1E4C021; Sun, 22 Mar 2009 18:40:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903201247440.6865@intel-tinevez-2-302>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114154>

On Fri, Mar 20, 2009 at 12:48:50PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 20 Mar 2009, Petr Baudis wrote:
> 
> > On Fri, Mar 20, 2009 at 11:31:31AM +0100, Johannes Schindelin wrote:
> > > I had it ready yesterday!  But the real problem is not addressed by 
> > > your patch, either: '%<branch>' is a legal branch name.
> > > 
> > > I briefly considered <branch>^{tracked}, but
> > > 
> > > - the ^{} codepath does not try to substitute branch _names_, so we'd 
> > >   have to duplicate that ^{} detection, and,
> > > 
> > > - it is really cumbersome to write.
> > 
> > We already have @{N} to do one branch-based substitution, so what about 
> > following this convention? Can't we have @{t}?
> 
> Have you ever tried a German keyboard layout?  You would not say that @{} 
> is easy to write if you did.

Interesting, do you really use the regular German keyboard layout while
working in shell or programming? Most Czech people I know [*] use either
the USA layout or Czech programming layout.

> Besides, @{<string>} is already taken for the date-based reflog.

Yes, but some strings can never be dates. ;-)

Has our ref-shed painting fest reached any conclusion yet? I'm not fond
of spending more one-off sequences (~, //, ../, ...) on this, or
anything containing a colon (too confusing, IMHO). It would be nice to
get some generic escaping syntax.

The cleanest way I can think of is declaring ~ a special character and
having <ref>~<letter> as a generic way for ref-based expansions;
master~t would then expand to tracked branch of master.

The only(?) downside is that to mangle HEAD ref, you should write \~t
(but you won't notice your mistake until user 't' appears), but that's
a tough call...

(Should HEAD~t -> $HEAD~t -> master~t -> origin/master or rather
HEAD~t -> origin/HEAD? The former is more intuitive, I guess.)


[*] Since most Czech people I know are UNIX users, it seems...

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
