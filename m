From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Improve git_blame in preparation for incremental
	blame
Date: Tue, 09 Dec 2008 23:43:23 +0100
Message-ID: <20081209223703.28106.29198.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 23:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LABJt-0001JM-5j
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 23:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbYLIWn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 17:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbYLIWn2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 17:43:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:21772 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbYLIWn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 17:43:27 -0500
Received: by ug-out-1314.google.com with SMTP id 39so78681ugf.37
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 14:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=b1ptPkv2l7RHl+C9EuG0L02qRmK1YkYt+imzGbcQepg=;
        b=GSIR+iU3B0fL9QqWUU/edXrW37CCIdPSScheOFBaIFg/MzMENhd9hu6WYILCX8b58s
         ydMJNvMJxR12sMza332ILgWzcNHkaSb2/JDKr076TIS1yHjtBSQQtG3qHTubt0us6ZX2
         Hf0gvd9n8JRidzce5qy7IQBye4WO+tlxtTwrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=LXBFGE+vS5XRxYS+avDubND48nCdbor+4UbIt0IZT3vMXPnWDFqWOaRAcc5R0erfm8
         h8lQflKsaED4x/x0fvzhs2S80rcoj4WdY0YkEpfc0kBcSyeLPZaNE9nGEebNyCElzXNc
         TzjxKUv4vfjgNWY/ejkuqqN0oJKKADacDJYi8=
Received: by 10.86.96.18 with SMTP id t18mr294752fgb.56.1228862605168;
        Tue, 09 Dec 2008 14:43:25 -0800 (PST)
Received: from localhost.localdomain (absh60.neoplus.adsl.tpnet.pl [83.8.127.60])
        by mx.google.com with ESMTPS id d4sm1017545fga.58.2008.12.09.14.43.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Dec 2008 14:43:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB9MhNmB028179;
	Tue, 9 Dec 2008 23:43:25 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102657>

The following series implements a few improvements to git_blame code
and 'blame' view output to prepare for WIP/RFC patch adding incremental
blame output to gitweb using AJAX (JavaScript and XMLHttpRequest); the
code in question is based on code by Petr Baudis from 26 Aug 2007
  http://permalink.gmane.org/gmane.comp.version-control.git/56657
which in turn was based on Fredrik Kuivinen proof of concept patch.


The first patch in series (moving id to tr element) is needed in
blame_incremental, and it makes it easier to use DOM to manipulate
gitweb blame output.

Second patch is about what I have noticed when examining git_blame
code.

The last patch is not necessarily required; but please tell me if it
is to be accepted or to be dropped, to know whether to base
incremental blame on it.

---
Jakub Narebski (3):
      gitweb: A bit of code cleanup in git_blame()
      gitweb: Cache $parent_commit info in git_blame()
      gitweb: Move 'lineno' id from link to row element in git_blame

 gitweb/gitweb.perl |   84 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 49 insertions(+), 35 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
