Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300801F404
	for <e@80x24.org>; Mon,  9 Apr 2018 23:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeDIXfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 19:35:32 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:39318 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbeDIXfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 19:35:30 -0400
Received: by mail-yw0-f177.google.com with SMTP id q66so3418126ywg.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gdh6l+T3aOuAG0J/NZy3Q6Zr1h/E4P6gy2e0c0LFoC4=;
        b=tBDfbnq2z5MxNLF/cEXQDtTGZN2q2dDd/IWlOiS034QKkoeL4tWcvXRqmERy2YBSbp
         QnqI96X9pM3X3rfgRMV4ujzDQ4qBU40Y4VKeH1u/bivMzrTUdkzkD/HJC8AHpUy1iYus
         YGBufk69xSmuGRqx9444NiVEr67MNOsAMkvZ6MjfGLQQz5qpGE6+qcmpH7dfC4v2zeyM
         2+l8v5JjNxl1kdkvLEbjqeB1OP5p97DFMdXMfTcGOt/gHNdhZYCI91nHdhtvWvPvKiQm
         HrhMAkmBwDqOr9IuwLIqDlIBQVM2Pkt9CStIPqAg29kYDBQvA5GmVDkBfxzlifOSHByu
         imwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gdh6l+T3aOuAG0J/NZy3Q6Zr1h/E4P6gy2e0c0LFoC4=;
        b=KsiRz7XuuWe8BJ7sO0QmjUBq2EJirLYElsKaSxl56ZKidyjDZZmXmIyn4mPfONn2c9
         7ndC9kgzn3JmwYrYUulEVvtMsCEo4z4cWCn9d4ckRL0f5aCZTjAkiLDxRwA6umGhTa1+
         ZLiYcRUuzNNl90QeWjBwfs/++ibT2LZ0Oa0pvYW948bm9bPr1u6qfEcxYhNJdeSUTor/
         YInAXzSHFptYPTVew0sA9Zn+tAoNvIII68B54k2MRCMphhr03/8XQRFzUmfFS7lipekO
         FiW1XPftZCyzWY6CSolHX3ajstXHU34CY1j2840cOy68gVfL+z4QjJNR2NLseLlRTnkD
         r+3A==
X-Gm-Message-State: ALQs6tD0m3Rmiu0uBGcdoxIdMgKr9y4+zwtZwOigULzOdCkwCxRsNJmO
        1AHkrhQsKxiFa1TkaMz7fVd52C4+LdeQzWDuiMbZDQ==
X-Google-Smtp-Source: AIpwx4/U9OaUu3oJi7Fdd9BNJPhOkkfoK7Ety75sCwBX4lb+SjNfAWwvSPdj7TIoiEdSbK2kVxiWd76eWujMFuXdg3Q=
X-Received: by 10.129.86.5 with SMTP id k5mr12313284ywb.345.1523316589374;
 Mon, 09 Apr 2018 16:29:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 16:29:48 -0700 (PDT)
In-Reply-To: <20180409232416.GA102627@google.com>
References: <20180406232136.253950-1-sbeller@google.com> <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-13-sbeller@google.com> <20180409232416.GA102627@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 16:29:48 -0700
Message-ID: <CAGZ79kYWb=AXCBRodnoYbf9s5HP9Tf-yUoMHjMKm4tTrXa4Bgw@mail.gmail.com>
Subject: Re: [PATCH 12/16] refs: store the main ref store inside the
 repository struct
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Mon, Apr 9, 2018 at 4:24 PM, Brandon Williams <bmwill@google.com> wrote:

>> -     main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
>> -     return main_ref_store;
>> +     r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
>> +     return r->main_ref_store;
>
> I assume that since this takes in a git dir as a parameter
> that the ref-store is in a good enough place to be embedded in a
> repository struct (as in this would work with an arbitrary repo)?

That is my current understanding.

As the refs code can also take a path into a submodule and construct
a submodule ref store for the caller, we'd want to resolve the tension
between the ref store and the repository struct who is responsible for
the submodule ref store eventually by removing the submodule
functionality from the ref store and only relying on the ref stores created by
the repository struct.
