Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F5C77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 02:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEGC5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 22:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGC5k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 22:57:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4511573
        for <git@vger.kernel.org>; Sat,  6 May 2023 19:57:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so3778990e87.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 19:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683428257; x=1686020257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dunK/fajV6DEdyM7n44z4CwBERuBs4zUYtuJoYi7K8g=;
        b=GQGZY/r9VOfJ89vVUZsaS3CP0sxalqdHv96fqe8jv7qzTA5ppu3mKY3bpgG4ZAp8V3
         6okH0Q01bKBbLbsKRaCrLWbKVtn+N3BaaEBGMNjfxj5ZZti/csReB1kuOhFTQ/yApJ+j
         D1+nahmDj/H33l3uSzj08hTPvsR/s/hhWSqCtRiKSDe6getyvUVbcq+D9AuuvSDp3+BT
         YqkNFB85+sP2r2d9m3v3KQfXuwvOdp94V9QSww2mSPhNkGw1LUVdSfSl1bqu2cXBL7tV
         7ify/+GjGoaRW6ZpTw4Whdbg+jwew4dwNSr3NWgpqJiF2uhaHwxqUw1ehy49XrxOUuPX
         Jnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683428257; x=1686020257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dunK/fajV6DEdyM7n44z4CwBERuBs4zUYtuJoYi7K8g=;
        b=TUiJ+g1KwNjeu2OILFa0sj+hw42beipj9i2zll3xPrHne2J9t5ZqQqZZ/6t2NzOZjt
         dV+YIsBaAxAc23LXaKN00HTmpxG7eTw15VTa7PbkKokpkzpBa/mybPA36SBX3CoxLJEB
         b0kE15lD3SFPO2pUWKdc8xJEVW3iVskCe1Kcl+k5Sbsy+UvFaUxUntYkh9W0YPXoVb+Y
         N1FhaZ5SOLcvk0IWtG9nk5aOrBToyYHD94yNmnShf9bTBse3DwAMgNCicUxAs0uyHKhM
         AwBoM87MClwC28aQ+YWWkTYMAWHQOsRZWUMXNAM2msU/9/uBtZKHNVy+I9IKTkQL9DAy
         hFaQ==
X-Gm-Message-State: AC+VfDze3fxaNAuCA0j4IOTeuKCq6qxxlmMGXeSBl2W5vwXo5hjkbLSM
        AM8Eu+hYm3Wt3PdJGDYhYwfxSYCQAMWxY3gZhno=
X-Google-Smtp-Source: ACHHUZ4W9E5QLS5apAsnVSYJEwlkgF8DxsSK88aRf2ExckdUwQYQNkl0eo9uvSiBT2cKffAIgZo9T1ttCpLb0rBw4eg=
X-Received: by 2002:a19:f702:0:b0:4ef:d5fb:c37c with SMTP id
 z2-20020a19f702000000b004efd5fbc37cmr1658491lfe.69.1683428257435; Sat, 06 May
 2023 19:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com> <CAPMMpoi7+rdQzQPyVB8T9Pb+f332c68QvWLkwBdJZw=BcP0jbQ@mail.gmail.com>
In-Reply-To: <CAPMMpoi7+rdQzQPyVB8T9Pb+f332c68QvWLkwBdJZw=BcP0jbQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 May 2023 19:57:25 -0700
Message-ID: <CABPp-BGtRF68YJaN+nQ6bCqeh4R-dC9a6mBZvAFkX9YbkFR3sQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2023 at 10:06=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
[...]
> ASIDE: I realized today that the warnings in
> die_if_some_operation_in_progress() suggest "--quit" (potentially
> leaving a conflicted index) and do not mention "--abort". Is there any
> objection to beefing up these messages a bit to offer both options?

Honestly, I'd prefer to just change them to --abort.

--quit is for very unusual expert situations (I did the operation,
forgot I was in the middle, did all kinds of funny resets and tweaks
and who-knows-what, and then later discovered there was an in-progress
operation I had forgotten, but I decided I liked my totally munged
state better and want to keep it while somehow marking the operation
as over.[1])  I think recommending it to users is a bit of a
disservice.  If someone feels strongly about keeping it, I'd argue for
having both --abort and --quit, with --abort more prominent.

But my first vote would be for changing these to mention --abort.  And
adding some scary warnings to the places where --quit is documented,
to recommend users consider --abort instead.


[1] That might sound like an exaggeration, but I think that's exactly
how it was advertised originally: 9512177b682 ("rebase: add --quit to
cleanup rebase, leave everything else untouched", 2016-11-12)
