From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Tue, 10 Sep 2013 09:08:34 +0100
Message-ID: <20130910080834.GL2582@serenity.lan>
References: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <vpqr4cy4g5q.fsf@anie.imag.fr>
 <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
 <20130909195231.GA14021@sigill.intra.peff.net>
 <20130909202435.GJ2582@serenity.lan>
 <CAMP44s0y-cpEWuPTQSwC-Hyp-RNcwdyDRTbAsUewH5bAPPMXuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 10:09:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJJ0N-0005Be-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 10:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab3IJIIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 04:08:55 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38351 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3IJIIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 04:08:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 27EF6CDA597;
	Tue, 10 Sep 2013 09:08:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fMfRGFNld7Q; Tue, 10 Sep 2013 09:08:48 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2BC9FCDA58A;
	Tue, 10 Sep 2013 09:08:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0y-cpEWuPTQSwC-Hyp-RNcwdyDRTbAsUewH5bAPPMXuQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234422>

On Mon, Sep 09, 2013 at 06:02:35PM -0500, Felipe Contreras wrote:
> On Mon, Sep 9, 2013 at 3:24 PM, John Keeping <john@keeping.me.uk> wrote:
> > On Mon, Sep 09, 2013 at 03:52:31PM -0400, Jeff King wrote:
> >> On Mon, Sep 09, 2013 at 11:47:45AM -0700, Junio C Hamano wrote:
> >>
> >> > You are in favor of an _option_ to allow people to forbid a pull in
> >> > a non-ff situation, and I think other people are also in
> >> > agreement. So perhaps:
> >> >
> >> >  - drop jc/pull-training-wheel and revert its merge from 'next';
> >> >
> >> >  - update Felipe's series with a bit of tweak to make it less
> >> >    impactful by demoting error into warning and advice.
> >> >
> >> > would be a good way forward?
> >>
> >> I think that would address the concern I raised, because it does not
> >> create a roadblock to new users accomplishing their task. They can
> >> ignore the warning, or choose "merge" as the default to shut up the
> >> warning (and it is easy to choose that if you are confused, because it
> >> is what git is doing by default alongside the warning).
> >
> > I think we need to make sure that we give instructions for how to go
> > back if the default hasn't done what you wanted.  Something like this:
> >
> >     Your pull did not fast-forward, so Git has merged '$upstream' into
> >     your branch, which may not be correct for your project.  If you
> >     would rather rebase your changes, run
> >
> >         git rebase
> >
> >     See "pull.mode" in git-config(1) to suppress this message in the
> >     future.
> 
> And you propose to show that every single time the user does a 'git
> pull'' that results in a non-fast-forward merge? Isn't that what 'git
> pull --help' is for?

Only if the user has not given an explicit mode (either on the command
line or in their config) and possibly if an advice.pullNonFF variable is
not set to false.  I think that matches what Git does elsewhere.

git-pull(1) provides quite a lot more information that I think a new Git
user would be comfortable with.  There certainly is not a quick way to
find out how to fix this error and I don't think it makes sense to add
one because we'll still be presenting the user with all of the other
content and they won't have any way to know what they can safely ignore
and what they have to read and understand.
