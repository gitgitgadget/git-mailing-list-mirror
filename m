From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Tue, 29 Jan 2013 19:08:44 +0000
Message-ID: <20130129190844.GB1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 20:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0GhY-0000fX-Es
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab3A2TSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:18:14 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56037 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab3A2TSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:18:13 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2013 14:18:13 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 35624CDA630
	for <git@vger.kernel.org>; Tue, 29 Jan 2013 19:08:50 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kkmvph8VRKav for <git@vger.kernel.org>;
	Tue, 29 Jan 2013 19:08:48 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 66907CDA60B
	for <git@vger.kernel.org>; Tue, 29 Jan 2013 19:08:45 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214959>

These are kept short by simply deferring to PEP-8.  Most of the Python
code in Git is already very close to this style (some things in contrib/
are not).

Rationale for version suggestions:

 - Amongst the noise in [1], there isn't any disagreement about using
   2.6 as a base (see also [2]), although Brandon Casey recently added
   support for 2.4 and 2.5 to git-p4 [3].

 - Restricting ourselves to 2.6+ makes aiming for Python 3 compatibility
   significantly easier [4].

 - Advocating Python 3 support in all scripts is currently unrealistic
   because:

     - 'p4 -G' provides output in a format that is very hard to use with
       Python 3 (and its documentation claims Python 3 is unsupported).

     - Mercurial does not support Python 3.

     - Bazaar does not support Python 3.

 - But we should try to make new scripts compatible with Python 3
   because all new Python development is happening on version 3 and the
   Python community will eventually stop supporting Python 2 [5].

 - Python 3.1 is required to support the 'surrogateescape' error handler
   for encoding/decodng filenames to/from Unicode strings and Python 3.0
   is not longer supported.

[1] http://thread.gmane.org/gmane.comp.version-control.git/210329
[2] http://article.gmane.org/gmane.comp.version-control.git/210429
[3] http://thread.gmane.org/gmane.comp.version-control.git/214579
[4] http://docs.python.org/3.3/howto/pyporting.html#try-to-support-python-2-6-and-newer-only
[5] http://www.python.org/dev/peps/pep-0404/

---
Changes since v1:

- Set 3.1 as the minimum Python 3 version

- Remove the section on Unicode literals - it just adds confusion and
  doesn't apply to the current code; we can deal with any issues if they
  ever arise.

 Documentation/CodingGuidelines | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 69f7e9b..db7a416 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -179,6 +179,19 @@ For C programs:
  - Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
+For Python scripts:
+
+ - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
+
+ - As a minimum, we aim to be compatible with Python 2.6 and 2.7.
+
+ - Where required libraries do not restrict us to Python 2, we try to
+   also be compatible with Python 3.1 and later.
+
+ - We use the 'b' prefix for bytes literals.  Note that even though
+   the Python documentation for version 2.6 does not mention this
+   prefix it is supported since version 2.6.0.
+
 Writing Documentation:
 
  Every user-visible change should be reflected in the documentation.
-- 
1.8.1.1.644.g4977e08
