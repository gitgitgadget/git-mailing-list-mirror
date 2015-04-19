From: Tim Friske <me@tifr.de>
Subject: Why does "git log --author=<pattern>" not work with "regexp-ignore-case"
 and other regexp-related options?
Date: Sun, 19 Apr 2015 10:29:41 +0200
Message-ID: <55336775.2020000@tifr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 19 10:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjkc0-0005Sq-N2
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 10:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbbDSI3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 04:29:51 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34838 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbbDSI3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 04:29:47 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id 7A25A40491
	for <git@vger.kernel.org>; Sun, 19 Apr 2015 10:29:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id lupu4gZmHrCP for <git@vger.kernel.org>;
	Sun, 19 Apr 2015 10:29:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267433>

Hi,

I wonder why "git log --author=<pattern>" does not work with the
"regexp-ignore-case" option and the other regexp-related options?
Wouldn't it be useful to make the "author=<pattern>" option support the
following options?

  * basic-regexp
  * extended-regexp
  * fixed-strings
  * perl-regexp

In the same way "git log --committer=<pattern>" cannot be combined with
any of the above options.

I tried to find out which regexp dialect to use for the "<pattern>"
argument that must be passed to the "author" and "committer" options but
without luck. The git-log(1) manual page just states for these options
"... that match the specified pattern (regular expression)".

Given a commit with the following headers:

Author: Tim Friske <me@tifr.de>
Commit: Tim Friske <me@tifr.de>

When running "git log --author='tim|friske' --regexp-ignore-case" I
would expect a match because lower- and upper case characters are
treated as equal.

When running "git --log --author='Tim|Friske' --fixed-strings" I would
expect *no* match because the string 'Tim|Friske' should be taken
literally and not be interpreted as a pattern.

When running "git --log --author='Tim|Friske' --basic-regexp" I would
expect *no* match because basic regular expression syntax does not
support "|" alternation.

Wouldn't it be nice to have all of the above options collaborate with
each other?

BR
Tim
