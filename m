From: Salvatore Iovene <salvatore.iovene@googlemail.com>
Subject: Problems rebasing branch after renaming files
Date: Fri, 27 Feb 2009 10:55:29 +0200
Message-ID: <c64207c00902270055q57442e2dmd81c197419dda71a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 09:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcyWl-0008By-MK
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbZB0Izg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 03:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbZB0Izf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 03:55:35 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:62766 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZB0Izc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 03:55:32 -0500
Received: by bwz26 with SMTP id 26so912696bwz.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 00:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fGIJiDUrteyrWVSlRbWHqCsNz+n5On0uQPjQRhYBGN4=;
        b=Ysrny0BDfkkqJX1qbpeoT0vy16XYrZ7swWb5wofa5ajikm7vmwuJ0ThLBaWzgr6xTU
         m4SauZp82K6Xxxmuxf582pC0fmc5coz6/SxSZpR7hBq2+QPKOAavokfZSgjY/hnwkEPY
         ZP+YO5BHH+AM8jDk+lXixfVPPek16qX7DzKKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kXrzhiph0izb7uhZFqd8e4C/FHz8lln08Gm4ls78dJhrfJSGjBDl+sI/o5FltkWrdZ
         r230ictRVTH22QyN7lRucJsSh8xn9SQgFleImhjsxg+S4RoXHlST4xFuNS51lIZK1QPP
         1SL2+k1GU1CMIn8OpdH7fVgXfJLEypZJnyQrY=
Received: by 10.180.245.20 with SMTP id s20mr785189bkh.184.1235724929060; Fri, 
	27 Feb 2009 00:55:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111649>

Hi list,
I ran into a problem, and I'm unsure it's a git bug or a misuse of mine.

Here's the scenario:

1) Have the master branch and a branch called A

master
|
|----- A

2) Work more in master

master
|
|----- A
|
|

3) Create branch B and work on it. In this branch, rename a directory
containing source files with git-mv

master
|
|----- A
|
|----- B

4) Merge B to master

master
|
|------ A
|
|
|
|

5) Rebase A to master

master
|
|
|
|
|
|----- A

I found that, checking out A, my files in the now renamed directories
are as the were in B, i.e. not including the changes made in A,
because I have rebased A to master and git didn't realize that the
files in old_directory_name are the same as in new_directory_name so
they should have been merged.

Either this is a git bug or not, can anyone suggest a way to fix this?
All I've thought so far is to git-format-patch the patches that I had
in A, use sed to replace the old_directory_name with the new one,
create a new branch called A2 at master's head, apply the patches
there and git-branch -D A.

Thanks!

PS: please CC me as I'm not on the list.

-- 
Salvatore Iovene
http://www.iovene.com/
http://www.geekherocomic.com/
