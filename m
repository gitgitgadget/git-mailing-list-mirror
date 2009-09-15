From: "Halstrick, Christian" <christian.halstrick@sap.com>
Subject: git-svn and rebasing refactored (moved) content
Date: Tue, 15 Sep 2009 18:11:38 +0200
Message-ID: <D35B4A582834DC418CCF9AF41AB69B70014954E265@DEWDFECCR04.wdf.sap.corp>
References: <1252699129-6961-1-git-send-email-spearce@spearce.org>
 <1252699129-6961-2-git-send-email-spearce@spearce.org>
 <1252699129-6961-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 22:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mneb0-0003ee-BV
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 22:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbZIOUZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 16:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbZIOUZl
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 16:25:41 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:39061 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZIOUZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 16:25:41 -0400
X-Greylist: delayed 15240 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2009 16:25:40 EDT
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n8FGBhWk023035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 18:11:43 +0200 (MEST)
Received: from DEWDFEHT01.wdf.sap.corp (dewdfeht01.wdf.sap.corp [10.21.23.100])
	by mail.sap.corp (mail03-26) with ESMTP id n8FGBgqS024822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 15 Sep 2009 18:11:42 +0200 (MEST)
Received: from DEWDFEHT04.wdf.sap.corp (10.21.23.103) by
 DEWDFEHT01.wdf.sap.corp (10.21.23.100) with Microsoft SMTP Server (TLS) id
 8.1.393.1; Tue, 15 Sep 2009 18:11:36 +0200
Received: from dewdfeccr04.wdf.sap.corp ([fe80::5efe:10.21.23.13]) by
 DEWDFEHT04.wdf.sap.corp ([fe80::5efe:10.21.23.103%15]) with mapi; Tue, 15 Sep
 2009 18:11:36 +0200
Thread-Topic: git-svn and rebasing refactored (moved) content
Thread-Index: AcozGnRSv64erZECTMyYhxJHspEwOAC/n78w
In-Reply-To: <1252699129-6961-3-git-send-email-spearce@spearce.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, de-DE
X-Scanner: Virus Scanner virwal06
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128585>

Hi,

I have a question regarding git rebase operation when content was moved. I have
the problem when I transfer stuff from a subversion repo into my git repo, but
I wouldn't know the solution even if it would be a pure git scenario. Here is
the problem:

There is a SVN repository "Source" containing that files
"Source":
project/feat1/A.java
project/feat1/B.java
project/C.java

There is git repository "Target" where I work. That repository get's updates
from "Source" by 'git-svn migrate ...'. I had to move the files coming from
"Source" (using 'git mv'). I just moved but did not (and will not in future)
modify the files of "Source". Additionally I added my own new files. The state
of target is:
"Target":
project/src/feat1/A.java (renamed file)
project/src/feat1/B.java (renamed file)
project/src/C.java (renamed file)
project/pom.xml (created file)

Ideally from time to time I would like to rebase my work I do in "Target" on
the latest state of "Source". I use "git rebase ..." for that. But this
sometimes fails. If in "Source" files are only modified everything works fine.
E.g. modifications to "Source":project/feat1/A.java are visible in
"Target":project/src/feat1/A.java.  That's great!

But the rebase fails with conflicts when things are moved or deleted in
"Source". E.g. if "Source":project/feat1/A.java becomes
"Source":project/feat2/A.java and I merge that commit into my branch in
"Target" I get 

> CONFLICT (rename/rename): Rename
> "project/feat1/A.java"->"project/feat2/A.java" in branch "HEAD" rename
> "project/feat1/A.java"->"project/src/feat1/A.java " ...

I do understand the conflict but I am asking whether there is a better way to
use git so that I can get around these merge problems.

Ciao
  Chris
