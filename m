From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Minor builtin 'git am' side-effect
Date: Thu, 20 Aug 2015 15:22:47 +0200
Message-ID: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSPo9-0002TZ-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 15:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbbHTNWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 09:22:55 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60774 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbbHTNWz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 09:22:55 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZSPnx-0003n4-RF; Thu, 20 Aug 2015 15:22:53 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZSPnr-00056o-CM; Thu, 20 Aug 2015 15:22:47 +0200
Received: from x590d6ed3.dyn.telefonica.de (x590d6ed3.dyn.telefonica.de
 [89.13.110.211]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 20 Aug 2015 15:22:47 +0200
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440076974.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276238>


Hi,

The format of the files '.git/rebase-apply/{next,last}' changed slightl=
y
with the recent builtin 'git am' conversion: while these files were
newline-terminated when written by the scripted version, the ones writt=
en
by the builtin are not.

This probably  makes no difference for shell scripts looking at these
files, e.g.  our __git_ps1() handles both just fine.  However, it can
break C programs, when after strtol()ing the contents of the files they
get defensive and check for the terminating newline at *endptr (this is
how I noticed, as one of my pet projects did just that).

I'm not saying that the new behavior is bad and should be fixed; I mere=
ly
point it out and leave the rest for you to decide.

Best,
G=C3=A1bor
