From: Jeff King <peff@peff.net>
Subject: Re: Diff colorizer confused by dos newlines
Date: Tue, 9 Jul 2013 15:41:32 -0400
Message-ID: <20130709194132.GD5153@sigill.intra.peff.net>
References: <51DC5650.1070708@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwdnB-0003Jx-Aw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab3GITlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:41:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:41400 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab3GITlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:41:36 -0400
Received: (qmail 12061 invoked by uid 102); 9 Jul 2013 19:42:52 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 14:42:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 15:41:32 -0400
Content-Disposition: inline
In-Reply-To: <51DC5650.1070708@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229986>

On Tue, Jul 09, 2013 at 02:28:32PM -0400, Phillip Susi wrote:

> When I try to look at a color diff of a file using dos newlines, the
> output gets an odd sequence of ansi escapes and a stray carriage
> return showing up only on the + lines, but not the -.  The normal
> looking - lines look like this:
> 
> \r\n ( from previous line ), ansi color escape, '-', whitespace, text,
> terminating ansi escpae ( [m ), \r\n.
> 
> The broken + lines look like this:
> 
> \r\n ( from previous line ), ansi color sequence, '+', terminating
> ansi escape ( [m ), whitespace, ansi color sequence, text, terminating
> ansi escape, ansi color sequence, stray \r, terminating ansi escape, \n.

That's intentional; the added lines go through the "whitespace checker"
to help you identify potential whitespace problems (there is not much
point showing them on lines going away, since you are getting rid of
them).

> Any suggestions on how to resolve this?

Try:

  git config core.whitespace cr-at-eol

See the description of "core.whitespace" in "git help config" for more
details.

-Peff
