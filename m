From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Add a function skip_prefix_if_present()
Date: Wed,  5 Feb 2014 07:25:14 +0100
Message-ID: <1391581517-8586-1-git-send-email-mhagger@alum.mit.edu>
Cc: "Kent R. Spillner" <kspillner@acm.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 07:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAvwH-0004jg-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 07:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbaBEGZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 01:25:57 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49373 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288AbaBEGZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 01:25:56 -0500
X-AuditID: 12074413-b7fc76d000002aba-54-52f1d973bebb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F2.8C.10938.379D1F25; Wed,  5 Feb 2014 01:25:55 -0500 (EST)
Received: from michael.fritz.box (p57A24DEA.dip0.t-ipconnect.de [87.162.77.234])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s156POxu019775
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Feb 2014 01:25:54 -0500
X-Mailer: git-send-email 1.8.5.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqFt882OQwfoGNYuuK91MFg29V5gt
	Huz4yWRxe8V8ZovuKW8ZHVg9Ll/x9vj7/gOTx85Zd9k9Ll5S9vi8SS6ANYrbJimxpCw4Mz1P
	3y6BO+PA4oOMBTfZKqa+P8XawPicpYuRg0NCwETi7XLPLkZOIFNM4sK99WxdjFwcQgKXGSU+
	HmtmgnCOM0l8OXmECaSKTUBXYlFPM5gtIqAmMbHtEAtIEbPAaaCOib9YQRLCAjYSfVNnMYLY
	LAKqEo3Xb4LZvALOEmcaTjFCrFOQaFm2i30CI/cCRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
	RbrmermZJXqpKaWbGCEhIryDcddJuUOMAhyMSjy8BsIfg4RYE8uKK3MPMUpyMCmJ8tbfAArx
	JeWnVGYkFmfEF5XmpBYfYpTgYFYS4U3sBsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGan
	phakFsFkZTg4lCR4U0GGChalpqdWpGXmlCCkmTg4QQQXyAYeoA3LQQp5iwsSc4sz0yGKTjEq
	SonzJoEkBEASGaV5cANg0fyKURzoH2HepSBVPMBEANf9CmgwE9Dgda7vQQaXJCKkpBoYp+g3
	p0w7YWHb881zpoySq9azJ0/zTs68nbwqL7Fm9oSr503fa6w+WsLasdvBzk4qYTrD2X3crsdm
	snP+e5PZFL7+waee+O+rYnTfhkjp1gvP7uORlUy4+tBL4PO0OCbpxAuvu5dFJN3imv/BdZOv
	tNNWptD1/i8VF4g7PZdokmKbto3nwOc+JZbijERDLeai4kQARZJshcECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241594>

These patches apply on top of gitster/nd/more-skip-prefix.

I noticed that Duy's new function skip_prefix_defval() was mostly
being called with its first and third arguments the same.  So
introduce a function skip_prefix_if_present() that implements this
pattern.

Michael Haggerty (3):
  Add and use a function skip_prefix_if_present()
  diff_scoreopt_parse(): use skip_prefix_if_present()
  rev_is_head(): use skip_prefix()

 builtin/checkout.c    |  4 ++--
 builtin/fast-export.c |  2 +-
 builtin/merge.c       |  2 +-
 builtin/show-branch.c | 15 ++++++++-------
 diff.c                |  6 +++---
 git-compat-util.h     |  5 +++++
 git.c                 |  2 +-
 notes.c               |  4 ++--
 refs.c                |  2 +-
 wt-status.c           |  4 ++--
 10 files changed, 26 insertions(+), 20 deletions(-)

-- 
1.8.5.3
