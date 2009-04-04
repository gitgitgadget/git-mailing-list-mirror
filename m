From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to
	be used
Date: Sat, 4 Apr 2009 14:06:01 -0400
Message-ID: <20090404180601.GA14888@coredump.intra.peff.net>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com> <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 20:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqAHf-00080K-31
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 20:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006AbZDDSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961AbZDDSGT
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 14:06:19 -0400
Received: from peff.net ([208.65.91.99]:50013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbZDDSGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 14:06:18 -0400
Received: (qmail 11830 invoked by uid 107); 4 Apr 2009 18:06:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 04 Apr 2009 14:06:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2009 14:06:01 -0400
Content-Disposition: inline
In-Reply-To: <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115590>

On Sat, Apr 04, 2009 at 11:59:56AM -0500, Dan McGee wrote:

> In the case of a small repository, pack-objects is smart enough to not start
> more threads than necessary. However, the output to the user always reports
> the value of the pack.threads configuration and not the real number of
> threads to be used. This is easily fixed by moving the printing of the
> message after we have partitioned our work.
> 
> (pack.threads is on autodetect and would be set to 4)
> $ git-repack -a -d -f
> Counting objects: 55, done.
> Delta compression using 2 threads.
> Compressing objects: 100% (48/48), done.
> Writing objects: 100% (55/55), done.
> Total 55 (delta 10), reused 0 (delta 0)

That makes sense to me, though I wonder if it may confuse and frustrate
users who are expecting their awesome quad-core machine to be using 4
threads when it only uses 2. Is it worth printing both values, or some
indicator that we could have been using more?

-Peff
