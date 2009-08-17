From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 01/11] Fix build failure at VC because function declare use old style at regex.c
Date: Tue, 18 Aug 2009 00:01:02 +0800
Message-ID: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4eP-0003SU-UH
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108AbZHQQBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbZHQQBa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:01:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:24233 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbZHQQB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:01:29 -0400
Received: by rv-out-0506.google.com with SMTP id f6so802467rvb.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4HlHgv4cxcz6mwNzraNAL+pvXr0Y/qFzDDBpTBSzs3g=;
        b=rcS7kLNEdHQu9Ojt0XfvkYs4wjME7DcsCqMS6zNGnBXeWbvQULk+VS+l4TGiRkGERk
         WLus43rQPKerImXHnK7BRp6HCHn20eKuAGSUzqQHRzRzOSA7n2Pn476DA93q+aTZIwuT
         Ysz2Dmvf1u7/OclhGO/FdjHUUnvFaS4X49blk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NfPZPH5blGsw8PHLMUmmBOxOxbDCjtS+g9cS6QoHqw6+Ol1Ge85MgcD4CVrnSf9a68
         hKlmNSqwycPSEXo+7sHNbunEbUHepJpqZASVOtNhx4UtaLVvTT2dEBHvu+hp3Qs49WhC
         dETAoK1OV9iw7n+oaIJ7FnVFpCuZpNBhh+jrg=
Received: by 10.140.133.6 with SMTP id g6mr2394320rvd.19.1250524890874;
        Mon, 17 Aug 2009 09:01:30 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id k2sm2034782rvb.33.2009.08.17.09.01.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:01:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

regerror declare function argument type after function define.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/regex/regex.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5ea0075..5728de1 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -4852,11 +4852,7 @@ regexec (preg, string, nmatch, pmatch, eflags)
    from either regcomp or regexec.   We don't use PREG here.  */
 
 size_t
-regerror (errcode, preg, errbuf, errbuf_size)
-    int errcode;
-    const regex_t *preg;
-    char *errbuf;
-    size_t errbuf_size;
+regerror (int errcode, const regex_t * preg, char * errbuf,size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
-- 
1.6.4.msysgit.0
