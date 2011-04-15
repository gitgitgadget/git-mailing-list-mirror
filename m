From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 00/11] gitweb: Change timezone in dates using JavaScript
Date: Fri, 15 Apr 2011 16:43:54 +0200
Message-ID: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:44:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGK-00027a-1O
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab1DOOoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43845 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1DOOo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:29 -0400
Received: by wya21 with SMTP id 21so2304119wya.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=KQpcPG0Jhpcfe+G788X8DzcjPsjbSuSxAwZR5UWJq8g=;
        b=qhju3xSv+k8I17kB31zPOkRDGK+eW9E9nrVqz04EzX+mPojzkp2bV828aA8rUbTb5V
         8MH4hctcpQZIajtLnb6eTiLf6Gtd+l7lCeWBzttmPvFLp/lJz9Q5359+h1RgUexKnd3r
         MSL4m5OUp+ZWr7a/1PygMpP9Dp80mJTM2bQrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vwJNZiXkGqgbE8HToUucqVngRDvsew79zm4Fw2eNSGP7DgiRjPReSUhD65ADO3cXVp
         dtC4TlBS0BPK4+bMn6W9N3NnUKlFfmF9Cj7bKTop82ZDNAMKak66QHid7xLwI6yzlGAj
         bYEpmk2X8KECpVY9uj8iAzko3PAyLfiXM7Cq0=
Received: by 10.227.177.13 with SMTP id bg13mr2116093wbb.92.1302878668313;
        Fri, 15 Apr 2011 07:44:28 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.25
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171600>

This is second version of this series.  First version was sent as

  [PATCH 00/11] gitweb: Change timezone
  http://thread.gmane.org/gmane.comp.version-control.git/171212

The major issue left is that changing (selecting) timezone doesn't
work on Chrome / Chromium, as reported by Kevin Cernekee.  See patch
10/11 for more details.

NOTE that this time, in this version of series, the path-by-patch
comparison with original J.H. patches is not provided.  It would be
re-added in the final version.


This is split version (with assorted cleanups) of J.H. patch adding
JavaScript-base ability to change timezone in which dates are
displayed.

  [PATCH 0/1] Gitweb: Change timezone
    [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
  Message-Id: <1300925335-3212-1-git-send-email-warthog9@eaglescrag.net>
  http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=169881

Below there is copy of original J.H. announcement:
JH>
JH> This is just a javascript implementation of Kevin's localtime
JH> feature.  It's pretty straight forward, though date handling in
JH> Javascript is, special (head bangingly so).
JH> 
JH> This should be good to run on any browser, with the safe fallback
JH> of UTC being the default output should Javascript not work / be
JH> available.

Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCH 01/11] gitweb: Split JavaScript for maintability, combining on build
  [PATCH 02/11] gitweb.js: Update and improve comments in JavaScript files
  [PATCH 03/11] gitweb.js: Provide default values for padding in padLeftStr and padLeft
  [PATCH 04/11] gitweb.js: Extract and improve datetime handling
  [PATCH 05/11] gitweb.js: Introduce gitweb/static/js/lib/cookies.js
  [PATCH 06/11] gitweb.js: Provide getElementsByClassName method (if it not exists)
  [PATCH 07/11] gitweb: Refactor generating of long dates into format_timestamp_html
  [PATCH 08/11] gitweb: Unify the way long timestamp is displayed

  Unchanged from previous version of this series.

* [PATCH 09/11] gitweb: JavaScript ability to adjust time based on timezone
  
  Cosmetic changes compared to previous version of this patch.

* [PATCHv2/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
  [PATCHv2/RFC 11/11] gitweb: Make JavaScript ability to adjust timezones configurable

  The main part.  The major part of changes is fixing noted issues,
  and bugs reported by Kevin Cernekee in response to v1 of series.

  The first patch of two, 10/11, includes additionally some
  refactorings that should make code cleaner and easier to follow
  (reducing size of functions).

  This is the same or nearly the same version of those two patches as
  sent to git mailing list as:

    http://thread.gmane.org/gmane.comp.version-control.git/171212/focus=171389


Shortlog:
~~~~~~~~~
Jakub Narebski (9):
  gitweb: Split JavaScript for maintability, combining on build
  gitweb.js: Update and improve comments in JavaScript files
  gitweb.js: Provide default values for padding in padLeftStr and padLeft
  gitweb.js: Extract and improve datetime handling
  gitweb.js: Introduce gitweb/static/js/lib/cookies.js
  gitweb.js: Provide getElementsByClassName method (if it not exists)
  gitweb: Refactor generating of long dates into format_timestamp_html
  gitweb: Unify the way long timestamp is displayed
  gitweb: Make JavaScript ability to adjust timezones configurable

John 'Warthog9' Hawley (2):
  gitweb: JavaScript ability to adjust time based on timezone
  gitweb.js: Add UI for selecting common timezone to display dates

Diffstat:
~~~~~~~~~
 .gitignore                                         |    1 +
 gitweb/Makefile                                    |   19 +-
 gitweb/gitweb.perl                                 |   76 +++--
 gitweb/static/gitweb.css                           |   33 ++
 gitweb/static/js/README                            |   20 ++
 gitweb/static/js/adjust-timezone.js                |  330 ++++++++++++++++++++
 .../static/{gitweb.js => js/blame_incremental.js}  |  228 +-------------
 gitweb/static/js/javascript-detection.js           |   43 +++
 gitweb/static/js/lib/common-lib.js                 |  224 +++++++++++++
 gitweb/static/js/lib/cookies.js                    |  114 +++++++
 gitweb/static/js/lib/datetime.js                   |  176 +++++++++++
 11 files changed, 1023 insertions(+), 241 deletions(-)
 create mode 100644 gitweb/static/js/README
 create mode 100644 gitweb/static/js/adjust-timezone.js
 rename gitweb/static/{gitweb.js => js/blame_incremental.js} (74%)
 create mode 100644 gitweb/static/js/javascript-detection.js
 create mode 100644 gitweb/static/js/lib/common-lib.js
 create mode 100644 gitweb/static/js/lib/cookies.js
 create mode 100644 gitweb/static/js/lib/datetime.js

Dirstat:
~~~~~~~~
  40.1% gitweb/static/js/lib/
  32.7% gitweb/static/js/
  18.3% gitweb/static/
   8.7% gitweb/
-- 
1.7.3
