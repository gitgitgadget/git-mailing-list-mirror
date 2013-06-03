From: Jeff King <peff@peff.net>
Subject: Re: info/exclude not working
Date: Mon, 3 Jun 2013 16:32:26 -0400
Message-ID: <20130603203226.GA23224@sigill.intra.peff.net>
References: <CALy29pLQ-LWg0knzbzLoQfwSt+df_b3tNdWk7OeSN-CjkJhfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Devin Rhode <drhode@amobee.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbQt-0003xq-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab3FCUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:32:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:34378 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab3FCUc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:32:29 -0400
Received: (qmail 2744 invoked by uid 102); 3 Jun 2013 20:33:13 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Jun 2013 15:33:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2013 16:32:26 -0400
Content-Disposition: inline
In-Reply-To: <CALy29pLQ-LWg0knzbzLoQfwSt+df_b3tNdWk7OeSN-CjkJhfsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226277>

On Mon, Jun 03, 2013 at 01:04:39PM -0700, Devin Rhode wrote:

> MBP:dish devin$ cat ../.git/info/exclude
> # git ls-files --others --exclude-from=.git/info/exclude
> # Lines that start with '#' are comments.
> # For a project mostly in C, the following would be a good set of
> # exclude patterns (uncomment them if you want to use them):
> # *.[oa]
> # *~
> models/CAFE.json
> dish/models/CAFE.json
> 
> MBP:dish devin$ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> # modified:   models/CAFE.json ***Shouldn't appear

The exclude mechanism does not mean "do not ever look at this file". It
means "when you are adding untracked files, do not include this one".
Somebody has already added the file to the repository before your
exclude was in place, so it is a tracked file.

There is currently no official mechanism in git to do what you want
(there are some hacks, but they include many pitfalls).

-Peff
