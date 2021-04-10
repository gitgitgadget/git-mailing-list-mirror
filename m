Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D2CC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 03:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2878611AF
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 03:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDJDZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJDZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 23:25:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1CFC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 20:25:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso5888507pji.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 20:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tbRpkwbRUMElj9Wy5tw7wfWH7ZOG146+2kCdLMtdxDM=;
        b=qJAI5cqD5ci8AKEHTUJapJbyNVriJCg2LWNLyd10t22T1dxtzsmIIYm2gg5TZ2smyL
         722669OeV/JHl9t5MRuVUgR1uczriiQjPjYTmsRUaTzZtufd/jWduY79TWvZ9DLnXqKU
         2flFbkU5FzxojFeIAwLrlYmai/5ZwY+dAeMdEwFfgNzWGdkxrUlPJrs7f3nbldImXoz3
         KabNZ/MFuqx8chadbN0I19h7qGxYgs5ZtItOlCXQCI2uAhOuHbz2lqU2QZxGwQx3/X2i
         Iqjidx8Nl8VcaGQ3eBnI/8bNqxJOIM7Dbjm9n3m7+Ee6oaOzKoheyLwWXOD2KcVWqHK0
         fUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tbRpkwbRUMElj9Wy5tw7wfWH7ZOG146+2kCdLMtdxDM=;
        b=IIbK/IQTxSW1QQKYHK+9jBNsI1dDA+owKdEea5PiBCeQEjLfSJYeiktVLHrmmATtE5
         IunPD/MwtH4LLMvo7D3RLBrDXnAScZQDPU+mA5qwHvxF81VLf/j07Vw0pxe4iyzsIPvn
         bRLGg03C9MC7rnYCh+2zvUQCYo+C1L20iLh/6ZQSTcbUZ+BNwqbmVQB90hFfUIO233uQ
         SQOkPLcCX0wvFvJ2pT63IsYw3O/ekBQr7iyUWY3fh3r1vGSwk15jr/ibAYmaJ79+lMGB
         2alhWbBsenR/e7WHnwRedDioCGpvuEr0B88csyhAinpTrB65j5E/tXETPs62zwWPfCFg
         QUVA==
X-Gm-Message-State: AOAM532tGH8mzMcmXGO1HPAjacRxA3OOM8FDFKpINAasgeoKFuX7f4Dl
        7YIVFn1zxPPI0b9218DiJlZMNKi/dA5KsxcCSBq+cNch
X-Google-Smtp-Source: ABdhPJzdAI65duWOvEeMDS8ETQ2P4U1Z4hId0aJDOQpZ7U+c12e7hj1d3iqgGNP2YqSDZmpVy1jTvKmTMRL6Ik+c7FM=
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr16995705pjh.70.1618025123959;
 Fri, 09 Apr 2021 20:25:23 -0700 (PDT)
MIME-Version: 1.0
Sender: rcdailey@gmail.com
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 9 Apr 2021 22:25:13 -0500
X-Google-Sender-Auth: I5IXw9nMSB8R0O3Llvf-k2_VI-Y
Message-ID: <CAHd499A6XNPOPA+EA+TQKhkaH2ps5S7km-CGU+DdSA3vSVTmqQ@mail.gmail.com>
Subject: difftool and new files
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I do `git difftool -d @^^`, I get a left & right directory. My
understanding is that the left directory represents 2 commits worth of
diffs and the right one represents my "working copy".

In my case, my difftool is beyond compare 4 on Windows. In that
difftool, I have symlinks enabled. I also prefer this to avoid copies
when doing large diffs.

When I move changes to *existing* files from left to right, in other
words I'm modifying a file already in my working copy, those changes
are persisted when I close my difftool. This is working as expected.

However, let's say in my tip commit, I deleted a file. But since I'm
diffing further back, I can attempt to restore that deleted file to my
working copy by moving it from left to right. From Beyond Compare's
perspective, this particular file exists on the left, but not the
right side. My expectation is that when a new file is created on the
right, that that file appears in my working copy when I close the diff
tool. However, that is not the case. The file appears to be moved over
during the diff, but the result is not retained. The file is still
missing in my working copy and any changes I made to it in beyond
compare are seemingly lost.

I imagine this is working by design. It makes sense that git only
watches for changes *to existing files* in the temp directories. It
probably just ignores any files that were not originally on the right
side to begin with.

My ask here is to see if there is any way to get this to work as I
expect. It's convenient to be able to restore deleted files inside
difftool, so I'm wondering if this is possible somehow.
