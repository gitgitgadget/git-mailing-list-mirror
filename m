From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: strange "git clone" behavior wrt an active branch
Date: Sun, 28 Sep 2008 08:05:46 -0400
Message-ID: <ee2a733e0809280505n69f62e0fy89667c175bcc16c@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 14:10:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjv6G-0003GV-VP
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 14:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYI1MFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 08:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYI1MFs
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 08:05:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:18839 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbYI1MFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 08:05:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1118174fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=V0lxAAqEE6vi7FaCem57WBZQDPrYRDevOk1C1Z/xy1o=;
        b=dNmJex1W55L5CL/CnfuY2QhjDPdL3FDupUwuYtWJ8lSn3jgFzjsZF0Okvf5oGtLNJ6
         Snw7ULn+TrZ6bOCVnBD66EYn8KNehXWqw291bpkgGsjf8TF/mNCOv3iHMcUrzrFdw/d6
         LpiJszCWhSr3D2pL25m/JfTXojNvS+kBxY3U0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=q5VdTP9vZ0iDzcI+kc6F4pMWOBRlnPHDpPuVezePa9UDG0zJmgDzABfIyNUxRl5igg
         vacjmwnNZrnu5kwUDK/Z6LM7WSYX/XV7o+FHxCI/C692n87BTgQg3UOJotAs9aloY0zg
         ELyIZQQMlyLPZ76Gf5wdeRPfeOFJRY21d4+9I=
Received: by 10.187.223.14 with SMTP id a14mr401203far.106.1222603546276;
        Sun, 28 Sep 2008 05:05:46 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sun, 28 Sep 2008 05:05:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96959>

Hi All,
I am using the latest stable version git-1.6.0.2.

The man page for git-clone states explicitly that "git clone"

" Clones a repository into a newly created directory, ...[snip]...
  and creates and checks out an initial branch equal to the
  cloned repository's currently active branch. "

I noticed that while my active branch "My" happens to point to the
same commit as the "master" the git clone will check out master
instead of My (currently active branch). Is it a bug?

Here is the example that demontrates the problem

~> mkdir tmp
~/tmp> git init
~/tmp> cat > txt
some text
~/tmp> git add .
~/tmp> git ci -m 'init ci'
~/tmp> git branch -a
* master
~/tmp> git co -b My
~/tmp> git branch -a
* My
  master

Now "My" is my active branch in 'tmp' repo. It points to the same
commit as the master. Now let us clone it

~/tmp> cd ..
~> git clone tmp tmp1
~> cd tmp1
~/tmp1> git branch -a
* master
  origin/HEAD
  origin/My
  origin/master

In the cloned repository 'tmp1',  master branch is active. No local
tracking branch for "My" was created. I think this behavior
contradicts the man page. Is it a bug or feature??

Thanks,
--Leo--
