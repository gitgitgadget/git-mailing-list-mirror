From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 14:35:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102141418370.14920@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <m3mxm28v3i.fsf@localhost.localdomain> <201102140036.42197.johan@herland.net>
 <201102141040.35819.jnareb@gmail.com> <4D594E32.3090208@xiplink.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4D9-0006ti-3j
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1BNTfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:35:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33887 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1BNTfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:35:45 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGM00HI1H3I0W20@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Feb 2011 14:35:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4D594E32.3090208@xiplink.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166751>

On Mon, 14 Feb 2011, Marc Branchaud wrote:

> For me, having more than one remote be *simultaneously* authoritative for a
> set of tags is the unusual case.  I find that most projects, no matter how
> decentralized, need to agree upon the project's "official" history, and that
> such agreement is almost always encapsulated within a single, "official"
> repository.  To have more than one is, frankly, insane.

That's a social convention, and a pretty sane one indeed.

BUT if this happens not to be the case (think of a project fork) then 
the tool must not get in the way if you happen to want to track both 
branches at the same time including their possibly conflicting set of 
tags.

So having a separate namespace for tags coming from different remotes 
shouldn't make any difference to you when the tool can easily figure out 
that none of them conflicts with each other.

> So to me it seems completely natural to think of a project's "official" tags
> as the ones that are obtained from the project's "official" repository.  It
> follows that tags should subscribe to the same remote-ref model as branches.

That's exactly what the proposal is about: making remote tags 
distinguishable per remote, just like branches are.

>  The benefits are powerful: consistency; deals naturally with imported
> histories from different repositories; and allows automatic propagation of
> updated (i.e. moved) tags from remotes to clones (yes tags *should* never
> move, but they do, often for good reason and occasionally as part of a
> project's natural evolution).

Sure.  But if you follow a single remote like most people do then you 
won't see the difference from the current state of affairs we have 
today.

But if you do follow multiple remotes related to the same project, and 
one of them do move a tag, then you certainly want to be notified of it 
and then have the _choice_ of the actual remote you want to use for the 
tag meaning, and not having that tag become authoritative for all the 
remotes you track, especially if you may end up not agreeing with that 
move for some reasons.

> There have been several comments disparaging per-remote tags, but people are
> clearly dissatisfied with the status quo.  Can anyone propose another
> alternative?

People have been disparaging the lack of explicit rename tracking in Git 
too.  IMHO those people disparaging per-remote tags so far did not bring 
any serious solid technical reason for not doing it.  Resistance so far 
appears to be based on a fear of change, which change is even not 
justified as people's workflow should remain completely unchanged in the 
presence of duplicate non-conflicting tags encouraged by current social 
conventions.


Nicolas
