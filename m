Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA7CDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376486AbjJKWdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKWdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:33:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C991
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:33:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so51999166b.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google; t=1697063618; x=1697668418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyieHP7VRSY1ftXzahbDR89JRA15NkXsVZK7lPqKtC8=;
        b=UBhG7nws15/0AdPQCMehiW4ri54r3SYG0Y3b+LWcR6D1qlErBNFwKfIbqpJy29gbmn
         ztANvpruI28wsTkLrVIYc4mI2+5sbAe/PMzgDaeGkddStn9A33Z50sy3+XVnyySHEIMH
         NSprZIXM5zpNHq4agDww6X8scXC0wabFGe6G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063618; x=1697668418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyieHP7VRSY1ftXzahbDR89JRA15NkXsVZK7lPqKtC8=;
        b=d3cbMSXkBUa9JVbs3MB/NOXrYr02drSlea/qM/Yk73MiHMaaNY4zv6BxMT32ML75m/
         S2o1SWhsOBU0jwf+3HQ0mTD0XW0oxO99TCn4/aeAf65m25A1GT/JZ/alP2LqFuUSl32L
         YQX0p9ALPJFcMsBK4RYsCWsKdFWWkdgGDol2anIgkZtF7qw4cRlW1yHVnLfa5hiYNKuG
         ycD28ViQFeN/EAzl4Q4+C1wKAVNyQuLaVu5PzQNKYieSvRMX0pM1Qn9Vv4ZCaxZCfyQq
         m6eu7EH6u9ZccYWFlFN9XTDJwVy9joINI1WZl8TTahO6nMb39AVnsQeh6j6nEksPFN7N
         2YsQ==
X-Gm-Message-State: AOJu0YwKQcKMxsDIdIqd19kyNCgrKNW4ySnn3Ycl9QBpuf3ZIXWvyEXs
        cAqb4Dp3UFTv3AYdSyQfc2IHTInqyFsx/COKuaf/qQ==
X-Google-Smtp-Source: AGHT+IFNx7MMHRkWytEtepgHRcbF8r9HXdcxMmhEOeYysrxBUYBAlFedkbdrvltsk+CZD1o4oteeM9YmQxqpG7IN2eE=
X-Received: by 2002:a17:906:51d0:b0:9ae:4492:df47 with SMTP id
 v16-20020a17090651d000b009ae4492df47mr18823395ejk.54.1697063617985; Wed, 11
 Oct 2023 15:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com> <ZScUWrj6CQTg05HL@nand.local>
In-Reply-To: <ZScUWrj6CQTg05HL@nand.local>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 11 Oct 2023 23:33:26 +0100
Message-ID: <CACf-nVfMLRy6DGbX+G+eJ-LFNEywTmJkpdem8no=TTziLOV+Jw@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: add tracing for fetches
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Thanks for taking a look.

On Wed, 11 Oct 2023 at 22:32, Taylor Blau <me@ttaylorr.com> wrote:
>
> One of the custom patches that GitHub is carrying in its private
> fork is something similar to this that dumps information from
> upload-pack into a custom logging system specific to GitHub

I suspected as much. My initial goal is clones vs fetches, filter use, and
shallow use... since I'm changing code is there anything else that you think is
worthwhile instrumenting? I thought about casting the ints to booleans
(ie: >0 haves; >0 wants; etc) but I figured the actual numbers might come in
handy at some point, and changing them back in future would be incompatible. I
deliberately didn't add thin/ofs/etc flags: most of that stuff is on by default
now so it felt like noise.

> > + jw_object_begin(&jw, 0);
> > + {
>
> Is there a reason that we have a separate scope here? I think we may
> want to drop this as unnecessary, but it's entirely possible that I'm
> missing something here...

I just followed the patterns in test-json-writer.c - personally I think since
JSON objects/arrays have starts & ends then it's easy to read. But one person's
readable is another's coding style violation ;-)

> > + jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
>
> I'm pretty sure that list_object_filter_config_name() returns characters
> that are safe for JSON-encoding, and/or that jw_object_string() does any
> quoting beforehand, but worth checking nonetheless.

Yes, jw_object_string() calls append_quoted_string() which deals with escaping
and quoting.

Thanks,

Rob :)
