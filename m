From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 19:04:43 -0500
Message-ID: <20071218000443.GA8294@fieldses.org>
References: <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <20071217211317.GC19816@mail.oracle.com> <20071217213049.GG13515@fieldses.org> <alpine.LFD.0.999999.0712171646230.8467@xanadu.home> <20071217215709.GH13515@fieldses.org> <7vtzmh55lu.fsf@gitster.siamese.dyndns.org> <20071217223055.GI13515@fieldses.org> <7vprx553u4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Py4-0001RS-1l
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbXLRAFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbXLRAFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:05:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59130 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290AbXLRAFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:05:15 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J4Pwx-0002LZ-TD; Mon, 17 Dec 2007 19:04:43 -0500
Content-Disposition: inline
In-Reply-To: <7vprx553u4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68666>

On Mon, Dec 17, 2007 at 02:55:15PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Hm.  We tell people to set up public repo's by doing something like:
> >
> > 	git clone --bare ~/proj proj.git
> > 	touch proj.git/git-daemon-export-ok
> > 	scp -r proj.git example.com:
> >
> > Is that going to hit the same problem if the public server has an older
> > git version?
> 
> It will, but I think you should teach people --mirror pushing these
> days, which was specifically invented for priming the public
> repository.
>
> That way, the administrator at example.com, as long as he initializes an
> empty repository with suitable daemon-export-ok and necessary hooks
> (which can be automated via templates), does not even have to allow you
> a full ssh access.

So the basic instructions would be something like this?:

	ssh example.com "git init --bare myproj.git"
	# (or ask your admin to do the previous step)
	git add remote example example.com:myproj.git
	git push --mirror example

OK, that's neat, thanks.

On the backwards-compatibility issue, though: this won't help the large
number of people who learned to just clone a bare repo and copy it
around, since they aren't of their own initiative going to seek out new
ways of doing things that they think they already know how to do.

--b.
