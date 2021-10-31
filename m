Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1700DC433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 06:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7D56054F
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 06:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhJaGpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 02:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJaGpf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 02:45:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B9C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 23:43:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v127so11151641wme.5
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FWC0o+rywJOEQld2fiR3qq8nS7Sz7JFseiGBBxsqVH4=;
        b=CRAdmcOT678wkkz0dPqbj/XUf9uEnRQMrdwg+jrh8MwMXk+E0AjAb3GFp8+cHSpzjY
         JA40VzBi+NGmdnvQsVW6mW0yP+tt6qa245SgtcWpc1XpBS/tt+aiRGPaL7XAiSXNiqdW
         jNMGd0Tcq/dZE5ERiALmanHL1ryB+eogZyHXFX9WWuLKnWj4q3uqdHOQZwASaAJ5bznE
         F4a5Qlsp1KDp+tyyz2boCRurKbKaV3vw2kLfFSvrAtb4CZTY3GPZQZ0Ba0Rfj+m/mNdP
         iXMDXf4FsNcNozSBVIZ53+pSKRNfsLro2nSzRk+Z41ZGdXK+9hhgMf7Cd/MmxaWzDBQ7
         TteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FWC0o+rywJOEQld2fiR3qq8nS7Sz7JFseiGBBxsqVH4=;
        b=jOO85RPaIGZvSgZ3qw0MWVU99qEwwHcHgXwH39OrkGYd8KBlXtH5HeCr/tMF3vjWhv
         iuHkhRqVt6gF6fMH2jzAVoxr/uNxKg9oJwSRKXn7ncSnmikrPR+X0fm8DTU1sV+tOsdh
         MoY21uoc4E7eXfUVuegfizC5lg013sOwes2Rb6QcBiKti8h3Li0oUSx3Ms64uTqCaR1+
         rSqPcaAZ0Z/5sjbLbF1gjAyMKniJ4ZusCG4/VaFpivEIYgGMPjO8atnOxjzXh2m2583x
         RAUZJoyXkxLwfbwY1R7vjzZjxSbOlaM3NGm1SoUMxppnXcg3Pd6LdakP1NFZWm7BjaqB
         Z7jA==
X-Gm-Message-State: AOAM533TI7azM3zhiFNz1n6D9FHeXRjW8Ry11ngnU7S6eURXvzVD7Cix
        CuWvvf3lYibMtMTsmqRB9ysjGI7PfLI=
X-Google-Smtp-Source: ABdhPJy2Yqo209w4PKggo3ZKy+zube4OFKlI2J7hUum58UI1TIEDecMogIacb3WkuRGaK/F17hmMCA==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr3461275wmk.66.1635662582495;
        Sat, 30 Oct 2021 23:43:02 -0700 (PDT)
Received: from gmail.com (62-47-13-59.adsl.highway.telekom.at. [62.47.13.59])
        by smtp.gmail.com with ESMTPSA id h13sm6000074wrx.82.2021.10.30.23.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 23:43:02 -0700 (PDT)
Date:   Sun, 31 Oct 2021 07:43:00 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Ryan Hodges <rphodges@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git apply --intent-to-add deletes other files from the index
Message-ID: <20211031064300.z6lk4wpojwudgxjw@gmail.com>
References: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
 <20211030203916.zopggbajumvb4z3f@gmail.com>
 <C09B3C5C-86D1-47B4-B4BC-9D0355596A1D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C09B3C5C-86D1-47B4-B4BC-9D0355596A1D@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 30, 2021 at 02:42:42PM -0700, Ryan Hodges wrote:
> Thank you. I was hoping to be the one that fixed this because it was a level of logic that matched my current knowledge level.

Sorry I should have just confirmed the bug since you had already said to
look into it. (I usually try to send things when they are "done" from my
side to minimize roundtrips.)
I'm sure there are more low-hanging fruits but finding them is the hard part,
see also https://lore.kernel.org/git/xmqq7dl5z425.fsf@gitster.g/

> I was kind of surprised no one has reported this before.

I guess no one has used it since it was added in 2018.
