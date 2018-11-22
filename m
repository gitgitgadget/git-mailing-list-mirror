Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3D31F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 10:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405410AbeKVVhw (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 16:37:52 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38752 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeKVVhv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 16:37:51 -0500
Received: by mail-wr1-f50.google.com with SMTP id v13so5332749wrw.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurrell-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=5yCDBi1/wy6lwWMgUhwj+ydLU9idSr1SKTkAn+4Llx8=;
        b=yncaqKnmKcLfanfuu4wiw+0XBxvookNnLPqRsTZFDnF4I5KijERkDF8qDN2jbQB74W
         1Dd27y4Tl4j0OSCisvSo/hyyuY3bgr9mTrQ8DtX6MvibwWs4lBhQT9LYUKN908kBSixm
         hTaXmA1/qli7YbwxexWMcvk0mhUn8Sa17FJNrXkLHsSugVLlgCQ0aU7QYQBlhRTyaP8T
         St6I7857ePazD+pszJit8K2F7Pob9EwNvWv7DZKF7ZLXJIdQECCSdME4g5z/U+dKEdXj
         Ll4GHS/uui5Rrvf7itOzi/Ghkik9Hzvw21CsUVVH5pVlNTyiiKdPfE5EGP5mjKCg4ofi
         ptJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=5yCDBi1/wy6lwWMgUhwj+ydLU9idSr1SKTkAn+4Llx8=;
        b=sckoQ0l+CY8buvtT8Kna4vzKERhgqQ3kI5GL1BOpeO8GGJGj6TM3IftkiY2eCOCuuv
         XEDvMq79Eq6/htUEiyOHtYnqg+Y2/TfpQZDPtGSV9oGIXkFAo3IS7jFQBGT77LIHumtC
         rstrvodjXYSpCLq40w6rJkhXcpcxNRTNj2trwgJF1L3+R2lDvqVm4nB7OyaMd4tTZU7w
         bBuLdIQsUCcQPPlaMduAdjw6cxf8l4v3iBC2nMkjxfwujTxCn/cd75SpCUjrhIdVauit
         yBLfLtMY/XP1g3H9pIlmaDV5zIEEfE9mEXT26Ieo4noIBsDYyTPvU9U+lJzNwTD0R8O/
         kxkw==
X-Gm-Message-State: AA+aEWZmu9QekGW5VLx//GzfOFjSilgoVE/vADMzSVABARNHwp/kIz5n
        EsIMZczU+7vrWfROYzTpEQEKJKZRDn0=
X-Google-Smtp-Source: AFSGD/WV1sWzPFLAgfiKWxpXqSMcgOOCCIgBv5XFWlEafoiKX2Qp19ZPezJ0fu6eEU6/w/v0auP0LQ==
X-Received: by 2002:adf:e284:: with SMTP id v4mr5635805wri.26.1542884336651;
        Thu, 22 Nov 2018 02:58:56 -0800 (PST)
Received: from localhost ([194.224.154.179])
        by smtp.gmail.com with ESMTPSA id x142-v6sm7619318wmd.20.2018.11.22.02.58.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 02:58:55 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:58:36 +0100
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Subject: Document change in format of raw diff output format
Message-ID: <20181122105836.GA36193@retiro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was troubleshooting some breakage in some code that consumes the output of `git log --raw` and looking on two machines with different versions of Git just now I discovered the output format has changed somewhere between v2.14.5:

:000000 100644 000000000... 9773b7718... A      content/snippets/1157.md

and v2.19.0:

:000000 100644 000000000 9773b7718 A    content/snippets/1157.md

A quick search turns up some patches related to the GIT_PRINT_SHA1_ELLIPSIS env variable, which can be used to force the old output format, and which landed in v2.16.0, I think.

Does it sound right that we should update the documentation in diff-format.txt to show what the new output format is? The examples all show the old output format, which isn't produced by default any more.

Something like the following? If the answer is yes, I can turn it into a real patch.

Cheers,
Greg


diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 706916c94c..33776459d0 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -26,12 +26,12 @@ line per changed file.
 An output line is formatted this way:

 ------------------------------------------------
-in-place edit  :100644 100644 bcd1234... 0123456... M file0
-copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
-rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
-create         :000000 100644 0000000... 1234567... A file4
-delete         :100644 000000 1234567... 0000000... D file5
-unmerged       :000000 000000 0000000... 0000000... U file6
+in-place edit  :100644 100644 bcd123456 012345678 M file0
+copy-edit      :100644 100644 abcd12345 123456789 C68 file1 file2
+rename-edit    :100644 100644 abcd12345 123456789 R86 file1 file3
+create         :000000 100644 000000000 123456789 A file4
+delete         :100644 000000 123456789 000000000 D file5
+unmerged       :000000 000000 000000000 000000000 U file6
 ------------------------------------------------

 That is, from the left to the right:
@@ -75,7 +75,7 @@ and it is out of sync with the index.
 Example:

 ------------------------------------------------
-:100644 100644 5be4a4...... 000000...... M file.c
+:100644 100644 5be4a4abc 000000000 M file.c
 ------------------------------------------------

 Without the `-z` option, pathnames with "unusual" characters are
@@ -100,7 +100,7 @@ from the format described above in the following way:
 Example:

 ------------------------------------------------
-::100644 100644 100644 fabadb8... cc95eb0... 4866510... MM     describe.c
+::100644 100644 100644 fabadb827 cc95eb0f2 4866510ea MM        describe.c
 ------------------------------------------------

 Note that 'combined diff' lists only files which were modified from

