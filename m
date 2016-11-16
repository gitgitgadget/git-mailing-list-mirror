Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8BA2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 21:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941096AbcKPVvQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 16 Nov 2016 16:51:16 -0500
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:47238 "EHLO
        dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932263AbcKPVvL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Nov 2016 16:51:11 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Nov 2016 16:51:11 EST
X-AuditID: 1209190e-36fff70000003a84-0d-582cd3a1f563
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id A0.4C.14980.1A3DC285; Wed, 16 Nov 2016 16:46:09 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id uAGLk80c005633;
        Wed, 16 Nov 2016 16:46:09 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id uAGLk6AS010607
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 16 Nov 2016 16:46:07 -0500
Date:   Wed, 16 Nov 2016 16:46:06 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org
Subject: [PATCH] git-gui: Sort entries in optimized tclIndex
Message-ID: <alpine.DEB.2.10.1611161643170.835@buzzword-bingo.mit.edu>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixG6norvwsk6EwYo11hZdV7qZLBp6rzBb
        XD28lNXiXedtFgcWj/9ztrB6XLyk7NF0qp3V4/MmuQCWKC6blNSczLLUIn27BK6MrimHWQpa
        OComrJ/N1MB4m62LkZNDQsBE4sTPd+xdjFwcQgJtTBITdqxhg3A2Mkoc3t3GAuHsZpJ4uOA1
        O0gLi4C2xOQL91hAbDYBNYkPR7+ygtgiQPbEtkNgcWaBHInvu9+DxYUFbCSm3N7BDGLzCrhJ
        TLtwHiwuKqArcejfHzaIuKDEyZlPoHrVJQ58usgIYWtL3L/ZxjaBkW8WkrJZSMpmISlbwMi8
        ilE2JbdKNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyg8OSX5djBOavA+xCjAwajEwytR
        pBMhxJpYVlyZe4hRkoNJSZR3wzGgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeX2eBcrwpiZVV
        qUX5MClpDhYlcd7/bl/DhQTSE0tSs1NTC1KLYLIyHBxKErzHLgE1ChalpqdWpGXmlCCkmTg4
        QYbzAA3fCFLDW1yQmFucmQ6RP8Woy3Fi2ssHTEIsefl5qVLivJvOARUJgBRllObBzQGnFU4H
        iVeM4kBvCfN+BBnFA0xJcJNeAS1hAlqyRwBsSUkiQkqqgTH2YXK7/v7g2df4VE5tq2o4kXvb
        If/m9CuLFimqKs2onfzDJmHTtPXhApsnS0rtnHRK+eGy9G5X+aXva2IY6/0t0n10rjy/439k
        rWvmV4nZP2cFTJ7RKug+6+UfhyO5nl8svB4z/qyP27mqNJ3T4h63VPGWfAFz8eRuSfYlt6N1
        Fj35WqT8Nl6JpTgj0VCLuag4EQAWg3MgBgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

auto_mkindex expands wildcards in directory order, which depends on
the underlying filesystem.  To improve build reproducibility, sort the
list of *.tcl files in the Makefile.

The unoptimized loading case (7 lines below) was previously fixed in
v2.11.0-rc0~31^2^2~14 “git-gui: sort entries in tclIndex”.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 git-gui/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index fe30be38d..f94b3e13d 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -252,7 +252,7 @@ $(ALL_MSGFILES): %.msg : %.po
 lib/tclIndex: $(ALL_LIBFILES) GIT-GUI-VARS
 	$(QUIET_INDEX)if echo \
 	  $(foreach p,$(PRELOAD_FILES),source $p\;) \
-	  auto_mkindex lib '*.tcl' \
+	  auto_mkindex lib $(patsubst lib/%,%,$(sort $(ALL_LIBFILES))) \
 	| $(TCL_PATH) $(QUIET_2DEVNULL); then : ok; \
 	else \
 	 echo >&2 "    * $(TCL_PATH) failed; using unoptimized loading"; \
-- 
2.11.0.rc0

