Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A263C2D0C3
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319F624673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBXKL269"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfLGRsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:48:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39074 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLGRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so11297504wrt.6
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SLkuqqTjGncvg9DOoCEM8adhCOWvgdXI58i+R9CsCHw=;
        b=YBXKL269hRPQ8u/yqqFa/jo6POVqCxHIeNVxHupZQ8JRXXWXlmmtEqlWVZT8aL9qIp
         oC1xM+2agkkbeIwKuZnDKCNtXKnZ25bDEWLWAMAGrYHDUZ9iTsrpm9dZzGGZg7YVVnVM
         m2PibBlC2xRPrmfWCWbd9jxdacJUinic8x3flyBEHtSBSU3eFgGjUAibg+EiZfWJIMrT
         Sot8oJshNIPRAINex+OzSrttt5rST1UQ2oiEpvQRvi0/VzFQBg8RA/qk1VZTG3uxvfAC
         qpO2uLHdpR63k9kTWYNu4IZMHwJa4ueGzdangwFF904RfcXT6/FG9t/ePToJ2ig9W99T
         WJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SLkuqqTjGncvg9DOoCEM8adhCOWvgdXI58i+R9CsCHw=;
        b=byjHF4wS2xi0PVgVfpqseleKkQrJrhpv634Ke9ngtPrGnIZM7DG5aJigcJhaHl0Zmb
         vzcieZKq+TDSACCopslPjF1wib1fgx/Bhw3iw+ZvYL6YLXXMo/tD4mG+/fulEUlTp2LI
         q4oEGKslE+2jmQRAFUd7eu8xuDGMC55Gn7A1MEriRZT+omZjD+zRGNRshFpgNQ9qRODv
         N7AqUqhr0FOn9oIHD5ZLo5k/8OxTSIr7OnasL9AQWxmXXfttFdkcKWvOy3oJujvVp8Ne
         6FqEoEcMdiSaAKKoGaE814mLnXTfvcv/7T5ZSqNW0gJjADp6QI8QLIe3MylQ4XgYSScI
         0vkg==
X-Gm-Message-State: APjAAAWpesMivos43/j3EAr+P1OH9OSSvddLd9dCs8NYkcsrnCuy0us3
        NpJLc3WWLjI6wbQAVcIo/1+pyN/z
X-Google-Smtp-Source: APXvYqxUoyTQwO09XQG7Qk+CBFVdOGa/Qi462rZNxZTfXyxQAo+YnFfmrLnxS02g6VmjfSTFUJ2hBA==
X-Received: by 2002:adf:c446:: with SMTP id a6mr21155346wrg.218.1575740876313;
        Sat, 07 Dec 2019 09:47:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm7637839wmg.45.2019.12.07.09.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:55 -0800 (PST)
Message-Id: <445dbc59f0cb82fabccc380c0346d65b778d8d1e.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:43 +0000
Subject: [PATCH v5 15/15] git-p4: Add depot manipulation functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Since the Depot paths and filenames are encoded according to P4, we need
to track them in bytes but also have to decode them with different
encodings (either ASCII or the encoding configured in pathEncoding,
which defaults to UTF-8)

Add the following functions to support future code conversion actions.

 * depot_count_depth         - counts the number of directories in the
       path
 * depot_remove_leading_path - removes (n) directories from the front
       of the depot path.
 * depot_Remove_p4_wildcard  - removes "/..." from the end of the path
 * depot_encode_utf8         - converts the path from the native
       encoding to utf8 encoding.  Returns (depot_path, did_decode)
 * depot_encode_restore      - restores the original encoding of the
       path.

Signed-off-by: Ben Keene <seraphire@gmail.com>

---
This code block could use review for the depot_encode_* functions.

Should this code return an absolute Unicode string or a byte array.
---
 git-p4.py | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 16f29aae41..f82f05632c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -724,6 +724,99 @@ def encodeWithUTF8(path, verbose=False):
                 print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
     return path
 
+
+def depot_count_depth(depot_path):
+    """Counts the number of directories found
+    in the depot_path. Paths will be decoded 
+    with encodeWithUTF8 to ensure that depot
+    encoding is repected.
+
+    Example:
+        //depot         = 1
+        //depot/        = 1
+        //depot/dir     = 2
+    """
+    depot_path=encodeWithUTF8(depot_path)
+    if not depot_path.endswith(b"/"):
+        depot_path+=b"/"
+    return depot_path.count(b"/") - 2
+
+def depot_remove_leading_path(depot_path, depth):
+    """Remove depth number of directories from 
+    the beginning of the depot_path. This will
+    be returned in the original encoding.
+    The leading "//" does not count as a directory
+    and will be automatically stripped.
+
+    depot_path should be in bytes
+
+    Example:
+    Given a depot_path of: //depot/main/file.txt
+    depth: 0        - depot/main/file.txt
+    depth: 1        - main/file.txt
+    depth: 2        - file.txt
+    depth: 3        - (empty string)
+    """
+
+    # First, decode the path
+    [depot_path, did_decode] = depot_encode_utf8(depot_path)
+
+    #remove leading //
+    if depot_path.startswith(b"//"):
+        depot_path=depot_path[2:]
+    if depth != 0:
+        segments=depot_path.split(b"/")
+        segments=segments[depth:]
+        depot_path=b"/".join(segments)
+
+    if did_decode:
+        depot_path = depot_encode_restore(depot_path)
+
+    return depot_path
+
+def depot_remove_p4_wildcard(depot_path):
+    """Removes the "/..." from the end of depot
+    path.
+
+    depot_path must be bytes. Bytes are returned.
+    """
+    # First, decode the path
+    [path, did_decode] = depot_encode_utf8(depot_path)
+    
+    if not path.endswith(b"/..."):
+        return depot_path
+    path=path[:-4]
+
+    if did_decode:
+        path = depot_encode_restore(path)
+
+    return path
+
+def depot_encode_utf8(depot_path):
+    """conditionally encodes depot_path
+    in utf8 using the defined pathEncoding.
+
+    Returns a (depot_path, was_encoded)"""
+    did_decode=False
+    encoding = 'utf8'
+    try:
+        depot_path.decode('ascii', 'strict')
+    except:
+        if gitConfig('git-p4.pathEncoding'):
+            encoding = gitConfig('git-p4.pathEncoding')
+        depot_path = depot_path.decode(encoding, 'replace').encode('utf8', 'replace')
+        did_decode=True
+    return [depot_path, did_decode]
+
+def depot_encode_restore(encoded_depot_path):
+    """Recodes an encoded_depot_path 
+    from utf8 back to the configured 
+    pathEncoding"""
+    encoding = 'utf8'
+    if gitConfig('git-p4.pathEncoding'):
+        encoding = gitConfig('git-p4.pathEncoding')
+    return encoded_depot_path.decode('utf8', 'replace').encode(encoding, 'replace')
+
 class P4Exception(Exception):
     """ Base class for exceptions from the p4 client """
     def __init__(self, exit_code):
-- 
gitgitgadget
