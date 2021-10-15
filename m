Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C36C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD07760F6F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbhJORzW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 15 Oct 2021 13:55:22 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35705 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhJORzV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:55:21 -0400
Received: by mail-ed1-f43.google.com with SMTP id w19so40937516edd.2
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pr9wbVWpSn9MegpMbzw3G1WTw4iO6mOio8TZn9Gx2H4=;
        b=FLKqiOmkYInOr9sigfzrwe1dryCgigAuzHarCYYYsEVTfxdnA/s4Y4D/73QAauPrDi
         K5KB0euCT5y85zWLWtQsUBCITibkq/wvoPXcVTaufleg2WtFeiVIFZvlq+sfeHJTufvM
         EhsWrR5pCFjNoCkKKzlYZb2RdSzs4U9fHEyV53W1ETcLExieGtycFt3l3CJMq+KS2UEA
         B+QedZokJviW9kt3KvvTWKsUq0LBKujZl7nBmZzNTrkhUehOGr5g0En8qWmtsQ66xJFg
         X1p3uOjhDLuwiCrPcrZsU7pJxc8e890VeILaX2u+U8yjW8Pl3p5womwQG3KCLmiRVwHl
         bSGw==
X-Gm-Message-State: AOAM533/xtnPt2OfxhCQY1Ye0ZKAi+W197kQ5V/k/31Rjtf66leUfk0B
        IwF55MXHjrWY7UTaqT8doIgLS+B+tkzd3gbENAM=
X-Google-Smtp-Source: ABdhPJzxMYGpYFCNDEIfhOcIcktU/XQ15Qw+LfsIHjaxwydSBZOaGX6PSTsx+LgJtzfpcIs5NopyTOj8AwoyzP5xKpw=
X-Received: by 2002:a17:907:6e07:: with SMTP id sd7mr8249694ejc.392.1634320394256;
 Fri, 15 Oct 2021 10:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-01.13-ba64faf0580-20211015T093918Z-avarab@gmail.com> <YWmrL/POUE8P8Od1@google.com>
In-Reply-To: <YWmrL/POUE8P8Od1@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Oct 2021 13:53:03 -0400
Message-ID: <CAPig+cR3=K0HMtqW5smBOHKNksY3yqYy1tTPLbEyuFmULPsCBg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] hook: add 'run' subcommand
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 12:24 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Tue, Oct 12, 2021 at 03:30:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > +     if (argc > 1 && strcmp(argv[1], "--") &&
> > +         strcmp(argv[1], "--end-of-options"))
>
> --end-of-options isn't documented anywhere, right? Fine, I don't mind, but it's
> interesting to support it "secretly".

This option is documented in Documentation/gitcli.txt (i.e. `git help cli`).
