From: Maaartin <grajcar@seznam.cz>
Subject: Comparing the working tree with a commit should be independent of
 the index
Date: Sat, 18 Aug 2012 20:36:54 +0200
Message-ID: <502FE0C6.6050106@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 20:50:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2o6B-0002pQ-TN
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 20:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab2HRSuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 14:50:09 -0400
Received: from smtp2.seznam.cz ([77.75.76.43]:35759 "EHLO smtp2.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab2HRSuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 14:50:08 -0400
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 14:50:08 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-Session-Info;
	b=PmAa1CzEfbDesUdLPx+QklczMJBeYCit+8QMecnDjxL1D7u+uPlNRym+Pq/PbxMoX
	3bjpcesOY9Vwj3IpHeMoHA0irsouDU2ODvywFCpPoH6WiHb3tp9gEV7gZpUi59oav4Y
	NoQaKqJKL1A8hhTnvelGQn8iBohGU+HYCdGAOG0=
Received: from [10.0.3.200] (188-120-197-152.luckynet.cz [188.120.197.152])
	by email-relay2.ng.seznam.cz (Seznam SMTPD UNKNOWN@exported) with ESMTP;
	Sat, 18 Aug 2012 20:36:56 +0200 (CEST)  
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
X-Smtpd: UNKNOWN@exported
X-Seznam-User: grajcar@seznam.cz
X-Session: 13
X-Country: CZ
X-Session-Info: (sid='5d240000000c', ip='188.120.197.152', helo='[10.0.3.200]', login='grajcar@seznam.cz', from='grajcar@seznam.cz', country='CZ', duration='00:00:01.081')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203689>

I've already posted it to SO [1], but got no satisfactory answer. The command

git diff mycommit

compares the working tree against mycommit, so it should not depend on the index. But it does as this example shows:

git init
echo A > A.txt; git add .; git commit -m A; git branch A
echo B > B.txt; git add .; git commit -m B; git branch B
git reset --hard A
echo BB > B.txt
git diff B

File B.txt exists both in the working tree and in the commit B, so a proper diff should be shown.

Instead I get "deleted file". Adding the file to the index changes it. This is IMHO a bug.

[1]: http://stackoverflow.com/questions/8452820/how-to-compare-the-working-tree-with-a-commit
