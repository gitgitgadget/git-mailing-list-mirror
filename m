Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C9C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F232073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnSMhrq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfLDW3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:52 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45140 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfLDW3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:48 -0500
Received: by mail-wr1-f49.google.com with SMTP id j42so1068703wrj.12
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qmCmURoMqMcKK7hPDa63KxUxtMekLT5cisZPYmvN+kg=;
        b=QnSMhrq8xj+wwnezTztT5hmE1IU6qcF0BxQitGI0tW0h73b3w5wAbe6v/r48KgT2RF
         VI6spOOPuwH0pzeRUR4wss0gQcuL6csIzegMuQBZlB5d5XhfWx4Cyi9RYS8QtVQ8+pDQ
         0wC+luVTwK3yK1ZJx2azBzffgo42K5Jn2owZbv2DV3o0mucAmxTS4vOAiDCkWFWFhl9o
         da9MkgyCTBcDhmMkfhs0cnS+I+dp5Mz/NN0GIynse36S2kCr+EwClRBXEl+7rD36iDeD
         D7M6Jxe9oDNQVnd7m54bL26UNEhuoaM2fRxxOJjIGQN/4wPZM5fAEsalfta0YVuR9b8n
         mtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qmCmURoMqMcKK7hPDa63KxUxtMekLT5cisZPYmvN+kg=;
        b=XlLtNVmIiBLVX0w4ojEebMLFgOijYI7y/h+m33936ZudTU8f4W+oBCubkiG8yHdly5
         UBzHGepBbpyWc/xVKjovForIR9LPCuJOm0mpzBMVFnqYcTH2jKuATDWLHnS8jXsLFRQz
         7bPYwRqGfHuo4Lrj2+7RKBwBOggap/j/7Fyvsu9T0SvgonEdQBRMjeSCCgWgZF/3HVGp
         EJXk4CrEHRE6Hts+1YoV/PbjaETkwMhliRV3DHaujGZpYaqTHKupkuSb6uT3vBcw78WY
         wmG6IGVMS3i4LXa895ljz7NAvLLgNBxPemZXWr6ZJgmCsSgFSMYkgtypTA/H3H5H6lSD
         tpVw==
X-Gm-Message-State: APjAAAUTGCoKcfSu9V6yt0X7/3vaEFxOQoKgkbzexG3QU706TFxvRO4Y
        10HengvhMeY9Ldw5KUmbkkYiuwgy
X-Google-Smtp-Source: APXvYqzBuuPm716Ypias6BTA5nK78HHvl4gYJ1c7x1yyPrMq6iXT88BAIA/IIHtSqxMpfoXzKhCdmw==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr6386867wrm.107.1575498585283;
        Wed, 04 Dec 2019 14:29:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm10535465wra.83.2019.12.04.14.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:44 -0800 (PST)
Message-Id: <10dc059444b965c3db3fda5600de64da32de53b4.1575498578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:33 +0000
Subject: [PATCH v4 07/11] git-p4: Add a helper class for stream writing
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

This is a transtional commit that does not change current behvior.  It adds a new class Py23File.

Following the Python recommendation of keeping text as unicode internally and only converting to and from bytes on input and output, this class provides an interface for the methods used for reading and writing files and file like streams.

Create a class that wraps the input and output functions used by the git-p4.py code for reading and writing to standard file handles.

The methods of this class should take a Unicode string for writing and return unicode strings in reads.  This class should be a drop-in for existing file like streams

The following methods should be coded for supporting existing read/write calls:
* write - this should write a Unicode string to the underlying stream
* read - this should read from the underlying stream and cast the bytes as a unicode string
* readline - this should read one line of text from the underlying stream and cast it as a unicode string
* readline - this should read a number of lines, optionally hinted, and cast each line as a unicode string

The expression "cast as a unicode string" is used because the code should use the AS_BYTES() and AS_UNICODE() functions instead of cohercing the data to actual unicode strings or bytes.  This allows python 2 code to continue to use the internal "str" data type instead of converting the data back and forth to actual unicode strings. This retains current python2 support while python3 support may be incomplete.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit 12919111fbaa3e4c0c4c2fdd4f79744cc683d860)
---
 git-p4.py | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 7ac8cb42ef..0da640be93 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4182,6 +4182,72 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+class Py23File():
+    """ Python2/3 Unicode File Wrapper 
+    """
+    
+    stream_handle = None
+    verbose       = False
+    debug_handle  = None
+   
+    def __init__(self, stream_handle, verbose = False):
+        """ Create a Python3 compliant Unicode to Byte String
+            Windows compatible wrapper
+
+            stream_handle = the underlying file-like handle
+            verbose       = Boolean if content should be echoed
+        """
+        self.stream_handle = stream_handle
+        self.verbose       = verbose
+
+    def write(self, utf8string):
+        """ Writes the utf8 encoded string to the underlying 
+            file stream
+        """
+        self.stream_handle.write(as_bytes(utf8string))
+        if self.verbose:
+            sys.stderr.write("Stream Output: %s" % utf8string)
+            sys.stderr.flush()
+
+    def read(self, size = None):
+        """ Reads int charcters from the underlying stream 
+            and converts it to utf8.
+
+            Be aware, the size value is for reading the underlying
+            bytes so the value may be incorrect. Usage of the size
+            value is discouraged.
+        """
+        if size == None:
+            return as_string(self.stream_handle.read())
+        else:
+            return as_string(self.stream_handle.read(size))
+
+    def readline(self):
+        """ Reads a line from the underlying byte stream 
+            and converts it to utf8
+        """
+        return as_string(self.stream_handle.readline())
+
+    def readlines(self, sizeHint = None):
+        """ Returns a list containing lines from the file converted to unicode.
+
+            sizehint - Optional. If the optional sizehint argument is 
+            present, instead of reading up to EOF, whole lines totalling 
+            approximately sizehint bytes are read.
+        """
+        lines = self.stream_handle.readlines(sizeHint)
+        for i in range(0, len(lines)):
+            lines[i] = as_string(lines[i])
+        return lines
+
+    def close(self):
+        """ Closes the underlying byte stream """
+        self.stream_handle.close()
+
+    def flush(self):
+        """ Flushes the underlying byte stream """
+        self.stream_handle.flush()
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
-- 
gitgitgadget

