From: Ed Avis <eda@waniasset.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 09:21:59 +0000 (UTC)
Message-ID: <loom.20150603T110826-777@post.gmane.org>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 11:23:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z04sm-0006c9-W6
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 11:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbbFCJWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 05:22:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:41806 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761AbbFCJWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 05:22:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z04sU-0006Ov-4A
	for git@vger.kernel.org; Wed, 03 Jun 2015 11:22:26 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:22:26 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:22:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270673>

I had expected that 'git checkout .' would fix up my working tree to make it
match the repository (in this case, the current revision of the master
branch).  When I originally ran it I had deleted a couple of files from the
working tree and wanted to restore them.  However, I expected that if doing
the checkout operation would lose data currently on disk then git would
prompt me first.

To compare, 'git pull' will not silently overwrite local changes; it will
prompt you to commit or stash them first.  'git checkout .' is a fairly
innocuous-looking command; it doesn't contain any --force or --overwrite or
other things that would make you think twice before typing it.  So I suggest
it should be equally safe to run.

The user interface might be something like:

% git checkout .
error: Your local changes to the following files would be overwritten:
        foo
You may want to commit or stash these changes, or delete the files if you
don't want them.  Use 'git checkout --force' to proceed, throwing away
local changes.
Aborting

If the checkout operation would only involve creating some files on disk
which aren't currently there, then it would proceed without prompting.

-- 
Ed Avis <eda@waniasset.com>
