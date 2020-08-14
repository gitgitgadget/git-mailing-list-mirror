Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED6EC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DA420774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHNWmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:42:03 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36617 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHNWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 18:42:03 -0400
Received: by mail-wr1-f42.google.com with SMTP id 88so9633460wrh.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 15:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3nrwEJ79YPcg9qqw0GP6dRoWjUU0MqIbn91z5xSTvQ=;
        b=U2z7GTZBNoV32ThXhhNUMvL/NCVAEkx/141I8aEjk3KHOd8T6DpTHP1emqTXTtmMzV
         aZzEETmSs4LI3MKwNQmAbYHtc2Fck50WWrAQueDlY0I9nEh4DhYAYo8LfKgbMYdYofDt
         RXwnbyR9PrGE/GVoMX00CL5rnRe6eFuNLITMge4JEwyqwhTCEL53vFn17Rud5T7QQexN
         m1DwKMw0t1KlrqnlP7Wuc3TrvuVCzr9s4EnoqGwmKNCAlGIWeL/UFb49XeVz9pgkbl3I
         iGollZBpuaK/EWWCpBKC0r7a27mTNTxjpj52BO+wODeti+jNbPxUiI+njTBLcMbhECH/
         lqSg==
X-Gm-Message-State: AOAM533pE5LxBnKsjzRo+tAQ02AKjzNioF/xiH3bPBsfbWfFhAcUwTQ5
        7ByjBMOHkWpDHlXJqqo4OsbT/x1VOorAj7p8R1s=
X-Google-Smtp-Source: ABdhPJwo2GUbyGEGcx/JUX4PaZhT9qGyqwSNdx3bPJuj2MLVsDqZWaSfSwZ4wT9r3HeGQu+H6alF2zhch7Iynts4fdM=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr4471644wrn.415.1597444922100;
 Fri, 14 Aug 2020 15:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
In-Reply-To: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Aug 2020 18:41:51 -0400
Message-ID: <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
Subject: Re: Possible bug with git restore
To:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 2:51 PM Sergii Shkarnikov
<sergii.shkarnikov@globallogic.com> wrote:
>     I tried to restore a couple of files from an earlier commit
> running the restore command with a wildcard:
>
>     git restore -s HEAD~ -- */filename.*
>
>     In my work tree those are .cpp and .hpp files stored in different folders.
>     Both files were deleted (and got (delete) status).
>     Running this command without wildcards for each file separately
> works as expected.

Thanks for the report. Can you provide a complete recipe in the form
of shell command to make this happen so others can reproduce the
behavior? Doing so will help track down the issue. Also, since this is
Windows, do the cases of the filenames in the referenced commit match
the cases actually on the filesystem (and have the cases changed
between commits)?
