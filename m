Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A3620A40
	for <e@80x24.org>; Tue, 28 Nov 2017 10:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdK1KVw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 05:21:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38681 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbdK1KVm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 05:21:42 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20171128102140euoutp013f0f9ea8e08b4d7efe291bcccd3c06c7~7OMC8852B0411304113euoutp01W;
        Tue, 28 Nov 2017 10:21:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20171128102140euoutp013f0f9ea8e08b4d7efe291bcccd3c06c7~7OMC8852B0411304113euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1511864500;
        bh=tH4EvEBe2mQ2ZRXW/pJ/7Yu8AzXiFPooFalPDOoajkw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MoD9XHwdqmJJ3KCdsXgybbSN7jHrb6szMBtvWlyWvXbSEpM0eW/JwH4Ig7NH79OlH
         BlDksbtYLJzrf1VvXrCd4DHZUayJDWLrWS2syrO/vJ/2S71IsaL42k74sjkhdrvC73
         qg02ybpFEugS8zfARS7/gG1C9D10EBVM9omQTx3k=
Received: from eusmges5.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171128102139eucas1p1f94e18be96552393d133a614cfbb391b~7OMCLHTPV1773217732eucas1p1L;
        Tue, 28 Nov 2017 10:21:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges5.samsung.com (EUCPMTA) with SMTP id 65.10.12743.3B83D1A5; Tue, 28
        Nov 2017 10:21:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171128102138eucas1p116ae54d723bb100202fae2c1aaf5a9d8~7OMBVCMY83150231502eucas1p1E;
        Tue, 28 Nov 2017 10:21:38 +0000 (GMT)
X-AuditID: cbfec7f5-f79d06d0000031c7-7a-5a1d38b35324
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AD.44.18832.2B83D1A5; Tue, 28
        Nov 2017 10:21:38 +0000 (GMT)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from localhost ([106.116.147.110]) by eusync4.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0P04007HPI427VA0@eusync4.samsung.com>; Tue, 28 Nov 2017 10:21:38
        +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Stefan Beller <sbeller@google.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: Prevent double UTF-8 conversion
Date:   Tue, 28 Nov 2017 11:21:26 +0100
Message-id: <20171128102126.20864-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djP87qbLWSjDJ4eEbDoutLNZHHz0ApG
        i3edt1ksNm9uZ3Fg8ViwqdSjb8sqRo+mU+2sHp83yQWwRHHZpKTmZJalFunbJXBlfLv6jrFg
        N2fFyhePWRsYL7B3MXJySAiYSGzePgfKFpO4cG89WxcjF4eQwFJGiSszp7BCOJ8ZJVrPrmOC
        6Vg0/RczRGIZo8TZKe8ZQRK8AoISPybfY+li5OBgFpCXOHIpGyTMLKApsXX3erANQgJfGCU6
        bhWB2GwCjhL9S0+wgtgiAuISb4/PZAeZySwwmVFi0vp2sISwgKXEycvb2UBsFgFViZ57P9kh
        dllLPPv5hBXiIHmJXW0XwWx+AS2JNU3XWUAGSQjMYZPYfXQP1G8uEjsuNkB9ICzx6vgWqLiM
        RGfHQSaIhn5GicPzv0MlpjBKLF7oAGFbS/xZNZEN4h0+iUnbpjODfCkhwCvR0SYEUeIh0Tpz
        KdRBjhIPP+2G+jhW4ujqrawTGOVmIYXRLEQYzUIKowWMzKsYRVJLi3PTU4tN9YoTc4tL89L1
        kvNzNzECk8Hpf8e/7mBceszqEKMAB6MSD+8EF5koIdbEsuLK3EOMEhzMSiK8p0xko4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInz2ka1RQoJpCeWpGanphakFsFkmTg4pRoYg7m+dMkVhuWek/bZ
        sYPLP7K5fFvIB6/AE1Z3rxl/Krryn7c+c3ev6QatJXM8UjzMMzIOTdkvuEO0qfvHmVpVCZF9
        /1a//3qh6xKLpBvbdMsjjFdTuFb6Pd0Tt6f1aFF2Gef8+GlbF8V5VoRuP3Dr5LUyveM75sYe
        a3Cf8Sw9Nvy1uvf2Nu9sJZbijERDLeai4kQA45ZKSwIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsVy+t/xa7qbLGSjDL79VLHoutLNZHHz0ApG
        i3edt1ksNm9uZ3Fg8ViwqdSjb8sqRo+mU+2sHp83yQWwRHHZpKTmZJalFunbJXBlfLv6jrFg
        N2fFyhePWRsYL7B3MXJySAiYSCya/osZwhaTuHBvPVsXIxeHkMASRonmVW9ZQRK8AoISPybf
        Y+li5OBgFpCXOHIpGyTMLKAuMWneImaI+m+MElc79jOCJNgEHCX6l54A6xUREJd4e3wmO0gR
        s8BURolj296BJYQFLCVOXt7OBmKzCKhK9Nz7yQ6xzFri2c8nrBAXyUvsarsIZvMLaEmsabrO
        MoGRfxaSm2Yh3DQLyU0LGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBAbotmM/N+9gvLQx
        +BCjAAejEg/vBBeZKCHWxLLiytxDjBIczEoivKdMZKOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8/buWR0pJJCeWJKanZpakFoEk2Xi4JRqYJS2rGUpjbcLNvze75si3H7E4t2/peI/sx++WKTx
        e5bKnHW1FWsWP3NXcLj5S3V2n6vQM+6ouoeJ8Wdf1was4Gty3s7mN8vlUO+MU2uyuB1s3mrZ
        sf265rM1Ne7aHU/ubrXFolbb13ME3dDQ29g71Upt2rG3yh73o07lOrifOWy/hDM2mCnVR4ml
        OCPRUIu5qDgRAJXDrkJMAgAA
X-CMS-MailID: 20171128102138eucas1p116ae54d723bb100202fae2c1aaf5a9d8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171128102138eucas1p116ae54d723bb100202fae2c1aaf5a9d8
X-RootMTR: 20171128102138eucas1p116ae54d723bb100202fae2c1aaf5a9d8
References: <CGME20171128102138eucas1p116ae54d723bb100202fae2c1aaf5a9d8@eucas1p1.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set encoding to utf-8 for file descriptors used to receive data from
git commands.

With encoding on the file descriptor set to "binary" Tcl (8.6 in my case)
does double conversion which breaks e.g. author name in amended commits.

For example "\305\201ukasz" (as written by git cat-file) becomes
"\303\205\302\201ukasz".

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 git-gui/lib/commit.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

So, this is the second attempt to draw some attention to this patch,
since the first one has somewhat failed.

https://marc.info/?l=git&m=150331641702091&w=2

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 83620b7cb..bcb6499a0 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -26,7 +26,7 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 	set parents [list]
 	if {[catch {
 			set fd [git_read cat-file commit $curHEAD]
-			fconfigure $fd -encoding binary -translation lf
+			fconfigure $fd -encoding utf-8 -translation lf
 			# By default commits are assumed to be in utf-8
 			set enc utf-8
 			while {[gets $fd line] > 0} {
-- 
2.11.0

