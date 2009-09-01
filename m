From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Incremental blame series (1 Sep 09)
Date: Tue,  1 Sep 2009 13:39:15 +0200
Message-ID: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 13:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiRat-0001Co-FP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 13:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbZIALb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 07:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbZIALb7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 07:31:59 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:41079 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZIALb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 07:31:58 -0400
Received: by fxm17 with SMTP id 17so3435894fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=QCuR/BMLfWnMfGM3ctYPGCwouvkoQOC8A3nJ+mVkTMs=;
        b=qQrNxExRuPdTOTucTiPMkUu2a1QOkrbMv23En4WvVeqhEtsKKVFTLAPftzqaBHYyeK
         xQkKGxOZ+tGyXZLg6QFkm6lzdeNsyrAENvnNLgUWBBvUvm/LgQE0v0LX04zKdcMZn4t/
         kC3ACALiadIjZAamEz2qlDnShVggmH6roMZns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jDbiW/lGk58EOWQbfymTTn0QS9Vg2nXdiglndZ9n+7EaQW9VB1q9lI0Ota2qnVBzhJ
         gGYlgMdE/cp+xNlGb8IPc3nFm63khPx+JsIY/wac/1yZIForBqt34nl+0lcXrpsUB8Zn
         GnMyAr9hXcMKDv6JVb02q4iNYOauVC4zZLG2k=
Received: by 10.102.165.11 with SMTP id n11mr2858454mue.5.1251804719412;
        Tue, 01 Sep 2009 04:31:59 -0700 (PDT)
Received: from localhost.localdomain (abwl209.neoplus.adsl.tpnet.pl [83.8.235.209])
        by mx.google.com with ESMTPS id y6sm566653mug.40.2009.09.01.04.31.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 04:31:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n81BdSNT005333;
	Tue, 1 Sep 2009 13:39:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n81BdQjq005332;
	Tue, 1 Sep 2009 13:39:26 +0200
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127530>

This series is meant to replace the 'jn/gitweb-blame' topic branch
(it is merged into 'pu', b08ae28).

Jakub Narebski (5):
  gitweb: Add optional "time to generate page" info in footer
  gitweb: Incremental blame (using JavaScript)
  gitweb: Colorize 'blame_incremental' view during processing
  gitweb: Create links leading to 'blame_incremental' using JavaScript
  gitweb: Minify gitweb.js if JSMIN is defined

The "time to generate page" info got its own style, and don't looks
bolted on now.  Incremental blame patch is no longer marked as proof
of concept, or as a work in progress; I think it is mature enough.

Last two patches (creating links and JSMIN) are in active development,
and should be considered work in progress (or even proof of concept
code).

This series has 3-color colorizing of 'blame_incremental' view is put
into separate patch.  JavaScript code used to create links leading to
'blame_incremental' view is now put in gitweb.js, which is meant to
contain all JavaScript code used by Git.

The last patch (modifying Makefile) was added because of concern that
heavily commented gitweb.js could be a burden on server.

 Makefile           |   26 ++-
 git-instaweb.sh    |    7 +
 gitweb/README      |    4 +
 gitweb/gitweb.css  |   23 ++
 gitweb/gitweb.js   |  862 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |  311 ++++++++++++++------
 6 files changed, 1146 insertions(+), 87 deletions(-)
 create mode 100644 gitweb/gitweb.js

-- 
Jakub Narebski
Poland
