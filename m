From: =?ISO-8859-1?Q?Jean-Philippe_Gari=E9py?= 
	<jean-philippe.gariepy@nuecho.com>
Subject: [BUG] git clean -X behaviour when .gitignore has sub-directory entries
Date: Mon, 27 Sep 2010 10:35:06 -0400
Organization: Nu Echo
Message-ID: <4CA0AB9A.4050002@nuecho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 16:42:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Eui-0002t6-4W
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 16:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759350Ab0I0Omi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 10:42:38 -0400
Received: from m.nuecho.com ([64.119.213.149]:45171 "EHLO m.nuecho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756176Ab0I0Omh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 10:42:37 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2010 10:42:37 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by m.nuecho.com (Postfix) with ESMTP id F07D5324002
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 10:35:21 -0400 (EDT)
X-Virus-Scanned: amavisd-new at z.nuecho.com
Received: from m.nuecho.com ([127.0.0.1])
	by localhost (zimbra.nuecho.ad [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PzpylyZ2+KSz for <git@vger.kernel.org>;
	Mon, 27 Sep 2010 10:35:21 -0400 (EDT)
Received: from burton.nuecho.ad (modemcable108.22-130-66.mc.videotron.ca [66.130.22.108])
	by m.nuecho.com (Postfix) with ESMTPSA id 82D0D324001
	for <git@vger.kernel.org>; Mon, 27 Sep 2010 10:35:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157336>

(this is a repost w/ a bit more context)

Hi,

Context:
"git clean -X" is really helpful in my projects to mimick a "make clean" 
(or more precisely a "make distclean") but I believe there is a small 
problem with the -X option of git clean. I've validated this with other 
people and they agree it's a bug.

Problem:
When using sub-directory entries in .gitignore, while the entry is 
ignored as expected, "git clean -X" doesn't clean the ignored sub-directory.

$ git init test
Initialized empty Git repository in /home/jpgariep/git/test/.git/
$ cd test/
$ mkdir -p a/b/c
$ touch a/b/c/test
$ echo '/a/b/' > .gitignore
$ git add .gitignore
$ git commit -m "Added .gitignore."
[master (root-commit) 94e2825] Added .gitignore.
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 .gitignore
$ git status
# On branch master
nothing to commit (working directory clean)
$ git clean -X -d -f
$ ls a
b

Why is b still there?


Git version:
git version 1.7.2.3  (but this has been around since 1.6.something)
Tested also with 1.7.3.2.g9027fa (today's HEAD of master branch)

Thanks.

-- 
Jean-Philippe
