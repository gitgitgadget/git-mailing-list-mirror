Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CCC433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C0C206DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 17:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCmWqmyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGHRlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgGHRlC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 13:41:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E75C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 10:41:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so4110902wme.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcpTRAhQNiRYUWJOBWp5mNHGQtdP6e/EctR9phRYrag=;
        b=RCmWqmyj7//eVO1o+VAU1zjfj92VPuKGUsbNJGsaaort48Td20u26YSCjI9XGpNj2/
         YWF+U+mW+38BGvtfNV4Wyqq0p47Pb81ag8ICftI3pHe83VKT5hQC9K9PDesMQsO2pXak
         cgjiZIrpHnu8f0rCd/X1MK27aZwN1yo38qB8TOJPBz+8sAZmiQdfxuRGvwZQ/d6kY9rh
         Y2rCsNhgFGn+u6Zdmfa9FjozBJzbhZ1ySyQNOsPHI13AZVNkDAM6a6Yvt4+34aCLF1Sp
         AVHV4rIsnCz5aT2BLwemyNxinn4FKzd4McW+xNtBirvRYq+icLDlvRSYK7OW28WFxlxX
         nxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcpTRAhQNiRYUWJOBWp5mNHGQtdP6e/EctR9phRYrag=;
        b=Y0r0SGfLFRCTjm75nReSt13u8vyJpbbHTL2uWXUZkCgp5W04k4Irx1oTBj6zp808Jv
         w+3yoHeGbVL9yKvSHdVKWFSlcFoEpaXvTkJkyD9A/aDeA+bAMJ6X2eTeup5XXtz9Ex+5
         gooahkUI3dyuAezlXebVjG4A7+xL4/LawFJVT4DF+g42ENn/Wi1twgF1YizUdiGnqegS
         laLjTLAravSNd4kjKGf4qB/PMbJLZ53VSP5kW44fuBij1s4tCKELp8mO+SQtpMLuTsDj
         8/G9qQsMqkDq0IElAd0G59avbzBecWJXGYlL57qdx3wwFqjjZI3ImVYMPGHz2+rArieD
         XTfQ==
X-Gm-Message-State: AOAM533zW6vUnrF3U5ylVTDxNkTdhCcUt2XX7hmxZN5rz9PGeAwsdwEt
        AilMbQKLXmLjxPxBIDNsC5V2xbGDLH9vk6rP7rJPhS/J
X-Google-Smtp-Source: ABdhPJw7LoI++KkezDwpGGtbCAojT/WCbGYbHD5QIgo90n0Zw5jQtmZSE0eQT56+QfRMw0Xku8yQo5MBmZ1jzqmMxsI=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr10107855wmf.87.1594230060581;
 Wed, 08 Jul 2020 10:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
 <20200707215951.GB2300296@coredump.intra.peff.net>
In-Reply-To: <20200707215951.GB2300296@coredump.intra.peff.net>
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Wed, 8 Jul 2020 12:40:49 -0500
Message-ID: <CAMP9c5mpJ9_HvEBTiEQj=vocTdH6N9uXkpLKiE8+hFbAt9p5Ow@mail.gmail.com>
Subject: Re: git grep --threads 12 --textconv is effectively single-threaded
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I just need to

git -c "diff.c.cachetextconv=true" ...

And the cache should automagically work?

Zach Riggle

On Tue, Jul 7, 2020 at 4:59 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jul 07, 2020 at 04:25:01PM -0500, Zach Riggle wrote:
>
> > It looks like the bit of code that is responsible for performing
> > textconv conversions is single-threaded, even if git-grep is provided
> > a number of threads to use.
>
> Yes, the locking is much coarser than it could be. The issue is in
> grep.c's fill_textconv_grep():
>
>           /*
>            * fill_textconv is not remotely thread-safe; it modifies the global
>            * diff tempfile structure, writes to the_repo's odb and might
>            * internally call thread-unsafe functions such as the
>            * prepare_packed_git() lazy-initializator. Because of the last two, we
>            * must ensure mutual exclusion between this call and the object reading
>            * API, thus we use obj_read_lock() here.
>            *
>            * TODO: allowing text conversion to run in parallel with object
>            * reading operations might increase performance in the multithreaded
>            * non-worktreee git-grep with --textconv.
>            */
>           obj_read_lock();
>           size = fill_textconv(r, driver, df, &buf);
>           obj_read_unlock();
>           free_filespec(df);
>
> Note that this lock is used whether we're doing textconv's or not (i.e.,
> it also excludes reading two objects from the object database at the
> same time, because none of that code is thread-safe). But the latency
> when we're doing a textconv is _much_ higher, because it's shelling out
> to a separate process and reading/writing the contents. Note the
> much-higher system CPU in your second timing:
>
> > Note the difference in total CPU usage in the following expressions:
> >
> > $ git grep --threads 12 -e foobar --and -e fizzbuzz &> /dev/null
> > 0.24s user 0.28s system 710% cpu 0.073 total
> >
> > $ git grep --threads 12 -e foobar --and -e fizzbuzz --textconv &> /dev/null
> > 0.90s user 1.75s system 110% cpu 2.390 total
>
> So I think implementing that TODO would help a lot (because each
> textconv could in theory proceed in parallel).
>
> As workaround in the meantime, I suspect that enabling
> diff.<driver>.cachetextconv for your particular textconv config might
> help. It would be slow on the first run, but then we'd be able to skip
> the external process entirely for subsequent runs (the results are
> cached in a git-notes tree, which are just raw object reads).
>
> -Peff
