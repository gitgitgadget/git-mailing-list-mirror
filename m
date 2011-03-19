From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH 2/2] bisect documentation: exit codes 126,127 abort bisect
Date: Sat, 19 Mar 2011 16:20:15 +0100
Message-ID: <4D84C9AF.2020900@gmail.com>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com> <7v1v267no9.fsf@alter.siamese.dyndns.org> <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com> <4D81B04A.1010802@viscovery.net> <20110317072723.GH11931@sigill.intra.peff.net> <7vei654omv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:20:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xx3-00077h-A9
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab1CSPUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 11:20:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55727 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab1CSPUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 11:20:19 -0400
Received: by fxm17 with SMTP id 17so4466287fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KmW/DwCWfJKEE2fq10UiNmcGor49/6xPHXSK5MJTp1Q=;
        b=bexi4lrI0uirSdZrT4+pubqz1UELRxIkdhYDrJmso1Mf+T4mPh81Fb6TiAc2/uXdo6
         vojOKStBnGc1qPK8kG0rpYc89ygh/l+W5XTEJL/Auy7QohjEQsjN8n5O7iBp5RQjcpgY
         KNGe78tPCqWTHypPyjtL2F2y9Vc0Q0Ol31u0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bF0bNI5Cm5T/REN/Zd0wSMN6mQ7wOJZbOeWJKcPQhPMngamEcjEXNrukr6elJIaUXI
         ixyRBQYXIeaUpzarARLX5IEpnbHR9nKcdIx5bgfbn75oy7N0gR4pdlahj1ISfgOV9Ulh
         BjSBpdg7WwvVLMYvU4kcCQYHCQ5Iyy5hYtI98=
Received: by 10.223.87.217 with SMTP id x25mr2738142fal.133.1300548018297;
        Sat, 19 Mar 2011 08:20:18 -0700 (PDT)
Received: from [192.168.1.101] (aapp186.neoplus.adsl.tpnet.pl [83.5.149.186])
        by mx.google.com with ESMTPS id l2sm1188798fam.29.2011.03.19.08.20.16
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 08:20:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vei654omv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169440>

Update documentation after meaning of those exit codes changed
from "mark as bad code" to "abort bisect run".

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 Documentation/git-bisect.txt |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index a1e47d6..70d8807 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -232,17 +232,16 @@ $ git bisect run my_script arguments
 
 Note that the script (`my_script` in the above example) should
 exit with code 0 if the current source code is good, and exit with a
-code between 1 and 127 (inclusive), except 125, if the current
-source code is bad.
+code between 1 and 124 (inclusive) if the current source code is bad.
+
+Exit code 125 should be used when the current source code cannot be
+tested. If the script exits with this code, the current revision will
+be skipped (see `git bisect skip` above).
 
 Any other exit code will abort the bisect process. It should be noted
 that a program that terminates via "exit(-1)" leaves $? = 255, (see the
 exit(3) manual page), as the value is chopped with "& 0377".
 
-The special exit code 125 should be used when the current source code
-cannot be tested. If the script exits with this code, the current
-revision will be skipped (see `git bisect skip` above).
-
 You may often find that during a bisect session you want to have
 temporary modifications (e.g. s/#define DEBUG 0/#define DEBUG 1/ in a
 header file, or "revision that does not have this commit needs this
-- 
1.7.1

-- 
Piotr Krukowiecki
