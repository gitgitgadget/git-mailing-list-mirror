Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC6CC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC03C61401
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 23:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhJDXyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 19:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDXyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 19:54:50 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17112C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 16:53:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c7so18264776qka.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yYi+pRC8KFy/WEObBHbsjmFXwr93Qo0Ht0vHmv+wc4c=;
        b=tBvFjBVMMq49Q9BWbuUqY/OdGQJPU/v6Z3UyBo1tKAXcb/vhXfw90wFeMyJqTV52KH
         fOoNuWvF9NzMm5k6acdwpz47D+lFDGtQUYfHW3k67RC95iqfiTxrJcxyjnzKlqBWbLHv
         m8ihUg24mLIGoL+wHquXXLDBpddiNmg1JaVnRnxKb/8hv9rMOkj14gRPlR98dA2ix5qP
         sttNg7eM4wJtWsrHiRzsXp2OknT0CaflIUmqkY97vse31APrfhjcxoAS6R+iK/NKSo44
         kF0PDMAJ37CEh9ZhjFCrR/YsX65VyVkK/d7hX5LC9YgIw0840UbMeKB+cbJ6RG1kyXRw
         3v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYi+pRC8KFy/WEObBHbsjmFXwr93Qo0Ht0vHmv+wc4c=;
        b=sht3BOZ1n+EfsSOgTJPIHSVaVTG+3LuExHsJ9t9Kd3VkkYLzAQo48Th4voRH4xZMaj
         wnvQCS/F2rz+kPpE0jASlXG1qWyNs/8AMBkEMIGwi/MdnZKjZoYayShIyFxEg+Yzbq/r
         UtrMCbWzZdfZRPtIQiNq+SHtc5gkMQX/yCXoz8igvKKuHJ5aGpj7mmfSSDls/MHHyUHV
         3M/FK4XBhQKvBjIGeuTVFTtR3YqU/dFnS0xQephvM/IU/DNux7KLGYEzfD+OZVRLN1D+
         UCrV3ziFPRks6dJCWkMWU1g4H8/p1PQ6oLs6YTvyM72psyPL6iyTpjmI3b2+a69L9PIc
         SZfg==
X-Gm-Message-State: AOAM531eqaPpMKdyYL522OxKrRwKIzkzwFriDGAuU30aGe74M8wfx2dy
        BaBW5cNWXV6QHi0gQ08S1YyClA==
X-Google-Smtp-Source: ABdhPJzxaegF481GnPUlHhO77yciOpp2zJv5zvI/+Id5W7WIHVv1TOXop7tUj3d5sMc4oFFrBz9M3Q==
X-Received: by 2002:a37:6241:: with SMTP id w62mr12179594qkb.444.1633391579578;
        Mon, 04 Oct 2021 16:52:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d17sm11086997qte.0.2021.10.04.16.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 16:52:59 -0700 (PDT)
Date:   Mon, 4 Oct 2021 19:52:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Oct 2021, #01; Mon, 4)
Message-ID: <YVuT2aOzcjmgX+K0@nand.local>
References: <xmqqo884tkxd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo884tkxd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 04:44:14PM -0700, Junio C Hamano wrote:
> * tb/aggregate-ignore-leading-whitespaces (2021-10-04) 1 commit
>  Will merge to 'next'.

Thanks for picking this one up. I definitely wrote it as a sketch, but
I think it's useful as-is, so I'm glad to see it move forward.

> * tb/repack-write-midx (2021-10-01) 9 commits
>  - builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
>  - builtin/repack.c: make largest pack preferred
>  - builtin/repack.c: support writing a MIDX while repacking
>  - builtin/repack.c: extract showing progress to a variable
>  - builtin/repack.c: rename variables that deal with non-kept packs
>  - builtin/repack.c: keep track of existing packs unconditionally
>  - midx: preliminary support for `--refs-snapshot`
>  - builtin/multi-pack-index.c: support `--stdin-packs` mode
>  - midx: expose `write_midx_file_only()` publicly
>
>  "git repack" has been taught to generate multi-pack reachability
>  bitmaps.
>
>  Will merge to 'next'?

I think so. Jonathan Tan and others gave this a thorough review. I did
send a replacement for the last patch, which you can find here:

  https://lore.kernel.org/git/YVeN0mXqYvTHtNB+@nand.local

(I realize that this is in response to v2 8/8, but it should apply as a
replacement for the final patch in the *third* version of this series.
If it's too much of a hassle, I'm happy to just send you a clean v4,
too).

Thanks,
Taylor
