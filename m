Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF25C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiGUJHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiGUJH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:07:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B53AE7D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:07:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2882935wma.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o5WxHLH4J0iqvGLSXwk4R2pMb/X+VqIsg8BxCAjKubM=;
        b=C1b+Wpckoc1Sk5F1pjcxX6XcTf26t18i7ErlSWRg7wpPwEwOTgbkEvNfUwpnw2EXWu
         ur1+uj9QUsKDDYKuWzHYxLKUywM/iI097h+OpqCetnnyXWByhDKm6G6no1tJrnsaeKlV
         4ULWBXRn7bSxC0i9Vn91wfTI6fJ7Qjd7SLXstpZ4BZ0p2Ahzr/LzAUFgwJlhL1RG20MU
         Zrv8TAyCD+EVHkxV7/TsJCgwij7pO2qwlk7wi83WvrUUjzaEsW7j83CivE9Ep5/ixSrF
         bWX102RscnOnx/hR3BDZX/a/6xg7uJo8L6d8/OvfP3pFWaWb3byngP6oM/piiOyi6uY4
         I8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o5WxHLH4J0iqvGLSXwk4R2pMb/X+VqIsg8BxCAjKubM=;
        b=vrckXYjI8xOo6RTq1kiHLNQed3Nv6a17HKvRRHnS0WiFhcA4IPYwNN5sVRyV9d6T1O
         LOzN+/NR9HU+u6N66GcMr8JHAa/FGjBavDxM89fm35RZebJbiO581BnScF/M85Knt2oG
         jC5DVZsLtpfvU/rJMcOtUWpXS2Td4YM++SdKMsgE7gVcERgep98r6lsatxwe7lqCbSd+
         QDbMXQbhM68JdoszSQ4Kn00v0QZgV4Emcx+CEl665d/dhuBg91E8omir/d1dpz8DJ+Eg
         9/KD26O7cgQe+dQ6cSG++nynH92eTECI+DtMuKdkKzUi1ylxvGdxq7EI3FhAefWLq3r+
         D98g==
X-Gm-Message-State: AJIora9kdxDgpYWBmeT47KvHFd8t3PAjBAWJeDoA2xuQ68AVOl8g4pIs
        XOzUFQMZ+2CXKEUu7sdzkNeRBuzZUEg=
X-Google-Smtp-Source: AGRyM1t76WUWlFKDmBW40MQnLJzrI0CisZPI23HDy7gGCJMTUGmF2Q0E0dzsnitR5L4P/f8zdZIxOQ==
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id x23-20020a05600c21d700b003a32088bbc6mr7272209wmj.68.1658394445204;
        Thu, 21 Jul 2022 02:07:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003a2f96935c0sm6595442wmb.9.2022.07.21.02.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:07:24 -0700 (PDT)
Message-Id: <4a81423f0e86764ee3c90cfff98f60a07b40a82c.1658394440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com>
References: <pull.1285.v2.git.git.1658134679233.gitgitgadget@gmail.com>
        <pull.1285.v3.git.git.1658394440.gitgitgadget@gmail.com>
From:   "Kilian Kilger via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:07:20 +0000
Subject: [PATCH v3 2/2] git-p4: refactoring of p4CmdList()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Kilian Kilger <kkilger@gmail.com>,
        Kilian Kilger <kkilger@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kilian Kilger <kkilger@gmail.com>

The function p4CmdList executes a Perforce command and
decodes the marshalled python dictionary. Special care has to be
taken for certain dictionary values which contain non-unicode characters.
The old handling contained separate hacks for each of the corresponding
dictionary keys. This commit tries to refactor the coding to handle the
special cases uniformely.

Signed-off-by: Kilian Kilger <kkilger@gmail.com>
---
 git-p4.py | 53 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e65d6a2b0e1..9323b943c68 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -822,6 +822,42 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 
+def p4KeysContainingNonUtf8Chars():
+    """Returns all keys which may contain non UTF-8 encoded strings
+       for which a fallback strategy has to be applied.
+       """
+    return ['desc', 'client', 'FullName']
+
+
+def p4KeysContainingBinaryData():
+    """Returns all keys which may contain arbitrary binary data
+       """
+    return ['data']
+
+
+def p4KeyContainsFilePaths(key):
+    """Returns True if the key contains file paths. These are handled by decode_path().
+       Otherwise False.
+       """
+    return key.startswith('depotFile') or key in ['path', 'clientFile']
+
+
+def p4KeyWhichCanBeDirectlyDecoded(key):
+    """Returns True if the key can be directly decoded as UTF-8 string
+       Otherwise False.
+
+       Keys which can not be encoded directly:
+         - `data` which may contain arbitrary binary data
+         - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text
+         - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
+       """
+    if key in p4KeysContainingNonUtf8Chars() or \
+       key in p4KeysContainingBinaryData() or  \
+       p4KeyContainsFilePaths(key):
+        return False
+    return True
+
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False, *k, **kw):
 
@@ -851,15 +887,13 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     try:
         while True:
             entry = marshal.load(p4.stdout)
+
             if bytes is not str:
-                # Decode unmarshalled dict to use str keys and values, except for:
-                #   - `data` which may contain arbitrary binary data
-                #   - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
-                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
+                # Decode unmarshalled dict to use str keys and values. Special cases are handled below.
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile', 'client') or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and p4KeyWhichCanBeDirectlyDecoded(key):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
@@ -869,12 +903,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
-            if 'desc' in entry:
-                entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
-            if 'client' in entry:
-                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
-            if 'FullName' in entry:
-                entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
+            for key in p4KeysContainingNonUtf8Chars():
+                if key in entry:
+                    entry[key] = metadata_stream_to_writable_bytes(entry[key])
             if cb is not None:
                 cb(entry)
             else:
-- 
gitgitgadget
