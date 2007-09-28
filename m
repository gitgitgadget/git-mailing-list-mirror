From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] post-receive-hook: Remove the From field from the generated email header so that the pusher's name is used
Date: Fri, 28 Sep 2007 15:24:26 +0100
Message-ID: <200709281524.26816.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 16:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGlz-0004jf-Kv
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760955AbXI1OYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761351AbXI1OYn
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:24:43 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:18627 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761337AbXI1OYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 10:24:42 -0400
Received: by mu-out-0910.google.com with SMTP id i10so4822931mue
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=f4BjG/YBpGgbloAkuj/+QpP/BH7HfSGEbvJewUwYXUg=;
        b=DvSeN7TKTlAtN65gWeGVUuUVgQ40d1zXd+cNranfuyRNHudkzT4Y1MvSEaAe7xk+THnw0WGuIGGNzLxaXzfT4IZR7hpVe2PLaOwiu+0/jb4m3zVs0IiCS5z+7v7kP0Ma710QR5DtyA4JJRCvFCTBxF/TEUwnPCBxd5pi5ZK1wP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=RFabp4/eG9r+3EeFs2FpbYTaFwilPgHvlmvyW3Kn5HdvJCdP6nPwhAPJ4pWV6UEOJ9TE4eAdoCX9VRVIaW1AqegFSiaPx3AxEknlHF6jYygl6xvUSuHFKzNEi6JAF3TM7LMdFcWtbHd9y9DnnnTq+y85o1HNV8nxV32Zmc50ZSY=
Received: by 10.82.119.17 with SMTP id r17mr7532530buc.1190989470483;
        Fri, 28 Sep 2007 07:24:30 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id 7sm46304nfv.2007.09.28.07.24.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 07:24:29 -0700 (PDT)
X-TUID: 666bba6975eb06f7
X-UID: 336
X-Length: 1234
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59400>

Using the name of the committer of the revision at the tip of the
updated ref is not sensible.  That information is available in the email
itself should it be wanted, and by supplying a "From", we were
effectively hiding the person who performed the push - which is useful
information in itself.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 contrib/hooks/post-receive-email |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 1f88099..cbbd02f 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -177,7 +177,6 @@ generate_email_header()
 	# --- Email (all stdout will be the email)
 	# Generate header
 	cat <<-EOF
-	From: $committer
 	To: $recipients
 	Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
 	X-Git-Refname: $refname
-- 
1.5.3.2.105.gf47f2-dirty
