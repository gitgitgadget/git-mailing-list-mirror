Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261EC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKKWXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiKKWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:23:26 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73E3AF
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:23:23 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p141so4543557iod.6
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkj8U+Z1Kmtm66kU/wYM+vM92ppNgwtOJLghKnXnsHs=;
        b=MT/nKOW575mfMkyXwWj1FP7PJXqUI0D3mtWjKy9bRQpvJgV4SlCf7Sfa8pDQ2kMZ63
         2UYRAZF50EQ3/+aKvA7roFtcM+Upc5D1xW7NpJd4VIqHdU/SggZVMeioyyMqIi4mGM4A
         cNcQgS2R10GQ2poy8kdrRwgHoNItnUEz4dA0mirJRc2BftIFDskpy95ij5Olg4C2ZNu2
         JXtkxGue8Rh15fjloP8FXLZD1jMtYD4CCimOTcwAnfIfBI9nHw/IgODrBqnnOyfvBEif
         l1ZYZwbJADbzC8tsBL8/DzMw++P/Ep602zZZe4LFH9pQ0mCKtgoYDnh2mAPgm71Oeph4
         D41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkj8U+Z1Kmtm66kU/wYM+vM92ppNgwtOJLghKnXnsHs=;
        b=8Ddsu5jVletkxQxjPrLdDrv1uE2JzJg4J/y75RdErVggs4km4oP7TpxWyxE3fX/SIp
         DBPe3fs15MrUa+HMcQo/uI9+AS+iRknhHsy/WnkNGyPyU3TFFrH7/nEJvEHXpDi0Vj5A
         e5Tz7QtmYfuT0ji/BO+nyvEyrMii5nHUx0t/4G2NC+SUY6q42i9ToH1Q3kM+O9TAGSbI
         oP2GL/lc8HR95+ZLAHVXxz4xz+1o223frg+Kd3wGJyNzzu4uHIuORZc1Y5Lkmt3bEyZC
         BnanMg9ZnqC3SA3bYt7rKIvxNe8/Yk2oGVthvo2xER+X/5k6E07Qc+4ugsin6WU/pwnA
         c9WQ==
X-Gm-Message-State: ANoB5pk9qWAo+UODP8ci7uzfa1N6DczbUSWfF8Srss16it7AexepT+fH
        TMjDQR7uM7NAJmkB6pn8TDgbFg==
X-Google-Smtp-Source: AA0mqf7qP0BsXx2Jz6jqtJgjpAZJlwap13rE4ypKxyh5I45lHrsVjOnnDymVjv64o+ecdwY3JXqGkg==
X-Received: by 2002:a5e:8618:0:b0:6c3:6e0:6a7a with SMTP id z24-20020a5e8618000000b006c306e06a7amr1784651ioj.161.1668205402963;
        Fri, 11 Nov 2022 14:23:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x16-20020a92d310000000b003024928a9afsm293306ila.83.2022.11.11.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:23:22 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:23:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repository-version.txt: partialClone casing change
Message-ID: <Y27LWVVTmGQ90A2O@nand.local>
References: <20221110160556.29557-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221110160556.29557-1-five231003@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 09:35:56PM +0530, Kousik Sanagavarapu wrote:
> ---
>  Documentation/technical/repository-version.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looking good, thanks.

Thanks,
Taylor
