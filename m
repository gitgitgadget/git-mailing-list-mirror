From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 0/9] transport-helper and fast-export fixes
Date: Sat, 24 Nov 2012 04:25:11 +0100
Message-ID: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6NP-0006my-1O
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab2KXDZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:35 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab2KXDZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NgVJiXFoq7qmI5l1awhjKkAlzPbw2ieaUYobk+RMPb0=;
        b=bDCPJjAshf1IutIWADis/vaItgw2LW+JaXW7A+dPZGBcm5vYA/prVkxr2d09DfosaX
         H60gHAMJZGl3g6A/jegTreTHngo7R/qvdorO7KA7S5q/yOYEnWXOdaMumgSUgQnO50ac
         IaYtdMUD1CC4hm+BDToDAyo7dHoJTvGH4PGFwHOBiSjVIzyxA+FCp1h2eBwMJ7bYLbwz
         WOgDljNrhQk/z2d1r8HeDMCJOE8uVdkGqykrIa0nahQzrqrvQ7oQtZYx/kasbAfFtUIH
         sLZGyBeyoGa8JGc9mDFvsTXbSc9PB65FjwNWbnQTOyU0bkfcTkiQ5W3819nMthnLzCs2
         ep5A==
Received: by 10.204.4.80 with SMTP id 16mr1672256bkq.73.1353727533316;
        Fri, 23 Nov 2012 19:25:33 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id j16sm4403233bkv.1.2012.11.23.19.25.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:32 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210299>

Hi,

Trying to fix the remaining issues with transport-helper I stumbled upon a
problem with the first patch attached. Now that the namespaced refs of the
remote helper are properly tracked, there's a problem when pushing more than
one ref at the same time *and* the last patch on the v5 patch series is
applied.

The second patch here tries to solve that problem.

The rest are cleanups and trivial fixes.

Felipe Contreras (9):
  transport-helper: update remote helper namespace
  fast-export: don't handle uninteresting refs
  transport-helper: trivial code shuffle
  transport-helper: fix push without refspec
  transport-helper: fix pushing with straight refspec
  transport-helper: fix push without marks
  fast-export: make extra_refs global
  fast-export: refactor get_tags_and_duplicates()
  fast-export: trivial cleanups

 builtin/fast-export.c     | 99 +++++++++++++++++++++++++----------------------
 t/t5801-remote-helpers.sh | 14 +++++--
 t/t9350-fast-export.sh    | 30 ++++++++++++++
 transport-helper.c        | 39 ++++++++++++-------
 4 files changed, 120 insertions(+), 62 deletions(-)

-- 
1.8.0
