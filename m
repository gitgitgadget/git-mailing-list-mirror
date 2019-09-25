Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDA91F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406904AbfIYIVF (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:21:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44151 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbfIYIVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:21:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so2920728pfn.11
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c1yeFComJdT3K3FcVq/cpP/e6NGVkjr/1fSwE2QW0lU=;
        b=dT60H5tu4USejW7X0oc9uhIQo+4RMy+CPKjttAne6wW3siPZ/4f/2fYLNsA995BFy4
         eW/4qlty7FfrxrF2iTCKserKIw/ZVmkdwB5Fprm/3Ey9YwpE8zJ0dJ/CXKnIyrMDMNTQ
         iZWtTeS3IkOCPnVFX/w72RpZPoYfcRWbnxfKn7yTht+21wiq6R2h9iGB10nZL6os/0nJ
         FFozHCbjRMVl0By/uqAsuPCfHRFXA3leLur0oPyeAjz6czDW/dmrLCyXOv5UYnF+XDsV
         yjqlNmmjL1SJHacZhn1P6LreH0r2+cI2bvQd9X1Y9Eao/tyXRR858GOUCLhMolaoccsv
         4hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c1yeFComJdT3K3FcVq/cpP/e6NGVkjr/1fSwE2QW0lU=;
        b=gWWS68EWnSHrV9y43gYpHfN3x6h53LztXytqo7QCTXMyt104nF/I7xsoXQipyKSyaj
         2OronVZGiBdnKhnIbHWUuWAN0PmVyEb7/sppyXw2wpUDBOdvBUZf+Dpr4uHhRZX6H/yd
         Np6c3WCjoZ4w3K8nwhUeaX5QFIfQxTDJnzbqW+8lEAjbAjD8azR/xBlZqAo69j8D5nXW
         5WadKP4+OoPNRp3KMMEZJ6Yojn8whKy+4wgteR4QftAgVzX7fi+fZQjzWkFaO+sn030Y
         B5py7tX78it2y01NE4NkllN2bLBI0xIdSzLHRPozll/iE14czTk6qibjQbYPCn1CkQXW
         rdKQ==
X-Gm-Message-State: APjAAAV4XyhX6XMpt2dasmg/98TVvTEAjNAtjzegUU2Mg6Tj1dHX2RLI
        Zo8UV3VzfO2yq1bSDIg6IODpCmWo
X-Google-Smtp-Source: APXvYqyRXbcaQIiYUINnZJ+SY9P3AFi2YgjZHEa7lxhnkWU1OTHg4xcOXRMWNHnzLpruckWGodstQQ==
X-Received: by 2002:a63:4661:: with SMTP id v33mr7584944pgk.258.1569399664143;
        Wed, 25 Sep 2019 01:21:04 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id g12sm8317913pfb.97.2019.09.25.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:21:03 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:21:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] Makefile: emulate compile in $(HCO) target better
Message-ID: <14def72319521d7380fb6a8ec570d014c0f5361b.1569398897.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <cover.1569398897.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569398897.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when testing headers using `make hdr-check`, headers are
directly compiled. Although this seems to test the headers, this is too
strict since we treat the headers as C sources. As a result, this will
cause warnings to appear that would otherwise not, such as a static
variable definition intended for later use throwing a unused variable
warning.

In addition, on platforms that can run `make hdr-check` but require
custom flags, this target was failing because none of them were being
passed to the compiler. For example, on MacOS, the NO_OPENSSL flag was
being set but it was not being passed into compiler so the check was
failing.

Fix these problems by emulating the compile process better, including
test compiling dummy *.hcc C sources generated from the *.h files and
passing $(ALL_CFLAGS) into the compiler for the $(HCO) target so that
these custom flags can be used.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Peff, thanks for the suggestion! I modified it a little bit so that we
wouldn't have to keep regenerating the *.hcc files unnecessarily.

I also considered piping into the compiler's stdin directly which I know
works for GCC (and _probably_ Clang) but I opted against it because I'm
not sure it's portable for other compilers. Maybe it's alright for this
to be less portable since it's a developer target?

 .gitignore |  1 +
 Makefile   | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 521d8f4fb4..34efe125cb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -216,6 +216,7 @@
 /tags
 /TAGS
 /cscope*
+*.hcc
 *.obj
 *.lib
 *.res
diff --git a/Makefile b/Makefile
index f879697ea3..581cc617e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1872,7 +1872,7 @@ ifndef V
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $<;
+	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -2771,9 +2771,14 @@ ifndef GCRYPT_SHA256
 endif
 CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
+HCC = $(HCO:hco=hcc)
 
-$(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
+%.hcc: %.h
+	@echo '#include "git-compat-util.h"' >$@
+	@echo '#include "$<"' >>$@
+
+$(HCO): %.hco: %.hcc FORCE
+	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
 .PHONY: hdr-check $(HCO)
 hdr-check: $(HCO)
@@ -3082,6 +3087,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
+	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
-- 
2.23.0.248.g3a9dd8fb08

