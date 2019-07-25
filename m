Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B021F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 20:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGYU1Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 16:27:16 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35135 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfGYU1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 16:27:16 -0400
Received: by mail-ua1-f65.google.com with SMTP id j21so20420526uap.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CbiAW9n1UCj44xF5FjlCybHPC9Lr1uoQAPqdbOFLK7g=;
        b=DPVyymZF9qw27HGX35YA68aNb1+cWrL7lTogaBJDdZ/x/Rgj9TASEWHV649qsBqAGa
         bv4sOJ1JFUh/PW7zc7iyKGlciVIJdz9U6pMiqqEpeM8Nz/5s7sVUCIVEz0rImaOB88gd
         lWvhkN3EQmFyQ34it4soCK1Z8LSC9oy/R832QQBGFID9MSWZ7qfSq7EXaInGkzDL/gyh
         B/tB43As81FO8jF9A968cY0/WEiy8WrHALuoYUYYnKs9rYPoiIwC2wwXEAr+mp4V1TWt
         a6IBxnUaSZUALl5wd4bsof8SCElOXe4DuVa4w99Y88LVNnX7392rqP8oDLVEK8O4QCE0
         21Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbiAW9n1UCj44xF5FjlCybHPC9Lr1uoQAPqdbOFLK7g=;
        b=rh+oCReeprVQEiqtIluHT5QNSNFb90sye57IKiDNtLk84HuYv89PqHW4/LMg6C0QJ/
         x1MM7GoSXCAoLe0UIao4zqrAiiap6WEO0r6bXStJlETsl1UFHVBLe2Oy++39rVxEvdjb
         PQl+4zzo3I+tb9WXxB6FflVY1SdRSAvv3gWjmEBbKneF8NYSJ/gpHWGorJjKEm/d86wq
         uEgre64OIpP9Y4ylzgPm+yi7x5GsruRNrR88+ScSEP4aU2yjQc10vd/oWEhMfhprDYhF
         sui0Ky7eUkD1e/pg8nmNDTvYM5TqWZy6K9+AklpzHyvdax8sYAdaDzVQLOdNkP+nfKpC
         Px0A==
X-Gm-Message-State: APjAAAXa39wLzmDjieE8wdCqi+NjM826pxW7/dWYD9ylwWuoY83EPG/V
        YaCTpa4x0VIPwZ4CLvlGpU3sNQIApzFvnwhlyp9vD2XJ
X-Google-Smtp-Source: APXvYqynbYthjEDyGADI9hu2rlkrVc3UyAHWYAS/NeN6NV1kglBZkAflBWBpT4WgqKoUzQ2XBMggYJt4wtv7+zqT9b4=
X-Received: by 2002:ab0:6911:: with SMTP id b17mr6553701uas.18.1564086434911;
 Thu, 25 Jul 2019 13:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-16-newren@gmail.com>
 <nycvar.QRO.7.76.6.1907252206180.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907252206180.21907@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Jul 2019 13:27:03 -0700
Message-ID: <CABPp-BGpCEZ-40_SsT_vU+hCP=MiKzhky6yBr6G=UMnwLNR2Ow@mail.gmail.com>
Subject: Re: [PATCH 15/19] merge-recursive: split internal fields into a
 separate struct
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 1:12 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 25 Jul 2019, Elijah Newren wrote:
>
> > merge_options has several internal fields that should not be set or read
> > by external callers.  This just complicates the API.  Move them into an
> > opaque merge_options_internal struct that is defined only in
> > merge-recursive.c and keep these out of merge-recursive.h.
>
> This method requires an extra `malloc()`/`free()` pair, leaving room for
> leaks.
>
> I'd rather keep the definition of that struct in `merge-recursive.h`,
> and make the `priv` field a full struct instead of a pointer. That would
> save on that extra allocation.

Yes, it has one extra malloc()/free() pair for the entire merge operation.  But:
  * That's a drop in the bucket compared to the allocations already
performed during a merge
  * The allocation and free happen in merge_start() and
merge_finalize().  Not much to keep track of, so not much room for
leaks.
  * I want what's currently in merge-recursive.h to be as simple as
possible; I implemented your suggestion first, but it doesn't simplify
as much as possible.

But, more importantly:
  * I want to write an alternative merge strategy providing drop-in
replacement functions for merge_trees(), merge_recursive(), and
merge_recursive_generic(). Defining merge_options_internal inside
merge-recursive.h would mean that I have to have _exactly_ the same
internal options in my implementation of merge-ort.c.  That doesn't
make sense.

Elijah
