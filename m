From: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
Subject: fast-import/export from Plastic SCM questions about renames
Date: Fri, 21 Jan 2011 14:41:13 +0100
Message-ID: <4D398CF9.70405@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 21 15:32:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgI2d-0001Dh-TN
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 15:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab1AUOcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 09:32:39 -0500
Received: from berith.lunarbreeze.com ([216.97.239.175]:54606 "EHLO
	berith.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab1AUOci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 09:32:38 -0500
X-Greylist: delayed 3080 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2011 09:32:38 EST
Received: from 213.254.84.80.static.user.ono.com ([213.254.84.80] helo=[192.168.1.241])
	by berith.lunarbreeze.com with esmtpa (Exim 4.69)
	(envelope-from <psantosl@codicesoftware.com>)
	id 1PgHEr-0001Vj-1S
	for git@vger.kernel.org; Fri, 21 Jan 2011 05:41:17 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - berith.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - codicesoftware.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165372>

Hi,

I'm currently developing a fast-export (and later a fast-import) to be
able to export from Plastic SCM to Git and also import from Git to
Plastic SCM.

Plastic tracks history of directories and hence it easy to handle moves
between directories. But, during the export/import from plastic to git I
found the following situation:

R src/samples/sampledata src/samples/samplebase
R src/samples/samplebase/Test.Workflow.xml
src/samples/samplebase/new/Test.Workflow.xml

It is a "move within" a move and it always fails telling that
src/samples/samplebase/Test.Workflow.xml is not in the branch.

If I split the "move" op into a delete + an add, it works, but reading
the documentation I expected it to work.

Also, after splitting the "moves" into add/delete pairs, I've found an
issue with a simple rename:

- a directory that is renamed from src/Diff to src/diff (here I kept a R
operation)

- 1000 commits later (after tons of files have been modified inside the
src/diff dir) I get a rename like src/diff/Diff.c src/diff/diff.cs and
an error saying src/diff/Diff.c is not in the branch.

It is very possible that my export code is wrong, but I wanted to check
if it is better to simply get rid of the "move" (R) operations in
fast-export.

Thanks,

pablo


www.plasticscm.com
