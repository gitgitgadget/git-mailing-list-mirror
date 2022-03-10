Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB32C4332F
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiCJSoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbiCJSoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:44:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E28E102408
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:43:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s25so10985288lfs.10
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lTRNDdMZFHivppxukFNMMyz49nlVW6i6OvMx2QhxLmQ=;
        b=gfNuNsKmYmc0TghgVyve4QmxONuyD3+ANdK5ooQYv7xBNQLQ1SBjxrtO4nyMKO+buL
         1pzZ77N7TrJdss4lEOCuu12bKCuKeydhFddByeMDbAIYn8dh58WD42am7ETMKz09jngF
         VwhDPO0iY76cH9xaadG3ksyYCKzmaRFsJ22N7RS2G1GJZPzrBr23EOda0wyNmEgl3T4j
         x+GjRmnHfJNXLr1uvW5wnQjAQzj4hvqOeeC6yqDdgLcyl2j0oj9Dv8US9bh/naXMv9yP
         uTmWMvBcpT0cDiAGtOYjJyBPFNaJGsnz/VrExwQsv9OLgGiUG6orfhhZA2Yq7j8wEkx9
         jw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTRNDdMZFHivppxukFNMMyz49nlVW6i6OvMx2QhxLmQ=;
        b=0LmI+oGNQv5wAOXaeYAPIbApaxkV6/w8HTLrcPYdtqJ8dc7NJtL66ttEqMi/rhDsHC
         VQS5UE0nqYTDwkqDRDyRdKtV9TWtre0tZI4q2bb3FnHGzUsxQ9AVFj/go/4klNk1yOtm
         9jPZmuqROuevm2OSdKw+KiBVARlRHheGSfA0WEd8tBRHC52ZCjGJABhNtC+CvLIdEQZ6
         DZjgNXDPP7IDVgOhgKZvhdE9Q2KDqExhqJE7dzSHirORcCuJ5rh7mTYHt67hrVjLF3gl
         cEFGp0pEBDby16AVdQWZ1rqh5msZeBUizDD66kWrs7cJX7eGDOGjoWr5klawPMUYAVt/
         kVKw==
X-Gm-Message-State: AOAM530T6Z+hWeCrvGt1DkAAQmaiUT7PUSVA9fy8AhypN1qHOYb5hCvj
        IzQzM/BPldE4unRZlnR6/Uu/0QXaYaI4Bzb9OiRkO459YTw=
X-Google-Smtp-Source: ABdhPJyM2eWd4/Ea7Uvbws7HxF8eRYb3dcLFRht+3GTizQ1LlAaWhEnbN1ctrw4Q6OtUgJg7piRcmXVFqEkqEorcLLU=
X-Received: by 2002:a05:6512:32ca:b0:446:4262:e29 with SMTP id
 f10-20020a05651232ca00b0044642620e29mr3821741lfg.522.1646937799716; Thu, 10
 Mar 2022 10:43:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <211116.8635nwr055.gmgdl@evledraar.gmail.com>
 <CANQDOdcEtOMMOLcHrnTKReRS23PvjOGp58VdpEkV_6iZuSPXaw@mail.gmail.com>
 <211117.86ee7f8cm4.gmgdl@evledraar.gmail.com> <CANQDOdcKzxM+M7wgxUz831SbpwGWR7gcUC8xLFM14BcCJ+60sA@mail.gmail.com>
 <211201.864k7sbdjt.gmgdl@evledraar.gmail.com> <220310.86lexilo3d.gmgdl@evledraar.gmail.com>
 <CANQDOdcJX9bYAJN4_M5-k_Ssg+kK+CVOsanXr+Xnu7B+nzfqSw@mail.gmail.com>
 <220310.86r179ki38.gmgdl@evledraar.gmail.com> <CANQDOdf1pE+PUv_XqLobGq8Wvan-iH28RhBJFYM-NfxHKBjU+Q@mail.gmail.com>
 <00ae01d834a9$d443a530$7ccaef90$@nexbridge.com>
In-Reply-To: <00ae01d834a9$d443a530$7ccaef90$@nexbridge.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 10:43:08 -0800
Message-ID: <CANQDOdeFdTzB6GKEeNPJm0-j0qyD+n8+e=+Qn98PvRg8N5wdEQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] Implement a batched fsync option for core.fsyncObjectFiles
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 10:08 AM <rsbecker@nexbridge.com> wrote:
> While this might not be a surprise, on some platforms fsync is a thread-b=
locking operation. When the OS has kernel threads, fsync can potentially ca=
use multiple processes (if implemented that way) to block, particularly whe=
re an fd is shared across threads (and thus processes), which may end up ca=
using a deadlock. We might need to keep an eye out for this type of situati=
on in the future and at least try to test for it. I cannot actually see a s=
ituation where this would occur in git, but that does not mean it is imposs=
ible. Food for thought.
> --Randall

fsync is expected to block the calling thread until the underlying
data is durable.  Unless the OS somehow depends on the git process to
make progress before fsync can complete, there should be no deadlock,
since there would be no cycle in the waiting graph.  This could be a
problem for FUSE implementations that are backed by Git, but they
already have to deal with that possiblity today and this patch series
doesn't change anything.
