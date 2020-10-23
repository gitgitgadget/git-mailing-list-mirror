Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0CC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2834420897
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpcpD4dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755872AbgJWUMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755840AbgJWUMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 16:12:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C73C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 13:12:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 32so2490323otm.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIsLlEpyjM8Nl/93W+chDF4gyh42gcV1lGPcwVpx+MU=;
        b=WpcpD4dtLdCidN59Js42nyaW4Wr3/WpT/MrlSaVZ0EjLI7GcZzKB9QwJPnjIdfgJq1
         hEi96a0oJJihXYGX+x0h7Gy1OqogOXy0cQAsDoGQ3DsY4i8UySFmTBGrS3JyIEdt7ev4
         8Xr+W7RyOF2WWEoBNpB6RvpAZBRwHW+qP1VS3XF201vFaYKKyfdeAtc3bUAmcuPKNNb0
         cbX5MJBB0GWkYxpU95jmlZMP0IyZ655ipeKPA2Qd4pcXkiCurSPO2EXN94+iE6ygF4ZX
         OdMs+OfOLJ0FGzMKtHBUAdYmZ9V2aY0S1hGtkHtObMslvHkX+wwoTK19SpC0jTFnt7DK
         xeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIsLlEpyjM8Nl/93W+chDF4gyh42gcV1lGPcwVpx+MU=;
        b=oyJnE9scdQLEQeRcHE8GAlrh1p3ZHJW67n/hLlWdBXDSh233HilZ5ypTU8+OtTCVwk
         3EnMkGIBZyrE9TTjcBfoiEUpPalzJ770h2u613kJSo5mGi9Lzu5vU490+Ev77fvBDObd
         yPDR/+mIZHfm7WPVaZY9aNB7ZgScG4KQBGlNKrIW3SVhiSV33eUpmem6GE9Eumg7X0YE
         +Iv+f20NHYMIoAMcSyhmeZgpmZDtuYjWM9RvSN3n2P/xRK0ZX5AufD2pS8nyuSWgn2Wq
         stBW26Oa0VsFMCYdkLP9GRWmWNhIin27DYvGjQ68zAngrqLMfODhoHDwc8FhJ7b1FmHI
         6uMQ==
X-Gm-Message-State: AOAM5324hpz1VMWs4Kz2WyRJkk2rfC+3fwtzu/9BvjrbNgS3kZbnzV1G
        N+P7lMUqXwdjeGCh4OJ+2hqZZIQaCvG0WF1dS931EsriLpI=
X-Google-Smtp-Source: ABdhPJzv3VNAa9Kob3+1uqfTF3Qp4Bbe2S1/tHicxLRCBYYmSe1eE/sRQ5SkOGbKc4CtI0H24tI+s7/BYjX3CkCyctI=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr3221702otj.345.1603483973844;
 Fri, 23 Oct 2020 13:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com> <2659d1cb987735ec123ca7a82ed7e058e4d6bef0.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <2659d1cb987735ec123ca7a82ed7e058e4d6bef0.1603468885.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Oct 2020 13:12:43 -0700
Message-ID: <CABPp-BHJyVbXp1bnN4uBMAgfx8i_4hCksAQbEjc_BG+1J+4xXw@mail.gmail.com>
Subject: Re: [PATCH 9/9] t6423: add more details about direct resolution of directories
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 9:01 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6423-merge-rename-directories.sh | 37 ++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 16 deletions(-)

Whoops, I had meant for this last patch to be kept local for now and
only send it in after adding more of the merge-ort implementation.  To
make matters worse, it's slightly out of date with what I have on my
'ort' branch.  Oh, well, I guess it doesn't hurt...at least not if I
get the up-to-date version of the changes.  I'll include those in v2,
along with the small change Junio highlighted for patch 1, but wait a
few days for more feedback to come in on this series.
