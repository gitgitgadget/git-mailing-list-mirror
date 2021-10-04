Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C59FC43217
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1444761357
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhJDQ74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbhJDQ7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E52CC061783
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so4648172wrg.6
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=Z3fb3lypPkLB1ZwMqd9jUfSL0Qvbq2M5kqcdAzjdEEuY592GkV6veDqriEPxWo8T2h
         vHE5PvFdzDMSW+7LCme2dnKc00dcZy5qXP3Z9uIeo6aDWkdz7ah9HNhenIKX861IWDwI
         bPM/PZOSYjaSsd0PAjZA2Y1Us9u1OCeYxYIgNpfRChBq0YQOo7M1Fs/TQ1L78ZJo2o0W
         46xgcqMdB7578rRzIUbd90E4SCWcdkKWfKp9sjgVSkszoNgJZncxuwB7+GtNF6mz6Zyu
         n0rqhujGMjQqsus6/EwmPGDMxxllvOUOxV/8vUoej9DKQpBEdPxfNxCQZA8BVSkzMTke
         72bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=sFceHVZTB2x44z3pWmdjuary6z8s5GiVrW8o2B3TA+Z6QM/RkacTVsHhwlsWEfgiHm
         dG3XOT9NayVVenDzXFCdDzijj9T8Lnwl3Ht0pA8O/pDuzrZrzrN8fu95Xr5lJLlqpqgO
         JQua1RI6FnOJYaHPFfLzGFNB5xI5dPs/nAATE/a/yCfEpkdcZFW88xoyB6JUmWcN976i
         yl0w9cNjagf1ROz6nKEPdEd4XCPRIFFGby5BnmV7tHQYlhimvJz7U0K1DRFxSxd73IR9
         bOD5SNwsr87saEoBi3uNz97mqLuVfoBTvCsBw8wsswLgNlIujHWjAFqEG2HMQKtSGYD/
         kIDw==
X-Gm-Message-State: AOAM530oA1u98X817NNeIJSrWEwKR7i4J5KF6sB9DRIw/TNoHrMi12i4
        7zUYhpnC9rearJ9B9ld1Waw4P19n3dQ=
X-Google-Smtp-Source: ABdhPJyMZfygcP8e1klyjkOmuji8IoxLYOY85yUBoQL3IMi2s9ZvoJThJJUzU/Mb6CL59yo/dNaLWw==
X-Received: by 2002:adf:bc52:: with SMTP id a18mr2076286wrh.245.1633366673936;
        Mon, 04 Oct 2021 09:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm15053179wru.91.2021.10.04.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:53 -0700 (PDT)
Message-Id: <e88bab809a2cd226170f511df4e7b57a55d87ff4.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:45 +0000
Subject: [PATCH v8 7/9] unpack-objects: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The unpack-objects functionality is used by fetch, push, and fast-import
to turn the transfered data into object database entries when there are
fewer objects than the 'unpacklimit' setting.

By enabling bulk-checkin when unpacking objects, we can take advantage
of batched fsyncs.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/unpack-objects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295ba..51eb4f7b531 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "object-store.h"
 #include "object.h"
@@ -503,10 +504,12 @@ static void unpack_all(void)
 	if (!quiet)
 		progress = start_progress(_("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
+	plug_bulk_checkin();
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
+	unplug_bulk_checkin();
 	stop_progress(&progress);
 
 	if (delta_list)
-- 
gitgitgadget

