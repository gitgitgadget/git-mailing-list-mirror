From: linux@horizon.com
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: 23 Feb 2006 19:29:15 -0500
Message-ID: <20060224002915.17331.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 01:29:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCQpv-0005lK-1L
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 01:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBXA30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 19:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWBXA30
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 19:29:26 -0500
Received: from science.horizon.com ([192.35.100.1]:29261 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932246AbWBXA3Z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 19:29:25 -0500
Received: (qmail 17332 invoked by uid 1000); 23 Feb 2006 19:29:15 -0500
To: cworth@cworth.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16677>

The annoying thing about temporary branch names like "bisect" and "seek"
is that:
a) They clutter up the nae space available to the repository user.
   Users have to know that those are reserved names.
b) If a repository is cloned while they're in use, they might get
   into a "remotes" file, with even more confusing results.

This is somewhat heretical, but how about making a truly unnamed branch by
having .git/HEAD *not* be a symlink, but rather hold a commit ID directly?
It's already well established that files in the .git directory directly
are strictly local to this working directory, so it seems a much better
home for such temporary state.

Admittedly, this requires more invasive edits (particularly adding a third
legitimate case to validate_symref()), but it seems to make more sense.
And be ultimately simpler than workarounds for the above problems.

Just loosen the rules from ".git/HEAD must be a symlink" to
".git/HEAD must be a symlink before you can check in".


Yes, I know it's radical.  At least I'm not questioning the
power and efficacy of indulgences.  :-)
