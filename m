From: Adam Mercer <ramercer@gmail.com>
Subject: Permissions of objects within shared repo
Date: Thu, 30 Apr 2009 20:49:36 -0500
Message-ID: <799406d60904301849t1e77e81bgc6d58ecd0e9d6b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 01 03:50:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzhtW-0001NL-W1
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 03:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbZEABt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 21:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755964AbZEABt5
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 21:49:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:17831 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbZEABt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 21:49:56 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1838969qwd.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 18:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=DlkEGFV/1sDvU70OiLYeTmj4efrZhXer0JsuZDiZB4A=;
        b=KpPgo9hpe8CYLI97YGiHEUbjOBeKkOy8PImHuPPbb5Y1LTAg9NCryreIW8AUrEp6Z7
         GYz9mVskrv02xOSO/nJgh8PhSCzCk4Cmeu0yTnWPPKzs0cETjHk1yeVhIu0PWEDvbtzp
         nUi+ZhbWgzc/iIZHlUBxEty10yFo6nibko/Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=PAvcM+G8qLpC3Rigxmzbqh4TfmL4KH+o0CNaeDa/TpC3yu+45qpFD8ZOs7sLzlUvEY
         wVCiXtOGz4jsmyqCIHbqhY1cFO4kdOLaGTqQqOiCR2/W2V7K4zmp9EhoCwNCW49X3NyP
         tZQrnNNSt5Jw0I2e9pk9ir0o4/3DvgE+jD6W0=
Received: by 10.229.70.139 with SMTP id d11mr1948700qcj.51.1241142596150; Thu, 
	30 Apr 2009 18:49:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118055>

Hi

We have a shared repository with the following config:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        sharedrepository = 1
[receive]
        denyNonFastforwards = true

Users push their commits to the repository over ssh, all users are in
group 1000 and so far everything seems to be working OK. However I
have noticed that something seems to be strange with the permissions
of the objects, e.g.:

[ram@g3 ~]$ cd /path/to/repo.git/objects/00/
[ram@g3 00]$ ls -l
total 43
-r--r--r--+ 1 user1           1000  2729 Apr 19 13:13
028ade623678384fca34c51e0ea3ae91b8a50d
-r--r--r--+ 1 user1           1000 10697 Apr 20 21:19
0d9f5769a65081bf95d64b0a23b62b55095f2f
-r--r--r--+ 1 user2           1000   297 Apr 17 10:00
2b3138d14b41d5a01308edd32e8af5ad4c4886
-r--r--r--+ 1 user3           1000   169 Apr  9 12:03
8ab284186f0ceb450d86e3ff1eca486eb6f5b3
-r--r--r--+ 1 user4           1000   846 Apr 27 16:51
90192a4a1843e5849129312ac3bc98766c4c85
-r--r--r--+ 1 user5           1000   602 Apr 13 20:37
948b07abc15345dc31a15757cbc248fa95e49e
-r--r--r--+ 1 user4           1000   435 Apr 20 17:44
a30f4ded65434a2a2d050d98657c118665578f
-r--r--r--+ 1 user6           1000   818 Apr 25 04:11
a5fed2108570efb32e6db519cda92b07e91994
-r--r--r--+ 1 user6           1000   169 Apr 26 13:34
a756fb8966f4564e522471230f5bfe72e33776
-r--r--r--+ 1 user7           1000   379 Apr  9 04:59
bb60a52d841151b564267de8c37a2198a5812e
-r--r--r--+ 1 user8           1000   846 Apr 16 10:55
db929d4496f84b5d7e6a5bd9aeda904bf1b3e6
-r--r--r--+ 1 user2           1000  2089 Apr 20 07:24
ddd0edf3c9b1b94e7036f44a65cf71ace1cfb2
[ram@g3 00]$

will this cause a problem when git gc --auto decides its time to put
these loose objects into a pack, i.e. will they be able to be removed?

Cheers

Adam
