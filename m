From: Christoph Mallon <christoph.mallon@gmx.de>
Subject: git diff --check always shows line 1 for blank at EOF for new files
Date: Wed, 06 Oct 2010 11:27:58 +0200
Message-ID: <4CAC411E.3010204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 11:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3QIM-0007Iq-GJ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 11:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562Ab0JFJ2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 05:28:15 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:50736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932548Ab0JFJ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 05:28:12 -0400
Received: (qmail invoked by alias); 06 Oct 2010 09:28:10 -0000
Received: from p5B14CE9C.dip.t-dialin.net (EHLO tron.homeunix.org) [91.20.206.156]
  by mail.gmx.net (mp069) with SMTP; 06 Oct 2010 11:28:10 +0200
X-Authenticated: #1673122
X-Provags-ID: V01U2FsdGVkX18rKukakRIrLoTTbbGiL48vTQpfhASyXlJmsEXUJs
	GxOltcK5aL6ghs
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; de-DE; rv:1.9.2.9) Gecko/20100919 Thunderbird/3.1.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158278>

Hi,

there seems to be a glitch in git diff --check for new files: If a new 
file has trailing empty lines, then the error message always refers to 
line 1. This happens with git 1.7.3.1.

Here is a simple test case:
   git init test
   cd test
   printf 'a\nb\nc\n\n' > file
   git add -AN
   git diff --check

The last command will show "file:1: new blank line at EOF.".

It works fine, if the diff is not against /dev/null, e.g.:
   git init test
   cd test
   printf 'a\nb\nc\n' > file
   git add -A
   echo >> file
   git diff --check

This correctly shows "file:4: new blank line at EOF.".
