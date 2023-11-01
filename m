Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946ED134A3
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClKdgXA4"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FE9B7
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:03:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5210a1515so97367301fa.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698843812; x=1699448612; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI7BSQ9eutWEFYErd1eSzNCJ99F+y4CKHnqm0krvW64=;
        b=ClKdgXA44tV2KfxfQOVKc34Jg/xz7q2qjIXVWmrQfMpGcP0+3cyot8f57YUBTu4QLD
         qIhiHaLuNHlizsYqpgacsbYBCe/hs4Av/UrZ6fpAS2L6VoOLvadR6x7p0l5hqPzXrOp3
         mjSe1b2rmk2/PBc0ohizl/KZy7d+g32wBKtIC68sN5AiajllqZA6n6Hc13CPq/F9XfNk
         rrjQXUfQsHpArKjbnVluLlpSO/PSVhxOtmWznUxxWdubdf7v5Y6adB/hI4nx5ieco5H+
         D8tgm9kiNeJ4GcHLKHjsfAylhdQyX6fX+7Q4Y7XQYFc1ZjpiOT4zyGiPwSxsDlHXPRdm
         EfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843812; x=1699448612;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HI7BSQ9eutWEFYErd1eSzNCJ99F+y4CKHnqm0krvW64=;
        b=NKh2V5ZA0YpJsDbe5JUsL6Kh56BrtCiq73RZVh5tOhBeoMQCJXrLo5zNez7ELT1gZv
         MRLfnEUraIvK8wB6Q8FdCG4usMEfAl49ndpuYQNjnOJCm+t/gfOpt8vQglDGA9iPQsNI
         4e/egq1OFI/5m9yHOtTPtNaBcKSFzw+phpoS4y1yBsYJBAupDNOtZdWhSqENTeMza9GK
         yn6TFbL+rDjxkNXR6nF9eWJWCrAbOkRS2OqgTJ2BhWsddLNEJ2SOoewZ0EXNxLMljz7X
         iJ5cpWNH4xkKlHR1JK3c4QuW+z4KoMs47p+h63FGAa3yCZiIKixGQMYeJSoWGjHOYgt2
         RnHQ==
X-Gm-Message-State: AOJu0YzdER6fJ3tuE7gEtf1I/G8WFNVAbqzRnHB03oZoB/d8o091ch22
	TJ3WjRgc0f5MQ5iNwWgWj64M+vTOcWc=
X-Google-Smtp-Source: AGHT+IFHrEvM62AvjGIZs0KgI2szeuGWwJIhAuF0ZacBn9bHruIJb/KpI9b0nZf+gYM0jO+F6wgUJA==
X-Received: by 2002:a2e:9116:0:b0:2c5:56b:cbd1 with SMTP id m22-20020a2e9116000000b002c5056bcbd1mr12217442ljg.10.1698843811931;
        Wed, 01 Nov 2023 06:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b004053e9276easm1473210wms.32.2023.11.01.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:03:31 -0700 (PDT)
Message-ID: <pull.1604.v2.git.1698843810814.gitgitgadget@gmail.com>
In-Reply-To: <pull.1604.git.1698680732691.gitgitgadget@gmail.com>
References: <pull.1604.git.1698680732691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Nov 2023 13:03:30 +0000
Subject: [PATCH v2] max_tree_depth: lower it for MSVC to avoid stack overflows
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There seems to be some internal stack overflow detection in MSVC's
`malloc()` machinery that seems to be independent of the `stack reserve`
and `heap reserve` sizes specified in the executable (editable via
`EDITBIN /STACK:<n> <exe>` and `EDITBIN /HEAP:<n> <exe>`).

In the newly test cases added by `jk/tree-name-and-depth-limit`, this
stack overflow detection is unfortunately triggered before Git can print
out the error message about too-deep trees and exit gracefully. Instead,
it exits with `STATUS_STACK_OVERFLOW`. This corresponds to the numeric
value -1073741571, something the MSYS2 runtime we sadly need to use to
run Git's test suite cannot handle and which it internally maps to the
exit code 127. Git's test suite, in turn, mistakes this to mean that the
command was not found, and fails both test cases.

