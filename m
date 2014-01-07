From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop unnecessary copying in credential_ask_one
Date: Tue, 7 Jan 2014 15:02:22 -0500
Message-ID: <20140107200221.GB21812@sigill.intra.peff.net>
References: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
 <20140102030330.GA10976@sigill.intra.peff.net>
 <20140102073835.GA5431@sigill.intra.peff.net>
 <xmqq7gaiqjzw.fsf@gitster.dls.corp.google.com>
 <20140107175009.GA19691@sigill.intra.peff.net>
 <xmqqlhyrd1bz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cr6-0003LT-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbaAGUCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:02:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:56650 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbaAGUCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:02:24 -0500
Received: (qmail 20434 invoked by uid 102); 7 Jan 2014 20:02:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 14:02:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 15:02:22 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlhyrd1bz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240143>

On Tue, Jan 07, 2014 at 11:44:00AM -0800, Junio C Hamano wrote:

> > test-terminal only handles stdout and stderr streams as fake terminals.
> > We could pretty easily add stdin for input, as it uses fork() to work
> > asynchronously.  But the credential code does not actually read from
> > stdin. It opens and reads from /dev/tty explicitly. So I think we'd have
> > to actually fake setting up a controlling terminal. And that means magic
> > with setsid() and ioctl(TIOCSCTTY), which in turn sounds like a
> > portability headache.
> 
> I wonder if "expect" has already solved that for us.

I would not be surprised if it did. Though it introduces its own
portability issues, since we cannot depend on having it. But it is
probably enough to just

  test_lazy_prereq EXPECT 'expect --version'

or something. I dunno. I have never used expect, do not have it
installed, and am not excited about introducing a new tool dependency.
But if you want to explore it, be my guest.

-Peff
