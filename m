From: Andrei Thorp <garoth@gmail.com>
Subject: Fwd: Git Submodule Misbehaviour With ./
Date: Tue, 24 Feb 2009 15:56:20 -0800
Message-ID: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
References: <80055d7c0902241541o5c8fad50ra4eace5919bcf6df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 00:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc7Bq-0006lh-33
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 00:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZBXX4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 18:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754330AbZBXX4W
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 18:56:22 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:47408 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZBXX4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 18:56:22 -0500
Received: by gxk22 with SMTP id 22so7782162gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/M3psmSDQEt5eEsus/uU4gi9+EdPhgKwiMyRHUoiUwE=;
        b=HBbHE1qbQMOtl+sy6Id2MJwX/bbSgG1Yc2zvvnonZ58oCtFxrxaqPIGxQM6K+TUTZX
         JZYiVd5oOlNVW7cnI4qEIYoJRwXiaqF4R4DbGA0GOMrPR80JY5R3tYrmihQncpI545Ar
         h4QbAI8b/fGy8HUEp6uQgqomBpmVMi84EP3Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZEUGsBqIbPP0j3ItyPkgm7AswxLw003t+ud7HH7pOyAx/BTc5nKBamOlGfJuCKkGmA
         Nw4u7kVD6IM6ALG6oybR38u78tQgKdKfnqbqB79tkeQbUYuFel5Hj4/fEXsLwP1pXB/C
         toKaUNWmhm/Z1uAG0ouBBLieWiwGRY6c2ceCA=
Received: by 10.150.156.20 with SMTP id d20mr303594ybe.102.1235519780080; Tue, 
	24 Feb 2009 15:56:20 -0800 (PST)
In-Reply-To: <80055d7c0902241541o5c8fad50ra4eace5919bcf6df@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111362>

Hello,

Git (I have version 1.6.1.3) seems to misbehave when it comes to git
submodule add and ./. Here is an example.

================================================
$ cd Configs
$ git submodule add git@git.mercenariesguild.net:obvious.git ./awesome/obvious
Initialized empty Git repository in /home/garoth/Configs/awesome/obvious/.git/
stdin: is not a tty
remote: Counting objects: 32, done.
remote: Compressing objects: 100% (29/29), done.
Receiving objects: 100% (32/32), 5.10 KiB, done.
remote: Total 32 (delta 8), reused 0 (delta 0)
Resolving deltas: 100% (8/8), done.
$ git submodule init
No submodule mapping found in .gitmodules for path 'awesome/obvious'
$ git commit -m "Added obvious submodule"
$ cd ~/Desktop
$ git clone ~/Configs
$ git submodule init
No submodule mapping found in .gitmodules for path 'awesome/obvious'
================================================

Note how when I did git submodule add, I used ./awesome/obvious. The behaviour
of "No submodule mapping found in .gitmodules for path 'awesome/obvious'" only
occurs when you use ./. If I were to use:

$ git submodule add git@git.mercenariesguild.net:obvious.git awesome/obvious

instead, then git handles everything just fine. Thanks to dsal in #git
for helping me
figure this out. Perhaps there is an error with regards to how the
.gitmodules file
is parsed or encoded. I'm not really a git developer, but I wanted to
have this issue
documented at least somewhere.

Thanks,

-Andrei Thorp
