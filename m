Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D7FC433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EB60231
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhJMFUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhJMFUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:20:45 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB8BC061714
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f189so340587pfg.12
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GWq8VVA/w+P/FFbZu43+9fAT4rqkr1/83y09oKmzEk=;
        b=NyrfhTcOju5XG+VrP9LYIBkMWJBwDHdW1AzPObAVJ9e3DWWIRG4Kf5E7FRHfvNHD93
         PNxja3gpvYg8rXZpEopmZKAJVO+VpEnMCa7QSfO94gm2ewxua0u6B7BEBsUBy0clKdui
         CUeqKX0IFh6c0yD66vmtnvPXrQt1IdFu4Ertu2qfIrjCeVu6wDCIYgUdfdC6/SSzQvrP
         tWC263+PuRQ6Cl5u3s5ZCaKYANbn5Am9DB7CUVC6rdxd3UWqHRx9G5Ocj+AGzXtm7238
         QrzbaoK/pmWqv7pEqu/Cp7upsyx8YMpfvzVVXVfx6iB1CNlN5+8bBt14Izv4XHwAUQkm
         Z3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GWq8VVA/w+P/FFbZu43+9fAT4rqkr1/83y09oKmzEk=;
        b=bejkALv1lvw32hXueKHMpsD6bQbRuSvROAF++zZ+1DLo02TE3XVEHoKTmeYOPIg1w8
         dTVb5ezrDDvPpI/Xc6hMX7lgjcZt9kk9+5UuL16v8eL0au6XKiQDiqWGOcslRK/44IGI
         1xrTwYWgJ27V2vPHqs/itoGy9uDdo4x6w0D16ImMRB8PaYGxCiomEec7wGAVp9r/7tLe
         bdAH2os/i3mtyuHOo3FZUDbgy8Afyx4USid86yMUMsD/9V7IsLczAMZdyboLh8dfI7Vn
         cDfGNNgxBNpzeTo/ehug9deIvBf5RkaIsTjU0DkliiF4IFtrvodaiSiET7OMBNfwiHcs
         wp8Q==
X-Gm-Message-State: AOAM533BULfH9q0bQqUzAQGCgAca7fua0RiQ+hyHjizntd8NERAH7ogi
        menEYJdguMpfVTF3jRFK6txwzohTQIo=
X-Google-Smtp-Source: ABdhPJwLhmf07U+bfE812d4y+fkpjGvs+9e0CyDIebjd/p+wFcVfB0Uyz/gDfy3hMyAJ5rs0RLLNUQ==
X-Received: by 2002:a63:454e:: with SMTP id u14mr25905865pgk.314.1634102322660;
        Tue, 12 Oct 2021 22:18:42 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:42 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 3/9] submodule--helper: rename helpers for update-clone
Date:   Wed, 13 Oct 2021 10:47:59 +0530
Message-Id: <20211013051805.45662-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `update-clone` subcommand helpers that perform the parallel clone
and printing to stdout for shell script consumption, are renamed.

This lets us use the names `update_submodules()` and
`update_submodule()` for the helpers in the next patch, when we create
an `update` subcommand that does a full conversion.

We will get rid of these helpers in a cleanup patch at the end of this
series, when the `update-clone` command is no longer useful to us.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bbab43230b..f60db966ea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2466,7 +2466,7 @@ static int do_run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
-static void update_submodule(struct update_clone_data *ucd)
+static void update_clone_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
 		oid_to_hex(&ucd->oid),
@@ -2474,7 +2474,7 @@ static void update_submodule(struct update_clone_data *ucd)
 		ucd->sub->path);
 }
 
-static int update_submodules(struct submodule_update_clone *suc)
+static int update_clone_submodules(struct submodule_update_clone *suc)
 {
 	int i;
 
@@ -2495,7 +2495,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 		return 1;
 
 	for (i = 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
+		update_clone_submodule(&suc->update_clone[i]);
 
 	return 0;
 }
@@ -2560,7 +2560,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	return update_submodules(&suc);
+	return update_clone_submodules(&suc);
 }
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
-- 
2.32.0

