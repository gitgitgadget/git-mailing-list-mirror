From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 19:41:29 -0400
Message-ID: <20140613234128.GE23078@sigill>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
 <20140613065942.GB7908@sigill.intra.peff.net>
 <xmqqtx7o3dvh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Mike Burns <mike@mike-burns.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvb6I-0001On-2m
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 01:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbaFMXle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 19:41:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:43911 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754113AbaFMXle (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 19:41:34 -0400
Received: (qmail 2175 invoked by uid 102); 13 Jun 2014 23:41:34 -0000
Received: from mobile-166-198-031-023.mycingular.net (HELO sigill.intra.peff.net) (166.198.31.23)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 18:41:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:41:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtx7o3dvh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251653>

On Fri, Jun 13, 2014 at 10:42:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [1] It might make sense for test_set_editor, when run from within a
> >     test, to behave more like test_config, and do:
> >
> >       test_when_finished '
> >         sane_unset FAKE_EDITOR &&
> >         sane_unset EDITOR
> >       '
> >
> >     I don't know if there would be fallouts with other test scripts,
> >     though.
> 
> The default environment for tests is to set EDITOR=: to avoid
> accidentally triggering interactive cruft and interfering with
> automated tests, I thought.

Ah, yeah, that would make more sense.

> If the above sane-unset is changed to EDITOR=: then I think that is
> probably sensible.

I think the trick is that other scripts may be relying on the global
side-effect, and would need to be fixed up (and it is not always obvious
which spots will need it; they might fail the tests, or they might start
silently passing for the wrong reason).

-Peff
