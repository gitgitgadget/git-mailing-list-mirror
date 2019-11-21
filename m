Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC2C33C9E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D29206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT4ZADU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUWUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40524 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id 4so3023563wro.7
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SSk2c0GZIeKhzrboplrlbr89TjCddJrfGqCdlxfV+pU=;
        b=fT4ZADU15k5fIdiT8fpFZhv+iXzuEqHi4uHKoIo4kCB0kqGMOC0y5r267RIxJtcH8N
         UZD/kn9HWVKZBv18VcIo8Qy29A3y/I02N37eJNGNgAc53V4dyQU5KOJkuPcAjlJMMHPr
         lZJagUiV1DDzoPykrYVUReXURVeA/DJ4kz6uiokyGwQi6dG0X1jdnIBS0qS1RG53cYNh
         vPMUGfaFu8ANtXsRXkaGPe9FfoakoOuhF3DOHlT9hr4CSY4k78nO6WRsjjhljR5AViuy
         2zDZz2LnCSwIBsndjOxZNYrgIrRkeaNQscCc3eYCgq8Be39Lzoe5kzGWt4AuvD4/yvER
         3QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SSk2c0GZIeKhzrboplrlbr89TjCddJrfGqCdlxfV+pU=;
        b=uPfBSH1FSd1rHJgwtsVXNbPquqFLxhB0eIGWx2qlefm7tSZTgTpbona0uWYVoKZPjB
         ho/o7lnDurBEFCJG5h8TPcTUfjnOi7Oa6yb5WvACHodtLw3yu03kqk/iAZPoYzLb9Ve2
         lLI1y3o+nggz0v4MWPDTozvXMVx4vtBGswVOz7wpoLQbUP4Alo6zErgj5OOmwK90alfa
         71G9HRxwLiWRfAsQmsuUDrdw5lz97N1SLU5n6b/ze29PCNDMzHSj8cwvdIP8HIa5iSah
         hEq0jMao6ZH3ly9URc2Vy/RWEwOqYyiAZCtGqnTZxt7ljpabDPgKDoiZ5r566YsfoZOu
         HLfA==
X-Gm-Message-State: APjAAAUdH8wI+OyRtHnEMNE1MIbeLIPX94Mv8KieNReWyUcqsa9AUMBX
        NNeX1e8o8W8uKkbiZsmCQMm+cQNO
X-Google-Smtp-Source: APXvYqx9qk0jVVLQ0qDJFvTLLmaUpmHmy732rFqjCdc0p4K5UA9fBFTCta5jagP3FfhaCTF1xZGyeA==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr5595110wrn.289.1574374833184;
        Thu, 21 Nov 2019 14:20:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm4720189wrr.19.2019.11.21.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:32 -0800 (PST)
Message-Id: <141a1909a44af1dc6a1bead323ebb0ce5842403f.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:24 +0000
Subject: [PATCH 09/11] t7063: disable fsmonitor with status cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The status cache tests use GIT_TRACE_UNTRACKED_STATS to check very
detailed statistics related to how much Git actually checked for
untracked files. The fsmonitor feature changes the expected behavior
here, so disable the GIT_TEST_FSMONITOR environment variable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7063-status-untracked-cache.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..c433738a3a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -4,6 +4,9 @@ test_description='test untracked cache'
 
 . ./test-lib.sh
 
+# fsmonitor changes the expected behvaior of GIT_TRACE_UNTRACKED_STATS
+GIT_TEST_FSMONITOR=""
+
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
 # is updated lazily after contents in the directory changes, which
 # forces the untracked cache code to take the slow path.  A test
-- 
gitgitgadget

