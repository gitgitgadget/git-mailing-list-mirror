From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 0/4] gitweb: Match highlighting in project search
Date: Mon, 27 Feb 2012 02:28:57 +0100
Message-ID: <1330306141-25013-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pOw-0006Bw-O8
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab2B0B3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:29:13 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50437 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab2B0B3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:29:12 -0500
Received: by eaah12 with SMTP id h12so1998434eaa.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 17:29:11 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.98.73 as permitted sender) client-ip=10.14.98.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.98.73 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.98.73])
        by 10.14.98.73 with SMTP id u49mr6894685eef.35.1330306151618 (num_hops = 1);
        Sun, 26 Feb 2012 17:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Lrxy7ZfH7ndbmYw138Uc8eNzCsnG/uyX6sQe9S3Xim0=;
        b=PCvm6bdKZj2SV0vIbkhfO4xhnJJQMSLjiVhBKD6ZO6ph/p10XEs6uA0QeqyRWbIfZe
         c+hPtdkNAE6J2q2gUue/2XO9VBjs9Gyo2PH1Vu6TnkGjlJf4ePaTDrHaz8mNIoUy5Y80
         v6ox360z3pw3hJkdlBXaeixOVUnqDju1HSzFg=
Received: by 10.14.98.73 with SMTP id u49mr5168230eef.35.1330306151454;
        Sun, 26 Feb 2012 17:29:11 -0800 (PST)
Received: from localhost.localdomain (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id w60sm51884379eeb.4.2012.02.26.17.29.09
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 17:29:10 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191592>

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
