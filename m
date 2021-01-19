Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE3AC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E30C22E01
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbhASWYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbhASWYU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 17:24:20 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE2C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 14:23:39 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h21so996820qvb.8
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfC1xl7F8ZLaU1+ISWOhBa4S3DXsks7TcSbcdK02cBk=;
        b=dci9BTU/9MRBdiTc8SQvOQmfeGNZC7TQi56wd0plQZEUjLx4ZiqoAddApqn/na6Re7
         KVIaDMJ70b5LYvuCwEtaq9VAUmXgiBsd0Hkhs644YCg2Q9JVF6JOclz6Q7Qt6DmUyNvJ
         0SWIA/t1R9Kv+Ptb7uRY8idfMY6YoAMhNaFEPZCX5sqBiG/4s+3OfuYa+WZZvIsS4Ku+
         SKna9SHXbpioF1MkK5E/sNWk17AgHEta4ePhTB+yUqWldUdN78RlE4Jh5ObBxdVTt8Xs
         BOunlmTZvewbatogpKWBxokesRsIzw1HcbOM6nt8egJTymFEyWvMk3vvlMBdGO1ZKL2w
         2rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfC1xl7F8ZLaU1+ISWOhBa4S3DXsks7TcSbcdK02cBk=;
        b=ndZoGYmY+mYuZmIZ0D3gF2Ng5q8IUwydfzJUbYtlRbswBo31V/tb4eiWjbGqctWlaV
         JWXQleyhVpCumQR/vD/fwu0DfsHIqshqOKJp8T0fzqs5T6rTq7Dq0yzUfUZHU/kfV/Ic
         D8ubK86oeqQOWqlNacaQs5eZmk1Sv4KUvcDKhEM7tD0hOSFZIUgsXzitR1u3WrwIlpFf
         bEmBt+6Idox2mS7aoXj06OMIsuorAAnK0LQf1/+WL8aZBIGQgB6aDD3ie3RuftO7B8+c
         gLz8ac1BDicF65O4lQbOSnCCluBfk/ipI3vW6O5frDlV27SC///8UfX/Rg9du70xtvA5
         a8eQ==
X-Gm-Message-State: AOAM531WGhqaOe9ZaZnZLVhOpsXbsU/iEVWUCpYukFh5jZWJ4lBAT6CB
        1yohqELGUEnvS1IrSWiiJatUmQ==
X-Google-Smtp-Source: ABdhPJxGAdsnGERPJpGRbOyFC05qvSmwpfEBIVhJbDDu/JsAWIV6XGoc4w4RiXUsDkf/0ZZoRripOg==
X-Received: by 2002:a0c:edc4:: with SMTP id i4mr6683884qvr.43.1611095018701;
        Tue, 19 Jan 2021 14:23:38 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id c2sm64718qke.109.2021.01.19.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:23:37 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:23:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Jacob Vosmaer <jacob@gitlab.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdb6GmVXWLEGkP1@nand.local>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAcE/dTuOB9PbGQU@nand.local>
 <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <YAcuUDqfvKzfHFMb@nand.local>
 <YAdWNgF75QEYFLA7@coredump.intra.peff.net>
 <YAdaAsP6vCQla/Ar@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdaAsP6vCQla/Ar@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 05:15:30PM -0500, Jeff King wrote:
> On Tue, Jan 19, 2021 at 04:59:18PM -0500, Jeff King wrote:
>
> > > > What does "delimited by /" mean?
> > >
> > > Ah, I just meant that it looks for the longest common prefix where it
> > > will only split at '/' characters. But, that's not right at all:
> > > find_longest_prefixes_1() will happily split anywhere there is a
> > > difference.
> >
> > Right. We thought in early revisions of the ref-filter work that we
> > might have to split on path components, but it turns out that the
> > underlying ref code is happy to take arbitrary prefixes. And it's that
> > code which defines our strategy; Even if the ls-refs code wanted to
> > allow only full path components, it should be using the limiting from
> > for_each_ref_in() only as an optimization, and applying its own
> > filtering to the output.
>
> Having now looked carefully at the ls-refs code, it's a pure
> prefix-match, too. So I think we _could_ rely on for_each_fullref_in()
> returning us the correct full results, and not checking it further in
> send_ref(). But I kind of like keeping it there as an extra check (and
> one which could in theory grow more logic later).

Hmm. What if the caller asks for:

  ref-prefix refs/tags/a
  ref-prefix refs/tags/b

?

The LCP between those two is refs/tags, so send_ref() will presumably
get lots of reuslts that it doesn't care about (assuming there are tags
besides a and b).

Thanks,
Taylor
