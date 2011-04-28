From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 00/13] gitweb: Change timezone in dates using JavaScript
Date: Thu, 28 Apr 2011 21:03:58 +0200
Message-ID: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWW8-00036F-LX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab1D1TEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1D1TEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:37 -0400
Received: by wwa36 with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Yppu1m9ajz8CagxBsmqU1/GGT0u/sBFjlGTJaOHdUu8=;
        b=up0kf8QVQIpr/lbT4KLtf0NTD37MF3uVDqn90fp4H1uL9wWSPR5k/ythweeRyM5ZrE
         m8+kvv4yTD9m/1Gdylhzbowpwv3KxqobglCnd/QPut4pYn1sspmP4f1uRRomFMzm3YY7
         QC/A+awnAodE3tXhHGpxc2nk5BLPjvKx9qins=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xi2fjNSKV10ZbhI2dCeR9Wytvdnaj6s/9Gy8W4c2l96o0V4UMoZOF9ghOrzZM38jTk
         R5jG5iCk4KfV7nTvzR4EXrfaSAayTU/csYckU+YfYYqJv7swVSkQYiUuZwrM799+997G
         6YbyMx8cNzSQFXS4y8sTvA3APMfT72U1mUAJ0=
Received: by 10.227.61.16 with SMTP id r16mr3887807wbh.24.1304017476055;
        Thu, 28 Apr 2011 12:04:36 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.33
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172384>

This is third version of this series.

First version was sent as
  [PATCH 00/11] gitweb: Change timezone
  http://thread.gmane.org/gmane.comp.version-control.git/171212

Second version was sent as
  [PATCHv2 00/11] gitweb: Change timezone in dates using JavaScript
  http://thread.gmane.org/gmane.comp.version-control.git/171600

This version fixes the issue with Chrome / Chromium that was known in
previous version of this series (reported by Kevin Cernekee).
Additionally gitweb.js (or rather js/adjust-timezone.js that composes
part of gitweb.js) uses safer techique.  This patch was sent as 
[PATCHv3 10/11] amending original [PATCHv2/RFC 10/11] in previous
version of series.

This version of series also include 01/13 patch that fixes issue with
git-instaweb target (reported by Junio C Hamano).  Also new 02/13 patch
is a cleanup noticed while writing 01/13.  Those two patches were sent
as [PATCH -01/11] and [PATCH 12/11] in thread with previous version
of this series.

Some patches include additional Helped-by lines.


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


Interdiff to a174d61 ('jn/gitweb-js' from Apr 27, 2011):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It is not really necessary to replace it with this series, as can be
seen from the interdiff below:

diff --git a/gitweb/static/js/adjust-timezone.js b/gitweb/static/js/adjust-timezone.js
index a6e55d5..0c67779 100644
--- a/gitweb/static/js/adjust-timezone.js
+++ b/gitweb/static/js/adjust-timezone.js
@@ -67,10 +67,11 @@ function fixDatetimeTZ(tz, tzClassName, nochange) {
 
 		curElement.title = 'Click to change timezone';
 		if (!nochange) {
-			var epoch = parseRFC2822Date(curElement.innerHTML);
+			// we use *.firstChild.data (W3C DOM) instead of *.innerHTML
+			// as the latter doesn't always work everywhere in every browser
+			var epoch = parseRFC2822Date(curElement.firstChild.data);
 			var adjusted = formatDateRFC2882(epoch, tz);
 
-			// curElement.innerHTML = adjusted; // does not work for Mozilla 1.17.2
 			curElement.firstChild.data = adjusted;
 		}
 	}
@@ -196,12 +197,13 @@ function removeChangeTZForm(documentFragment, target, tzClassName) {
 
 	// timezone selection UI was appended as last child
 	// see also displayChangeTZForm function
-	var removed = container.removeChild(popup);
+	var removed = popup.parentNode.removeChild(popup);
 	if (documentFragment.firstChild !== removed) { // the only child
 		// re-append it so it would be available for next time
 		documentFragment.appendChild(removed);
 	}
 	// all of inline style was added by this script
+	// it is not really needed to remove it, but it is a good practice
 	container.removeAttribute('style');
 
 	return documentFragment;


Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCH 01/13] git-instaweb: Simplify build dependency on gitweb
  [PATCH 02/13] Remove gitweb/gitweb.cgi and other legacy targets from main Makefile

  New in this series, previously appeared as reply-to add-ons to
  previous version of series:
    http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171792
    http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171802

* [PATCH 03/13] gitweb: Split JavaScript for maintability, combining on build
  [PATCH 04/13] gitweb.js: Update and improve comments in JavaScript files
  [PATCH 05/13] gitweb.js: Provide default values for padding in padLeftStr and padLeft
  [PATCH 06/13] gitweb.js: Extract and improve datetime handling
  [PATCH 07/13] gitweb.js: Introduce code to handle cookies from JavaScript
  [PATCH 08/13] gitweb.js: Provide getElementsByClassName method (if it not exists)
  [PATCH 09/13] gitweb: Refactor generating of long dates into format_timestamp_html
  [PATCH 10/13] gitweb: Unify the way long timestamp is displayed

  Minor cosmetic changes in commit messages.

* [PATCH 11/13] gitweb: JavaScript ability to adjust time based on timezone

  Futureproofing against possible changes in gitweb output layout by
  using curElement.firstChild.data and not curElement.innerHTML... and
  we are more consistent as we need to use the former way for setting,
  see added comment in the code.

* [PATCH 12/13] gitweb.js: Add UI for selecting common timezone to display dates

  Includes fix for Chromium / Google Chrome behavior by not using
  'onblur' handler (which doesn't work anyway) from

    [PATCHv3 10/11] gitweb.js: Add UI for selecting common timezone to display dates
    http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171632

  It additionaly uses safe form of DOM manipulation:

    element.parentNode.removeChild(element);

* [PATCH 13/13] gitweb: Make JavaScript ability to adjust timezones configurable

  Patch unchanged compared to previous version.

Shortlog:
~~~~~~~~~
Jakub Narebski (11):
  git-instaweb: Simplify build dependency on gitweb
  Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
  gitweb: Split JavaScript for maintability, combining on build
  gitweb.js: Update and improve comments in JavaScript files
  gitweb.js: Provide default values for padding in padLeftStr and
    padLeft
  gitweb.js: Extract and improve datetime handling
  gitweb.js: Introduce code to handle cookies from JavaScript
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
 Makefile                                           |   28 +--
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
 12 files changed, 1024 insertions(+), 268 deletions(-)
 create mode 100644 gitweb/static/js/README
 create mode 100644 gitweb/static/js/adjust-timezone.js
 rename gitweb/static/{gitweb.js => js/blame_incremental.js} (74%)
 create mode 100644 gitweb/static/js/javascript-detection.js
 create mode 100644 gitweb/static/js/lib/common-lib.js
 create mode 100644 gitweb/static/js/lib/cookies.js
 create mode 100644 gitweb/static/js/lib/datetime.js

Dirstat:
~~~~~~~~
  39.2% gitweb/static/js/lib/
  32.0% gitweb/static/js/
  17.9% gitweb/static/
   8.5% gitweb/
-- 
1.7.3
