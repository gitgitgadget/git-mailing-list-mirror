Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE41C77B78
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjDXQwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjDXQv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:26 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E8AD37
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:51:04 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-18b0879e0c8so3502707fac.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355063; x=1684947063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgn6n2kCBKA8Oi48GTjtt8h1FvePhHI6E29EwGu2AFI=;
        b=jRGT8ETJr6GcEZFFpiOwAnUeJDCmulaX0C9cMROmvqwsZ8sqIToeJryIpBvXtzPLZ1
         qhnPPGrW3/3FHQXQg7idD7Sosh9CwwaR2OwyfIW5SDffuwRTJEhrDTg8RwyJhoqlfttg
         OPJ9qacIIzvSKNR+Sa0BLNJ1WOyMf2PMm7PMN8xHfD+ivXGz94rYSDipDhe8kGVuTh1B
         d1Bn7d889Em9aVoZbq69J6Vfn/w6BuTHKR5Dgp4kyWpxaq/CfnF4wCAWYkOWpsRv78ry
         5CUgfmnfzyFVFxqi4mXlQ/b3vKhxZD4FpMhl9slv4kwx4MnXGccNZUwSEjJU/+VrAQRI
         NmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355063; x=1684947063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgn6n2kCBKA8Oi48GTjtt8h1FvePhHI6E29EwGu2AFI=;
        b=K3SylS7JuemhQjw6+16o9E6IV5EbqmZgJ3B2HHxXcth0mVF09Zl55mflk3zycY2ROJ
         ChkdrxONy1VfRFgonYqrni1feXA35f1XSGXlBaRCselDPKnCFm3+yV75CvfeNIpzOOA/
         ACh7TpJ5oZTGXsDbcOun1rk3EYpnU89J/Vo0KvljcmhXIKI1VR/BU0rjsXwhP8Iq19go
         uCOO14s2zR33VpQ5qRE0GbSRbKl7VUyy3f1bZTHpeLxFps3kE6pr/yOtGMfB3PKqr/rQ
         gt8WMpQ2rTQFjJL01Sgu5AIHW1k5FNXWyKGd4yxbLGmDHCGx4XGVcaAJa75snevoOeuU
         xn5w==
X-Gm-Message-State: AAQBX9dV3fWI2vQlO92Yn7JJOF4M9/tMstLjBoVkpWBkOReKdOVxn6Jw
        pIr3uzj+eqk0AzNsHx7hrTzKnUFxF1Q=
X-Google-Smtp-Source: AKy350aHXdIWdZMm1/K1xX3adHWl4LEizxL17yqajl6foskq+FgEIpjZR+LTlv2NHYzl84pe5P557Q==
X-Received: by 2002:a05:6870:8308:b0:17a:e1b7:ebef with SMTP id p8-20020a056870830800b0017ae1b7ebefmr8820403oae.12.1682355062806;
        Mon, 24 Apr 2023 09:51:02 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l21-20020a056870d4d500b0018b9dc6acaasm4317750oai.34.2023.04.24.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:51:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/15] version-gen: get rid of GVF variable
Date:   Mon, 24 Apr 2023 10:50:41 -0600
Message-Id: <20230424165041.25180-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's not much point in a variable which is never going to change and
doesn't really add any readability.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index a1c50cb06b..3d30ce74af 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,5 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=2.40.GIT
 
 get_version () {
@@ -15,5 +14,5 @@ VN=$(get_version)
 
 NEW="GIT_VERSION = $VN"
 
-test -r $GVF && test "$NEW" = "$(cat $GVF)" && exit
-echo "$NEW" | tee $GVF >&2
+test -r GIT-VERSION-FILE && test "$NEW" = "$(cat GIT-VERSION-FILE)" && exit
+echo "$NEW" | tee GIT-VERSION-FILE >&2
-- 
2.40.0+fc1

