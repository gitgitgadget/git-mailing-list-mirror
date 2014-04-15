From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Tue, 15 Apr 2014 01:43:57 -0400
Message-ID: <20140415054356.GA4772@sigill.intra.peff.net>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
 <20140412114212.GB14820@sigill.intra.peff.net>
 <5349562bb7ae4_c9914c7308f9@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 07:44:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZwA8-00077c-B4
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 07:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbaDOFoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 01:44:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60014 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875AbaDOFn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 01:43:59 -0400
Received: (qmail 20406 invoked by uid 102); 15 Apr 2014 05:43:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Apr 2014 00:43:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Apr 2014 01:43:57 -0400
Content-Disposition: inline
In-Reply-To: <5349562bb7ae4_c9914c7308f9@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246274>

On Sat, Apr 12, 2014 at 10:05:15AM -0500, Felipe Contreras wrote:

> As you can see; some branches are published, others are not. The ones that are
> not published don't have a @{publish}, and `git branch -v` doesn't show them.
> Why is that hard to understand?

Do you ever push the unpublished branches anywhere at all? If not, then
you would not have a tracking branch. E.g., git _would_ push to remote
"gh", branch "refs/heads/topic", but there is no remote tracking branch
"refs/remotes/gh/topic", because you have never actually pushed there.
So there is no @{publish} branch.

Or do you have some branches in a state where they are "pushed, but not
published"? It wasn't clear to me from your example if your "pu" or
"dev/remote/hg-extra" ever get pushed.

I do not use "git branch -v" myself, so I don't personally care that
much how it behaves. But I do use a separate script that does the same
thing, and I would want it to show the ahead/behind relationship between
each branch and where it would be pushed to (and as I said, I define
mine with refspecs). Right now it uses nasty hackery to guess at where
things will be pushed, but ideally it would ask git via @{push} or some
similar mechanism.

If the former (you do not actually push them), then I think the
semantics I am looking for and the ones you want would coincide. If not,
then I think we are really talking about two different things.

-Peff
