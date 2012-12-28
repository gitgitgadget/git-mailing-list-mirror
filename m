From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Installation Plan
Date: Fri, 28 Dec 2012 14:54:24 +0100 (CET)
Message-ID: <2dbfdf9e-9a4c-40f2-9661-a62a938911a2@zcs>
References: <50D475A9.9020407@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dennis Putnam <dap1@bellsouth.net>
X-From: git-owner@vger.kernel.org Fri Dec 28 15:04:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToaXk-0006Vo-SV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 15:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab2L1OA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2012 09:00:28 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:58946 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559Ab2L1OA0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Dec 2012 09:00:26 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2012 09:00:26 EST
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 45B5E62225F;
	Fri, 28 Dec 2012 14:54:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5UtgOZbCsZi; Fri, 28 Dec 2012 14:54:24 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id E75F7622259;
	Fri, 28 Dec 2012 14:54:24 +0100 (CET)
In-Reply-To: <50D475A9.9020407@bellsouth.net>
X-Originating-IP: [91.43.221.218]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212240>


> 7) Clone new repository for development and testing on Windows. (Do I
> need the shared drive any more?)

Not necessarily, depending on how to connect your local repo to the
remote one (your central repo). I'd suggest using ssh protocol: in this
case your windows box will connect to the linux box via ssh and do all
operations via ssh - no network filesystem required.

> 8) When a new version is ready for release, push commit to remote
> repository after which builds will use new code (I'm assuming the
> file copies happen automagically).

Yes, see post-update hook (on the central repo side).
It is executed right after objects have been transfered and refs update=
d.
(IOW: when your changes made finally it into the cental repo).
Note that the 'git push' operation will wait until that hook is finishe=
d.
So, if the build takes a while, you most likely want to do it asychrono=
usly.
A nice way is letting the hook just add the new refs to some queue
(you can even use git refs for that) and have another process (in a loo=
p
or via cron) polling for new queue entries and run the build.


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
Mobile: +49 (151) 27565287
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
