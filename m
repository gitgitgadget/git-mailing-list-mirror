From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] [submodule] Add depth to submodule update
Date: Fri, 28 Jun 2013 08:50:01 +0200
Message-ID: <20130628065001.GA2783@sandbox-ub>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
 <20130624224925.GC32270@paksenarrion.iveqy.com>
 <20130625221132.GB4161@sandbox-ub>
 <20130626160219.GC9141@paksenarrion.iveqy.com>
 <7vli5wvb3n.fsf@alter.siamese.dyndns.org>
 <51CC5235.6030908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 28 08:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsSVg-0003IP-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 08:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab3F1GuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 02:50:14 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:35148 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab3F1GuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 02:50:13 -0400
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UsSVQ-0000nQ-UA; Fri, 28 Jun 2013 08:50:05 +0200
Content-Disposition: inline
In-Reply-To: <51CC5235.6030908@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229177>

On Thu, Jun 27, 2013 at 04:54:45PM +0200, Jens Lehmann wrote:
> Am 26.06.2013 23:03, schrieb Junio C Hamano:
> > Fredrik Gustafsson <iveqy@iveqy.com> writes:
> > 
> >> On Wed, Jun 26, 2013 at 12:11:32AM +0200, Heiko Voigt wrote:
> >>> On Tue, Jun 25, 2013 at 12:49:25AM +0200, Fredrik Gustafsson wrote:
> >>>> Used only when a clone is initialized. This is useful when the submodule(s)
> >>>> are huge and you're not really interested in anything but the latest commit.
> >>>>
> >>>> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> >>>
> >>> I this is a valid use case. But this option only makes sense when a
> >>> submodule is newly cloned so I am not sure whether submodule update is
> >>> the correct place. Let me think about this a little more. Since we do
> >>> not have any extra command that initiates the clone this is probably the
> >>> only place we can put this option. But at the moment it does not feel
> >>> completely right.
> >>>
> >>> Apart from that the code looks good. If the user does a checkout of a
> >>> revision that was not fetched submodule update will error out the same
> >>> way as if someone forgot to push his submodule changes. So that should
> >>> not be a problem.
> >>
> >> I agree and would love to say that I've a more beautiful solution, but
> >> I haven't.
> >>
> >> The only other solution I can think about is to add a git
> >> submodule clone that will do only clones of non-cloned submodules.
> > 
> > The "update" subcommand already has "--init" to do "init && update",
> > and it would not complain if a given submodule is what you already
> > have shown interest in, so in that sense, I do not think what the
> > posted patch does is too bad---if it is already cloned, it just
> > ignores the depth altogether and makes sure the repository is there.
> > A separate "submodule clone" would only make it more cumbersome to
> > use, I suspect.
> 
> Yup, I see no need for a new command either.

I agree there is no reason for that.

> Me too thinks adding "--depth" to "update" makes sense (and I don't
> think that this pretty generic name will become a problem later in
> case someone wants to add a maximum recursion depth, as grep already
> uses "--max-depth" for the same purpose).

Hmm, but does it have a --depth option for revisions? Maybe we should
call it --clone-depth or --rev-depth to make it clear? --depth and
--max-depth would be completely orthogonal but the name does not allow
to distinguish them properly.

> But "--depth" should also be added to the "submodule add" command.
> As an example we already have the "--reference" option, which is
> passed to clone on add and update. Additionally that one supports
> the form with and without '=', so I'd prefer the new update option
> to basically re-use the same code the reference option uses. And
> at least two tests, of course ;-)

And add documentation, please :-)

Cheers Heiko
