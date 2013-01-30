From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3] CodingGuidelines: add Python coding guidelines
Date: Wed, 30 Jan 2013 20:47:32 +0000
Message-ID: <5c15718db7bd34da2679c88ddabe3e63b0117ef2.1359578487.git.john@keeping.me.uk>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 21:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0eZh-0003Bb-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965Ab3A3Urn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:47:43 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42300 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756957Ab3A3Urj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:47:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9A7BC8660E3;
	Wed, 30 Jan 2013 20:47:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bA++GC0TFxCk; Wed, 30 Jan 2013 20:47:38 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 0DB388660E0;
	Wed, 30 Jan 2013 20:47:38 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id F31F7161E2AE;
	Wed, 30 Jan 2013 20:47:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJfx146GUp0Y; Wed, 30 Jan 2013 20:47:37 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 61C74161E4E3;
	Wed, 30 Jan 2013 20:47:32 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215074>

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
Changes since v2:

- Tone down discussion of the byte string prefix.

- Change "is supported since" to "has been supported since".

 Documentation/CodingGuidelines | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 69f7e9b..432c6cd 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -179,6 +179,20 @@ For C programs:
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
+ - When you must differentiate between Unicode literals and byte string
+   literals, it is OK to use the 'b' prefix.  Even though the Python
+   documentation for version 2.6 does not mention this prefix, it has
+   been supported since version 2.6.0.
+
 Writing Documentation:
 
  Every user-visible change should be reflected in the documentation.
-- 
1.8.1.2.633.gbba9ccc
