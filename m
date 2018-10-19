Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6C81F453
	for <e@80x24.org>; Fri, 19 Oct 2018 01:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeJSKCD (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 06:02:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54887 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJSKCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 06:02:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so2070801wma.4
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oCxylyKcl5rIwUZtodqyWfGJWwwg+3K4FemIfIEWSuk=;
        b=q+MdcA5XpXRea685aKlgVZSg+y7vpO8eFMR3uSaqmZgpA//8nhtwuEvgyalOnGNeA+
         WcZ8t/S+O+ixZfNS3nLoafdUPc/cg8Vs+gbWzBOTNJ24+aVzhj/gedOZdRU4HrDy6oGz
         AAzlDCsd203LGL2PrDfmCAVaozWM8BfPxH6t08oeijR0l5oa3TyzdWRq6VHfMpbwZLkG
         prTiwtWj+vtHbgurD2Z0Y/8ZG6g5PuzrX4J07MINdPqLl2GVzQiwtOtLXroOyAFM26KA
         wBaENfeSLxpE/wkT0OokA+i2BmlXhGXcr+hWqsbEBeMl5af/lrBLtCiCnMsivavDHgLd
         m+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oCxylyKcl5rIwUZtodqyWfGJWwwg+3K4FemIfIEWSuk=;
        b=ClgbiTX/4P6TrZpdSUmSZ+1NF0O0M+/t6QNWT1ko2fZO+MPLTiwSxGSpxSP/7NLFXD
         vEVb9dqxXnM5aP7PPG0kGmtipleCzYGro3X7pqdhVvvGqn3G6NlP16e2nbCq026dVJ/0
         xRF+wocvEuUZXWy+fPTS3K6ZdAvEINBcLAmCgVLLMxnYt20+qIQ6WaY99J+hIjnERu43
         gCQugV1bMB00Cm2mkEZS2i33zCIchstNsg43Rue9FQv2421JjCGFXwfG7kx89tneJ0J7
         +RQ/r6zfGJAM+8lthZjB6FCZ6Zh7Dh/eyCZ/9AL/NFaATfyjqNRg56u57Pq+o4Kl7Uk7
         8r/A==
X-Gm-Message-State: ABuFfogLgpFIoRL90juuuTsgE5KDv3Q0K9pcjRHdkKHqICteRhMhHhpp
        EgHF9hjLGnZClTOHz+jWggc=
X-Google-Smtp-Source: ACcGV61dJcW0NQMuQHH+l9RtLt8TsYZKLbmWHjDn64i1ug/NKJ+XbywFBrhvKt4V8WkksJxMESP0Lw==
X-Received: by 2002:a1c:1c0c:: with SMTP id c12-v6mr2554564wmc.18.1539914288842;
        Thu, 18 Oct 2018 18:58:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e14-v6sm22488113wrt.76.2018.10.18.18.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:58:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] index_bulk_checkin(): Take off_t, not size_t
References: <20181018191140.23318-1-tboegi@web.de>
Date:   Fri, 19 Oct 2018 10:58:06 +0900
In-Reply-To: <20181018191140.23318-1-tboegi@web.de> (tboegi's message of "Thu,
        18 Oct 2018 21:11:40 +0200")
Message-ID: <xmqq36t24s0h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> bulk-checkin.c | 4 ++--
>  bulk-checkin.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

If you lost SP in your editor, then it is OK but if format-patch
lost it for some reason, plasee tell me as we need to find the bug.

>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 409ecb566b..2631e82d6c 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -189,7 +189,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
>  
>  static int deflate_to_pack(struct bulk_checkin_state *state,
>  			   struct object_id *result_oid,
> -			   int fd, size_t size,
> +			   int fd, off_t size,

The size is once casted to uintmax_t for recording in the object
header (which is fine), and then passed to stream_to_pack(), which
still takes, and more importantly, does comparisons and chunking in,
size_t after this patch.  Without xsize_t() around size passed in
the call to stream_to_pack(), you may silently be truncating off_t
down to size_t in this function.

> @@ -258,7 +258,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
>  }
>  
>  int index_bulk_checkin(struct object_id *oid,
> -		       int fd, size_t size, enum object_type type,
> +		       int fd, off_t size, enum object_type type,
>  		       const char *path, unsigned flags)
>  {
>  	int status = deflate_to_pack(&state, oid, fd, size, type,

This one is a thin wrapper around deflate_to_pack() above.

Its sole caller is sha1-file.c::index_stream() and takes size_t from
its callers, and passes size_t to index_bulk_checkin().

The sole caller of index_stream(), sha1-file.c::index_fd(), wants to
pass st->st_size, and it uses xsize_t() because index_stream() and
callchain underneath currently take size_t.  You want that callchain
to take off_t with this patch.

The whole purpose of stream_to_pack() is to take potentially large
input from the file on the filesystem, chop that into manageable
chunks and feed the underlying hashing and deflating machinery that
takes possibly smaller integer types to represent the sizes of data
they take in a single call, so once that function is taught to take
ofs_t I think you can say you converted the entire callchain from
index_fd() down.

So, this looks like a good starting step, but I suspect it needs one
more level of digging for it to become truly useful.
