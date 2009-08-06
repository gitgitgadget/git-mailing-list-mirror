From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Incremental blame series
Date: Thu,  6 Aug 2009 19:11:49 +0200
Message-ID: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:12:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6Vx-00048i-DU
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbZHFRMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756365AbZHFRMX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:12:23 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:50365 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbZHFRMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:12:20 -0400
Received: by yxe5 with SMTP id 5so1224531yxe.33
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=KtflOzUkYStyvmGTUAi5b26tw5NVE8tXZmAimOagw/o=;
        b=fvy0QNEW/tjZ5Qm/F/KzsfPeT6DX0CTdibl0++86IjyBzK/z+VK+/M6frH+Pd7GVmP
         An3zdyBC1+kqVygBuFbRuR1DuQXjZrmgK69Ns3PQaeyOnVxYI4FpiWvK9nbbx34qvo5a
         xKJa0KQ845x5P7v4ICC5kfYFY2MW4vYCOaDlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Lls5p0LbTTTCaEt5UkNQA3EOAbUP17eSW2PMstaadLVC/srEVyizskI9fNLJb+x5uB
         KygEYhNcV5C31mU1CIbGkPYpFMDPsFIu1ek+vaLF/FByZIO77vzxnmyGYAd567G0H2sq
         hVhl69jUfMPu06gKa+xJNJrcdOQtyqphsLRkI=
Received: by 10.90.54.5 with SMTP id c5mr68690aga.91.1249578740225;
        Thu, 06 Aug 2009 10:12:20 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.7])
        by mx.google.com with ESMTPS id 10sm651968agb.76.2009.08.06.10.12.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 10:12:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n76HC8LN003892;
	Thu, 6 Aug 2009 19:12:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n76HC51X003891;
	Thu, 6 Aug 2009 19:12:05 +0200
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125096>

This series is meant to replace the top 4 commits of 'jn/gitweb-blame'
topic branch, those dealing with AJAX-y blame.

* jn/gitweb-blame:
      gitweb: Create links leading to 'blame_incremental' using JavaScript
      gitweb: Incremental blame (proof of concept)
      gitweb: Add optional "time to generate page" info in footer
      gitweb: Add -partial_query option to href() subroutine

      gitweb: Use light/dark for class names also in 'blame' view
      gitweb: Add author initials in 'blame' view, a la "git gui blame"
      gitweb: Mark commits with no "previous" in 'blame' view
      gitweb: Use "previous" header of git-blame -p in 'blame' view
      gitweb: Mark boundary commits in 'blame' view
      gitweb: Make .error style generic


The commit adding -partial_query option to href() is no longer
necessary, and was removed from this improved series.

This version at last doesn't turn off application/xhtml+xml as content
type in gitweb, because blame.js no longer uses innerHTML (and I can
debug it in my web browser).  Major changes are to second patch in the
series.

Table of contents:
==================
 [PATCH/RFC 1/3]   gitweb: Add optional "time to generate page" info
                   in footer
 [PATCHv3/RFC 2/3] gitweb: Incremental blame (proof of concept)
 [PATCHv2/RFC 3/3] gitweb: Create links leading to 'blame_incremental'
                   using JavaScript

Diffstat:
=========

 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/blame.js    |  731 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   16 ++
 gitweb/gitweb.perl |  321 +++++++++++++++++------
 5 files changed, 994 insertions(+), 87 deletions(-)
 create mode 100644 gitweb/blame.js
