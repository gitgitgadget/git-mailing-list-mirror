Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61353C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F161182
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 14:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIOA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDIOA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 10:00:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2CC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 07:00:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b4so9864963lfi.6
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea-ac-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HIyudkNOhpi7XGR/29zOXR4WYAwP0X90gLl2RtSPfnI=;
        b=htiVh6V+QKYx5oKe9KsCpMVMAfltoowYWyOU3q+uaPJvdO3UIkVAhV4pCLrEOnHSnG
         eG3WCPkIJ7HW/37mDbH3QWJzHmQxs+rjR/Bf17Bdmg0hdIqm6fqgHielof8oIfGnRgs3
         0LoDX6kXC2herfL2w8S3OTFAd7JWGgvKxkkgKv4MXY0cVgDhizIp6xhk6BPvWfDRAFbm
         xzhm8XzOrFgYp2Fc9J1GCdR6nKEFFln7nTiiGNj+secxMAElA42D1Ha3rJCcuoLWZ744
         NNRM46OJ3IcxbSFboaXjRfyG3fCgEs3WMtOERHW3m/AtTfl/dc2cZD2Tlr++VCUzzZyx
         ppJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HIyudkNOhpi7XGR/29zOXR4WYAwP0X90gLl2RtSPfnI=;
        b=ZLmaDKnLOCsXrXydDKhNn1a3ZiGvT1Z7DKGLnEPqNkKjZTKsv4WzptupKBD+ZK1DIN
         fTMLfYGv0qll6KI2xjoGRGY1WByLyS+XVPj29cmFTLAyL6iNfnlq6SU9LZ42BqnPQU+e
         BHkz8t1eVIk+dnnnBkBxE+2qm1gGNGnUpAMAvRdCf3Dw/IYlV8jzWWBCy57OpFDsBjw8
         450NxlBB0Xe8xuu/GooSWvcDdtg+8GC69wxXzTqNoqYCAb6K/aT7oPWNXkOfTZNrPFj+
         QkkcJWZVUcdNPU/3JHQ4MsLyL2KjAfmOXRYL8ZdYBMjVssRthXeEejKugHG3Iz7toDPw
         oxsQ==
X-Gm-Message-State: AOAM53241pzsBcKPj6dClw/bTtBwhKjDd2NK3D12vNhBmTrHKd//RGRB
        Q5XdnXHgh/nrYoRT8nd3F0/gUeGibtZ2B8RynCCAbK7b230zdA==
X-Google-Smtp-Source: ABdhPJwmbA/FYKya5uUw1ogsOW6QsqV4axvC8f08mBCXtNfZTF60Uto+7rbBk+nfzkhN1QU+Wl4DmaJaEZWDZ+R2aCo=
X-Received: by 2002:a05:6512:21c2:: with SMTP id d2mr10141467lft.424.1617976840813;
 Fri, 09 Apr 2021 07:00:40 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?4oCN7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvOygleyImOujjOyXsA==?=
         =?UTF-8?B?6rWsKOyerO2VmSkgLyDsu7Ttk6jthLDtlZnqs7wgXQ==?= 
        <seunghoonwoo@korea.ac.kr>
Date:   Fri, 9 Apr 2021 22:59:44 +0900
Message-ID: <CAPb83E_r-gx-zDU1eLwPLfC_Zd-4Hyb_x6t_s_pGHwfxuQ0+vQ@mail.gmail.com>
Subject: Possible memory leak bug reports for the latest "git" repository.
To:     git@vger.kernel.org
Cc:     hanjiyeon0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Development team.

