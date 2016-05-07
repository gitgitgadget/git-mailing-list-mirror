From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Sat, 7 May 2016 01:32:09 -0400
Message-ID: <20160507053209.GA1704@sigill.intra.peff.net>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
 <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
 <20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
 <xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 07:32:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayuqf-0002qh-Go
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 07:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbcEGFcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 01:32:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:35593 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbcEGFcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 01:32:13 -0400
Received: (qmail 21468 invoked by uid 102); 7 May 2016 05:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 May 2016 01:32:12 -0400
Received: (qmail 3694 invoked by uid 107); 7 May 2016 05:32:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 May 2016 01:32:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 May 2016 01:32:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293873>

On Fri, May 06, 2016 at 08:33:15AM -0700, Junio C Hamano wrote:

> > Then I replied:
> >
> >    However, that doesn't mean that we have to spread this badly chosen
> >    name from options to config variables, does it?  I think that if we
> >    are going to define a new config variable today, then it should be
> >    named properly, and it's better not to call it 'commit.verbose', but
> >    'commit.showDiff' or something.
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=289303
> >
> > Any thoughts on this?  Before a poorly named config variable enters to
> > the codebase and we'll have to maintain it "forever"...
> 
> My thoughts are --show-diff would probably be a UI mistake of a
> different sort, if you are anticipating that the different kinds of
> information to be shown in verbose modes would proliferate and that
> you would want to give the user flexibility to pick and choose to
> use some while not using some other among them.  You would end up
> having --show-xyzzy --show-frotz --show-nitfol ... options.
> 
> I am not convinced that we would want such a degree of flexibility
> in the first place, but even if we did, we'd be better off giving
> that as "--verbose=diff,xyzzy,frotz...", I would think.
> 
> And commit.verbose that begins its life as a simple boolean, which
> can be extended to become bool-or-string if needed, is better than
> having commit.showDiff, commit.showXyzzy, commit.showFrotz, etc.

I don't think anyone is anticipating more "--show-" options. It is just
that "--verbose" is the opposite of "--quiet" in most other commands,
and pertains to chattiness on the terminal about what is going on.

Whereas in git-commit, is about sticking some data in the commit message
template. Naively I'd expect it to cause commit to spew more data to
stderr about what's being committed, ident info, etc.

If you are thinking that there could be something like "--show-ident" to
replace that, I do not mind that too much. But IMHO that does not
address the root problem that commit's "--verbose" is not very much like
the same option in other commands. And something like
"--verbose=diff,ident" just seems to make that worse by coupling options
that otherwise don't have anything to do with each other.

-Peff
