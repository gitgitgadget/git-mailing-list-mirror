From: Jeremy Nickurak <vger-lists@trk.nickurak.ca>
Subject: Retrieving logs matching pattern for all time.
Date: Fri, 2 Sep 2011 18:03:34 -0600
Message-ID: <CA+eQo_0gZpbz399GN1b+0mq8OY3Xoo+kij=UGSjwbJcNreYBvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 02:03:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzdi5-0004Qc-A9
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 02:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab1ICADg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 20:03:36 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37296 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab1ICADf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 20:03:35 -0400
Received: by qyk15 with SMTP id 15so989419qyk.19
        for <git@vger.kernel.org>; Fri, 02 Sep 2011 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nickurak.ca; s=google-dkim;
        h=mime-version:sender:x-originating-ip:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=KdMaEIbH4/iSnujjmzwmmOkVQro94CWg0xuX1ujLv+U=;
        b=ErNBZnzq9VojcIA2SDaZBK80cWwWCDmvf8NRK6T24EvsXzFpQ0BSgp7IR0DiibSy7S
         Loel/O1Ups3WTGsftUWXa7zzXJvX8gjYWBeMUFTP23Fmxkd8uM5F985lK/rlsMdCzhlA
         95nYPdmaGWMo5fsqSWq9w0LnpVamkPV2zUABI=
Received: by 10.229.65.1 with SMTP id g1mr1269957qci.110.1315008214505; Fri,
 02 Sep 2011 17:03:34 -0700 (PDT)
Received: by 10.229.45.199 with HTTP; Fri, 2 Sep 2011 17:03:34 -0700 (PDT)
X-Originating-IP: [128.221.197.57]
X-Google-Sender-Auth: psRxuMrTB7zxxB53YoNF8FxHPWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180642>

I have a glob pattern of files, and I'd like to get git logs for every
commit that touched those files. 'git log filesmatchingglob*' is
pretty close.

Unfortunately, because the * is interpreted by bash, it doesn't catch
logs for files that don't exist anymore.

Protecting the * from bash was my next thought, but that doesn't seem to help:

> user@host:~$ mkdir something
> user@host:~$ cd something
> user@host:~/something$ git init
> Initialized empty Git repository in /home/nickuj/something/.git/
> user@host:~/something$ echo hello > hello.txt
> user@host:~/something$ git add hello.txt
> user@host:~/something$ git commit -m hello hello.txt
> [master (root-commit) ca4b223] hello
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 hello.txt
> user@host:~/something$ git log -- 'hel*'
> user@host:~/something$

IE, git doesn't seem to interpret globs itself in patterns.

http://stackoverflow.com/questions/543346/git-list-all-the-files-that-ever-existed
suggests a means to get a list of all files that ever existed, and I
could certainly iterate across that, find the files that match the
pattern, and then run git-log against that.... but it seems like a
problem somebody's already solved more elegantly.

Any thoughts?

-- 
Jeremy Nickurak
