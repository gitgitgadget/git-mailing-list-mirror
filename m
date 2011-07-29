From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 0/6] gitweb: Improve project search
Date: Fri, 29 Jul 2011 13:52:53 +0200
Message-ID: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldB-0005uD-6n
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab1G2LxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65163 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab1G2LxY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:24 -0400
Received: by fxh19 with SMTP id 19so2225343fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=P4ns63Zv/1xNWg4dGFlZZVJHq1Wa1JEI/5mVwthSIag=;
        b=RG+Xh2RE5fZ6QcKEAoB2kqOJgfl60LO2U1eUtcU9/JRRDszSu9fww6Fg6z5GavKCzS
         JpV9Cxi/HFbTofB36cN1/VaR7KqhouGChq3aPpK7GsU5NgtGdXJLm9q88oLK9rml1cbQ
         Hw5q5SBbk+ZresQshXrI2rrKjscDnv4cdBG0M=
Received: by 10.223.144.141 with SMTP id z13mr1699067fau.18.1311940402823;
        Fri, 29 Jul 2011 04:53:22 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.20
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178132>

This patch series started a bit strange, by noticing that I have had
gitweb-Project-search patch in my unapplied StGit stack for gitweb/web
branch.  I tried to re-do it on top of current codebase... only to
realize that gitweb already has project search :-)

So this series turned into enhancing project search to the state that
it was in said patch, splitting it into smaller parts (into separate
patches), and further improving.

The first patch is not really necessary, at least for now.  It was
intended for the situation where we could configure gitweb to show
_only_ project search form (like on http://repo.or.cz), to be able to
show all projects via "search type" show_all... which might be added
in the future.

The last two patches are new, and probably should be taken together.
The issue with them is that the second patch turns off shortening of
project description in project search view.  Fixing that would require
more complicated code... but perhaps current situation is all right.


CC-ing John 'Warthog9' Hawley of git.kernel.org, and Petr 'Pasky' Baudis
of repo.or.cz


Jakub Narebski (6):
  gitweb: Allow underscore in $searchtype ('st')
  gitweb: Improve projects search form
  gitweb: Option for filling only specified info in
    fill_project_list_info
  gitweb: Faster project search
  gitweb: Highlight matched part of project name when searching
    projects
  gitweb: Highlight matched part of project description when searching
    projects

 gitweb/gitweb.perl       |  110 +++++++++++++++++++++++++++++++++++++--------
 gitweb/static/gitweb.css |    7 +++-
 2 files changed, 96 insertions(+), 21 deletions(-)

-- 
1.7.5
