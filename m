Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C0C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6103761038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348421AbhIXUOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348399AbhIXUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88345C061613
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i23so30894810wrb.2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=dM+xicnb9pPddczEcg4c4VC36EkigoiQk+gth5qeQ4MxE3QZD0BBv9RzM67PxEwLgJ
         W+2zAWewlWikZ6/OI3JwhbYs+tKZWFGaAMj3Ns+s+tIxMRMv80eW59W+hrPFzsUYydxv
         3H4PYx1TOe8CySGoxYKQ1HHoyhC2ogZCeU+64qMdXIaeTzguWJA+Mgi+a5jdIwAJwy5b
         xSXUYpMJjF/aETXo2ZyUDJ2XIrB/MLa+oXs+/NLk9Amn+Zt/hSxS6ODXSzTc0jiMMidI
         D0X+69cbAH3LWLpDRQ9cF8sZ17uTKJD7PVSi/R53VJfxEx29rhMCxHbyOFxDzvvWiAQe
         qBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=vkRpPpXiYL0QwtX/sOogMyFpb14JOVQTUfc1VQrpFgVi6Vbbrn8hSNna/0mjSQp+wr
         ELHW9JG/YH4APXqJ6K238ONOcKXFW4a8ysWi//ksK2bWk55OLriuL3yaBVKnGDl18a0X
         sKPGwReS9IIgPLsyq6diMQG2F0PEkEv5VfbF5z3kJDXgcv7Kz68DSqk0dhOEoULv8FuG
         bWVJomF4IRj+G1l67GQGJYdOteKqQh4IofIwL7AspDiRi/1hVWm3UQ6t2GNaKbQpnQ7p
         4o2YfWidzPK+HACi8yLl+aciwNQ7aCbkOqpdko+LwCbQXfh7TyF0zo46aapzqZfv1Zsp
         z/UA==
X-Gm-Message-State: AOAM530Owa5jYnnz+w1mQ8CRecw+Pb3BO4caAJYpYxggK63FQ3y+Gd60
        689aVHAr8/gdlFSd6rmmBXWBy4NBUP4=
X-Google-Smtp-Source: ABdhPJxBDoyLKte2l4FgOnnI4IU8WmmPgVdY25lz7cYks9Q6iMH0jbO7DtFGdQpxtNy1QRbhPjI+Ig==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr4085564wmj.83.1632514336238;
        Fri, 24 Sep 2021 13:12:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a77sm9267800wme.28.2021.09.24.13.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:16 -0700 (PDT)
Message-Id: <889e76687601e3a1242e57c430a1b7f64ea1d77b.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:09 +0000
Subject: [PATCH v5 5/7] unpack-objects: use the bulk-checkin infrastructure
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

