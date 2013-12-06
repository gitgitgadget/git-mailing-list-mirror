From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Fri, 6 Dec 2013 17:18:06 -0500
Message-ID: <20131206221805.GE25620@sigill.intra.peff.net>
References: <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
 <20131205202807.GA19042@sigill.intra.peff.net>
 <xmqq4n6m52fy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3ix-00032L-Pz
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759490Ab3LFWSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:18:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:51879 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758737Ab3LFWSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:18:08 -0500
Received: (qmail 11805 invoked by uid 102); 6 Dec 2013 22:18:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 16:18:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 17:18:06 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4n6m52fy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238960>

On Thu, Dec 05, 2013 at 02:59:45PM -0800, Junio C Hamano wrote:

> > One test needs to be updated, because it actually corrupts a
> > pack and expects that re-packing the corrupted bytes will
> > use the same name. It won't anymore, but we can easily just
> > use the name that pack-objects hands back.
> 
> Re-reading the tests in that script, I am not sure if keeping these
> tests is even a sane thing to do, by the way.  It "expects" that
> certain breakages are propagated, and anybody who breaks that
> expectation by improving pack-objects etc. to catch such breakages
> will be yelled at by breaking the test that used to pass.

I had a similar thought, but I figured I would leave it for the person
who _does_ make that change. The yelling will be a good signal that
they've got it right, and they can clean up the test (either by dropping
it, or modifying it to check the right thing) at that point.

> Seeing that the way the test scripts are line-wrapped follows the
> ancient convention, I suspect that this may be because it predates
> our more recent best practice to document known breakages with
> test_expect_failure.

I read it more as "make sure that the v1 index breaks, so when we are
testing v2 we know it is not an accident that we notice the breakage".

But I also see your reason, and I think it would be fine to use
test_expect_failure.

-Peff
