From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 17:30:55 -0500
Message-ID: <20071217223055.GI13515@fieldses.org>
References: <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <20071217211317.GC19816@mail.oracle.com> <20071217213049.GG13515@fieldses.org> <alpine.LFD.0.999999.0712171646230.8467@xanadu.home> <20071217215709.GH13515@fieldses.org> <7vtzmh55lu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OVv-00018b-5E
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759349AbXLQWbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759165AbXLQWbQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:31:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:47098 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757308AbXLQWbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:31:15 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J4OUB-0000cG-Ep; Mon, 17 Dec 2007 17:30:55 -0500
Content-Disposition: inline
In-Reply-To: <7vtzmh55lu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68640>

On Mon, Dec 17, 2007 at 02:17:01PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > On Mon, Dec 17, 2007 at 04:52:16PM -0500, Nicolas Pitre wrote:
> >> On Mon, 17 Dec 2007, J. Bruce Fields wrote:
> >> 
> >> > By the way, just as a data point: I do keep some git repositories on
> >> > NFS, and access them from multiple machines with different git versions
> >> > (not on purpose--it's just that the machines don't all run the same
> >> > distro, so it'd be extra work to give them all the same version).  I
> >> > don't use anything older than 1.5.0.  If the repository became unusable
> >> > on one of those machines without warning it'd be annoying.
> >> 
> >> What the v1.5.5 release notes will say is that you'll have to set 
> >> pack.indexversion=1 to remain compatible with pre-1.5.2 Git versions.  
> >
> > Is there any reason not to make pack.indexversion=1 the default (for
> > preexisting repositories at the very least) and suggest in the release
> > notes that people set something else if they want the features the new
> > version provides?
> 
> That's a judgement call.

Sure.  And I'm totally unfamiliar with the details here, so don't my let
my judgement weigh too heavily.

> Pack-idx format v2 is by design much safer in the face of bitflip (do we
> have a test case to make sure this is indeed true?).  But from the end
> user's point of view, all the usual "I do not want to be forced to
> update that old box I do not want to touch" applies.
> 
> And the people who needs to suffer from the dilemma are only the ones
> who access a single repository across NFS with git from different
> vintage.

Hm.  We tell people to set up public repo's by doing something like:

	git clone --bare ~/proj proj.git
	touch proj.git/git-daemon-export-ok
	scp -r proj.git example.com:

Is that going to hit the same problem if the public server has an older
git version?  (Servers do tend to be on longer upgrade cycles; the
public server I use was on something 1.4ish till about a month ago.)

--b.
