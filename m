From: Florian =?iso-8859-1?Q?K=F6berle?= <florian@fkoeberle.de>
Subject: gitignore bug: including files in an excluded directoy does not 
     work.
Date: Sat, 23 May 2009 11:18:25 +0200 (CEST)
Message-ID: <809f58722b8bdb916fa7816cd80d3833-EhVcXl1BQAtYRw8cBxcBWQEwfgFLV15YQUBGAEFbXkI3XV8WXlhwH1RQWEFeRENtXlhdQ1hSWAtfWg==-webmailer2@server05.webmailer.hosteurope.de>
Reply-To: florian@fkoeberle.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 11:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7njO-0005mt-AH
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 11:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbZEWJgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 05:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbZEWJgc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 05:36:32 -0400
Received: from perry.mc0.hosteurope.de ([80.237.138.8]:49679 "EHLO
	perry.mc0.hosteurope.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZEWJgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 05:36:31 -0400
X-Greylist: delayed 1087 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 05:36:31 EDT
Received: from server05.webmailer.hosteurope.de ([10.9.0.184]); 
	by mailout.hosteurope.de (perry.mc0.hosteurope.de) running EXperimental Internet Mailer using esmtp
	id 1M7nNy-0000IJ-8H; Sat, 23 May 2009 11:19:22 +0200
Received: from nobody by server05.webmailer.hosteurope.de with local (Exim 4.63)
	(envelope-from <florian@fkoeberle.de>)
	id 1M7nN2-00041G-Vd; Sat, 23 May 2009 11:18:25 +0200
X-Squirrel-UserHash: EhVcXl1BQAtYRw8cBxcBWQE=
X-Squirrel-FromHash: UFIPX1YTTFE=
User-Agent: Host Europe Webmailer/1.0
X-Priority: 3 (Normal)
Importance: Normal
X-HE-Spam-Level: /
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119771>

steps to reproduce:

git init
echo /src/config > .gitignore
echo \!/src/config/readme.txt >> .gitignore
mkdir -p src/config
touch src/config/readme.txt
git add src

expected results:
git should add the readme.txt file

actual result:
git doesn't add the readme.txt file


additional comments:

pre to the commit d6b8fc303b it was possible to archive the wished effe=
ct
with this .gitignore file:
------------------
/src/config/
!/src/config/readme.txt
------------------
The pre d6b8fc303b git fails to detect that it can exclude src/config.
Thus it checks the directory content and finds out that the readme.txt
matches both - the exclude and the include pattern.


commit d6b8fc303b389b026f2bf9918f6f83041488989b
Author: Junio C Hamano <gitster pobox.com>
Date:   Thu Jan 31 01:17:48 2008 -0800
    gitignore(5): Allow "foo/" in ignore list to match directory "foo"


Best regards,
=46lorian K=F6berle
