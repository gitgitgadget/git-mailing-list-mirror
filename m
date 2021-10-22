Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C094C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B6260273
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhJVWtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhJVWtj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:49:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20DC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:47:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s3so5934619ild.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IlufdNaTqLnE3RlqPdYWdAf42mjhs3oj2Xzhjh8F8VQ=;
        b=6eypBMMxtJltIP5xuocmE4kqXWDU6ZV5Hx+qtJIxadJf8YIfoPeAIdvQ0gW8Fr63qR
         ZrgI8I6UfnXd30uX3CHcpx5JcOLJbHmiRAZe0ZBfvydCwcnBf1N585a3kItehUb6hp82
         JB24NspikZvURjtt6yfkS0Vlw2wWzeqBslYgOSL2gwEpPlm36qH+qXhNK23Gjmvo+ooP
         /j5nA1aa0r3sTN/byACkafLFTI22IymML6cS0VmmQQjB7XZN+ke0BYOkuGMFPrt3gpaV
         HlqDdRPzzqwKeyehIydkGzHVo1fb4Mns0pEw9m5sD7OIlzW2y+W884vMQkK8rYAifWm2
         6EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IlufdNaTqLnE3RlqPdYWdAf42mjhs3oj2Xzhjh8F8VQ=;
        b=K4T6+qE+47/Hg1uXgWuqb7+0i6zVXRvUHlWX3/EUgV8zMXNwLGSRlSfamP1P+wJc/r
         Oj1Th6QN7HrjX3SzSClFmGdSH/7E5Tqpk/ft4pIUqHhpdBfvoE5wUofrDXuBL3z+6QVq
         wXCfZxRWcY3DGNpL8Wa9Gb6iu4hkacvXeLjcxEe7UFg0tMML3ZK78oC8r0OGZ9kH2R2T
         fbyGhCJWI6SZIsjwSmxBmR1M+us/YEegzeKOBQLnVhWZl59NId1si1JwBme8EhZ1Ad2Y
         c1Rxcm55slYJ2qp9SJd2Htmk+qYY7zuvZ6yL5cvrtAfC7GFHZidyD83jONm0iwrk8Ynk
         MoMA==
X-Gm-Message-State: AOAM532rC2mELBIoTpOIjpoon1RvpwwNGzkoupLYTJByn64puCerIMdj
        J7LinJo5xUm2u8KfueN4fHRDVw==
X-Google-Smtp-Source: ABdhPJxFxpZXjuuFX51TasYkGKpya5mJy4/4otrtYhwgbjCqd2iXxEcgbvZV6MN6QDdjO8wy5b7eoQ==
X-Received: by 2002:a05:6e02:1c23:: with SMTP id m3mr1666970ilh.194.1634942840826;
        Fri, 22 Oct 2021 15:47:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i2sm5124909ilv.63.2021.10.22.15.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:47:20 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:47:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 08/10] pack-bitmap-write.c: don't return without
 stop_progress()
Message-ID: <YXM/dw2llyrWA370@nand.local>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-08.10-e0a3510dd88-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-08.10-e0a3510dd88-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function.
>
> We could call stop_progress() before we return, but better yet is to
> defer calling start_progress() until we need it.
>
> This will matter in a subsequent commit where we BUG(...) out if this
> happens, and matters now e.g. because we don't have a corresponding
> "region_end" for the progress trace2 event.
>
> Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  pack-bitmap-write.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 9c55c1531e1..cab3eaa2acd 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -575,15 +575,15 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
>
>  	QSORT(indexed_commits, indexed_commits_nr, date_compare);
>
> -	if (writer.show_progress)
> -		writer.progress = start_progress("Selecting bitmap commits", 0);
> -
>  	if (indexed_commits_nr < 100) {
>  		for (i = 0; i < indexed_commits_nr; ++i)
>  			push_bitmapped_commit(indexed_commits[i]);
>  		return;
>  	}
>
> +	if (writer.show_progress)
> +		writer.progress = start_progress("Selecting bitmap commits", 0);
> +

Ah, this is the change that you and I discovered independently. For what
it's worth, I wrote something slightly differently, which was to jump to
a "cleanup" label and then call stop_progress() there instead of waiting
to call start_progress().

But thinking on it more, I think that difference highlights a compelling
reason to get rid of this progress meter entirely. That's because this
rule of "if there are fewer than 100 commits, select all of them"
doesn't even update the progress meter!

And the loop that it is timing below is so fast that we end up just
showing the final count, which doesn't provide any useful information
beyond how many commits *could* have been selected.

So I think that your fix is OK, and I'd be happy to see this get picked
up as-is, but I'd be equally happy to drop this progress meter
altogether.

>  	for (;;) {
>  		struct commit *chosen = NULL;
>
> --
> 2.33.1.1346.g48288c3c089
>
Thanks,
Taylor
