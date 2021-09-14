Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A218C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2999560EC0
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhINBIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhINBIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 21:08:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47834C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:07:02 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l10so12131438ilh.8
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OMDkvMBfwie4GwAIdWm0JUdInPbA0W4RqFl20iYM8ew=;
        b=CKsmM8OsQGuqKcDGHmpwniL//4l2JJ/nzJNcb3LoapAhb1QViw3HJhZ+8ZopNCugD5
         KifJMLbRrggqEC3P3ZHLzHKB9xc5rBct4H3zcdesn6ZDZGFxDcGrFn+ZfjPsBFvurbXb
         GynfDcP+wTHeIXBb+yiU+rXzPLV0ZmiWtgAyensoyUpqkpgT19tQj0fYTMen7UYbVLsO
         C3P9ztG3wUGSZpip4+F2F/GefH9H5SdrBG5hi/UyPbJ6Ih1bXZHnMgQBOZB8KP2DxHOV
         aHX+/UIOZ5jkDthhKBCfC+rE+VwfkkEK9RqXBHxP7WnSFEl8fhXxjC+umg9fFEm8DU+e
         NFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OMDkvMBfwie4GwAIdWm0JUdInPbA0W4RqFl20iYM8ew=;
        b=VfhM1chg+gCgphNyaliEYMFQ8RlWy7cOLUmNt0LaTA+VYpJHrkbBjrXRRI33vjnz4W
         WX42Hi46XCg+7jMDjaJ6uBsD8KkE/lQiUNSsvOWM+b/D1mPbNGfNARxTOwvrywkB/X5r
         J7jTcLSWmvoMza1j+V+slAukgkBYmZrtQ9tlT9EDkppLBlzTVFePkOkBbmObOBGXhiUo
         M/fOQ9ChcIfsAREK7ha0fFgewhXS/4qxCcZiE0hVYuHhG8tLRBtODV5TKM0hpGI6tEuF
         0Fo+1w+w2pNWxaJKuGcNv9emqDqnvQpOprWCB8KAJW/ORh0vrQe6wVNJZLRsK0aqC4yx
         7mvQ==
X-Gm-Message-State: AOAM530B3Lpi4hdIZlX3tc/v9IwxNqJ2mYEE9h/4DIaf3bPIYPHEjQTg
        lWf5F+xpLD+ZdOb94ObTcnc7Nw==
X-Google-Smtp-Source: ABdhPJyqxkVpI7KZSZRou8JAEenjJDr7EAa0wB4UGBrZEP0r45hLiPLkqNjz5FUiw/+On+IsecemDw==
X-Received: by 2002:a92:b109:: with SMTP id t9mr4196976ilh.176.1631581621674;
        Mon, 13 Sep 2021 18:07:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4sm5704268ioo.2.2021.09.13.18.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:07:01 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:07:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
Message-ID: <YT/1tGxiCNTsWPBz@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local>
 <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 04:15:09PM -0700, Glen Choo wrote:
> > > +	cd "$TRASH_DIRECTORY/full" &&
> > > +	git fsck &&
> > > +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> > > +		"incorrect checksum" &&
> > > +        git config --unset core.commitGraph &&
> >
> > But I'm not aware of a way to temporarily unset a configuration variable
> > for the duration of a test, so here I would probably write:
> >
> >     test_must_fail git -c core.commitGraph= fsck
> >
> > which Git interprets as "pretend this variable is unset in-core".
>
> From my testing, I suspect that git does not pretend the variable is
> unset, but rather, it pretends that the variable is set to the empty
> string. It seems that git behaves as if the variable is set to "false".
> This is called out in Documentation/git.txt:
>
>   Including the equals but with an empty value (like `git -c
>   foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>   --type=bool` will convert to `false`.
>
> If the variable really is set to false, how might we proceed here? Shall
> we stick with test_when_finished?

Hmm, I thought that we did support `git -c foo.bar=` as shorthand to
unset the key `foo.bar`, but I must have been mistaken, because the
documentation there is quite clear.

In that case, I think your original approach to use test_when_finished
makes sense and is good. Thanks for double checking!

Thanks,
Taylor
