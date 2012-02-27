From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 0/4] gitweb: Match highlighting in project search
Date: Mon, 27 Feb 2012 02:55:18 +0100
Message-ID: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:56:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1por-0007pJ-RT
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab2B0Bze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:55:34 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63081 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab2B0Bzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:55:33 -0500
Received: by eaah12 with SMTP id h12so2006941eaa.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 17:55:32 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.28.134 as permitted sender) client-ip=10.14.28.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.28.134 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.28.134])
        by 10.14.28.134 with SMTP id g6mr6977241eea.15.1330307732463 (num_hops = 1);
        Sun, 26 Feb 2012 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Lrxy7ZfH7ndbmYw138Uc8eNzCsnG/uyX6sQe9S3Xim0=;
        b=nt1Rqcql1w6dw9k3BuoG/s+efiaVuw+QOFoBc+bscP09BjXA93uq8iYsu/zcdBHz0k
         jTJ3aXGEtgN4ZI4go8h6SSY+kedyZN90w/eklSGVU5Zex4xl0YZGzn6JXeR9XVFXRoAe
         /XqahlznTKqi0VEHOyUGjxk2Xdkzg48CfJwQs=
Received: by 10.14.28.134 with SMTP id g6mr5208673eea.15.1330307732328;
        Sun, 26 Feb 2012 17:55:32 -0800 (PST)
Received: from localhost.localdomain (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id n17sm52112996eei.3.2012.02.26.17.55.31
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 17:55:31 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191594>

These patches are separated from second part of previous version of
this series

  "[PATCHv2 0/8] gitweb: Faster and improved project search"
  http://thread.gmane.org/gmane.comp.version-control.git/190852

It is meant to replace 'jn/gitweb-hilite-regions' in pu.

This series adds highlighting of matching string to project search.
The per-project 'commit' and 'grep' search already implement match
highlighting.  Additional goal is to provide beginnings of match
highlighting framework, to be used thorough gitweb, reducing code
duplication and unifying handling of match highlighting, improving
it.

The implementation of match highlighting in this series can highlight
correctly multiple matches in single line, as opposed to hand-rolled
code for highlighting in 'grep' and 'commit' search types for 'search'
action.


Previous version of this series had as a last patch proof-of-concept
of using match highlighting infrastructure for per-project search,
namely 'grep' search:

  gitweb: Use esc_html_match_hl() in 'grep' search
  http://thread.gmane.org/gmane.comp.version-control.git/190852/focus=190860

This version does not include it, among others because of question
on how to implement -nbsp=>1 version of match highlighting (see first
patch in series for comments).  It would be as a separate patch series.


Jakub Narebski (4):
  gitweb: Introduce esc_html_match_hl and esc_html_hl_regions
  gitweb: Highlight matched part of project name when searching
    projects
  gitweb: Highlight matched part of project description when searching
    projects
  gitweb: Highlight matched part of shortened project description

 gitweb/gitweb.perl |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 92 insertions(+), 3 deletions(-)

-- 
1.7.9
