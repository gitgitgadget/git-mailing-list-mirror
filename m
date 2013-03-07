From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 11:25:59 +0100 (CET)
Message-ID: <822188477.192374.1362651959144.JavaMail.root@openwide.fr>
References: <1492019317.191838.1362650820122.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 11:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDYAB-0008Lu-LK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab3CGKei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 05:34:38 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:45954 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3CGKeh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 05:34:37 -0500
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2013 05:34:37 EST
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id F1449280AD
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 11:25:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dv3h4OXWL+xq for <git@vger.kernel.org>;
	Thu,  7 Mar 2013 11:25:59 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 4EDD228065
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 11:25:59 +0100 (CET)
In-Reply-To: <1492019317.191838.1362650820122.JavaMail.root@openwide.fr>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217588>

Hello everybody


I am trying to use git-subtree to follow a subproject but I have a coup=
le of problems and I am not sure if I am doing something wrong=20

Basically I am trying to use a tag on the subproject as my "base" for t=
he subproject but subtree doesn't seem to handle that properly


my first attempt was to simply do=20

"git subtree add --squash git://git.buildroot.net/buildroot 2013.02"=20

but subtree refused, telling me that the SHA of the tag is not a valid =
commit.=20
Ok it makes sense, though I think this is a very valid use-case...

so I tried

"git subtree add git://git.buildroot.net/buildroot 2013.02^{commit}"=20

which was refused because git fetch can't parse the ^{commit} marker.
Again it makes sense, but I really want to start from that tag.


so I tried

"git fetch git://git.buildroot.net/buildroot 2013.02"
"git subtree add --squash FETCH_HEAD"

which worked. Ok at that point I am slightly abusing git subtree, but i=
t seems a valid usage

except that this last attempt causes serious problems when trying to sp=
lit out the tree again

the call to "git commit-tree" within "git subtree split" complains that=
 the SHA of the parent
is not a valid commit SHA. Which is true, it's the SHA of the tag.


At this point I am not sure if I am abusing subtree, if I have a legiti=
mate but unimplemented use-case and how to=20
fix/implement it.

the squash-commit message only contains the SHA of the tag, should it c=
ontain the SHA of the commit ?

"subtree split" can only handle commit SHA, should it somehow follow ta=
g SHA too ? how ?

this is probably a trivial fix for someone with good knowledge of git-s=
ubtree but i'm not there yet, so any hint would be welcomed

    Regards

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim
