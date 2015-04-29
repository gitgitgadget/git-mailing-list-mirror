From: Jeff King <peff@peff.net>
Subject: Re: 'git show' with multiple revisions
Date: Tue, 28 Apr 2015 22:04:52 -0400
Message-ID: <20150429020452.GA873@peff.net>
References: <loom.20150428T120412-982@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 04:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnHMx-0005JO-UI
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 04:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031323AbbD2CEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 22:04:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:51478 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031266AbbD2CEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 22:04:55 -0400
Received: (qmail 2747 invoked by uid 102); 29 Apr 2015 02:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 21:04:54 -0500
Received: (qmail 23218 invoked by uid 107); 29 Apr 2015 02:05:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 22:05:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 22:04:52 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150428T120412-982@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267952>

On Tue, Apr 28, 2015 at 10:10:52AM +0000, Ed Avis wrote:

> Could 'git show' sprout an option to get multiple things programmatically
> so that they can be separated out again?  One way would be to quote or escape
> the contents somehow so that the result can be parsed:
> 
>     % git show --porcelain REV1:FILE REV2:FILE
>
> [...]
>
> Note that here I am only getting the file content, not log messages or any of
> the other things which 'git show' can produce.  So perhaps what I really want
> is some kind of 'git cat'.  Or is there another more appropriate tool?

I think you want `git cat-file`:

  {
	echo REV1:FILE
	echo REV2:FILE
  } |
  git cat-file --batch

This prints a header line for each output object which contains the size
of the object (so a parser reads a header line, then N bytes, then a
header line, N bytes, and so on).

-Peff
