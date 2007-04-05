From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Reomanded usage?
Date: Thu, 05 Apr 2007 11:49:13 +0200
Message-ID: <1HZOaf-18TkBc0@fwd26.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 12:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZPWn-0003Mc-8u
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 12:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946030AbXDEKtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 06:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946062AbXDEKtO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 06:49:14 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:44103 "EHLO
	mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946030AbXDEKtN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2007 06:49:13 -0400
X-Greylist: delayed 3590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2007 06:49:13 EDT
Received: from fwd26.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1HZOan-000492-08; Thu, 05 Apr 2007 11:49:21 +0200
Received: from localhost (V8dQTOZcZeYO67wq4IK5QYwTC6oQ7LkbQ3nnOfmzWNl1bG32e0mW0+@[172.20.101.250]) by fwd26.aul.t-online.de
	with esmtp id 1HZOaf-18TkBc0; Thu, 5 Apr 2007 11:49:13 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V7-7-2
X-ID: V8dQTOZcZeYO67wq4IK5QYwTC6oQ7LkbQ3nnOfmzWNl1bG32e0mW0+@t-dialin.net
X-TOI-MSGID: a1b6921c-70c8-46aa-96b0-64e2718bc1a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43816>

Hi,

I would like to get your opinion on the way I used cogito in the
following 
example. In particular I would like to know if the command
"cg-switch -fr origin master" is the recommended usage in this case.

The situation: I have cloned a repository from some "original" repo.
I made some changes and committed them into my repo. Now I don't want to

push my changes into the "original" repo but instead I want to get
the latest changes from the "original" repo (with out my changes) and
continue 
to work on them. I want to keep my changes to be able to introduce
them into the "original" repo at some later point.

I think I need to create a branch with my changes. With the master
branch I 
need to go back to where I started from the "original" repo. And then 
I can update my master from the "original" repo.

That's the way I did it:

cg-status
Heads:
    >master     0176cac7fddc64d55ff5cad49e04567c402c3970
   R origin     0176cac7fddc64d55ff5cad49e04567c402c3970
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453

# do some changes  

cg-commit -m .....
Committed as 7002e00d13e1227349897996db0fb27e9a1232a9
cg-status
Heads:
    >master     7002e00d13e1227349897996db0fb27e9a1232a9
   R origin     0176cac7fddc64d55ff5cad49e04567c402c3970
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453

# more changes

cg-commit -m ..........
Committed as c43629cb3a382e89b13eef1193122db1bba8a243
cg-status
Heads:
    >master     c43629cb3a382e89b13eef1193122db1bba8a243
   R origin     0176cac7fddc64d55ff5cad49e04567c402c3970
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453


# now I want to go back to the commit before my changes and update
# to the latest commit in the origin and go on with some other work from

# that latest commit
# and keep my changes in a local branch (or head)

# create new head using cg-switch

cg-switch -c expect
Creating new branch expect: c43629cb3a382e89b13eef1193122db1bba8a243
Switching to branch expect...
cg-status
Heads:
    >expect     c43629cb3a382e89b13eef1193122db1bba8a243
     master     c43629cb3a382e89b13eef1193122db1bba8a243
   R origin     0176cac7fddc64d55ff5cad49e04567c402c3970
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453

# go back to my master

cg-switch master
Switching to branch master...
cg-status
Heads:
     expect     c43629cb3a382e89b13eef1193122db1bba8a243
    >master     c43629cb3a382e89b13eef1193122db1bba8a243
   R origin     0176cac7fddc64d55ff5cad49e04567c402c3970
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453

# now reset the master to the origin I started from

cg-switch -fr origin master
Repointing branch master: c43629cb3a382e89b13eef1193122db1bba8a243 ->
0176cac7fd
dc64d55ff5cad49e04567c402c3970
Switching to branch master...
cg-status 
Heads:
     expect     c43629cb3a382e89b13eef1193122db1bba8a243
    >master     0176cac7fddc64d55ff5cad49e04567c402c3970
   R origin     0176cac7fddc64d55ff5cad49e04567c402c3970
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453

# update my master with the current commit in the original repository

cg-update
Fetching pack (head and objects)...
remote: Generating pack...
remote: Done counting 1 objects.
remote: Deltifying 1 objects.
remote:  100% (1/1) done
remote: Total 1 (delta 0), reused 0 (delta 0)
Unpacking 1 objects
 100% (1/1) done
Fetching tags...
Tree change:
0176cac7fddc64d55ff5cad49e04567c402c3970..9495c6fd42aefa745d937bf7b
b50ea138b4dc919

Applying changes...
Fast-forwarding 0176cac7fddc64d55ff5cad49e04567c402c3970 ->
9495c6fd42aefa745d93
7bf7bb50ea138b4dc919
        on top of 0176cac7fddc64d55ff5cad49e04567c402c3970 ...
cg-status
Heads:
     expect     c43629cb3a382e89b13eef1193122db1bba8a243
    >master     9495c6fd42aefa745d937bf7bb50ea138b4dc919
   R origin     9495c6fd42aefa745d937bf7bb50ea138b4dc919
   R otest      25ea047321cd15dd32eb7d6e0b51d86ee1668453


Best regards,
Michael
