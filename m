From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 11:52:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg>
References: <52327E62.2040301@alum.mit.edu>
 <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
 <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu>
 <20130924075119.GD7257@sigill.intra.peff.net>
 <alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
 <5246C975.1050504@alum.mit.edu>
 <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com>
 <5247ACB9.40208@alum.mit.edu> <52499797.9030100@xiplink.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Marc Branchaud <mbranchaud@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 17:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQfmG-0003lX-J1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 17:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab3I3Pwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 11:52:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43850 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab3I3Pws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 11:52:48 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTY00GUM43ZGX50@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 Sep 2013 11:52:47 -0400 (EDT)
In-reply-to: <52499797.9030100@xiplink.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235616>

On Mon, 30 Sep 2013, Marc Branchaud wrote:

> Why would there be ambiguity warnings?  The fetch command shouldn't issue any
> warnings, since all the remotes' names get safely tucked away in distinct
> namespaces.
> 
> Are we talking about DWIM warnings?  Aside from git-describe I don't see why
> such warnings would be a problem.  To DWIM-resolve a tag name look in
> refs/tags/* and refs/remotes/*/tags/* -- much like it's done for branches
> already.  If a tag name has multiple matches then it's ambiguous.  Git could
> be clever and check for matching SHA1 values, but why bother?  It almost
> seems like a disservice to silently disambiguate such names.  I would think a
> user would prefer to know about any possible ambiguities, rather than have
> some suddenly appear (and maybe also disappear).

Consider that I have in my Linux kernel tree:

- a remote branch corresponding to Linus' master tree

- multiple remote branches corresponding to Linux stable branches

- a remote for linux-next which is a repo constantly being rebased

Now all those repositories share the mainline tags from Linus' repo and 
they add some more of they own which are not shared.  So if they all 
have a v3.11 tag that resolve to the same SHA1, then there is 
effectively no ambiguity at all and git should not warn at all.

*However* if one of those v3.11 tags does not agree with the others 
_then_ I want to be warned about it.

So having multiple matching tags that do resolve to the same SHA1 across 
different remote repositories _is_ the norm and should work 
transparently.


Nicolas
