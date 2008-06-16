From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git reflog expire honour core.sharedRepository.
Date: Mon, 16 Jun 2008 17:19:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0806161718050.3302@eeepc-johanness>
References: <1213565862-23247-1-git-send-email-madcoder@debian.org> <7vhcbuco2w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806161713520.3302@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	gitster@pobox.com, joerg@debian.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:18:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8GTb-0003gK-Cs
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbYFPPRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbYFPPRk
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:17:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:52092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753506AbYFPPRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:17:39 -0400
Received: (qmail invoked by alias); 16 Jun 2008 15:17:37 -0000
Received: from unknown (EHLO eeepc-johanness.viawireless.co.uk) [212.183.134.211]
  by mail.gmx.net (mp066) with SMTP; 16 Jun 2008 17:17:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195MZ5z5AN5UfbXh7VmV4uYnp09uANY8PbAocqZyy
	TZJdES6V8VF0eA
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0806161713520.3302@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85193>

Hi,

On Mon, 16 Jun 2008, Johannes Schindelin wrote:

> On Sun, 15 Jun 2008, Junio C Hamano wrote:
> 
> > Pierre Habouzit <madcoder@debian.org> writes:
> > 
> > > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > > ---
> > >  builtin-reflog.c       |    1 +
> > >  t/t1301-shared-repo.sh |   15 +++++++++++++++
> > >  2 files changed, 16 insertions(+), 0 deletions(-)
> > >
> > >  Some people like to have logAllRefUpdates even for bare repositories, and if
> > >  shared, git-gc breaks them.
> > >
> > > diff --git a/builtin-reflog.c b/builtin-reflog.c
> > > index 897d1dc..430929f 100644
> > > --- a/builtin-reflog.c
> > > +++ b/builtin-reflog.c
> > > @@ -308,6 +308,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
> > >  		} else if (cmd->updateref && commit_ref(lock)) {
> > >  			status |= error("Couldn't set %s", lock->ref_name);
> > >  		}
> > > +		adjust_shared_perm(log_file);
> > 
> > Why is it sane to do this unconditionally, instead of putting in another
> > else or something?
> 
> Because adjust_shared_perm() checks for shared_repository, and returns 
> when there is nothing to do.

Ooops.  I think I missed your point, namely that this should only be done 
when no error occurred.  I just blame it on the short snippet.

Sorry,
Dscho
