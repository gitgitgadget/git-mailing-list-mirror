From: John Griessen <john@ecosensory.com>
Subject: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 03 Jan 2011 15:49:41 -0600
Message-ID: <4D224475.1090805@ecosensory.com>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 22:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZsHl-0001Eb-Md
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 22:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab1ACVto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 16:49:44 -0500
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:42002 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab1ACVtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 16:49:43 -0500
X-Authority-Analysis: v=1.1 cv=UQuFHoD2CPQ248x8AXEbKhr4z9AaDqApxmEl3BhfZ64= c=1 sm=0 a=SldSeXCDZ5oA:10 a=8nJEP1OIZ-IA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:17 a=wR-FlJDvAAAA:8 a=QN1-tMDUMlsjoChOZaQA:9 a=v0gmY6xSFTbcK_cvM9ebZt8uQ08A:4 a=wPNLvfGTeEIA:10 a=_rE2JZbVKix_j0qc:21 a=XhBYgyN2kqwayTr0:21 a=hpnIzNeuzKcqG6phuHbX0Q==:117
X-Cloudmark-Score: 0
X-Originating-IP: 66.68.104.159
Received: from [66.68.104.159] ([66.68.104.159:40307] helo=[192.168.15.39])
	by hrndva-oedge02.mail.rr.com (envelope-from <john@ecosensory.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 08/E6-00963-574422D4; Mon, 03 Jan 2011 21:49:42 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164457>

I would like to serving repos with repo.git/git-daemon-export-ok from a debian linux server installation,
but I am getting symptoms of clone failing.

john@toolbench:~/EEProjects/test$ git clone git://ecosensory.com/tek_7k_ext.git
Cloning into tek_7k_ext...
fatal: protocol error: bad line length character: fata

I've read that that is due to the shell at the client end putting out extra characters...
but other testers on other machines get it the same way...


Next I tried changing my command that runs git-daemon
from

exec 2>&1
echo 'git-daemon starting.'
exec chpst -ugitdaemon \
   "$(git --exec-path)"/git-daemon --verbose --base-path=/var/cache /var/cache/git

to

exec 2>&1
echo 'git-daemon starting.'
exec chpst -ugitdaemon \
   "$(git --exec-path)"/git-daemon --verbose --base-path=/srv/gitosis /srv/gitosis/repositories

and results are:

john@toolbench:~/EEProjects/test$  git clone git://ecosensory.com/tek_7k_ext.git
Cloning into tek_7k_ext...
fatal: protocol error: bad line length character: fata
john@toolbench:~/EEProjects/test$  git clone git://ecosensory.com/repositories/tek_7k_ext.git
Cloning into tek_7k_ext...
fatal: protocol error: bad line length character: fata


What can I do to simplify this testing and pin point the problem?

Or is gitweb recommended?

thanks,

John Griessen
