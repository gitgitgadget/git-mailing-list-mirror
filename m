From: Lea Wiemann <lewiemann@gmail.com>
Subject: [FYI/PATCH] Git.pm: add missing semicolon
Date: Sat, 14 Jun 2008 01:22:46 +0200
Message-ID: <1213399366-3539-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 01:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7IcQ-0008Py-Vc
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 01:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333AbYFMXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 19:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756318AbYFMXWo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 19:22:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:48805 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbYFMXWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 19:22:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2898856fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=6sNdxuHauRfRN+DuS9Dl7/EoJomxS3uHFNYMy03qxZA=;
        b=b3XpsSaiJ+H+qhoT6wSkS1PAaybkrM9kBbRo2Fg839RLhuz8WmSnLusQH/U+mT3Sn/
         I3gLG6abqvZGt4NNtsm7jvn/I25oaMCSAoW60P3fultB375zvyzDg/ncpcfhfcOBnVu3
         npceO/uJIQhZ1D+OvsuF6iS0XnObZwZ9RCzTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=TDFmZL7IlmQYCQRjx2i22c1q6FgMoI5gE15u8MBAXGTrWcOIhLP7t0d+jc57qgv8Tf
         5qp+Ji4/9KWg3BUP8XCtOmHaYcJH+IK4HTxz6Twx7qmgo2fzHlIFXSWZaOgKxe1I1+Xb
         00x02E0qPzdaeaLwv9yzzlPKyTSPmOfdux3HU=
Received: by 10.86.90.2 with SMTP id n2mr4741960fgb.51.1213399362073;
        Fri, 13 Jun 2008 16:22:42 -0700 (PDT)
Received: from fly ( [91.33.222.17])
        by mx.google.com with ESMTPS id 12sm6804579fgg.0.2008.06.13.16.22.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 16:22:41 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K7IbW-0000vU-JS; Sat, 14 Jun 2008 01:22:46 +0200
X-Mailer: git-send-email 1.5.6.rc2.51.g3f3f7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84952>

---

There is obviously a semicolon missing after the try/catch block;
without the semicolon '$opts{Repository} = abs_path($dir);' becomes an
argument to the try function.  The code (apparently?) never gets
exercised in any test case, but I don't understand it well enough to
write a test case or determine whether it's correct now.

Hence this patch is not for inclusion (from my end at least).  I'm
posting it just FYI and in case anyone wants to take a look.

diff --git a/perl/Git.pm b/perl/Git.pm
index 97e61ef..ea6f13f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -207,13 +207,13 @@ sub repository {
 			my $search = Git->repository(Repository => $dir);
 			try {
 				$search->command('symbolic-ref', 'HEAD');
 			} catch Git::Error::Command with {
 				# Mimick git-rev-parse --git-dir error message:
 				throw Error::Simple('fatal: Not a git repository');
-			}
+			};
 
 			$opts{Repository} = abs_path($dir);
 		}
 
 		delete $opts{Directory};
 	}
-- 
1.5.6.rc2.51.g3f3f7.dirty
