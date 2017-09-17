Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088EC2047F
	for <e@80x24.org>; Sun, 17 Sep 2017 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdIQQOu (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 12:14:50 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43852 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdIQQOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 12:14:50 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id AgEn1w0040M91Ur01gEooz; Sun, 17 Sep 2017 17:14:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=inrgoetUWoOxGkmx5VsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     benpeart@microsoft.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] test-drop-caches: mark file local symbols with static
Message-ID: <762d317b-8174-1809-a077-38b036850d3f@ramsayjones.plus.com>
Date:   Sun, 17 Sep 2017 17:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Ben,

If you need to re-roll your 'bp/fsmonitor' branch, could you please
squash this into the relevant patch (commit c6b5a28941, "fsmonitor:
add a performance test", 15-09-2017).

Thanks!

ATB,
Ramsay Jones

 t/helper/test-drop-caches.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 717079865..17590170f 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -2,7 +2,7 @@
 
 #if defined(GIT_WINDOWS_NATIVE)
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	char Buffer[MAX_PATH];
 	DWORD dwRet;
@@ -49,7 +49,7 @@ typedef enum _SYSTEM_MEMORY_LIST_COMMAND {
 	MemoryCommandMax
 } SYSTEM_MEMORY_LIST_COMMAND;
 
-BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
+static BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
 {
 	BOOL bResult;
 	DWORD dwBufferLength;
@@ -77,7 +77,7 @@ BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
 	return bResult;
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	HANDLE hProcess = GetCurrentProcess();
 	HANDLE hToken;
@@ -118,36 +118,36 @@ int cmd_dropcaches(void)
 
 #elif defined(__linux__)
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	return system("sync");
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	return system("echo 3 | sudo tee /proc/sys/vm/drop_caches");
 }
 
 #elif defined(__APPLE__)
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	return system("sync");
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	return system("sudo purge");
 }
 
 #else
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	return 0;
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	return error("drop caches not implemented on this platform");
 }
-- 
2.14.0
