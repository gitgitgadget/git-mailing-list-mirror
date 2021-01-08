Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C46C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E153423A7D
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbhAHStY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbhAHStY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:49:24 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28254C061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:48:44 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h19so7200524qtq.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IguhXgf2fJ0sGoJOUEP1A0vgahI1wzwSbr2TH+7jYVQ=;
        b=nM3UcN+U4VMtNqRK4776cUbinvTEbIm6LQ6hbggIY/lFBvVIQVj4DaOfnRqqmbnhrT
         RFVzgm/suFlnToWrduiFmAYbvwhVXPHEPdWjM4ioc2VvU8/Ng/qJNV7Jv2lSxtOK2uub
         yFdJLCRZBvIIN2i5qVxqbe+DzrLkHae0+M+/dJlyHN1FyaZRi9gbTVi89qB7Odwli9up
         /9iKgN8p8emQlSpwxZZiRo8Jifcl5QVcJghgDxPjrvHFbzXeM+VPsXqDdek3YNUFLZLu
         hmQ8vJa7txg/DEpFhrMNrhcW690NMQ19LPfG6S9aIKcBWmb378MOATy/aXBQSt1KcamF
         QhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IguhXgf2fJ0sGoJOUEP1A0vgahI1wzwSbr2TH+7jYVQ=;
        b=ucN1pMRNMpOZDyypcvYTsQzL4vCGfInUNkWac2iE9YAnDIEyU7Gag8NyEB1nAfUmVw
         Uy2mBag0/d0e6ouKckbNTahiFVXpBJ09Q6svphWclHjo2EO+Or6MOlNu3VGI45VUkYH7
         SuZksozWAK0YcLwLXoqVG4e1pgQOYUZA0He9fijvJaif+NNLaQKRgVzJW1Mh5kNr9u5b
         nAAIK1+4JEcAwe/u/qingNyUfohlOnTYuXhQ2da4XKOVFZhmE5FHo1ejXTMPJ7mXXF0V
         FbH3S5XzAa5CwExIk++1kBsRH0Y3FVG69RYV8Cjjoe9VtBYpKpzV9Pzdkpw0rAzmTJSI
         g0NQ==
X-Gm-Message-State: AOAM531JqaRTfuhG2s+vJRRi3QcQCcAz6s3x2F9nhAlbEgt0bZS3OBQB
        u5DYjXTujNK7/kgadxZi9vc1si+ghXKlGQ==
X-Google-Smtp-Source: ABdhPJx4NBifBaekdnN8yQ+mXprldpa5D0k+OwUmlWlt+/nxhW87fDBzxIa5SG58BOPmbP7Ij/A1xA==
X-Received: by 2002:ac8:4e87:: with SMTP id 7mr4866472qtp.310.1610131723357;
        Fri, 08 Jan 2021 10:48:43 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id h1sm4741066qtr.1.2021.01.08.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:48:42 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:48:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Adina Wagner <a.wagner@fz-juelich.de>
Cc:     git@vger.kernel.org
Subject: Re: suspected race between packing and fetch (single case study)
Message-ID: <X/ipCPFyW3gAWrHo@nand.local>
References: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
 <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adina,

On Fri, Jan 08, 2021 at 05:39:12PM +0100, Adina Wagner wrote:
> Hi,
>
>
> colleagues encouraged me to report a "personal" bug I've stumbled
> across. Its "personal", because I wasn't able to create a minimal
> reproducer, or even reproduce it with the same script on other
> infrastructure. We're suspecting a race between packing and fetch. The
> script I am using is at the bottom of the email.

Indeed, similar races between fetching and repacking are known. For
example, this discussion:

  https://lore.kernel.org/git/20200316082348.GA26581@inner.h.apk.li/

is about the .idx going away during a fetch. A similar thing is
happening here, but instead of the .idx file going away, your source
repository is repacking (and thus getting rid of loose object files).

Here, I think the issue is less complicated. Since you're cloning from a
local repository, the 'git clone' command calls 'clone_local()', which
in turn calls 'copy_or_link_directory()'. If the directory being copied
changes while being iterated over, the receiving end isn't guaranteed to
pick up the changes.

Worse, if the source _removes_ a file that hasn't yet been copied, over,
then the copy will fail, which is what you're seeing here.

One workaround would be to clone your repositories locally with
'--shared', which won't copy any objects from the source repository, but
instead mark its object store as an alternate to the newly created one.

> I wonder if there is a way that Git could guard cases where background
> gc processes may still be running?

Perhaps Git could take some sort of lock when writing to the object
store, but an flock wouldn't work since we'd want to allow multiple
readers to acquire the lock simultaneously, so long as there is no
writer.


Thanks,
Taylor
