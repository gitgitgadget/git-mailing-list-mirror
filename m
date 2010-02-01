From: =?iso-8859-1?Q?Elli=E9_Computing_Open_Source_Program?= 
	<opensource@elliecomputing.com>
Subject: Problem listing GIT repository with accents
Date: Mon, 1 Feb 2010 11:48:29 +0100
Message-ID: <7E88665723814E46BCBA1A39E84C27A5@elrond>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 12:02:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbu2h-0000BR-9T
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 12:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0BALCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 06:02:00 -0500
Received: from zeus.promailserver.com ([74.200.236.204]:3951 "EHLO
	zeus.promailserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0BALB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 06:01:59 -0500
X-Greylist: delayed 801 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2010 06:01:59 EST
Received: from elrond ([83.199.180.163])
        by zeus.promailserver.com (Merak 8.3.6) with ASMTP id JMX17238
        for <git@vger.kernel.org>; Mon, 1 Feb 2010 10:48:38 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5843
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138599>

Dear all,

I'm writing a tool (ECMerge) which use the git command line to list fol=
ders=20
content (as of specific commits, tags and so on). This way our users ca=
n=20
browse a GIT repository in our GUI.

We are in front of the following problem: when a GIT repository contain=
s a=20
folder with accents, the files names for its content are often prepende=
d=20
with random characters. Here is a transcript of a list of operation=20
exhibiting the problem:

 C:\temp\scc-tests\git>git ls-tree HEAD .
100644 blob 443d8625f771c421efd86c129483f9a139a4e85f    "p\351p\351.txt=
"
C:\temp\scc-tests\git>mkdir "caract=E8re sp=E9cial"
C:\temp\scc-tests\git>echo plouf > "caract=E8re sp=E9cial\plouf.txt"
C:\temp\scc-tests\git>git add "caract=E8re sp=E9cial"
C:\temp\scc-tests\git>git commit -m plouf
[master b94d9cb] plouf
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 "caract\350re sp\351cial/plouf.txt"

C:\temp\scc-tests\git>git ls-tree HEAD .
040000 tree d2b614bbfb4c5f39a32eb1309654262df113f605    "caract\350re=20
sp\351cial"
100644 blob 443d8625f771c421efd86c129483f9a139a4e85f    "p\351p\351.txt=
"

C:\temp\scc-tests\git>git ls-tree -r HEAD .
100644 blob bf10a8b39e72c754ee1872fcdb13662cba6a8880    "caract\350re=20
sp\351cial/\272plouf.txt"
100644 blob 443d8625f771c421efd86c129483f9a139a4e85f    "p\351p\351.txt=
"

C:\temp\scc-tests\git>git ls-tree -r HEAD "caract=E8re sp=E9cial"
100644 blob bf10a8b39e72c754ee1872fcdb13662cba6a8880    "caract\350re=20
sp\351cial/\272plouf.txt"

Note the spurious \272 which comes in the listing :(
Trying again the same commands may give other spurious characters (each=
 time=20
we tried we get different _bad_ responses)


Hope you can do somehing for that,
Best regards
Armel Asselin - from Elli=E9 Computing
