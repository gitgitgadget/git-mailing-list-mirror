From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4] git-p4: RCS keyword handling
Date: Wed, 22 Feb 2012 10:15:40 +0000
Message-ID: <1329905741-2092-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 11:15:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S09Ee-0005Y3-M6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 11:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab2BVKPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 05:15:40 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38726 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab2BVKPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 05:15:39 -0500
Received: by wgbdt10 with SMTP id dt10so6551841wgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 02:15:38 -0800 (PST)
Received-SPF: pass (google.com: domain of luke@diamand.org designates 10.180.93.194 as permitted sender) client-ip=10.180.93.194;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of luke@diamand.org designates 10.180.93.194 as permitted sender) smtp.mail=luke@diamand.org
Received: from mr.google.com ([10.180.93.194])
        by 10.180.93.194 with SMTP id cw2mr33580828wib.0.1329905738091 (num_hops = 1);
        Wed, 22 Feb 2012 02:15:38 -0800 (PST)
Received: by 10.180.93.194 with SMTP id cw2mr27795149wib.0.1329905737945;
        Wed, 22 Feb 2012 02:15:37 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id m16sm69061192wie.9.2012.02.22.02.15.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 02:15:36 -0800 (PST)
X-Mailer: git-send-email 1.7.9.259.ga92e
X-Gm-Message-State: ALoCoQkwmriAyFoQ4mubAoB5PCxAari4Y1ZkR2y+KJxo6++dw4nGH8vV3gAo6GYjIzlEIJU7Fqzq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191245>

Updated patch incorporating comments from Pete and Junio to
handle RCS keyword expansion in git-p4.

Note: The current patch fails to to handle the case where a user
adds an expanded RCS keyword in *git* (e.g. via cut-n-paste).
I'll try to address that separately. There's a failing test case
for this.

This version:

 - uses "p4 fstat" to get the filetype
 - uses Junio's suggested regexp to match $Keyword:$
 - uses the sets of added/deleted files rather than parsing diff output
 - various other small fixes spotted by Pete
 - adds additional test cases

Luke Diamand (1):
  git-p4: add initial support for RCS keywords

 Documentation/git-p4.txt   |    5 +
 contrib/fast-import/git-p4 |  118 ++++++++++++--
 t/t9810-git-p4-rcs.sh      |  388 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+), 10 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

-- 
1.7.9.259.ga92e
