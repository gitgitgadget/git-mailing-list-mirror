From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last
 branch
Date: Thu, 15 Jan 2009 21:35:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901152132390.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151500.01876.trast@student.ethz.ch> <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de> <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNYwf-0007Zn-Mf
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 21:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410AbZAOUee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 15:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933414AbZAOUed
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 15:34:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:60124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933410AbZAOUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 15:34:31 -0500
Received: (qmail invoked by alias); 15 Jan 2009 20:34:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 15 Jan 2009 21:34:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19a905Jw25amytIq8D4XF5OvRG3mKbqoJhpLVXFKg
	k/toFPuUML9o7H
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105875>

Hi,

On Thu, 15 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 15 Jan 2009, Johannes Schindelin wrote:
> >
> >> [PATCH] pack-objects --all: include HEAD, which could be detached
> >
> > In hind sight, it would probably be better to add this to revision.c.
> 
> If you mean that "git log --all" should also include a possibly detached
> HEAD in its traversal, and a patch that implements such a fix would
> automatically fix "repack -a" without the patch you are responding to, I
> think I agree 100%.

Yes, indeed.

Something like

-- snip --
diff --git a/revision.c b/revision.c
index db60f06..b065184 100644
--- a/revision.c
+++ b/revision.c
@@ -1263,6 +1263,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 			if (!strcmp(arg, "--all")) {
 				handle_refs(revs, flags, for_each_ref);
+				handle_refs(revs, flags, head_ref);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-- snap --

but that was just a quick guess, and if nobody beats me to it, I'll turn 
it into a proper patch later.

Ciao,
Dscho
