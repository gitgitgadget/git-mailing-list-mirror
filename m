Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4658720970
	for <e@80x24.org>; Fri, 14 Apr 2017 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdDNNDA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 09:03:00 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35142 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdDNNC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 09:02:58 -0400
Received: by mail-pg0-f44.google.com with SMTP id 72so35096322pge.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WirKg210EWmWrwZnxPIrtz42O0vLDL0sWHSboFxUZ/4=;
        b=OEeb/5QoY3xdtIkV+9jKnhrWl2lv4lQOv5XZ9Xa8R3sk76uKrnATjSvtTjKa4LpWCP
         CuWroIL9kyDMaILdpJ4R3JzFROpOO67kNRlgwpj/nxu6iLdaiaK6RxcExhSoFJJYlG5z
         H0Tk/nogHebPjWWWshG0vRH3F/qFpZUKR0a/zzCIZKCsPAfyw13tai7FPugwQD1pS1Lg
         zTS0ZZrqD+48Akkp+xklihTPRmeI1vE8oQ/v5jQsHhS+FNDrkfFdeyuuqKSsmpBFcEM1
         YeEBa2jsF5IWYHpyuWvMlY0lkIX+EqBvmRLW7EwXWO7inhxlNj04lSlA3XTjaPCzsCcA
         iQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WirKg210EWmWrwZnxPIrtz42O0vLDL0sWHSboFxUZ/4=;
        b=V65/ALCW3nWJQezkJ9SVVnpDRy0T7ey1UcbDZOCNdv2tOlkiwMhEySfE1slQVWAXlR
         4pcWZVMcEAGPladLWe0TccR8iyEyjVsJy1hcrBhpfnTQsKt93IOjh209nSiXMY55Q/DU
         ATDJyah2VqUExIQknqpAjy0NYXgRX4VCUt69Jyckn3b2yltYkbVOkIjdtOtC+Y9BThad
         v89EH3nEwa1BEg3WZexdi06EhgG5c5CWLh53qBUS6f1dZ8ED6HMAXMpMoMaO8Yk0+5M0
         mmOQG05N0JtKgaW/QXrt5L9sQUXy0I7ualm/QTNfuCvUqlys92mcETxINsiRLWjs94kt
         XjQg==
X-Gm-Message-State: AN3rC/4du+f9u40ofC8aEybP0htx7VlEeUpdXEVdWI4lToCevaBbRsnE
        pTcQR0GZKjJndA==
X-Received: by 10.99.160.73 with SMTP id u9mr6932142pgn.176.1492174977480;
        Fri, 14 Apr 2017 06:02:57 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s10sm3436154pfe.28.2017.04.14.06.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 06:02:56 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 14 Apr 2017 20:02:51 +0700
Date:   Fri, 14 Apr 2017 20:02:51 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v7 19/28] files-backend: replace submodule_allowed check
 in files_downcast()
Message-ID: <20170414130251.GA29908@ash>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
 <20170326024241.31984-20-pclouds@gmail.com>
 <4e4fd98d-055d-6e2b-845d-51d3f1c2856f@alum.mit.edu>
 <CACsJy8ByRdcXUS57pqSH4Gmr6FLSfK1yNnq7u5wVzh=7hj0vBA@mail.gmail.com>
 <xmqq8tn3nu8x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tn3nu8x.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 03:44:46AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > I'll mark this mail and do a follow-up patch once this topic graduates
> > to master. It's less review burden and mail traffic.
> 
> I actually do not mind a single replacement patch.

Thanks. Here's the fixup patch

-- 8< --
From c572f11f9c653f6f18d51a56b31cc5d966f9b242 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?=
 <pclouds@gmail.com>
Date: Fri, 14 Apr 2017 19:54:31 +0700
Subject: [PATCH] fixup! files-backend: replace submodule_allowed check in
 files_downcast()

---
 refs.c               |  2 +-
 refs/files-backend.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 241b4227b2..c7bffac06d 100644
--- a/refs.c
+++ b/refs.c
@@ -1486,7 +1486,7 @@ struct ref_store *get_ref_store(const char *submodule)
 		return NULL;
 	}
 
-	/* pretend that add_submodule_odb() has been called */
+	/* assume that add_submodule_odb() has been called */
 	refs = ref_store_init(submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_submodule_ref_store(refs, submodule);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d97a924860..3faf5a0635 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1006,15 +1006,13 @@ static void files_assert_main_repository(struct files_ref_store *refs,
 	if (refs->store_flags & REF_STORE_MAIN)
 		return;
 
-	die("BUG: unallowed operation (%s), only works "
-	    "on main ref store\n", caller);
+	die("BUG: operation %s is only allowed for main ref store", caller);
 }
 
 /*
  * Downcast ref_store to files_ref_store. Die if ref_store is not a
- * files_ref_store. If submodule_allowed is not true, then also die if
- * files_ref_store is for a submodule (i.e., not for the main
- * repository). caller is used in any necessary error messages.
+ * files_ref_store. Die if the operation is not allowed on this particular
+ * store. "caller" is used in any necessary error messages.
  */
 static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 					      unsigned int required_flags,
@@ -1029,7 +1027,7 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	refs = (struct files_ref_store *)ref_store;
 
 	if ((refs->store_flags & required_flags) != required_flags)
-		die("BUG: unallowed operation (%s), requires %x, has %x\n",
+		die("BUG: operation %s requires abilities 0x%x but have 0x%x",
 		    caller, required_flags, refs->store_flags);
 
 	return refs;
-- 
2.11.0.157.gd943d85

-- 8< --
