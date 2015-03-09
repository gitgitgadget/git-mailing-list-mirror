From: Jeff King <peff@peff.net>
Subject: Re: Efficient parsing of `status -z` output
Date: Mon, 9 Mar 2015 02:19:20 -0400
Message-ID: <20150309061920.GB27128@peff.net>
References: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
 <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com>
 <CAMJduDvDO4GesL+eru3h1YHrbF5hFmyycX3f4ADQOo+VnD7GDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthew Rothenberg <mrothenberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 07:19:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUr2H-00022b-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 07:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbbCIGTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 02:19:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59022 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750897AbbCIGTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 02:19:23 -0400
Received: (qmail 5475 invoked by uid 102); 9 Mar 2015 06:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 01:19:23 -0500
Received: (qmail 4089 invoked by uid 107); 9 Mar 2015 06:19:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:19:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 02:19:20 -0400
Content-Disposition: inline
In-Reply-To: <CAMJduDvDO4GesL+eru3h1YHrbF5hFmyycX3f4ADQOo+VnD7GDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265128>

On Sun, Mar 08, 2015 at 09:41:08PM -0400, Matthew Rothenberg wrote:

> I see, thank you. But how would one ever get a copy operation to show
> up in the output of `git status -z` to begin with? It appears copies
> are only detected in `diff` and `show`, can be forced with the
> --find-copies-harder option, but that `git status` does not appear to
> take that option nor detect copies in any way that I can get it to
> replicate and output that status code to me... a test case would be
> great if you know one, thanks!

We don't turn on copy-detection in "git status" by default (only rename
detection), and I think you are right that there is currently no way to
turn it on manually. However, it would probably be sensible to handle
"C" diffs in your parser, if only to future-proof against a day when
that changes (and because it should fairly trivial once you build "R"
support).

I don't know if anybody is actively working on such a change, but
somebody expressed interest recently-ish:

  http://thread.gmane.org/gmane.comp.version-control.git/260381

-Peff
