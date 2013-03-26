From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/2] Fix -Wuninitialized warnings on older gcc
Date: Tue, 26 Mar 2013 19:08:37 +0000
Message-ID: <5151F235.4080303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:22:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZRy-000570-J9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab3CZTV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:21:57 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:45325 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754105Ab3CZTV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:21:56 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 9C588384080;
	Tue, 26 Mar 2013 19:21:54 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id E29B738407C;
	Tue, 26 Mar 2013 19:21:53 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 26 Mar 2013 19:21:52 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219188>

Hi Junio,

I had prepared 3 patches, but I noticed this afternoon that
the warning in transport.c has already been fixed in maint.
These were built on the tip of master as of saturday evening
(master @ 7b592fad).

Just FYI, as of saturday, Jeff's patches in maint/master had
removed 40 warnings from the MSVC build; 34 of the warnings
were due to commit 25043d8a all on it's lonesome! [1]. The
additional patches in pu, remove an additional 14 warnings.
This leaves only the following:

    $ grep warning msvc-pout | grep uninit
    c:\msysgit\msysgit\home\ramsay\git\fast-import.c(2916) : warning C4700:\
    uninitialized local variable 'oe' used
    c:\msysgit\msysgit\home\ramsay\git\builtin\rev-list.c(341) : warning C4700:\
    uninitialized local variable 'reaches' used
    c:\msysgit\msysgit\home\ramsay\git\builtin\rev-list.c(341) : warning C4700:\
    uninitialized local variable 'all' used
    c:\msysgit\msysgit\home\ramsay\git\merge-recursive.c(1886) : warning C4700:\
    uninitialized local variable 'mrtree' used

ATB,
Ramsay Jones

[1] In case you are puzzled by this, the warning is coming from
the linker, since the msvc build is using link-time code-gen/optimisation.


Ramsay Allan Jones (2):
  fast-import: Fix an gcc -Wuninitialized warning
  cat-file: Fix an gcc -Wuninitialized warning

 builtin/cat-file.c | 2 +-
 fast-import.c      | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.2
