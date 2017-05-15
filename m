Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DDD201CF
	for <e@80x24.org>; Mon, 15 May 2017 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754968AbdEOMth (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:49:37 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:33086 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdEOMtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:49:36 -0400
Received: by mail-it0-f53.google.com with SMTP id w68so9386464itc.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SncYdZH8zJfPuYNtW0dsiChZAnCnAiJPOIh2ObJwqr0=;
        b=nPt+hAs3hRCMNyGQB4BYg2dK1T8bn5CRQzHUnjat35tsyR/1dCZPMqRXSt/RjmvqbF
         Ad7QAjVUtudPnYSDdguxY+pHI4JGbNp0BSvxJbaJVBa8YNR244qTzLBcM/7/pntSvcD5
         rm2bdbszd280XHUwB+nhCkeHiJKKU66SQN+7fOsQp0YcCCJjEjj7ZSHz3kanPaQIqfzu
         Pe974gQjqANTBKoFDis2tEAlj4EU8pBrCJju498GWIdS6/U16F2Q420+QxX3xsAuJ6Rh
         vyExb5g97jyq4X6mpUx+CcQ5r/GZGKl4P76sS9J9EMth//BVZ/2EU+MuLA/4lMgpTp4G
         RXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SncYdZH8zJfPuYNtW0dsiChZAnCnAiJPOIh2ObJwqr0=;
        b=CWFiILYqVJZ5Z7Y4J9fWMLUPktcJVM0MGHxr2JbggbpzVPlPBuTSs6g3yGJToeqnWh
         KccX/7Z/Z1FI2dbct5yYWqULLB4UwtqlqPE/Rd7YvnrAKlJBoX4hHAbsxji92PeuxEOV
         nm+hbt8w2Eei3KQdkIfx/o88wzwF4nU6/55YTtluZF342C18H9K9N4EEJpq1VZ8qQS1h
         pv1wAw34WAP/MBtczSJm/Wma2NZLWi7MHL9Xxq7OGiQSpdFCrtg8wFGKRg1cUo9pv7Lz
         1e1p/12muEsOn7lCqERvmA3wbzn4AfpPJ3W6GECAcMfo7RNgx06Gd2l9uUlnL+kH11+c
         3BOQ==
X-Gm-Message-State: AODbwcCIKq0SnM1YxUVmkDKRz/lPbXlVUmkkWOW6xfvNrJV0X41oFTLf
        o99QwYwI05jCBFlmGBEwRYNUTRzMJQ==
X-Received: by 10.36.89.207 with SMTP id p198mr5054794itb.71.1494852574323;
 Mon, 15 May 2017 05:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 05:49:13 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 14:49:13 +0200
Message-ID: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
Subject: Git 2.13.0 segfaults on Solaris SPARC due to DC_SHA1=YesPlease being
 on by default
To:     Git Mailing List <git@vger.kernel.org>
Cc:     michael.kebe@gmail.com, Jeff King <peff@peff.net>,
        Marc Stevens <marc@marc-stevens.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 2.13.0 just running "git status" on a newly init'd repo on
Solaris SPARC[1] segfaults. Michael (CC'd) reported this issue on #git
and I helped him debug it.

Just compiling with BLK_SHA1=YesPlease solves the issue.

There are at least two different issues with DC_SHA1 here:

 * We don't properly detect that this platform is big endian. The
check at the top of sha1dc/sha1.c needs to test for _BIG_ENDIAN. This
comes from sys/isa_defs.h which (I'm told by #solaris) is included on
Solaris by default, at least by stdio.h.

Hacking the endian detection makes t0013-sha1dc.sh pass.

  * Even with that & the test passing just a plain "git init x && cd x
&& touch A && git add A && git commit" will segfault.

This is some bug in the sha1dc code, presumably some big endian issue
that's not resolved by the change above. Backtrace for that (censored
actual author info):

 Program received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 1 (LWP 1)]
 0x002f8c84 in sha1_compression_states (ihv=0xffbf8268, m=0x398ad5,
W=0xffbf82fc, states=0xffbf857c) at sha1dc/sha1.c:291
 291             SHA1COMPRESS_FULL_ROUND1_STEP_LOAD(a, b, c, d, e, m,
W, 0, temp);
 (gdb) bt
 #0  0x002f8c84 in sha1_compression_states (ihv=0xffbf8268,
m=0x398ad5, W=0xffbf82fc, states=0xffbf857c) at sha1dc/sha1.c:291
 #1  0x00300b60 in sha1_process (ctx=0xffbf8260, block=0x398ad5) at
sha1dc/sha1.c:1616
 #2  0x00301188 in SHA1DCUpdate (ctx=0xffbf8260,
     buf=0x398ad5 "deadbeefdeadbeefdeadbeefdeadbeefdeadbeef\nauthor Au
Thor <au.thor@example.com> 123456789 +0000\ncommitter Au Thor
<au.thor@example.com> 123456789
                  +0000\n\nBlah Blah"..., len=220)
     at sha1dc/sha1.c:1731
 #3  0x0030168c in git_SHA1DCUpdate (ctx=0xffbf8260, vdata=0x398aa0,
len=273) at sha1dc/sha1.c:1808
 #4  0x002a6f7c in write_sha1_file_prepare (buf=0x398aa0, len=273,
type=0x959c8 "commit", sha1=0xffbfd630 "",
     hdr=0xffbf8c28 "commit 273", hdrlen=0xffbf8c24) at sha1_file.c:3207
 #5  0x002a71ac in hash_sha1_file (buf=0x398aa0, len=273, type=0x959c8
"commit", sha1=0xffbfd630 "") at sha1_file.c:3266
 #6  0x002a25f8 in check_sha1_signature (sha1=0xffbfdbb8
"\375\067\356\337\002", map=0x398aa0, size=273, type=0x959c8 "commit")
     at sha1_file.c:1644
 #7  0x0022816c in parse_object (sha1=0xffbfdbb8
"\375\067\356\337\002") at object.c:269
 #8  0x0027c258 in get_reference (revs=0xffbfdc88, name=0xa87f0
"HEAD", sha1=0xffbfdbb8 "\375\067\356\337\002", flags=0)
     at revision.c:196
 #9  0x00284714 in setup_revisions (argc=0, argv=0x0, revs=0xffbfdc88,
opt=0xffbfdc74) at revision.c:2295
 #10 0x002ee4d8 in wt_status_collect_changes_index (s=0x348ea8
<s.24114>) at wt-status.c:585
 #11 0x002eeae8 in wt_status_collect (s=0x348ea8 <s.24114>) at wt-status.c:701
 #12 0x000db4fc in cmd_status (argc=0, argv=0xffbfe6fc, prefix=0x0) at
builtin/commit.c:1393
 #13 0x000acc24 in run_builtin (p=0x340ccc <commands+1200>, argc=1,
argv=0xffbfe6fc) at git.c:371
 #14 0x000acf98 in handle_builtin (argc=1, argv=0xffbfe6fc) at git.c:572
 #15 0x000ad1a4 in run_argv (argcp=0xffbfe66c, argv=0xffbfe670) at git.c:624
 #16 0x000ad3fc in cmd_main (argc=1, argv=0xffbfe6fc) at git.c:701
 #17 0x001747a0 in main (argc=5, argv=0xffbfe6ec) at common-main.c:43

1. Relevant part of uname -a: "SunOS <hostname> 5.11 11.3 sun4v sparc sun4v".
