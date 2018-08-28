Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95101F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeH2BxT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:53:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44551 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH2BxT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:53:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id k38-v6so3558563qtk.11
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xu9SZwDNnC8eay10JY+48rrK1S3Q5prASQ+hbpvycQ=;
        b=StujgoHQmqFaWeu+zwyvi7UBu1vJvDLrquKaBGBkdFpVdtmkL0b8MiqeYnfC+2ydMN
         1PajzILvCgPXPVFOOyUU4eSp408DltKm6xakIaGVpO2NM9kAY/NV5KwtjMivJYobOd2r
         m0FxQ12uBqSKk1LWZ3kFSYpAX0L8RkrGmfKwaCMVSf9k5sSwGZt1PFezizxa+4cs4BCW
         O2vQ/aN9sd/iWsEKOyqjkaUhWAoR/YIbMeQI5qw4NM08T9nSoRK67r+7CmyJH1WK3kSW
         sw4tH2AjelcPJCMcrwvuuOUq5sjbUvNRFzzeOg1+YcdjfvultEt3HGiYvgkyUj5zjUc0
         rn0g==
X-Gm-Message-State: APzg51AgGQRJnUWHk8P6nb7f78atDdcDeOkIfbV4w3MEzPN/bGpw2oXJ
        RJENerO9sJbj7YUkQeCGCBDC3YtaqQw+GCIa8MI=
X-Google-Smtp-Source: ANB0Vdb9V/8XF7Nbbl+sAawnBbDTXwuR4klds5MGmIcGHCEdD1LxFviYn2HtzYAopoF4xm/QgJHrovsTkcijDBjT8Rc=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr3675046qvm.6.1535493580676;
 Tue, 28 Aug 2018 14:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.26.git.gitgitgadget@gmail.com> <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
 <CAGZ79kbsJXF=X7tzpdogAY7LdLd87YkPY0euiYaa3uQKQPoZuQ@mail.gmail.com> <3bb1d527-87ae-5fdb-be9a-b83f6a68d3a0@gmail.com>
In-Reply-To: <3bb1d527-87ae-5fdb-be9a-b83f6a68d3a0@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Aug 2018 17:59:29 -0400
Message-ID: <CAPig+cSjanDi=jV75PdzYpAjwVgd4Suh3UyvY+Vy7yeHAuY8RA@mail.gmail.com>
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 5:31 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 8/28/2018 4:41 PM, Stefan Beller wrote:
> > On Tue, Aug 28, 2018 at 1:33 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +               GIT_TEST_COMMIT_GRAPH=0 &&
> >> +               test_must_fail git merge -m final G
> > This could go on the same line without the && in between, setting the
> > variable as a prefix.
>
> It cannot! The Linux build I ran complained that you can't put
> environment variables through test_must_fail.

Is GIT_TEST_COMMIT_GRAPH exported? If not, it won't have an impact on
git-merge anyhow.

As for the special case of one-shot environment variable and
test_must_fail(), you'll find "env" used as a workaround in a number
of tests:

    test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge ... &&