Here is an example stack trace from an example run:

    [0x0]   ntdll!RtlpAllocateHeap+0x31   0x4212603f50   0x7ff9d6d4cd49
    [0x1]   ntdll!RtlpAllocateHeapInternal+0x6c9   0x42126041b0   0x7ff9d6e14512
    [0x2]   ntdll!RtlDebugAllocateHeap+0x102   0x42126042b0   0x7ff9d6dcd8b0
    [0x3]   ntdll!RtlpAllocateHeap+0x7ec70   0x4212604350   0x7ff9d6d4cd49
    [0x4]   ntdll!RtlpAllocateHeapInternal+0x6c9   0x42126045b0   0x7ff9596ed480
    [0x5]   ucrtbased!heap_alloc_dbg_internal+0x210   0x42126046b0   0x7ff9596ed20d
    [0x6]   ucrtbased!heap_alloc_dbg+0x4d   0x4212604750   0x7ff9596f037f
    [0x7]   ucrtbased!_malloc_dbg+0x2f   0x42126047a0   0x7ff9596f0dee
    [0x8]   ucrtbased!malloc+0x1e   0x42126047d0   0x7ff730fcc1ef
    [0x9]   git!do_xmalloc+0x2f   0x4212604800   0x7ff730fcc2b9
    [0xa]   git!do_xmallocz+0x59   0x4212604840   0x7ff730fca779
    [0xb]   git!xmallocz_gently+0x19   0x4212604880   0x7ff7311b0883
    [0xc]   git!unpack_compressed_entry+0x43   0x42126048b0   0x7ff7311ac9a4
    [0xd]   git!unpack_entry+0x554   0x42126049a0   0x7ff7311b0628
    [0xe]   git!cache_or_unpack_entry+0x58   0x4212605250   0x7ff7311ad3a8
    [0xf]   git!packed_object_info+0x98   0x42126052a0   0x7ff7310a92da
    [0x10]   git!do_oid_object_info_extended+0x3fa   0x42126053b0   0x7ff7310a44e7
    [0x11]   git!oid_object_info_extended+0x37   0x4212605460   0x7ff7310a38ba
    [0x12]   git!repo_read_object_file+0x9a   0x42126054a0   0x7ff7310a6147
    [0x13]   git!read_object_with_reference+0x97   0x4212605560   0x7ff7310b4656
    [0x14]   git!fill_tree_descriptor+0x66   0x4212605620   0x7ff7310dc0a5
    [0x15]   git!traverse_trees_recursive+0x3f5   0x4212605680   0x7ff7310dd831
    [0x16]   git!unpack_callback+0x441   0x4212605790   0x7ff7310b4c95
    [0x17]   git!traverse_trees+0x5d5   0x42126058a0   0x7ff7310dc0f2
    [0x18]   git!traverse_trees_recursive+0x442   0x4212605980   0x7ff7310dd831
    [0x19]   git!unpack_callback+0x441   0x4212605a90   0x7ff7310b4c95
    [0x1a]   git!traverse_trees+0x5d5   0x4212605ba0   0x7ff7310dc0f2
    [0x1b]   git!traverse_trees_recursive+0x442   0x4212605c80   0x7ff7310dd831
    [0x1c]   git!unpack_callback+0x441   0x4212605d90   0x7ff7310b4c95
    [0x1d]   git!traverse_trees+0x5d5   0x4212605ea0   0x7ff7310dc0f2
    [0x1e]   git!traverse_trees_recursive+0x442   0x4212605f80   0x7ff7310dd831
    [0x1f]   git!unpack_callback+0x441   0x4212606090   0x7ff7310b4c95
    [0x20]   git!traverse_trees+0x5d5   0x42126061a0   0x7ff7310dc0f2
    [0x21]   git!traverse_trees_recursive+0x442   0x4212606280   0x7ff7310dd831
    [...]
    [0xfad]   git!cmd_main+0x2a2   0x42126ff740   0x7ff730fb6345
    [0xfae]   git!main+0xe5   0x42126ff7c0   0x7ff730fbff93
    [0xfaf]   git!wmain+0x2a3   0x42126ff830   0x7ff731318859
    [0xfb0]   git!invoke_main+0x39   0x42126ff8a0   0x7ff7313186fe
    [0xfb1]   git!__scrt_common_main_seh+0x12e   0x42126ff8f0   0x7ff7313185be
    [0xfb2]   git!__scrt_common_main+0xe   0x42126ff960   0x7ff7313188ee
    [0xfb3]   git!wmainCRTStartup+0xe   0x42126ff990   0x7ff9d5ed257d
    [0xfb4]   KERNEL32!BaseThreadInitThunk+0x1d   0x42126ff9c0   0x7ff9d6d6aa78
    [0xfb5]   ntdll!RtlUserThreadStart+0x28   0x42126ff9f0   0x0

I verified manually that `traverse_trees_cur_depth` was 562 when that
happened, which is far below the 2048 that were already accepted into
Git as a hard limit.

Despite many attempts to figure out which of the internals trigger this
`STATUS_STACK_OVERFLOW` and how to maybe increase certain sizes to avoid
running into this issue and let Git behave the same way as under Linux,
I failed to find any build-time/runtime knob we could turn to that
effect.

Note: even switching to using a different allocator (I used mimalloc
because that's what Git for Windows uses for its GCC builds) does not
help, as the zlib code used to unpack compressed pack entries _still_
uses the regular `malloc()`. And runs into the same issue.

Note also: switching to using a different allocator _also_ for zlib code
seems _also_ not to help. I tried that, and it still exited with
`STATUS_STACK_OVERFLOW` that seems to have been triggered by a
`mi_assert_internal()`, i.e. an internal assertion of mimalloc...

So the best bet to work around this for now seems to just lower the
maximum allowed tree depth _even further_ for MSVC builds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix t6700.[45] in win+VS test
    
    These two test cases have been failing for a while in Git for Windows'
    shears/* branches. Took a good while to figure out, too.
    
    Changes since v1:
    
     * Rewrite the patch to instead lower the max_allowed_tree_depth
       threshold even further for MSVC, side-stepping the stack overflow.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1604%2Fdscho%2Ffix-vs-win-test-with-new-depth-limit-test-cases-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1604/dscho/fix-vs-win-test-with-new-depth-limit-test-cases-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1604

Range-diff vs v1:

 1:  0e6e53bd824 < -:  ----------- tests: handle "funny" exit code 127 produced by MSVC-compiled exes
 -:  ----------- > 1:  5f738a78eb1 max_tree_depth: lower it for MSVC to avoid stack overflows


 environment.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index bb3c2a96a33..9e37bf58c0c 100644
--- a/environment.c
+++ b/environment.c
@@ -81,7 +81,20 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
-int max_allowed_tree_depth = 2048;
+int max_allowed_tree_depth =
+#ifdef _MSC_VER
+	/*
+	 * When traversing into too-deep trees, Visual C-compiled Git seems to
+	 * run into some internal stack overflow detection in the
+	 * `RtlpAllocateHeap()` function that is called from within
+	 * `git_inflate_init()`'s call tree. The following value seems to be
+	 * low enough to avoid that by letting Git exit with an error before
+	 * the stack overflow can occur.
+	 */
+	512;
+#else
+	2048;
+#endif
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0

base-commit: 3130c155df9a65ebccf128b4af5a19af49532580
-- 
gitgitgadget
