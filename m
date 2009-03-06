From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
	configured
Date: Fri, 6 Mar 2009 12:48:12 +0100
Message-ID: <20090306114812.GA19534@pvv.org>
References: <20090305221529.GA25871@pvv.org> <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com> <200903052322.02098.markus.heidelberg@web.de> <200903052325.44648.markus.heidelberg@web.de> <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com> <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de> <7v4oy7szze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfYYn-0001P0-GE
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 12:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbZCFLsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 06:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZCFLsV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 06:48:21 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:59741 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZCFLsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 06:48:20 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LfYXE-0000un-6O; Fri, 06 Mar 2009 12:48:12 +0100
Content-Disposition: inline
In-Reply-To: <7v4oy7szze.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112427>

On Fri, Mar 06, 2009 at 02:32:53AM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
> >
> >> On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
> >> <markus.heidelberg@web.de> wrote:
> >> > Oh, I confused "config option" with "command line argument"...
> >> 
> >> Right, I'd like to be able to do:
> >> $ git config push.iamnotretarded true
> >> $ git push
> >
> > LOL!  Sverre, you have a way to crack me up...
> 
> I found it amusing, too.
> 
> It may have some correlation with how well organized your work habit is,
> but I do not think it has much correlation with being retarded.  It is
> more about "'matching refs' is the perfect default for _my_ use pattern,
> don't mess with it, please".

So here is my current WIP suggestion for a new "push.default"
variable, I am not sure if a single entry can express all useful
choices, or if it is a good idea to introduce more default choices
other than "nothing" (with the goal of making it the default in a
later release).

I think all the values here make sense as a --option to git push
though (except --nothing...)

Suggested new entry in config.txt:

push.default::
	Defines the action git push should take if no refspec is given
	on the command line, no refspec is configured in the branch, and
	no refspec is implied by any of the options given on the command
	line.
+
	The term `current remote` means the remote configured for the current
	branch, or `origin` if no remote is set. `origin` is also used if
	you are not on a branch at all.
+
* `nothing` do not push anything
* `matching` push all matching branches to the current remote.
  All branches having the same name in both ends are considered to be
  matching. This is the default value.
* `same-remote` push all matching branches that are configured to use
  the current remote. Branches with no remote configuration are not pushed.
* `tracked` push all branches that are tracking a branch on the current
  remote to their counterpart.


- Finn Arne
