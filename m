From: Roland Lezuo <roland.lezuo@theobroma-systems.com>
Subject: Strange bug on MacOSX - can anyone reproduce?
Date: Fri, 18 Apr 2008 11:04:42 +0200
Message-ID: <3F7A8E3C-486E-464D-9403-7C08045A2C51@theobroma-systems.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 18 21:27:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmmXG-0002xB-Fj
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 11:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbYDRJEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 05:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbYDRJEq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 05:04:46 -0400
Received: from vegas.theobroma-systems.com ([88.198.52.168]:60150 "EHLO
	mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754056AbYDRJEq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 05:04:46 -0400
Received: from [86.59.122.178] (port=51334 helo=[10.0.2.103])
	by mail.theobroma-systems.com with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <roland.lezuo@theobroma-systems.com>)
	id 1JmmWQ-0006mT-W2
	for git@vger.kernel.org; Fri, 18 Apr 2008 11:04:45 +0200
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79867>

Hi!

I've a very strange bug on MacOSX 10.5 on a case sensitive HFS+  
filesystem.

git very regular show the following behavior:

git op fails with an "error: Unable to append to $(FILE)" message, a  
"cat $(FILE)" and the same git op
solves the problem deterministically.

Here is an example:

rlezuo@rlezuo:~/Projects/XXX/documentation$ git pull
remote: Counting objects: 100, done.
remote: Compressing objects: 100% (74/74), done.
remote: Total 74 (delta 59), reused 0 (delta 0)
Unpacking objects: 100% (74/74), done.
 From git@YYY.theobroma-systems.com:XXX/documentation
    cad9845..374115b  fop        -> origin/fop
error: Unable to append to .git/logs/refs/remotes/origin/master
    67f2dad..5812471  master     -> origin/master
Merge made by recursive.
error: Unable to append to .git/logs/refs/heads/master
fatal: Cannot update the ref 'HEAD'.

rlezuo@rlezuo:~/Projects/XXX/documentation$ git pull
error: Unable to append to .git/logs/refs/remotes/origin/master
 From git@YYY.theobroma-systems.com:XXX/documentation
    67f2dad..5812471  master     -> origin/master
Merge made by recursive.
error: Unable to append to .git/logs/refs/heads/master
fatal: Cannot update the ref 'HEAD'.

rlezuo@rlezuo:~/Projects/XXX/documentation$ cat .git/logs/refs/heads/ 
master
...

rlezuo@rlezuo:~/Projects/XXX/documentation$ git pull
error: Unable to append to .git/logs/refs/remotes/origin/master
 From git@YYY.theobroma-systems.com:XXX/documentation
    67f2dad..5812471  master     -> origin/master
Merge made by recursive.
error: Unable to append to .git/logs/HEAD
fatal: Cannot update the ref 'HEAD'.

rlezuo@rlezuo:~/Projects/XXX/documentation$ cat .git/logs/HEAD
...

rlezuo@rlezuo:~/Projects/XXX/documentation$ git pull
error: Unable to append to .git/logs/refs/remotes/origin/master
 From git@YYY.theobroma-systems.com:XXX/documentation
    67f2dad..5812471  master     -> origin/master
Merge made by recursive.
  ...
  HLD/csm/Random.dita                                |   14 ++++----
  HLD/csm/monitor.dita                               |   13 +++++---
  HLD/introduction/references.dita                   |   34 +++++++++++ 
+++------
  ST/introduction/st_references.dita                 |   29 +++++++++++ 
++++++
  16 files changed, 133 insertions(+), 54 deletions(-)
  create mode 100644 FS/hardware_spec_overview/ 
random_number_generator.dita


can anyone reproduce this? Is this a git bug or is this a OSX bug?

regards

DI Roland Lezuo
Theobroma Systems Design und Consulting GmbH
Gutheil-Schoder Gasse 17, 1230 Wien, Austria
Phone: +43 1  2369893-405, Fax: +43 1 2369893-9406
http://www.theobroma-systems.com
