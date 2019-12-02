Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C90C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC0521774
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbyUKWVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfLBTCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:02:21 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36845 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfLBTCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:02:21 -0500
Received: by mail-wr1-f48.google.com with SMTP id z3so539557wru.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=amLyMbqCohkIPr33r1nznA1K+NL1BmTXJPhUYfpKYko=;
        b=EbyUKWVp2jVwZLmJsC8g7HMY60Tpx6QWrXUBXi/iWnimsfya6tuTFX1IJ7IniO5zmG
         7Jww/T+djmdnr4NSyaVBduN4OMfWxwapB21/zfnphy0szRmRPSDU6x5ksXmGLOqwz1HQ
         +TJdgZ5mUOPa+oOcAU1dXH15eszEFtjBZ9cjzSKNYla5STij0W7oQfngvKTVvB6lwsRV
         slohSgW0lWYU4h6xbWixNN7uQTxQyBO6VXv4LEt8iJaip9HT574Xr7Beba/RpHTi41ge
         0qUxMAIrSd9pLY+tAPoYl53CdKAEWnGDY61uwYRjLsSltwDROYuNVTh6FwojjvBkjMpr
         MCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=amLyMbqCohkIPr33r1nznA1K+NL1BmTXJPhUYfpKYko=;
        b=mkHg3MIwZ/5NAvAVZFUAkenjnejvXaKpGiv7qJeqkrnpy0zeC35CYpBdL6CGfKCBM4
         htCQTHoU7iQthCmDs02HlwHGYB+diBJoIl8yUT5bdIcEnnGhuQRat5NN7emTz0JcMwKT
         iWSOjz4vX1CDSBpHQr2yFQs9DVduumscRAq1JNh9nmA5uP/6t+5QIjqZeg++vSaU6172
         4DsYP5FD+l/lia8e/z28UICXPH2rHFrl0EnuRRdl3MFgkmfak2QJr5gZhZN18MFAdbRC
         bDoHEgvCywlmHHGfzGqsP2w4WAeTByROrU0L6sYWzpsabuCtN7Zm2Q9rU5qOvBETlUuS
         N/QA==
X-Gm-Message-State: APjAAAXZzh2V2yAhCbQM+HA+YeK8+Cet70mXerGzx0ocyz6970ql3REq
        Fahh1IrJlmY39YeosQM2ZP0m/d/d
X-Google-Smtp-Source: APXvYqz0GqAqIu6IO05hKUjXAjO/GgR1LMPtHoEdpiPzGB0c0B19cu263dqVwnlpbW4nCF5DG4ex2w==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr498825wrq.396.1575313338315;
        Mon, 02 Dec 2019 11:02:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm400162wrr.50.2019.12.02.11.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 11:02:17 -0800 (PST)
Message-Id: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
References: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 19:02:15 +0000
Subject: [PATCH v3 0/1] git-p4.py: Cast byte strings to unicode strings in python3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue: The current git-p4.py script does not work with python3.

I have attempted to use the P4 integration built into GIT and I was unable
to get the program to run because I have Python 3.8 installed on my
computer. I was able to get the program to run when I downgraded my python
to version 2.7. However, python 2 is reaching its end of life.

Submission: I am submitting a patch for the git-p4.py script that partially
supports python 3.8. This code was able to pass the basic tests (t9800) when
run against Python3. This provides basic functionality. 

In an attempt to pass the t9822 P4 path-encoding test, a new parameter for
git P4 Clone was introduced. 

--encoding Format-identifier

This will create the GIT repository following the current functionality;
however, before importing the files from P4, it will set the
git-p4.pathEncoding option so any files or paths that are encoded with
non-ASCII/non-UTF-8 formats will import correctly.

Technical details: The script was updated by futurize (
https://python-future.org/futurize.html) to support Py2/Py3 syntax. The few
references to classes in future were reworked so that future would not be
required. The existing code test for Unicode support was extended to
normalize the classes “unicode” and “bytes” to across platforms:

 * ‘unicode’ is an alias for ‘str’ in Py3 and is the unicode class in Py2.
 * ‘bytes’ is bytes in Py3 and an alias for ‘str’ in Py2.

New coercion methods were written for both Python2 and Python3:

 * as_string(text) – In Python3, this encodes a bytes object as a UTF-8
   encoded Unicode string. 
 * as_bytes(text) – In Python3, this decodes a Unicode string to an array of
   bytes.

In Python2, these functions do not change the data since a ‘str’ object
function in both roles as strings and byte arrays. This reduces the
potential impact on backward compatibility with Python 2.

 * to_unicode(text) – ensures that the supplied data is encoded as a UTF-8
   string. This function will encode data in both Python2 and Python3. * 
      path_as_string(path) – This function is an extension function that
      honors the option “git-p4.pathEncoding” to convert a set of bytes or
      characters to UTF-8. If the str/bytes cannot decode as ASCII, it will
      use the encodeWithUTF8() method to convert the custom encoded bytes to
      Unicode in UTF-8.
   
   

Generally speaking, information in the script is converted to Unicode as
early as possible and converted back to a byte array just before passing to
external programs or files. The exception to this rule is P4 Repository file
paths.

Paths are not converted but left as “bytes” so the original file path
encoding can be preserved. This formatting is required for commands that
interact with the P4 file path. When the file path is used by GIT, it is
converted with encodeWithUTF8().

Signed-off-by: Ben Keene seraphire@gmail.com [seraphire@gmail.com]

Ben Keene (1):
  Python3 support for t9800 tests. Basic P4/Python3 support

 git-p4.py | 825 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 628 insertions(+), 197 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-463%2Fseraphire%2Fseraphire%2Fp4-python3-unicode-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-463/seraphire/seraphire/p4-python3-unicode-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/463

Range-diff vs v2:

 1:  0bca930ff8 < -:  ---------- Cast byte strings to unicode strings in python3
 2:  0435d0e2cb < -:  ---------- FIX: cast as unicode fails when a value is already unicode
 3:  2288690b94 < -:  ---------- FIX: wrap return for read_pipe_lines in ustring() and wrap GitLFS read of the pointer file in ustring()
 -:  ---------- > 1:  02b3843e9f Python3 support for t9800 tests. Basic P4/Python3 support

-- 
gitgitgadget
