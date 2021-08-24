Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB3C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB024611F0
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhHXVIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhHXVIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:08:41 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6BBC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:07:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h29so21921001ila.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tfMBkBW8cDmqrIffqQ5uVYdI9Xr6Xwc+istfGoaWVDc=;
        b=EFTwfbGmW7Rn7tvN1nbjsAVqcZlIX6K6ySFjluCNjq6OKVJvIn9viz8iF4pIo6qvJd
         oVWpbzvoJYl8L/hcZcQfXD8prlUwhIjvkHdjk104ToYhLngspF2fg25C2+2hAaxe/FIJ
         IUEjkmkS+rEVmyxgNKK2UAxrmLGpjAspz9+oLwBSnZESy4Ba4Nno4L+KcSTc5zclhDVz
         lcUOKh41zQvKvY4zsACQ5rhwAfot/8fKBhl7p1L8LcEQgGpoEbBlhIa2GXx+POz4E8Zx
         1oSxCepePMLtXDwk7SgbSyT5gYO0tpeMf0qE1p2JzCKYj+MYxOtrFYx5Q/ntkHk/Cgaj
         VkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tfMBkBW8cDmqrIffqQ5uVYdI9Xr6Xwc+istfGoaWVDc=;
        b=E+YoYcmybsVGWXb4KFeEMXuFDuk7KnsxbL2m8zvAU3N5aF/fANh+2MEZpgo5pMiJ4P
         ga71J+QNe9Ijl+HrmQ9PqKCYlJf48GDL6Y72RIboeUOPFDFQBHr/P32DLcTuUihT96Bi
         KpdNiPWpBhNsYLeJIu7Yj+QeUj2J4CjqIOINgSY0oSpWCgAVJR5YPFlIB9XMEbrECP+X
         4ivTad6Oty4KU0inRMD2NVseUdLeP3HnrspceYtk8N2s/fOqW/gKASQsALn8T5Q3aiCD
         lyhVGZ97iM/fc7od6uWNlxW9Vu62qr1Q9q3UZOJbvlpKVLKajdfISekEwrJX7kXCPX2j
         q/cA==
X-Gm-Message-State: AOAM531rHpZFY/bTOErgdoALQojKYKWGH/iuSRLHgyAHviRw7Y1DFQ/m
        LVV3X8NDBcuxM+11R+Wmk53vdw==
X-Google-Smtp-Source: ABdhPJzu+1WlIjYCFHOLTW0/ethmwAqLuxw2iUaHpiM9uq7d8EjOsbswQn8yp5/gi8xAwFciNJKAxw==
X-Received: by 2002:a05:6e02:1a4f:: with SMTP id u15mr28274138ilv.251.1629839276780;
        Tue, 24 Aug 2021 14:07:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k6sm10194278ilu.41.2021.08.24.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:07:56 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:07:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack: buffer ref advertisement writes
Message-ID: <YSVfq9lZGdSRCcP9@nand.local>
References: <20210824140259.89332-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210824140259.89332-1-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 04:02:59PM +0200, Jacob Vosmaer wrote:
> In both protocol v0 and v2, upload-pack writes one pktline packet per
> advertised ref to stdout. That means one or two write(2) syscalls per
> ref. This is problematic if these writes become network sends with
> high overhead.
>
> This change adds a strbuf buffer to the send_ref callbacks of the v0
> ref advertisement and v2's ls-refs. Instead of writing directly to
> stdout, send_ref now writes into the buffer, and then checks if there
> are more than 32768 bytes in the buffer. If so we flush the buffer to
> stdout.

Are there any consumers that rely on having information early (where
buffering would be a detriment to them)?

> To give an example: I set up a single-threaded loop that calls
> ls-remote (with HTTP and protocol v2) on a local GitLab instance, on a
> repository with 11K refs. When I switch from Git v2.32.0 to this
> patch, I see a 50% reduction in CPU time for Git, and 75% for Gitaly
> (GitLab's Git RPC service).

Hmm. Seeing a reduction in CPU time is surprising to me: do you have an
explanation for why the time-savings isn't coming purely from "system"
(i.e., any blocking I/O)?

> So having these buffers not only saves syscalls in upload-pack, it
> also saves time in things that consume upload-pack's output.

I don't think this explains it, since any time spent waiting on
upload-pack output should be counted against the system bucket, not CPU
time.

> ---
>  ls-refs.c     | 13 ++++++++++++-
>  upload-pack.c | 18 +++++++++++++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 88f6c3f60d..7b9d5813bf 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -7,6 +7,8 @@
>  #include "pkt-line.h"
>  #include "config.h"
>
> +#define OUT_WRITE_SIZE 32768
> +
>  static int config_read;
>  static int advertise_unborn;
>  static int allow_unborn;
> @@ -65,6 +67,7 @@ struct ls_refs_data {
>  	unsigned peel;
>  	unsigned symrefs;
>  	struct strvec prefixes;
> +	struct strbuf out;
>  	unsigned unborn : 1;
>  };
>
> @@ -105,7 +108,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	}
>
>  	strbuf_addch(&refline, '\n');
> -	packet_write(1, refline.buf, refline.len);
> +
> +	packet_buf_write_len(&data->out, refline.buf, refline.len);
> +	if (data->out.len >= OUT_WRITE_SIZE) {
> +		write_or_die(1, data->out.buf, data->out.len);
> +		strbuf_reset(&data->out);
> +	}

None of this looks wrong to me, but it might be nice to teach the
packet writer a buffered mode that would handle this for us. It would be
especially nice to bolt the final flush onto packet_flush(), since it is
otherwise easy to forget to do.

Thanks,
Taylor
