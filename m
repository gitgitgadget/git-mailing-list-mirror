From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON prerequisite
Date: Sat, 19 Feb 2011 19:23:46 +0000
Message-ID: <1298143495-3681-4-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsR3-0001pR-5D
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1BSTZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41634 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BSTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:28 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2346667eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=oJsiMfwsqF+k2/6nwbouCLv8Jlh4Wk76aUMJVGhsMPg=;
        b=algfnCHwZV30nIewhzzysoS4Oa4kE1VCnThRP3TjtpycSJgm/udcYXnKPIsK3j7BrS
         nDyP3c7fhOzCtBJnGbC0QxhIEaZpXYz4w/4lSey8dxSwEPjkBagFMFBMObAvHjnPVMsQ
         i1ufEifTXxZTq1Awxr3rsvl87qzx+4IxM+FmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dsrba3YLg+NfyAxdxUDHqGIaH5WAeccg6aCVHqDsyYitwJqL0LTMn0o6+1SXvBt7Di
         iXfyPMLCtoX1k20Vgo4YBmxvKyuyoKTqHCyZI+NJaBWZl8Di0bXb6/dw9LSDz9266QfE
         551IHmpW7fwNfclJrUyutPm9MbQGIlkrrqE1Y=
Received: by 10.213.35.147 with SMTP id p19mr2571879ebd.19.1298143527754;
        Sat, 19 Feb 2011 11:25:27 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.26
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:27 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167311>

Add a new test prerequisite called NO_GETTEXT_POISON to t/test-lib.sh
that's always set for now.

Some of the gettextize patches that'll follow this one will change
their test outputs if a functioning gettext implementation with poison
support is sitting on top of them, but for now I only have harmless
no-op wrappers in gettext.h so NO_GETTEXT_POISON can be set all the
time.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..ffcfa2e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1079,6 +1079,11 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
=20
+# Always set the NO_GETTEXT_POISON prerequisite while we don't have a
+# real gettext implementation in Git. This will be replaced by
+# something that varies in a future patch series.
+test_set_prereq NO_GETTEXT_POISON
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
--=20
1.7.2.3
