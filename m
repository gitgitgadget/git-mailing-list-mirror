From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 16:24:32 -0500
Message-ID: <20140107212432.GD28102@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
 <20140107205618.GA28102@sigill.intra.peff.net>
 <xmqqvbxvbiwz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:24:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0e8d-0008L4-0C
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbaAGVYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:24:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:56710 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752691AbaAGVYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:24:34 -0500
Received: (qmail 25211 invoked by uid 102); 7 Jan 2014 21:24:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 15:24:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 16:24:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbxvbiwz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240157>

On Tue, Jan 07, 2014 at 01:07:08PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, "pushbranch" is probably a better name for what I am referring to.
> > I agree that pushremote is probably enough for sane cases. I seem to
> > recall that people advocating the "upstream" push-default thought that
> > branch name mapping was a useful feature, but I might be
> > mis-remembering. I will let those people speak up for the feature if
> > they see fit; it seems somewhat crazy to me.
> 
> I think "branch mapping" you recall are for those who want to push
> their 'topic' to 'review/topic' or something like that.  With Git
> post 7cdebd8a (Merge branch 'jc/push-refmap', 2013-12-27), I think
> "remote.*.push" can be used to implement that, by the way.

Hmm. The top patch of that series still relies on "upstream" being a
push destination, though. So if I have a triangular workflow where I
fork "topic" from "origin/master", my "git push origin topic" will go to
"refs/heads/master" on "origin" under the "upstream" rule. So that seems
broken as ever. :)

But I guess what you are referring to is that in a triangular world, the
second patch lets me do:

  git config push.default current
  git config remote.origin.push 'refs/heads/*:refs/review/*'

And then "git push", "git push origin", or "git push origin topic" all
put it in "review/topic", which is what I want.

I think that is sensible, and only heightens my sense of the "upstream"
push.default as useless. :)

-Peff
