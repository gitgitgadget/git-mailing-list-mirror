From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 2/2] Add test for git clean -e.
Date: Tue, 20 Jul 2010 15:36:21 -0400
Message-ID: <b8f95cd841124e24b9774c301ac63e803da325de.1279654370.git.jaredhance@gmail.com>
References: <cover.1279654370.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 21:36:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIcE-00067n-BP
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab0GTTg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:36:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33283 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab0GTTg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:36:28 -0400
Received: by mail-vw0-f46.google.com with SMTP id 14so652057vws.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Sx112O1FpLj45VjBgfeSHnlAw3tl+JHq8hOJB+pcGks=;
        b=fWQ88Yj1A6EVuy9DpNRYJElTt+10rR9pNgaoGsQy3sqsFSr3eXx3k1AAPbdi6dqTuP
         4npy2ouCV0pO9RfqhrLWSj6VPdRpyD4Mv9VyCM80YShGOYT9EMI4XRYIXcWqCn7V+EKJ
         /qnJsRlZw5IUN3ppNnBGBp0ho/HKaH77byBrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KOSfiXnZxsgOKDFKd8P6i2vqxdaT2Xa3yN6w2CRhpsS3eJ1srV2s94CHsiXWalP191
         0+Ma3EPHY/uBHiFshayWgPyWIp22y6D95Gn2i8BXTHOxrS0qvjAMwLcYGq3LEtYXs5QI
         P7KTEJOqhpM9bHrcJyTrLbVszT9MrDEINl+8Y=
Received: by 10.220.125.88 with SMTP id x24mr3624607vcr.205.1279654586081;
        Tue, 20 Jul 2010 12:36:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id e1sm1735224vch.20.2010.07.20.12.36.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:36:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1279654370.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151356>


Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 t/t7300-clean.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7d8ed68..3a43571 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -438,4 +438,20 @@ test_expect_success 'force removal of nested git work tree' '
 	! test -d bar
 '
 
+test_expect_success 'git clean -e' '
+	rm -fr repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		touch 1 2 3 known &&
+		git add known &&
+		git clean -f -e 1 -e 2 &&
+		test -e 1 &&
+		test -e 2 &&
+		! (test -e 3) &&
+		test -e known
+	)
+'
+
 test_done
-- 
1.7.1.1
