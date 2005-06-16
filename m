From: Jon Smirl <jonsmirl@gmail.com>
Subject: Using local trees and cogito
Date: Wed, 15 Jun 2005 22:37:59 -0400
Message-ID: <9e473391050615193719d81951@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4442_8354814.1118889479319"
X-From: git-owner@vger.kernel.org Thu Jun 16 04:33:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DikBs-0003X5-R3
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 04:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVFPCiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 22:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVFPCiP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 22:38:15 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:46628 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261708AbVFPCh7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2005 22:37:59 -0400
Received: by wproxy.gmail.com with SMTP id 37so147103wra
        for <git@vger.kernel.org>; Wed, 15 Jun 2005 19:37:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=bN1LpyiRoCJ9ZHQZ0TDDNiOC1S8qLDYa6j1vhlOm7VdXoMlsBsQ3MYFtE7WPVzLhpCZtb38Z096u2kU1VZsmijbWIxfQMBT5/dlU2VeQz0J1+KwbhUt2OY9nkdeROkteZHyXuEZtlzThApXiEGFPAOCsSl1WkkaVXo/bfrEg894=
Received: by 10.54.2.42 with SMTP id 42mr216745wrb;
        Wed, 15 Jun 2005 19:37:59 -0700 (PDT)
Received: by 10.54.94.8 with HTTP; Wed, 15 Jun 2005 19:37:59 -0700 (PDT)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_Part_4442_8354814.1118889479319
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I took Jeff Garzik's scripts for managing multiple trees and reworked
them a little for cogito. I changed the names to something that makes
more sense to me, but what does everyone think? Or can cogito already
do this I just can't figure it out?

In my terminology forks are different tree heads in the same git tree
(local branches).

cg-fork fname -- make a new tree head from the current tree and switch to i=
t.
cg-goto fname -- switch the current working tree to one of the forks.
cg-goto -- display the name of the current fork
cg-goto -l -- display the name of all forks
cg-diff fname -- diff the current working tree to a fork
cg-merge fname -- merge another fork into the current fork

I fixed goto to not jump if there are pending changes. Is there a
better way to do this?

Is fork a good name since branches refer to other git trees? I'm
somewhat confused about exactly what a branch consists of, it looks to
me like the path to another external tree.

I do find Jeff's work very useful since it allows me to keep twenty
patches in a single tree and jump between them. This is better than bk
where I had to keep multiple entire trees with a build in each of
them. This way I only rebuild the files that changed after a jump.

One problem I did notice is that if you add file in a fork and jump to
a fork without the file, it doesn't get removed. That's not a big
problem but it can be confusing.

--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_4442_8354814.1118889479319
Content-Type: application/octet-stream; name="cg-fork"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cg-fork"

IyEvYmluL3NoCgppZiBbICEgLWQgLmdpdC9yZWZzL2hlYWRzIF0KdGhlbgoJZWNobyBDYW5ub3Qg
ZmluZCAuZ2l0IG1ldGFkYXRhLCBhYm9ydGluZy4KCWV4aXQgMQpmaQoKRk49Ii5naXQvcmVmcy9o
ZWFkcy8kMSIKCmlmIFsgLWYgJEZOIF0KdGhlbgoJZWNobyBCcmFuY2ggJDEgZXhpc3RzLCBtb3Zp
bmcgdG8gJDEub2xkLgoJbXYgLWYgJEZOICRGTi5vbGQKZmkKCmNwIC5naXQvcmVmcy9oZWFkcy9t
YXN0ZXIgJEZOCgpjZy1nb3RvICQxCgo=
------=_Part_4442_8354814.1118889479319
Content-Type: application/octet-stream; name="cg-goto"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cg-goto"

IyEvYmluL3NoCgppZiBbICIkMSIgPT0gIi1sIiBdCnRoZW4KCWxzIC5naXQvcmVmcy9oZWFkcwpl
bGlmIFsgIngkMSIgIT0gIngiIF0KdGhlbgoJaWYgWyAhIC1mIC5naXQvcmVmcy9oZWFkcy8kMSBd
Cgl0aGVuCgkJZWNobyBCcmFuY2ggJDEgbm90IGZvdW5kLgoJCWV4aXQgMQoJZmkKCWRpZmY9JChn
aXQtZGlmZi1jYWNoZSAtciAtcCBIRUFEKQoJaWYgWyAieCRkaWZmIiAhPSAieCIgXQoJdGhlbgoJ
CWVjaG8gIkNvbW1pdCBwZW5kaW5nIGNoYW5nZXMgZmlyc3QiCgkJZXhpdCAxCglmaQoJKCBjZCAu
Z2l0ICYmIHJtIC1mIEhFQUQgJiYgbG4gLXMgcmVmcy9oZWFkcy8kMSBIRUFEICkKCglnaXQtcmVh
ZC10cmVlIC1tIEhFQUQgJiYgZ2l0LWNoZWNrb3V0LWNhY2hlIC1xIC1mIC11IC1hCmVsc2UKCXJl
YWRsaW5rIC5naXQvSEVBRApmaQoKCg==
------=_Part_4442_8354814.1118889479319--
