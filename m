From: Pico Geyer <pico@xiplink.com>
Subject: Using git am -p 2 with binary patches
Date: Mon, 31 May 2010 17:59:29 +0200
Message-ID: <4C03DCE1.2000201@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 31 18:08:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ7XD-0002KD-FP
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 18:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0EaQIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 12:08:09 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:48352 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab0EaQII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 12:08:08 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2010 12:08:08 EDT
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 8DE4216D037
	for <git@vger.kernel.org>; Mon, 31 May 2010 11:59:33 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: pgeyer-AT-xiplink.com) with ESMTPSA id D08CB16D01A
	for <git@vger.kernel.org>; Mon, 31 May 2010 11:59:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Shredder/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148048>

Hi all.

I've been trying to apply a set of patches from one repository to a completely independent repository (no shared history).
Since the paths are different, I'm applying the patches with git am -p 2
I noticed that whenever my patches contain binary files, git-am fails to apply the patch.

Here's a simple test case:
mkdir gittmp
cd gittmp
git init
mkdir subdir
echo "abcdefghijklmnop" > blah.txt
tar -czf subdir/binfile.tgz blah.txt
git add subdir/binfile.tgz
git commit -m "Added binary file"
git format-patch --root HEAD
git am -p 2 0001-Added-binary-file.patch

And the output that I get is:
Applying: Added binary file
fatal: git diff header lacks filename information when removing 2 leading pathname components (line 9)
Patch failed at 0001 Added binary file
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Is this a bug in git-am or git-apply?
Or is there a good reason why this doesn't work?

I'm using the latest git version (1.7.1)

Thanks in advance.
Pico
