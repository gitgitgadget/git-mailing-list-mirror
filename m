From: Stefan Bucur <stefan.bucur@gmail.com>
Subject: Wrong file diff for merge conflict
Date: Sat, 4 Jul 2009 07:53:34 +0000 (UTC)
Message-ID: <loom.20090704T072854-229@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 10:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MN0AS-0006kW-Al
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 10:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbZGDIAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 04:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbZGDIAE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 04:00:04 -0400
Received: from main.gmane.org ([80.91.229.2]:59337 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbZGDIAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 04:00:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MN0AE-0005rI-AR
	for git@vger.kernel.org; Sat, 04 Jul 2009 08:00:02 +0000
Received: from 86-121-81-145.rdsnet.ro ([86-121-81-145.rdsnet.ro])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 08:00:02 +0000
Received: from stefan.bucur by 86-121-81-145.rdsnet.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 08:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.121.81.145 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1b4pre) Gecko/20090401 Ubuntu/9.04 (jaunty) Shiretoko/3.5b4pre)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122714>

Hi!

I would like to point out a very strange behavior of git merge, which led to
data loss or data duplication in the conflict file generated during a diff merge.

I had to merge two branches (A and B) which contained more files (e.g.
http://pastebin.ca/1483691 - before splitting branches) which were affected in
the following way:
* The files were formatted (indented) in branch A: http://pastebin.ca/1483684
* In branch B, their contents were altered in various points, but not
significantly (refactored some statements into macros): http://pastebin.ca/1483683

I checked out branch A, and I ran "git merge B", and (obviously) there was a
conflict with this file. The big surprise was to see that the generated diff
file looks like this:

http://pastebin.ca/1483228

The problem is with the last diff in the file, where the left portion is empty,
and the right portion contains code which already was marked as merged (common),
right before the start of the diff. Therefore, the mark at line 127 should
really have been before line 114.

Is this a bug or I am missing something?

Thanks,
Stefan Bucur
