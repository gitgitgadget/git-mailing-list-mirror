Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEFC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1931A64DEF
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhA1PxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:53:10 -0500
Received: from avasout03.plus.net ([84.93.230.244]:60094 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1PxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 10:53:09 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id 59aklOM6U99nq59allJQuR; Thu, 28 Jan 2021 15:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1611849142; bh=goDSkpg6Txg+XbP/a+1J9TgqnvSQq64C2P7L8U9Wdic=;
        h=To:Cc:From:Subject:Date;
        b=nwPeD3zZUF0D1l3IqD+DnUiTrrgL56/lQF8tTezfYNCQFsGRu6L/ksPCQ/cguZ+H5
         tc40UYqeAHAYDtv3sVt3iywUm0wkerDwvEdq99gJlxeoFtqQEkeRV3nnjpNyDfiOSI
         OysUgPxkga+jg1SDj31OqCKnH9FsSXR5CwJEAHwH51z3XfKZbJ73taGXFX/0zGZVUc
         1dAa+f0hdkkRTGwDLPhS3G0SHBQ/Q+F+GAxoxku2KBUhqnUzIlJuSrK+S19axkrLla
         5t/NQJt00tEoGvzlAqQgHiaHncV1miS3FLjiVRHYYhrd/KkjMcom1uIJpLXVPjgYl7
         xURq3lC8mGlBA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=QOtKmUOPXu6K3Rhi0a0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] transport-internal.h: fix a 'hdr-check' warning
Message-ID: <44f63835-63e6-a659-620d-a29cd1015c9a@ramsayjones.plus.com>
Date:   Thu, 28 Jan 2021 15:52:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIyM0xprEpEJAWDbOQzyx719lUtkLUyZ1M22MzoC8LIliSDpQDBnkZJV0hRgpp/G/Eh3rwxDXUBXqpw/OLcdnxtAgDB54nT9IEdUSJ9XLiIi5dDUbGKJ
 lU3HyOBYOL5GQ+m1DYoGfA49YLFgoxyOzYz6cLFe/8VXL2WkJzbvpZrWReEVfhCnNzRR98xZs6YIxw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jonathan,

If you need to re-roll your 'jt/clone-unborn-head' branch, could you
please squash this into the relevant patch (commit 0c7ab71872,
'connect, transport: encapsulate arg in struct', 2021-01-26).

Thanks!

ATB,
Ramsay Jones

 transport-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport-internal.h b/transport-internal.h
index 348daad3e4..b60f1ba907 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -4,6 +4,7 @@
 struct ref;
 struct transport;
 struct strvec;
+struct transport_ls_refs_options;
 
 struct transport_vtable {
 	/**
-- 
2.30.0
