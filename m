From: Jeff King <peff@peff.net>
Subject: Re: git log omits deleting merges
Date: Thu, 20 Mar 2014 15:54:04 -0400
Message-ID: <20140320195404.GA19252@sigill.intra.peff.net>
References: <5305B045.2060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:54:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQj2b-0007uw-F2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994AbaCTTyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 15:54:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:43405 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756155AbaCTTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:54:07 -0400
Received: (qmail 16724 invoked by uid 102); 20 Mar 2014 19:54:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 14:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 15:54:04 -0400
Content-Disposition: inline
In-Reply-To: <5305B045.2060503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244579>

On Thu, Feb 20, 2014 at 08:35:33AM +0100, Ephrim Khong wrote:

> Hi, git log seems to omit merge commits that delete a file if --follow or
> --diff-filter=D is given. Below is a testcase. I'm not sure if it is desired
> behaviour for --diff-filter=D, but it's probably not correct that --follow
> _removes_ the merge commit from the log output.

This is by design. Git-log does not calculate or show merge diffs unless
"-c" or "--cc" is specified, and thus no diff-filter can match.

> echo "log 1 - no output"
> # note that --diff-filter=A and M work as expected
> # the merge does not show up for --diff-filter=ACDMRTUXB either
> git log --pretty=oneline --diff-filter=D -- some_file

Try:

  git log -c --diff-filter=D -- some_file

which does show it.

-Peff
