Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C6C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1567620706
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbhASTLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbhASTJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:09:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E11C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:09:08 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z11so22955791qkj.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BuGr0S3IjzAnhbG7ubkFP+eBFWabAa0J+zEzm4pJT0A=;
        b=UGkk/gsGCM/I26ON1KSgiyQbADyMa35iw0FT2wFbZWkPpoqgAs03opJWEvktmlF+yQ
         2+4Kqk0a0+VbMHwdRreCoa5L5LOuygSABcgyB31H5DHGJ9E5UKoLH1GM5P6J3yQTBHB4
         5fv7+WgpI66IU5Uw/jzpI4xkoI8sEcAp9YbvON+0FLOPJ/8dDwi70EQikikVNSozpH1M
         EiD3+/Izaj18Z7q71uGMzqJhPvBQJuWt6YONeqOCFAp3PMIlHh+yzW+3IunMBi1j4R7r
         pXzg0ay9zAnkG+9X10l7ppLS1DzcVSPOu/GOqN4weJ97pBWpUhLfF8/GSSD8u2MktRCu
         0ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BuGr0S3IjzAnhbG7ubkFP+eBFWabAa0J+zEzm4pJT0A=;
        b=pCk94OGg3HRPuKHIwcyTS5DpVIroJiyjeYDb7XejkD1qceqvl/oWjGpQlJ98fMJSgr
         odyJGZsj0SKz3zDbKCS40TcsJGjsi0jSd79f2os5zDO3slH4weOCgyqSVMA42Mso/wE6
         kTDsQ9D6DGv2LTc5F55jDKsN2p+dByF0vYCGRwvYkui0uP6NWJcl9C01e572F0tGWent
         hNhzhGvbfc4HSN+NSwvm3I5mxgQYOPE0g9KXj105cE8Kf7fXJXvq0DMAm+febOATfvvf
         iXNUDHRQY5UQKNSErxaoyY+EGa2c/1FKcSXPI8ZLWFauDjOZiz8+UMfvAtKUiDiTLa6h
         JyIQ==
X-Gm-Message-State: AOAM531lN3pXBGwwZFVFcCLUXztZD8wZvaEmjL+7Z6S7DI9/Bdbc6f5/
        s3il62gN+TCx5P7XMTGnmCTRLg==
X-Google-Smtp-Source: ABdhPJxiQWG96CelgYMHaWy3Lh3E/m5/oQ3pTbcZSRqo601bV5sR1cPtXXMXUDRsEkyfoBFc7o173g==
X-Received: by 2002:ae9:e50b:: with SMTP id w11mr5792366qkf.306.1611083347608;
        Tue, 19 Jan 2021 11:09:07 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id l20sm13587055qtu.25.2021.01.19.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:09:06 -0800 (PST)
Date:   Tue, 19 Jan 2021 14:09:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAcuUDqfvKzfHFMb@nand.local>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAcE/dTuOB9PbGQU@nand.local>
 <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 06:42:56PM +0100, Jacob Vosmaer wrote:
> Hi Taylor,
>
> Thanks for your reply. That sounds like a great idea!
>
> On Tue, Jan 19, 2021 at 5:12 PM Taylor Blau <me@ttaylorr.com> wrote:
> > But, I think that we could get pretty far by treating the prefixes as
> > refs so that we can call ref-filter.c:find_longest_prefixes(). For its
> > purposes, it doesn't really care about whether or not the arguments
> > actually are references. It simply returns the longest common prefix
> > among all of its arguments (delimited by '/' characters).
>
> What does "delimited by /" mean?

Ah, I just meant that it looks for the longest common prefix where it
will only split at '/' characters. But, that's not right at all:
find_longest_prefixes_1() will happily split anywhere there is a
difference.

> Without really understanding the longest common prefix code in
> ref-filter.c, my intuitive concern is that the specifics of glob
> matching and special treatment of '/' may bite us. I suppose we'll be
> fine because ls-refs has its own matching logic. So long as
> for_each_fullref_in_prefixes yield enough prefixes, the end result
> would remain the same.

Right. We can ignore the concern about '/' (seeing my comment above),
and note that find_longest_prefixes_1() breaks on glob metacharacters,
so we'll only match or overmatch the desired set (and we'll never
undermatch).

I made sure to write in the second patch downthread that
ls-refs.c:send_ref() correctly handles receiving too many refs (and it
discards ones that it doesn't want).

> The question is then, does for_each_fullref_in_prefixes yield
> everything we need?

For the reasons above, yes: it will.

> I think my approach would be to expose the new
> for_each_fullref_in_prefixes iterator you propose through test-tool,
> and unit test it so we can be sure it handles both contexts
> (for-each-refs with globs and special '/', and ls-refs without any
> special character behavior) correctly.
>
> I may be overly cautious here, take this with a grain of salt because
> I am not an experienced Git contributor. On that topic, apologies if
> I'm botching my inline replies in this email.

I do appreciate your caution, but I'm not sure exposing a test-tool is
necessary, since we already test this behavior extensively in t6300 (and
now t5701, t5702 and t5704, too).

> Regarding your patch: it works correctly and as fast as expected for
> my development "many refs" test case. Yay! It also segfaults and fails
> some tests but see my comments below.
>
> All in all: thanks, great idea, yes we should reuse, I only lack
> confidence on correctness because I don't fully grasp your
> longest-common-prefix algorithm yet.

:-). Thanks for the pointers on the spots that I had missed (as I
mentioned, I only compiled it before sending, so having an additional
set of more careful eyes was quite helpful).


Thanks,
Taylor
