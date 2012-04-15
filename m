From: Clemens Buchacher <drizzd@aon.at>
Subject: Illegal filename characters one Windows
Date: Sun, 15 Apr 2012 02:07:26 +0200
Message-ID: <20120415000725.GA32140@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sun Apr 15 02:09:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJD1r-0007Xi-9E
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 02:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab2DOAIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 20:08:43 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:25074 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755143Ab2DOAIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 20:08:43 -0400
Received: (qmail 9581 invoked from network); 15 Apr 2012 00:08:39 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL507.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub82.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <msysgit@googlegroups.com>; 15 Apr 2012 00:08:39 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195538>

Hi,

I recently noticed that git does not deal very well with illegal
filenames on Windows. I have a repository which contains a couple of
filenames like "Re: some email.eml". On a Windows box, those files get
truncated to just "Re" during checkout, because ':' is an illegal
character for filenames on Windows. [1]

I know that the easiest solution would be to simply remove the illegal
characters on my Linux box and be done with it. But I dislike the fact
that git cannot handle such filenames more gracefully.

So I have been wondering how to fix this. I have considered converting
the filename to unicode or URL encoding or even just dropping the
illegal characters on checkout. But no matter which conversion I choose,
it will conflict with the converted filename, which would be a valid
index entry itself.

If a reasonable solution is not possible, maybe we should not try to
checkout such files at all, and mark them with --skip-worktree. That way
one can at least use such repositories, as long as one does not have to
touch any files with illegal characters in their filename. As it is,
most commands are not usable because the work tree is always dirty (the
files with illegal names have been "removed").

Any better ideas?

Clemens

[1] http://en.wikipedia.org/wiki/Filename
