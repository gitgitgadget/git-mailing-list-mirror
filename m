Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B64C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352374AbhLFVsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352372AbhLFVsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:48:03 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BCFC061A83
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 13:44:34 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so15410057otu.10
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 13:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f3gM61BqKcFEyPcOdZjQyHgLOqrHAGiECb+Q/I4AUZQ=;
        b=Qgh2lpnctJsfidMim9RnHHtMDKqxKLqJ87xUCkljHrh2q14yvmaJjrTVm1LmLo+pRR
         ApJkI4+WEUmjHu8SG7X6lGn+acWZ2sHeoTX+pErxrhfio46iVg7dszydESoV5G0VDu+5
         mIFEJXnMWaiP84880rsqzVo0+Npkr8gjOuf9orGGETLO5RxP0nSoCqNcmslLIEpCW6EU
         nxDqqHhPQaaxsYOnPZMADJV/lTZdbF0WJzimLz+KMe0RKG2vjpTKL/nLMNdnPatKgq4o
         lOMGukc/dyC5ZpHkfUFriOX9e8M7Qdfi6+th4hQEAfl+221DNZ5nPMbnchh5xRnIhT/x
         mVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f3gM61BqKcFEyPcOdZjQyHgLOqrHAGiECb+Q/I4AUZQ=;
        b=R2qde1FRw/LDkUPu3rumKldKA70TY6MGD8FOL3Tw91nnT3oGREmlyR4di52SnBm+aR
         sTSUMZKM8ePHftC2kLsoAuP31S6jzThNCGo7JZXj44x/AyCrrrcG9ncbftA82uy2XCAX
         HkCRe0g33M56aQqtN9rPJOTnSPbr1dnkY7pfNz/1LZ3il0w6un7WP6gegBAqlH+vnFZq
         FM0LKM7gRfhkDcgdEjHTskMrb9g2POwGh0n4ny/v7g+5F4xEd1DZ98Ep/iqKRc1hpQrA
         6Jv9l3ZD7CIvQpOuTfmHA9O/5LehLqWrvy40BUCh42Vg/qNTvS+WVTCx0s4l5L5m5U1n
         DgHQ==
X-Gm-Message-State: AOAM533wkdXsPDDVl3g7NrkoJJOqRYl2dCohZCEjdxdYyqjhN/037dX7
        OW8XVvvBXc60SoEOKUjFoUM=
X-Google-Smtp-Source: ABdhPJxv1JXlJRj5aKz1aKFmYWSDjs5bm00MiCDCzT6j/CydLaI0X72NvLtY4MypEc1TlplBFlY1Pw==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr32571583otm.245.1638827073433;
        Mon, 06 Dec 2021 13:44:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:88f0:5cbe:30c7:d6dc? ([2600:1700:e72:80a0:88f0:5cbe:30c7:d6dc])
        by smtp.gmail.com with ESMTPSA id l6sm2419069otu.12.2021.12.06.13.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:44:32 -0800 (PST)
Message-ID: <b3a30e27-7821-1fcb-bacc-07a6d2b3df76@gmail.com>
Date:   Mon, 6 Dec 2021 16:44:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 08/17] builtin/pack-objects.c: --cruft without expiration
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:
> Generating a non-expiring cruft packs works as follows:

I had trouble parsing the documentation changes below, so I came back
to this commit message to see if that helps.
 
>   - Callers provide a list of every pack they know about, and indicate
>     which packs are about to be removed.

This corresponds to the list over stdin.
 
>   - All packs which are going to be removed (we'll call these the
>     redundant ones) are marked as kept in-core, as well as any packs
>     that `pack-objects` found but the caller did not specify.

Ok, so as an implementation detail we mark these as keep packs.

>     These packs are presumed to have entered the repository between
>     the caller collecting packs and invoking `pack-objects`. Since we
>     do not want to include objects in these packs (because we don't know
>     which of their objects are or aren't reachable), these are also
>     marked as kept in-core.

Here, "are presumed" is doing a lot of work. Theoretically, there could
be three categories:

1. This pack was just repacked and will be removed because all of its
   objects were placed into new objects.

2. Either this pack was repacked and contains important reachable objects
   OR we did a repack of reachable objects and this pack contained some
   extra, unreachable objects.

3. This pack was added to the repository while creating those repacked
   packs from category 2, so we don't know if things are reachable or
   not.

So, the packs that we discover on-disk but are not specified over stdin
are in this third category, but these are grouped with category 1 as we
will treat them the same.

>   - Then, we enumerate all objects in the repository, and add them to
>     our packing list if they do not appear in an in-core kept pack.

Here, we are looking at all of the objects in category 2 as well as
loose objects.

> This results in a new cruft pack which contains all known objects that
> aren't included in the kept packs. When the kept pack is the result of
> `git repack -A`, the resulting pack contains all unreachable objects.

This now describes how 'git repack' will interface with this new change
to pack-objects. I'll keep an eye out for that.

> +--cruft::

Now getting to this description.

> +	Packs unreachable objects into a separate "cruft" pack, denoted
> +	by the existence of a `.mtimes` file. Pack names provided over
> +	stdin indicate which packs will remain after a `git repack`.
> +	Pack names prefixed with a `-` indicate those which will be
> +	removed. (...)

This description is too tied to 'git repack'. Can we describe the
input using terms independent of the 'git repack' operation? I need
to keep reading.

> (...) The contents of the cruft pack are all objects not
> +	contained in the surviving packs specified by `--keep-pack`)

Now you use --keep-pack, which is a way of specifying a pack as
"in-core keep" which was not in your commit message. Here, we also
don't link the packs over stdin to the concept of keep packs.

> +	which have not exceeded the grace period (see
> +	`--cruft-expiration` below), or which have exceeded the grace
> +	period, but are reachable from an other object which hasn't.

And now we think about the grace period! There is so much going on
that I need to break it down to understand.

  An object is _excluded_ from the new cruft pack if

  1. It is reachable from at least one reference.
  2. It is in a pack from stdin prefixed with "-"
  3. It is in a pack specified by `--keep-pack`
  4. It is in an existing cruft pack and the .mtimes file states
     that its mtime is at least as recent as the time specified by
     the --cruft-expiration option.

Breaking it down into a list like this helps me, at least. I'm not
sure what the best way would look like.

(Needing to pause here and look at the implementation later.)

Thanks,
-Stolee
