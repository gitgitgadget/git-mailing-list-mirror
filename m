From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Problem with git ls-files
Date: Mon, 7 Jan 2008 10:38:11 +0600
Message-ID: <7bfdc29a0801062038j269466fcgaffd2b90d59ebfb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 05:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBjlF-0002cs-UU
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 05:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbYAGEiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 23:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbYAGEiQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 23:38:16 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:64901 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYAGEiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 23:38:15 -0500
Received: by fk-out-0910.google.com with SMTP id z23so8323434fkz.5
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 20:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CSReoOp30GWvdO+TAM89DnTr+N9JRryTrWi9fEQyQXA=;
        b=i0431OhF3jBy7PgPaTLPPZ5PgUOCsjXh6tL3mXkEQuHzk2XMq9KKyjwTrWsLCjOZj0LrXDvNj6tP/XUdLBrT2EU7mDrE8LTITXiKxkPKlqa6R9rNjsllfMFSIqPa3npLq/hj/1sMOin4VRBhtMc/riTnAf640+PYMaILuFjTdQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kLTlNod9RIymgRxLm/yWjESFrvT1CPMKRi3joQpUxhFfxxo/XHf4FaE0ak/dmeBSka7bS7EmaEs0Fz0A3ObKyg6v4Ice8qkDD44aCWYiRBWswjlQVyoW/LgmsKa9KOR514jswuS+ysWST4YQegRb4+vIXY1ZLA/EHa52iKg8vr0=
Received: by 10.78.155.4 with SMTP id c4mr1303585hue.79.1199680691520;
        Sun, 06 Jan 2008 20:38:11 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Sun, 6 Jan 2008 20:38:11 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69758>

Hi all,

I am facing a strange problem with git ls-files in git-submodule. When I do -
echo in modules init with "$@" - `git-ls-files --stage` - `git
ls-files --stage -- "$@" | grep -e '^160000 '` - `pwd`
The output is =

in modules init with d - 100644
c462997b94c371248bf17895ee18e7fbea5bce9b 0 .gitmodules 160000
091158296a8f57322f70f3c17e5fcb66687a0970 0 a 160000
6397239aeb662ba96f61b59ccc0a0d0812f48435 0 b 160000
c9f0a7dedcb4a9daf5a68c37109577d7d177e10b 0 c 100644
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0 main.txt - -
/home/imyousuf/projects/git-projs/test/super-project/a

If we format the above output of git list-files --stage we can see the following

100644 c462997b94c371248bf17895ee18e7fbea5bce9b 0 .gitmodules
160000 091158296a8f57322f70f3c17e5fcb66687a0970 0 a
160000 6397239aeb662ba96f61b59ccc0a0d0812f48435 0 b
160000 c9f0a7dedcb4a9daf5a68c37109577d7d177e10b 0 c
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0 main.txt

In the output please note the path
/home/imyousuf/projects/git-projs/test/super-project/a

Now I am providing the output of -
ls -al /home/imyousuf/projects/git-projs/test/super-project/a

 drwxr-xr-x 4 imyousuf imyousuf 4096 2008-01-07 10:22 .
 drwxr-xr-x 6 imyousuf imyousuf 4096 2008-01-07 10:22 ..
 -rw-r--r-- 1 imyousuf imyousuf  130 2008-01-07 10:22 a.txt
 drwxr-xr-x 2 imyousuf imyousuf 4096 2008-01-07 10:22 d
 drwxr-xr-x 8 imyousuf imyousuf 4096 2008-01-07 10:22 .git
 -rw-r--r-- 1 imyousuf imyousuf   95 2008-01-07 10:22 .gitmodules


Now this is getting really confusing for me, because I get the strange
output when I call the git submodule from shell script but after the
shell script is executed if I do the same command copy and paste in
gnome-terminal it works fine.

Can someone please tell me what I am doing wrong?

Thank you,

Imran