Hi.
Recently, we discovered that the vulnerable code of CVE-2019-9169 is
included in the latest version (v2.31.1) of your source repository
(https://github.com/git/git).

Vulnerable file: git/compat/regex/regexec.c

Ref: CVE-2019-9169 (https://nvd.nist.gov/vuln/detail/CVE-2019-9169)

Original patch link:
https://sourceware.org/git/?p=glibc.git;a=blobdiff;f=posix/regexec.c;h=084b1222d95b62eb2930166060174ef78cb74b02;hp=91d5a797b82e2679ceab74238416de06693e46ea;hb=583dd860d5b833037175247230a328f0050dbfe9;hpb=2bac7daa58da1a313bd452369b0508b31e146637


Although the original vulnerability caused a heap-based buffer
over-read, the vulnerable code seems to cause a memory leak in your
repository.

Could you review whether this is a real vulnerability?

The below information shows our testing environments and results:

*****************************************************************************************
First test:

OS: Ubuntu 16.04.07 LTS
Git version: v2.31.1
Makefile config:

  1184 # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
  1185 # tweaked by config.* below as well as the command-line, both of
  1186 # which'll override these defaults.
  1187 CFLAGS = -g -O2 -Wall -fsanitize=address
  1188 LDFLAGS =

Result:

$ ./git-log -i '\(\(\)*.\)*\(\)\(\)\1'
fatal: your current branch 'master' does not have any commits yet
=================================================================
==27253==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff01de961 in realloc
(/usr/lib/x86_64-linux-gnu/libasan.so.2+0x98961)
    #1 0x843ee5 in xrealloc  /HDD/POC/CVE-2019-9169/git-2.31.1/wrapper.c:126

SUMMARY: AddressSanitizer: 65 byte(s) leaked in 1 allocation(s).
*****************************************************************************************


*****************************************************************************************
Second test:

OS: Ubuntu 18.04.5 LTS
Git version: v2.31.1
Makefile config: Default

Result:

$ printf xxxxxxxxxxxxxx |valgrind --leak-check=full ./git-log -i '\(\(\)*.\)*\1'
==63105== Memcheck, a memory error detector
==63105== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==63105== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
==63105== Command: ./git-log -i \\(\\(\\)*.\\)*\\1
==63105==
==63105==
==63105== HEAP SUMMARY:
==63105==     in use at exit: 118,368,930 bytes in 76,720 blocks
==63105==   total heap usage: 463,994 allocs, 387,274 frees,
2,273,364,625 bytes allocated
==63105==
==63105== 40 bytes in 1 blocks are possibly lost in loss record 38 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
==63105==    by 0x355BB5: chdir_notify_reparent (chdir-notify.c:48)
==63105==    by 0x2D5DC6: packed_ref_store_create (packed-backend.c:207)
==63105==    by 0x2D02BA: files_ref_store_create (files-backend.c:96)
==63105==    by 0x2CC295: get_main_ref_store (refs.c:1900)
==63105==    by 0x2E969D: handle_revision_pseudo_opt (revision.c:2578)
==63105==    by 0x2E969D: setup_revisions (revision.c:2730)
==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 40 bytes in 1 blocks are possibly lost in loss record 39 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
==63105==    by 0x355BB5: chdir_notify_reparent (chdir-notify.c:48)
==63105==    by 0x2D02D6: files_ref_store_create (files-backend.c:99)
==63105==    by 0x2CC295: get_main_ref_store (refs.c:1900)
==63105==    by 0x2E969D: handle_revision_pseudo_opt (revision.c:2578)
==63105==    by 0x2E969D: setup_revisions (revision.c:2730)
==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 40 bytes in 1 blocks are possibly lost in loss record 40 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
==63105==    by 0x355BB5: chdir_notify_reparent (chdir-notify.c:48)
==63105==    by 0x2D02E6: files_ref_store_create (files-backend.c:100)
==63105==    by 0x2CC295: get_main_ref_store (refs.c:1900)
==63105==    by 0x2E969D: handle_revision_pseudo_opt (revision.c:2578)
==63105==    by 0x2E969D: setup_revisions (revision.c:2730)
==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 65 bytes in 1 blocks are definitely lost in loss record 59 of 142
==63105==    at 0x4C31A3F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x4C33D84: realloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x340345: xrealloc (wrapper.c:126)
==63105==    by 0x30B93A: strbuf_grow (strbuf.c:98)
==63105==    by 0x30C8EC: strbuf_vaddf (strbuf.c:392)
==63105==    by 0x30CA33: strbuf_addf (strbuf.c:333)
==63105==    by 0x2A9700: preprocess_options (parse-options.c:666)
==63105==    by 0x2A9700: parse_options (parse-options.c:847)
==63105==    by 0x18053E: cmd_log_init_finish (log.c:199)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 84 (56 direct, 28 indirect) bytes in 1 blocks are definitely
lost in loss record 61 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x2AE9C0: copy_pathspec (pathspec.c:664)
==63105==    by 0x2E993A: setup_revisions (revision.c:2844)
==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 84 (56 direct, 28 indirect) bytes in 1 blocks are definitely
lost in loss record 62 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x2AE9C0: copy_pathspec (pathspec.c:664)
==63105==    by 0x2E996A: setup_revisions (revision.c:2849)
==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 191 (112 direct, 79 indirect) bytes in 1 blocks are
definitely lost in loss record 76 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x2AE381: parse_pathspec (pathspec.c:582)
==63105==    by 0x2E9164: setup_revisions (revision.c:2800)
==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 464 (448 direct, 16 indirect) bytes in 28 blocks are
definitely lost in loss record 98 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x217A3D: commit_list_insert (commit.c:554)
==63105==    by 0x217A3D: parse_commit_buffer (commit.c:447)
==63105==    by 0x296F37: parse_object_buffer (object.c:217)
==63105==    by 0x297070: parse_object (object.c:282)
==63105==    by 0x274781: add_ref_decoration (log-tree.c:179)
==63105==    by 0x2D5C53: do_for_each_repo_ref_iterator (iterator.c:418)
==63105==    by 0x2CB9F8: do_for_each_ref (refs.c:1492)
==63105==    by 0x274A65: load_ref_decorations (log-tree.c:211)
==63105==    by 0x1807C9: cmd_log_init_finish (log.c:262)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==
==63105== 37,468 (32 direct, 37,436 indirect) bytes in 1 blocks are
definitely lost in loss record 120 of 142
==63105==    at 0x4C33B25: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x3403AD: xcalloc (wrapper.c:140)
==63105==    by 0x1806F4: cmd_log_init_finish (log.c:233)
==63105==    by 0x18241F: cmd_log_init (log.c:275)
==63105==    by 0x18241F: cmd_log (log.c:754)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==    by 0x1289A4: cmd_main (git.c:872)
==63105==    by 0x127467: main (common-main.c:52)
==63105==
==63105== 184,176 (183,792 direct, 384 indirect) bytes in 11,487
blocks are definitely lost in loss record 130 of 142
==63105==    at 0x4C31B0F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
==63105==    by 0x217A3D: commit_list_insert (commit.c:554)
==63105==    by 0x217A3D: parse_commit_buffer (commit.c:447)
==63105==    by 0x217CEC: repo_parse_commit_internal (commit.c:498)
==63105==    by 0x2E4C3D: repo_parse_commit (commit.h:89)
==63105==    by 0x2E4C3D: try_to_simplify_commit (revision.c:1007)
==63105==    by 0x2E84AA: process_parents (revision.c:1140)
==63105==    by 0x2EBFED: get_revision_1 (revision.c:3999)
==63105==    by 0x2EC1BF: get_revision_internal (revision.c:4113)
==63105==    by 0x2EC344: get_revision (revision.c:4187)
==63105==    by 0x181538: cmd_log_walk (log.c:422)
==63105==    by 0x182427: cmd_log (log.c:755)
==63105==    by 0x12781D: run_builtin (git.c:453)
==63105==    by 0x12781D: handle_builtin (git.c:704)
==63105==
==63105== LEAK SUMMARY:
==63105==    definitely lost: 184,561 bytes in 11,520 blocks
==63105==    indirectly lost: 37,971 bytes in 1,139 blocks
==63105==      possibly lost: 120 bytes in 3 blocks
==63105==    still reachable: 118,146,278 bytes in 64,058 blocks
==63105==         suppressed: 0 bytes in 0 blocks
==63105== Reachable blocks (those to which a pointer was found) are not shown.
==63105== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==63105==
==63105== For counts of detected and suppressed errors, rerun with: -v
==63105== ERROR SUMMARY: 10 errors from 10 contexts (suppressed: 0 from 0)
*****************************************************************************************

Thank you.
Best regards,
Seunghoon Woo, Jiyeon Han

-- 

Best regards,

Seunghoon Woo
Korea University Dept. of Computer Science and Engineering
Computer & Communication Security Lab.
seunghoonwoo@korea.ac.kr
(+82)10-8147-9308
