From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 0/8] Highlight interesting parts of diff
Date: Wed, 11 Apr 2012 23:18:36 +0200
Message-ID: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wL-0004y6-BC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321Ab2DKVSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:18:52 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43287 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2DKVSv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:18:51 -0400
Received: by wibhj6 with SMTP id hj6so4824587wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=IYIF26R+IskQ/dbi5jgk1FVSIrX40iOs6rftxq8Gc60=;
        b=cAq0HjRZu4ni/cWm8rAQc9ilQqpHI5NmGB3NVwZGCuAa4wt9lmPYEt3F9jVRYUNTaS
         b9moBJ6VD0V0nJ4RaUc3huWELy4swYz/+CF+ueFKSntCs89ZXkS72cgyQStnXkIfVp8S
         DRMMamen4eeGsqM/Pk/4DPtPzktU3vWvFqfpXWdC64XxtHJ581pjEtw6XwR9419lAgUz
         eMCMwP6pvwu5mV0XSBds6Mgcmt59e1+PqCTffdP6zSsIsNx9XCoY4zvJ3MMdv6GwpUtw
         TUgeYzLWMISDWb1wskGd7FLfGoBBOXo4hEg3o2nzKKBpXXNsdpT4pSwVtLEk9oWMCmNm
         6rIQ==
Received: by 10.180.104.231 with SMTP id gh7mr1910wib.10.1334179129831;
        Wed, 11 Apr 2012 14:18:49 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id ff2sm13725781wib.9.2012.04.11.14.18.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:18:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195256>

Reading diff output is sometimes very hard, even if it's colored, espec=
ially if
lines differ only in few characters. This is often true when a commit f=
ixes a
typo or renames some variables or functions.

This patch series teaches gitweb to highlight fragments that are differ=
ent
between old and new line. This should mimic the same feature in Trac or=
 GitHub.

Changes since v3:

1) gitweb: Use descriptive names in esc_html_hl_regions()

    * Renamed $beg in $begin

2) gitweb: Extract print_sidebyside_diff_lines()

    * Reordered check for !$class

    * Reworded commit message to better (I hope) explain why the condit=
ions
      were changed

    * Dropped a comment '# assume that it is change'

3) gitweb: Use print_diff_chunk() for both side-by-side and inline diff=
s

    * Added ', and at the end of hunk.' to the commit message

Jakub Nar=C4=99bski (1):
  gitweb: Pass esc_html_hl_regions() options to esc_html()

Micha=C5=82 Kiedrowicz (7):
  gitweb: Use descriptive names in esc_html_hl_regions()
  gitweb: esc_html_hl_regions(): Don't create empty <span> elements
  gitweb: Extract print_sidebyside_diff_lines()
  gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
  gitweb: Push formatting diff lines to print_diff_chunk()
  gitweb: Highlight interesting parts of diff
  gitweb: Refinement highlightning in combined diffs

 gitweb/gitweb.perl       |  323 +++++++++++++++++++++++++++++++++-----=
--------
 gitweb/static/gitweb.css |    8 +
 2 files changed, 244 insertions(+), 87 deletions(-)

--=20
1.7.8.4
