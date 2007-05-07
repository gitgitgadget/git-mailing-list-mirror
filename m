From: Tom Koelman <tkoelman@xs4all.nl>
Subject: Checkout fails when one branch contains a directory with the name of a file in the other branch
Date: Mon, 07 May 2007 13:07:56 +0200
Message-ID: <ubqgw51tf.fsf@assurancetourix.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 13:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl1BR-0007Mi-U6
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbXEGLPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbXEGLPK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:15:10 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:4616 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbXEGLPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:15:09 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 May 2007 07:15:08 EDT
Received: from rij01785.infor.com (stugw.infor.com [194.99.90.2])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id l47B8Oo4058687
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 7 May 2007 13:08:25 +0200 (CEST)
	(envelope-from tkoelman@xs4all.nl)
Received: from localhost (HELO RIJ01785.assurancetourix.xs4all.nl) [127.0.0.1]
	by rij01785.infor.com (5.22.54.38)  (userid 2)
	with ESMTP (Classic Hamster Vr. 2.1 Build 2.1.0.11) ; Mon, 07 May 2007 13:07:56 +0200
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.99 (windows-nt)
X-Posting-Agent: Hamster/2.1.0.11
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46446>


Hi,

I am not sure whether this is intentional or not. I am wondering why
this scenario fails, and if it is by design, how I should handle this
situation:

--------------------------------------------------------------------------------
$ mkdir test

$ cd test

$ git init
Initialized empty Git repository in .git/

$ echo aFile > aFile

$ git add aFile

$ git commit -m "initial"
Created initial commit a4aa48bb4ca57699341e380b17a1c3d92e44d08b
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 aFile

$ git checkout -b branch
Switched to a new branch "branch"

$ git rm aFile
rm 'aFile'

$ git commit -m "No aFile file anymore"

Created commit 6ac689ae4d7e8c0d82526d84563c12109b6cd900
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 jacob

$ mkdir aFile

$ touch aFile/anotherFile

$ git add aFile/anotherFile 

$ git commit -m "added aFile directory"
Created commit 634e5fff2fdb6365d4be5b2dca29e9c78164cb07
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 aFile/anotherFile

$ git checkout master
fatal: Untracked working tree file 'aFile' would be overwritten by merge.
--------------------------------------------------------------------------------

Regards,
Tom Koelman
