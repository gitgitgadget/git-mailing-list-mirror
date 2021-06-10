Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460FC48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922B4613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhFJNAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:00:48 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35354 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFJNAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:00:47 -0400
Received: by mail-wr1-f51.google.com with SMTP id m18so2224479wrv.2
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xKCmthvcMA1CIUHOXUrBOBBrgHdjSTInnxe0oXM78tM=;
        b=XaXkTwR8/pJMuo6/C+Mvri9yG4z8laT5IpwJZQrYZ05Stwj+HrJCLFsD+P9wdYpw4F
         RFO3EedDkfJWzdkWxH1TGRXcrQS8bZejMtMV3oISN1cy7ww4pm0Sf93+SsNnd1W212/u
         dYq6NR1eUl+YR0/9MxTK/LbNTFKtwo1x7v+gcp+35r5KnsBOk4Kjj9U1hhHlDHGwe0RS
         OuGA0fYBZ4SWljP1NgPtipTywEshEwprMn89vAiVqEegtcBNQ3LJMiBcXocbPZbLaQCr
         pnID3FjhCuYPR7ux2W39bdx9Y0BmNDKBaMfZn9vzCNLHrHocs8h6dtNNdabX7t/7yN7G
         9few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xKCmthvcMA1CIUHOXUrBOBBrgHdjSTInnxe0oXM78tM=;
        b=bFu6/dd1rjuQSMygVl3g3w75GqIpa5zEFUsJEjAxoegQXU0121tO6aHdqPMQdd85T0
         ssFcsCxTugjOXtuNQ+T6rLigNPh9pWfgXPm2BB4JCCz2ZK0W24sc2dFWQCZGoAqTmHaJ
         UCqzHYbLSg2ORiO3ckomL1O1NtxrKlRQE4x3ako+JLWX6+qTjMAzDARv/D3DtBnPz7et
         iuw0duA1N2UdEabVmHQo0q3uT3isRrWEFX+216BTLbhOJzoFmWvzaaYg5yKV08W6EqhC
         MQ/K56EWqKaU/UyLxbPkVcpO3SboWsjm6s/Y2j2ZnY3l6/OkpDtGS+11vdjP691WHWrt
         ovxg==
X-Gm-Message-State: AOAM533LHAzw2SzRf5iBrwKcCopHEI98/hrmtMvkJWGzGc7r/T04e8N1
        SDZL/0NqgPXqa7HrYMOcfg2VJw3EKrA=
X-Google-Smtp-Source: ABdhPJx2V3lvt1nPrunV/2W2+VmEBJlTHLrBTWIAQF8fM8rZVjCrWyXXnd0pkffg94I3CjcplhBniw==
X-Received: by 2002:a5d:6e11:: with SMTP id h17mr5213205wrz.331.1623329870792;
        Thu, 10 Jun 2021 05:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k36sm2863940wms.30.2021.06.10.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:50 -0700 (PDT)
Message-Id: <f9b92e62b5987e8ab51cac07ee1c44d3ec02f7a0.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:41 +0000
Subject: [PATCH v2 1/8] refs: remove EINVAL errno output from specification of
 read_raw_ref_fn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This commit does not change code; it documents the fact that an alternate ref
backend does not need to return EINVAL from read_raw_ref_fn to function
properly.

This is correct, because refs_read_raw_ref is only called from;

* resolve_ref_unsafe(), which does not care for the EINVAL errno result.

* refs_verify_refname_available(), which does not inspect errno.

* files-backend.c, where errno is overwritten on failure.

* packed-backend.c (is_packed_transaction_needed), which calls it for the
  packed ref backend, which never emits EINVAL.

A grep for EINVAL */*c reveals that no code checks errno against EINVAL after
reading references. In addition, the refs.h file does not mention errno at all.

A grep over resolve_ref_unsafe() turned up the following callers that inspect
errno:

* sequencer.c::print_commit_summary, which uses it for die_errno

* lock_ref_oid_basic(), which only treats EISDIR and ENOTDIR specially.

The files ref backend does use EINVAL. The files backend does not call into
the generic API (refs_read_raw), but into the files-specific function
(files_read_raw_ref), which we are not changing in this commit.

As the errno sideband is unintuitive and error-prone, remove EINVAL
value, as a step towards getting rid of the errno sideband altogether.

Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs/refs-internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..f4445e329045 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -619,9 +619,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  *
  * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
  * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
- * EINVAL, and return -1. If there is another error reading the ref,
- * set errno appropriately and return -1.
+ * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
+ * (errno should not be ENOENT) If there is another error reading the
+ * ref, set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
-- 
gitgitgadget

