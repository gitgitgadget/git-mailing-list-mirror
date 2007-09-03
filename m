From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: problem with git cvsimport
Date: Sun, 2 Sep 2007 20:51:37 -0400
Message-ID: <5951BCFB-D3EF-4423-86F2-50F1D080721B@yahoo.ca>
References: <A74F186F-7C25-48D5-9354-C74576439AF1@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 02:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS0Ao-0006Zq-A4
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXICAvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 20:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXICAvq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:51:46 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:24438 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750719AbXICAvp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 20:51:45 -0400
Received: (qmail 13584 invoked from network); 3 Sep 2007 00:51:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:Mime-Version:In-Reply-To:References:Content-Type:Message-Id:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=rwzlBrHhSn0uqYc39iqshozRlRI/XTKmU9GKs6T3fwc7MRnoTnU1KbWLPleF5KpW1LRradr4p82MPxvNjbMKypgwM0G0057g28QnBGpIaACB1neqNBQUM2arQSaFL8Vqgk1WFQEmS1RWdhlTbOyFrif8p4fa0uKGR9JyHQP7a+M=  ;
Received: from unknown (HELO ?10.0.1.3?) (jean_francois_veillette@66.130.96.245 with plain)
  by smtp101.mail.mud.yahoo.com with SMTP; 3 Sep 2007 00:51:42 -0000
X-YMail-OSG: 7xezLekVM1ldH7.E9uDSD9wY8KZ1DW1_NLbs1dlLyxdtoOFEN70bCGdje6knXU1AtCWkc0efI2swqHNG.Y.sZttNK7G3g.HTfWbVLTg0HKoNpn3Aei8-
In-Reply-To: <A74F186F-7C25-48D5-9354-C74576439AF1@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57419>

Answering to myself ...
cvsps was the culprit.
I reverted to the unmodified 2.1 version (tag 2.1 without any patches =20
from the git repository) and suddently I was able to convert some cvs =20
projects.

But other projects are still causing problem.

- on one project it fail after 2 successful commits with :
	fatal: Not a valid object name refs/heads/DEV_2_1_1
	read-tree failed: 32768

- another is failing on a specific subdirectory (idealy the project =20
would be one directory up, in .../Wonder/Ajax/Ajax, but the =20
Components subdirectory importation systematicaly fail) :
	09:50:26: git cvsimport -v
	jfveillette@wonder.cvs.sourceforge.net's password:
	Initialized empty Git repository in /Users/jfv/Developement/=20
WebObjects/Wonder/Ajax/Ajax/Components/.git/
	Running cvsps...
	jfveillette@wonder.cvs.sourceforge.net's password:
	cvs_direct initialized to CVSROOT /cvsroot/wonder
	cvs rlog: Logging Wonder/Ajax/Ajax/Components
	DONE; creating master branch
	fatal: refs/heads/origin: not a valid SHA1
	fatal: master: not a valid SHA1
	warning: You appear to be on a branch yet to be born.
	warning: Forcing checkout of HEAD.
	fatal: just how do you expect me to merge 0 trees?
	checkout failed: 256


BTW, the output from =AB cvsps -g =BB (generating patches) seem to =20
succeed even when cvsimport fail.  Is there a tool that will take the =20
patches from cvsps and directly import them in git ?
I tried git-am but it failed.

Again, any pointer is welcome to help resolve issues with importing =20
cvs projects.
Thanks to Michael for pointing out cvs2svn,I haven't tried it yet.

- jfv


Le 07-08-31 =E0 10:31, Jean-Fran=E7ois Veillette a =E9crit :

> I can't get git-cvsimport to convert a cvs project to git (full log =20
> bellow).
> I always get :
> 	fatal: Not a valid object name refs/heads/HEAD
> 	read-tree failed: 32768
>
> I'm a relatively new to git. I would like to convert my project and =20
> track external projects with git.
> But cvsimport seem to fail.  Any pointer to help me resolve the =20
> issue is welcome !
>
> thanks,
>
> - jfv
>
> Detail informations ...
>
> host info (uname -a) :
> Darwin localhost 8.10.0 Darwin Kernel Version 8.10.0: Wed May 23 =20
> 16:50:59 PDT 2007; root:xnu-792.21.3~1/RELEASE_PPC Power Macintosh =20
> powerpc
>
> git --version
> git version 1.5.3.rc7.16.ge340d-dirty
>
> cvsps version 2.1 (got the git repository, merged 'master' with =20
> 'multitag')
