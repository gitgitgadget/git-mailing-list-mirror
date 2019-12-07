Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5564C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3326217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8bzyDNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLGRr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50619 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfLGRry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so11184417wmg.0
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ahJTPDk4z+xDr33bIFB3r9fymg4vPCK/dIbVmQ27Q70=;
        b=n8bzyDNAxQn0PuwUM8TEFDbQClhcs9q8uFCP/CK3/IZRby2XDVFbOSg/RS8Ek+DjJq
         /OnPA9mq0FKFUeGFL7hSnPlkUBjALGhyxsaVC3kBQ6ai2ttv/b5d675YwbzbhSJYmUht
         sV36iQTazCtNasdmiy9S6ieGgOKNjXEbfvaMswwDH/hei0A+1x6UIudu1p7wqw+qHWoe
         ZZ4OHnIMduihIA9JNIXzGvGZF7/Ppo+2GDUjEJlVh3CGXSN5i+DeG5dlurGdYJ/WM987
         PZD4QBP8Wb8kA+iCqHLWOInHnN4kT4pkpXEF5v6GtVfI3uJafWkXCCeuMSAvSRWmpMju
         bARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ahJTPDk4z+xDr33bIFB3r9fymg4vPCK/dIbVmQ27Q70=;
        b=DNZmuNy9vPzNu+WihI+5rne8tXsZ6nk+6ZZwJ5OvtICJXuTgVKiWN/qXJmANg/WqQC
         aj5I1XxprCIP01vUZbJ7lHU2qvYLTVpQOg4sdMWz0AJ1MiApAe/bzDm+Xbv26ZISV8e5
         ugHFmbpSHYTHtBs4P820Wse4qf2ZmGWSx8+PKQKQe9us+4jSxzjdXaygidPQjOoBsR37
         GdYHLJPo1Z7H6Pge5n1pkzNrBVJfKk1C9QpJNKF97Fmc4BmgS/PDGIzB6JNiE8Y7rlcJ
         UdadJp8Dt9pDbQSLd9riBX3SseqJCNrG7smwRbMv3Z4nChhF7gTFyuz2UUIcGAGaSc3P
         zrcQ==
X-Gm-Message-State: APjAAAW2e1DYW9IKk1Y4NFgDlRhOk1hweweg/C430slV42OhszlWZ2X1
        WmhOFnuF1c3Lr1qmDSysCjiCOE0U
X-Google-Smtp-Source: APXvYqxwG+t4djxaJzIs/yj6/UoJ4b5LCs9f/HxtQpKhGVo0I33PINpBs+n7liNVEQyMmJ5yjw1yJQ==
X-Received: by 2002:a1c:9e49:: with SMTP id h70mr17566212wme.79.1575740870949;
        Sat, 07 Dec 2019 09:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm20402616wrq.22.2019.12.07.09.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:50 -0800 (PST)
Message-Id: <1e677781d2cc75371b5362c7e63ea5ddf824d5da.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:36 +0000
Subject: [PATCH v5 08/15] git-p4: add casting helper functions for python 3
 conversion
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

Python 3 handles strings differently than Python 2.7.  Since Python 2
is reaching it's end of life, a series of changes are being submitted to
enable python 3.5 and following support. The current code fails basic
tests under python 3.5.

Change the existing unicode test add new support functions for
Python 2 - Python 3 support.

Define the following variables:
- isunicode - a boolean variable that states if the version of python
              natively supports unicode (true) or not (false). This is
              true for Python 3 and false for Python 2.
- unicode   - a type alias for the datatype that holds a unicode string.
              It is assigned to a str under Python 3 and the unicode
              type for Python 2.
- bytes     - a type alias for an array of bytes.  It is assigned the
              native bytes type for Python 3 and str for Python 2.

Add the following new functions:

- as_string(text)  - A new function that will convert a byte array to a
                     unicode (UTF-8) string under Python 3.  Under
                     Python 2, this returns the string unchanged.
- as_bytes(text)   - A new function that will convert a unicode string
                     to a byte array under Python 3.  Under Python 2,
                     this returns the string unchanged.
- to_unicode(text) - Converts a text string as Unicode(UTF-8) on both
                     Python 2 and Python 3.

Add a new function alias raw_input:
If raw_input does not exist (it was renamed to input in Python 3) alias
input as raw_input.

The as_string() and as_bytes() functions allow for modifying the code
with a minimal amount of impact on Python 2 support. When a string is
expected, the as_string() will be used to "cast" the incoming "bytes"
to a string type.

Conversely as_bytes() will be used to cast a "string" to a "byte array"
type. Since Python 2 overloads the datatype 'str' to serve both purposes,
the Python 2 versions of these function do not change the data. This
reduces the regression impact of these code changes.

'basestring' is removed since its only references are found in tests
that were changed in modified in previous commits.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e020958083..e6f7513384 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -32,16 +32,84 @@
     unicode = unicode
 except NameError:
     # 'unicode' is undefined, must be Python 3
-    str = str
+    #
+    # For Python 3 which is natively unicode, we will use
+    # unicode for internal information but all P4 Data
+    # will remain in bytes
+    isunicode = True
     unicode = str
     bytes = bytes
-    basestring = (str,bytes)
+
+    def as_string(text):
+        """ Return a byte array as a unicode string
+        """
+        if text is None:
+            return None
+        if isinstance(text, bytes):
+            return unicode(text, "utf-8")
+        else:
+            return text
+
+    def as_bytes(text):
+        """ Return a Unicode string as a byte array
+        """
+        if text is None:
+            return None
+        if isinstance(text, bytes):
+            return text
+        else:
+            return bytes(text, "utf-8")
+
+    def to_unicode(text):
+        """ Return a byte array as a unicode string
+        """
+        return as_string(text)
+
+    def path_as_string(path):
+        """ Converts a path to the UTF8 encoded string
+        """
+        if isinstance(path, unicode):
+            return path
+        return encodeWithUTF8(path).decode('utf-8')
+
 else:
     # 'unicode' exists, must be Python 2
-    str = str
+    #
+    # We will treat the data as:
+    #   str   -> str
+    #   bytes -> str
+    # So for Python 2 these functions are no-ops
+    # and will leave the data in the ambiguious
+    # string/bytes state
+    isunicode = False
     unicode = unicode
     bytes = str
-    basestring = basestring
+
+    def as_string(text):
+        """ Return text unaltered (for Python 3 support)
+        """
+        return text
+
+    def as_bytes(text):
+        """ Return text unaltered (for Python 3 support)
+        """
+        return text
+
+    def to_unicode(text):
+        """ Return a string as a unicode string
+        """
+        return text.decode('utf-8')
+
+    def path_as_string(path):
+        """ Converts a path to the UTF8 encoded bytes
+        """
+        return encodeWithUTF8(path)
+
+# Check for raw_input support
+try:
+    raw_input
+except NameError:
+    raw_input = input
 
 try:
     from subprocess import CalledProcessError
@@ -740,7 +808,7 @@ def p4Where(depotPath):
             if data[:space] == depotPath:
                 output = entry
                 break
-    if output == None:
+    if output is None:
         return ""
     if output["code"] == "error":
         return ""
@@ -4175,7 +4243,7 @@ def main():
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-        if cmd.gitdir == None:
+        if cmd.gitdir is None:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-- 
gitgitgadget

