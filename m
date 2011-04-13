From: lists@haller-berlin.de (Stefan Haller)
Subject: Interdiff between amended commits
Date: Wed, 13 Apr 2011 13:54:38 +0200
Message-ID: <1jzlxb0.12qxbsl1na9qhzM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:18:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9z1t-00018q-Uf
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab1DMMSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 08:18:36 -0400
Received: from mail.ableton.net ([62.96.12.117]:46333 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448Ab1DMMSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 08:18:36 -0400
X-Greylist: delayed 1434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 08:18:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=KZO5sf2ZURbe67tLZcLOkSBvercE5Dygw0KcmY9LTh0=;
	b=PbjR540SmD/ZR/zgj9IXJxXROHTEvuD3Z+1rl1kDIMoeKATNd7gmXVhAo3cPgPYuXz29Y2j2CZfXw808BmNCfsJ0dNVxeAEYWV0mNLVIMSGqTwGnSRQq7uOSewzhJA0nYATw7teWEDNpYYqoRCjgarupMDvEMIKtkeTwlmezoRk=;
Received: from macbook-stk.office.ableton.com ([10.1.12.10])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1Q9yec-0000x3-SL
	for git@vger.kernel.org; Wed, 13 Apr 2011 13:54:38 +0200
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.7 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171447>

I'd like to show an interdiff between two commits, e.g. when a commit
was amended.

I'm aware of the "intercommit" alias in the git wiki:

  $ git show commit1 > .git/commit1 && git show commit2 > .git/commit2 && interdiff .git/commit[12]

It only works for simple cases though, and I'd also like to avoid the
dependency to an external tool if possible.

So one thing I came up with is this:

  git checkout commit1^
  git cherry-pick --no-commit commit2
  git diff --cached

Two problems:

1) It requires a non-bare clone. At the place where I need it (on a
   server that sends commit emails) I only have a bare clone, so ideally
   I'd like something that doesn't need a working directory at all.

2) I'm not sure what to do if the cherry-pick doesn't apply cleanly.
   (The interdiff command has the same problem, of course).
   I don't even know what information I want to see in that case;
   anybody have an idea?

Any other thoughts about this are appreciated.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
