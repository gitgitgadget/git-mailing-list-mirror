From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/8] gitweb: Faster and improved project search
Date: Wed, 15 Feb 2012 21:38:44 +0100
Message-ID: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:39:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxld5-00045H-AV
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab2BOUjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:39:03 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48209 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab2BOUjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:39:01 -0500
Received: by eekc14 with SMTP id c14so521064eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=292FP0C1YM4gPmz4/VzvGAVIt8taKEeWnlGD4q0Uudc=;
        b=Z/MHloXyk7duNcUzcR0Lk/GB4F2CT9AO5mnSg6jdorwv3maZtFhJCXPV8x4VVmGNvG
         Wkg8pHSxLVtuamzSXp7/ciN5J/fh2m8ot9j6a8dnAUQD30ps1ep0qRP6GjRe+7yuSPuP
         nZWg2qbArW7hM4h6gx+coIrM18IVPPk8LRACc=
Received: by 10.213.23.17 with SMTP id p17mr1528006ebb.85.1329338340107;
        Wed, 15 Feb 2012 12:39:00 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.38.58
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:38:59 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190852>

[Cc-ing Junio because of his involvement in discussion about first
 patch in previous version of this series.]

First three patches in this series are mainly about speeding up
project search (and perhaps in the future also project pagination).
Well, first one is unification, refactoring and future-proofing.
The second and third patch could be squashed together; second adds
@fill_only, but third actually uses it.

Next set of patches is about highlighting matched part, making it
easier to recognize why project was selected, what we were searching
for (though better page title would also help second issue).

Well, fourth patch (first in set mentioned above) is here for the
commit message, otherwise it could have been squashed with next one.

Last patch in this series is beginning of using esc_html_match_hl()
for other searches in gitweb -- the easiest part.

Jakub Narebski (8):
  gitweb: Refactor checking if part of project info need filling
  gitweb: Option for filling only specified info in
    fill_project_list_info
  gitweb: Faster project search
  gitweb: Introduce esc_html_hl_regions
  gitweb: Highlight matched part of project name when searching
    projects
  gitweb: Highlight matched part of project description when searching
    projects
  gitweb: Highlight matched part of shortened project description
  gitweb: Use esc_html_match_hl() in 'grep' search

 gitweb/gitweb.perl |  158 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 135 insertions(+), 23 deletions(-)

-- 
1.7.9
