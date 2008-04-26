From: Jeff King <peff@peff.net>
Subject: Re: warning: too many files, skipping inexact rename detection
Date: Sat, 26 Apr 2008 09:57:37 -0400
Message-ID: <20080426135737.GA382@sigill.intra.peff.net>
References: <20080426063209.5615dd5e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 15:58:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpkv3-0004ZB-Ej
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYDZN5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 09:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYDZN5i
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 09:57:38 -0400
Received: from peff.net ([208.65.91.99]:4791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYDZN5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 09:57:37 -0400
Received: (qmail 24115 invoked by uid 111); 26 Apr 2008 13:57:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 26 Apr 2008 09:57:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2008 09:57:37 -0400
Content-Disposition: inline
In-Reply-To: <20080426063209.5615dd5e.akpm@linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80376>

On Sat, Apr 26, 2008 at 06:32:09AM -0700, Andrew Morton wrote:

> I get the above message all the time when pulling all the git trees.
> 
> I'm frightened!

Rename detection is O(n^2), so when it looks like it will take a really
long time, we skip it. This has been happening for a while, but 1.5.5
only recently started telling the user (based on some people wondering
why renames weren't found during their enormous merges).

The default rename limit is 100, but you can bump it via the
diff.renamelimit config option. A few tests that I did imply that
200-400 is reasonable for logging, and 800-1000 for a merge:

  http://article.gmane.org/gmane.comp.version-control.git/73519

Are you running into actual problems with rename detection, or is the
message just too scary and confusing?

-Peff
