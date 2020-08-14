Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F9CC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A83F214F1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WULMtBxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHNMVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:21:48 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC974C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:21:47 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id q68so2592386uaq.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VIEwnR3a7O6NqeU5TVfiK/B/1QRumpzvOuHWqt+b2VE=;
        b=WULMtBxkEralCcH19mEzd5U3mn68/CEbv2jh9h5hIQ7elv8Tkq6A6EEc6X0oK9qTQJ
         Ptgh2pd7RJcFrdHmPFVVs+VJBrp0rHZTB5U68dzCqLXSgqM03kv92DwviUGl89zzGMvu
         TNLSUmVKMlXt7NhkbcLQwOQ/wGr9hl+Mq9dp3xUK6P00NFeYP3vE0lBEu1STIvmDMvkd
         4OyXYyLaytELUFrAmdSGlzq6empxqhsr2Mr1HblFCi1MGRjGa4hYw1PLp19ZjJDVDK6T
         O6zQ5t2JmTTVNnTy433fOG8v166FOiPY0fY+hs806Goy8EF9WD0EJ3vUzqi1fp/DcDN8
         WsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VIEwnR3a7O6NqeU5TVfiK/B/1QRumpzvOuHWqt+b2VE=;
        b=EvurPiJD30VHujMQykBt7DrO1fdeecinKMIWtA1N1+3WfgHBdwJWnhqlETLUDxbGm9
         Pq0degijQCGONYQlde4j1dovMKrPDPVK5N5qdUzkPUE40hv+DEoe2N7mS5jVHWqc0AOJ
         yMSVLsKYnzd3ftWsKyKik9B4usjoEn9x/9LhrUnMsZ9kAGKgvEr4B9G143z+vlWAGUU/
         qzT4nQ8rlwiKR+7yeIp8hGVOH2LxfEGTSSTYCejGKhpab5CFApN+5GT64Nr2Q+UlXbIC
         KsN0Fspw/8752z2SZ0EjGSGxJbLxkmCDsuV/gJNRD1sCbCTbsKkXZmMGERisORFvfV0H
         KWnQ==
X-Gm-Message-State: AOAM531z4PQ4xbFxBRqI8YXOceEg+1tdPM+EnYjFhMDkrkfDR9OBYmtG
        2tnWU2sdA94F3jHu0E2HDBPIs74xyPt3L8VQqIAxafBMxo8=
X-Google-Smtp-Source: ABdhPJwZrIa91rKspUy/JAV+X+vH1bPUP+a7C12N3Qvp4J4Yu9NMDX+HxiekGjtBgscJV+KZVxochYVy3eDscLD5sno=
X-Received: by 2002:ab0:49ed:: with SMTP id f42mr1003794uad.115.1597407707175;
 Fri, 14 Aug 2020 05:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net> <20200813224901.2652387-3-sandals@crustytoothpaste.net>
In-Reply-To: <20200813224901.2652387-3-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 14:21:33 +0200
Message-ID: <CAN0heSq52VrEaUxxCb91Adw5YByz=H_r60px9UHbTcQHLb1PmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: fix step in transition plan
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 00:49, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> One of the required steps for the objectFormat extension is to implement
> the loose object index.  However, without support for
> compatObjectFormat, we don't even know if the loose object index is
> needed, so it makes sense to move that step to the compatObjectFormat
> section.  Do so.

This makes sense to me. I know I thought out loud before that maybe
there's some intention here and more specifically, maybe we want to
*know* that this loose-object-idx is always there. But we'd still need
to tiptoe around it in a SHA-1 repo, so even if we'd know that all
proper SHA-256 repos have been generating such a file since day 1, that
probably wouldn't help us much in terms of implementation/fallback
strategies and whatnot.

Martin
