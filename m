Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B951F462
	for <e@80x24.org>; Tue, 21 May 2019 21:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfEUV0M (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 17:26:12 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:38489 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfEUV0M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 17:26:12 -0400
Received: by mail-ed1-f44.google.com with SMTP id w11so457758edl.5
        for <git@vger.kernel.org>; Tue, 21 May 2019 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z1nLmTKZOwKZpYe8Cz5GsZT7WfmQQJSoyCFYyDHq2yU=;
        b=L4mDvh4Evuu5oeuS8nOQmXKxkDYzphZbYlW2nzfMv9/hK4rxHDqNhrBlUeEbYmI1Jn
         G9/XVlN1P0LZ85/qxsy9ixhbuAYKmNL7C+YDhAF4GHIWbJm6AZ8kau6HZo8znaWw4J99
         R7A3eG0NkFLEPwOQJvOchT4eTkT6QjlAfSdCU2uNgcBOsYyb1FwKqO3KxVcHSryZuo2n
         mjYOvdxkWMtiRLVSPHHf7tEpfoeG8WGrACq4OP9FRua8Mau8jeA6kNTCXSjPM6s4dr4I
         QUcl7BhArcFuR9sGOAGlDf7cCqWMTo3KDF+Gj6emHrRdZqeG75MpQEk5U8EvBK6McUah
         Ccvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z1nLmTKZOwKZpYe8Cz5GsZT7WfmQQJSoyCFYyDHq2yU=;
        b=RABXMSBXdWSKypDIQ/kDfeNaJ83ROTQjnxoP+M4l200kONIUTE1UNYFzf1pspcIQnS
         XAAcdbyTV2poWVs6BGXgseFAdwW5ggSLD+LBGfjUg8DLY+twPQlD3eq6/L6BQbrEnUKt
         ILepOidnrkalc37cvC2kopM+Rav8DBCh2Ac8wAGkn/Nkwwem5Hd+EWr0a+ny6ejen9AN
         RlNNLkF65riHR6XS7QeHRZlnLHG7/TkPRxW87M3QL3HjRnVOFrB6AccX1spMNB6LClf0
         WFpheawid+Efov6W9md6kc4XxpXh2vnpcrd2zr4lyU7o/wPv9CEHeWtYvJ2AyYZcHV1S
         AaRg==
X-Gm-Message-State: APjAAAWbPSs+soaKUfyEqA44V8gLnFTn7U5tf6UbIOzooSTlivpzVGQb
        62huglbjvmAtitYsX6SgSq5kj5O3yRs6qf8OwEYIgGM4lY0=
X-Google-Smtp-Source: APXvYqxALLonKgjvrLJb2MeXQ8PqpuO3qsJVr6bYNec43cXIhgfvMe7G2UrSvH+feuUIB3T+yvX3BEdozV7CyvQldIo=
X-Received: by 2002:a17:906:1483:: with SMTP id x3mr36225311ejc.90.1558473969896;
 Tue, 21 May 2019 14:26:09 -0700 (PDT)
MIME-Version: 1.0
From:   Keith Thompson <Keith.S.Thompson@gmail.com>
Date:   Tue, 21 May 2019 14:25:57 -0700
Message-ID: <CAAHpriPYxFv=vET92DonRb=kV_NWEDFe0nRnNH2wxcwP78BDdA@mail.gmail.com>
Subject: Slightly confusing documentation for "git clone --recursive"
To:     git@vger.kernel.org
Cc:     Keith Thompson <Keith.S.Thompson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/clone.c, the handling of "--recursive" as an alias for
"--recurse-submodules" changed between
v2.22.0-rc0 and v2.22.0-rc1. This report refers to the way it's
documented in the newest version
and suggests some improvements.

The short help (git clone -h) says:

    --recursive[=<pathspec>]
                          initialize submodules in the clone
    --recurse-submodules[=<pathspec>]
                          initialize submodules in the clone

It repeats the same description, but doesn't explicitly say that
they're equivalent. I can imagine
this causing some confusion. I might have wondered if there's some
subtle difference between them.
Suggested change:

    --recursive[=<pathspec>]
    --recurse-submodules[=<pathspec>]
                          initialize submodules in the clone

The long help ("git clone --help") says:

       --recurse-submodules[=<pathspec]
           After the clone is created, initialize and clone submodules within
           based on the provided pathspec. If no pathspec is provided, all
           submodules are initialized and cloned. This option can be given
           multiple times for pathspecs consisting of multiple entries. The
           resulting clone has submodule.active set to the provided pathspec,
           or "." (meaning all submodules) if no pathspec is provided.

           Submodules are initialized and cloned using their default settings.
           This is equivalent to running git submodule update --init
           --recursive <pathspec> immediately after the clone is finished.
           This option is ignored if the cloned repository does not have a
           worktree/checkout (i.e. if any of --no-checkout/-n, --bare, or
           --mirror is given)

The "--recursive" spelling is not documented, but is used in an example in
the documentation for "--recursive-submodules". Suggested change:

       --recursive=<pathspec]
       --recurse-submodules[=<pathspec]
           After the clone is created, initialize and clone submodules within
           [... rest of description as before]
