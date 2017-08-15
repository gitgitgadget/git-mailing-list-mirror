Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868F8208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbdHOMxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:54 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33210 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbdHOMxw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:52 -0400
Received: by mail-wm0-f50.google.com with SMTP id k20so23464387wmg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FC3H8i26DMZeQyMDnTyzFjie+91DaA+cc7FUJG8JGJg=;
        b=OFFHI6/I1k/U5F89xw1CmBrnngi0kaeVDe0k8vSg7byWks1qOEfZrfLXBTZfj3N6xv
         34kOorYsYsFNBmKYWRBsVGd5yKMuf0kc4Cbbc8Um+6xTpmv9G9Gq0uGkgi1LRuiIvLfO
         S4n1pQYBsVoyfKZhbPM5m8X8UfYKmXtXWKe7qMKFPaT/hn0J5UhsZoXZ1x2sx6mdY2n/
         7nmhXkNHDtNvTstZ7fA/UxphTzQr0ot7OKXKxy/ZWOp4edXNQIe31zRc259jKaod83nA
         HOnw1OJK+OomLknaHOpZoOQ6nThObKXgdsgRowmU09ByrcBb3drT5whfu/j09ZKFtmAr
         5sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FC3H8i26DMZeQyMDnTyzFjie+91DaA+cc7FUJG8JGJg=;
        b=e2WGTrjKZWa7nkM7HogBzOqXwq5g8K0wiEWhz4xPh/ga1NvcY5NJWiwutvU6MTk7KD
         lsj4naqXsIH0zfLwpIr94/FEl85ZRcgDtPDctxdtzZVRJ5/2u55P8vZpMsf4pNNnWF8X
         YM/96n6vzAtvD30K5vKqtDaHwGU07CTv387Y+jcgZXP8VT4BcyQ5c/67sPIK+q4ly7x2
         9W+NHfUCo/7rwBpEUweXPxoa/1StD3DGw5C/ErIr8x8q2GwccpxqJXPDs/XUK8NtOb1M
         9u60PXbHkKuCvKlohYCQ6OfZl/f5ZILGtl/SOyD7pwejM8wVe0QZFvI1kHaMr8pg+1YX
         lq+Q==
X-Gm-Message-State: AHYfb5hzX44CQYrE4yEpdTcra83LlMSSIRTQy2jz1DhNCpv6WIDAxDjR
        SXrfmzAA0VU1Gx3O
X-Received: by 10.28.140.67 with SMTP id o64mr1380916wmd.111.1502801630630;
        Tue, 15 Aug 2017 05:53:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:49 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: tsan: t5400: set_try_to_free_routine
Date:   Tue, 15 Aug 2017 14:53:07 +0200
Message-Id: <939b37f809dd9e1526593c02154fae14b369c73a.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using SANITIZE=thread made t5400-send-pack.sh hit the potential race
below.

This is set_try_to_free_routine in wrapper.c. The race relates to the
reading of the "old" value. The caller doesn't care about the "old"
value, so this should be harmless right now. But it seems that using
this mechanism from multiple threads and restoring the earlier value
will probably not work out every time. (Not necessarily because of the
race in set_try_to_free_routine, but, e.g., because callers might not
restore the function pointer in the reverse order of how they
originally set it.)

Properly "fixing" this for thread-safety would probably require some
redesigning, which at the time might not be warranted. I'm just posting
this for completeness.

Martin

WARNING: ThreadSanitizer: data race (pid=21382)
  Read of size 8 at 0x000000979970 by thread T1:
    #0 set_try_to_free_routine wrapper.c:35 (git+0x0000006cde1c)
    #1 prepare_trace_line trace.c:105 (git+0x0000006a3bf0)
    #2 trace_strbuf_fl trace.c:185 (git+0x0000006a3bf0)
    #3 packet_trace pkt-line.c:80 (git+0x0000005f9f43)
    #4 packet_read pkt-line.c:309 (git+0x0000005fbe10)
    #5 recv_sideband sideband.c:37 (git+0x000000684c5e)
    #6 sideband_demux send-pack.c:216 (git+0x00000065a38c)
    #7 run_thread run-command.c:933 (git+0x000000655a93)
    #8 <null> <null> (libtsan.so.0+0x0000000230d9)

  Previous write of size 8 at 0x000000979970 by main thread:
    #0 set_try_to_free_routine wrapper.c:38 (git+0x0000006cde39)
    #1 prepare_trace_line trace.c:105 (git+0x0000006a3bf0)
    #2 trace_strbuf_fl trace.c:185 (git+0x0000006a3bf0)
    #3 packet_trace pkt-line.c:80 (git+0x0000005f9f43)
    #4 packet_read pkt-line.c:324 (git+0x0000005fc0bb)
    #5 packet_read_line_generic pkt-line.c:332 (git+0x0000005fc0bb)
    #6 packet_read_line pkt-line.c:342 (git+0x0000005fc0bb)
    #7 receive_unpack_status send-pack.c:149 (git+0x00000065c1e4)
    #8 send_pack send-pack.c:581 (git+0x00000065c1e4)
    #9 git_transport_push transport.c:574 (git+0x0000006ab2c1)
    #10 transport_push transport.c:1068 (git+0x0000006ae5d5)
    #11 push_with_options builtin/push.c:336 (git+0x00000049d580)
    #12 do_push builtin/push.c:419 (git+0x00000049f57d)
    #13 cmd_push builtin/push.c:591 (git+0x00000049f57d)
    #14 run_builtin git.c:330 (git+0x00000040949e)
    #15 handle_builtin git.c:538 (git+0x00000040949e)
    #16 run_argv git.c:590 (git+0x000000409a0e)
    #17 cmd_main git.c:667 (git+0x000000409a0e)
    #18 main common-main.c:43 (git+0x0000004079d1)

  Location is global 'try_to_free_routine' of size 8 at 0x000000979970 (git+0x000000979970)

  Thread T1 (tid=21405, running) created by main thread at:
    #0 pthread_create <null> (libtsan.so.0+0x000000027577)
    #1 start_async run-command.c:1130 (git+0x0000006582e7)
    #2 send_pack send-pack.c:562 (git+0x00000065b7c8)
    #3 git_transport_push transport.c:574 (git+0x0000006ab2c1)
    #4 transport_push transport.c:1068 (git+0x0000006ae5d5)
    #5 push_with_options builtin/push.c:336 (git+0x00000049d580)
    #6 do_push builtin/push.c:419 (git+0x00000049f57d)
    #7 cmd_push builtin/push.c:591 (git+0x00000049f57d)
    #8 run_builtin git.c:330 (git+0x00000040949e)
    #9 handle_builtin git.c:538 (git+0x00000040949e)
    #10 run_argv git.c:590 (git+0x000000409a0e)
    #11 cmd_main git.c:667 (git+0x000000409a0e)
    #12 main common-main.c:43 (git+0x0000004079d1)

SUMMARY: ThreadSanitizer: data race wrapper.c:35 set_try_to_free_routine

