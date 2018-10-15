Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81441F453
	for <e@80x24.org>; Mon, 15 Oct 2018 05:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeJONG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 09:06:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52134 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJONG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 09:06:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so17382164wmf.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 22:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6Si7NdnQLPdKmDTJiUMzrO30EhUr3cyO15YwIKH6pTw=;
        b=kq1atRF72SKfqiv1Y8xRWF/yLaEgEeheYJhFercH/9LsT+l2LKGgUaqAYxgXp7Ux4J
         sI0tWNAVzZWbnKV/BEtqrqhV+epmwnNqK78v78vGPDNdFfFm++9Ov/MRpSVV6AdyoS92
         X37O/gvuBDRBguvV01gBfQjAaZJm7V8iIv+qrx4utBwm4AqHW7fP9h3ljydFKwe6IryP
         B4Wkz8O4urwmxs4/zQ++sN1LtuxQvJ0t0w5J5cJj0oxul+OJiSKbS6yi2d9ltym58gCq
         TREKvcBJex819XYgaXm0583XXQldypwaAe2qwSLECAi7ySul5UEnXcTF7FsHhWgJQBVW
         yrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6Si7NdnQLPdKmDTJiUMzrO30EhUr3cyO15YwIKH6pTw=;
        b=N3izA9aMzk/TSiiuFOf1D3iM4cnCh9WCE0zY6UDBun65buLaMihGIpLej3kUfnvY+v
         W3WtxZBN5pxQkDFwzPpaLbh7zRToOklOdliEuIlrYasJZYJLST5N4HMyHZGabbygvZ/g
         HTOTiRQWd2+jztpEpfKu8cezKLS5gbVKoU2qQ+nfAItV8nzJxF8xm4Ksw3OeTKOrF4n8
         DZnRw6Sse6W4r4ciYvCwZ3XCOrmkcolSDFBX7GJpuxz14dnQgp44jy93B87/ZxPfyMjo
         or3RIAN7or33638E7RCm58wNCychnlNZd618MOLkZMxNpP2BYny3qBAXzQJDx6eHCawX
         mm2w==
X-Gm-Message-State: ABuFfoh1dPwFfFeqN6cfVdTNgpOG4oFjltdton3qGUXJRiuvKsTFExtd
        pTvLrCbxBwmpN14i8x4zu90=
X-Google-Smtp-Source: ACcGV61yGkrrMiVPiMbJ1QmHj3CL1AyhN3kcMvQ39AThYNqKWQ6ajYbWiOJ0bNI0Jhz4zqPZBShAlA==
X-Received: by 2002:a1c:1452:: with SMTP id 79-v6mr11493894wmu.31.1539580997080;
        Sun, 14 Oct 2018 22:23:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b143-v6sm13791649wma.28.2018.10.14.22.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 22:23:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] merge-recursive: Avoid showing conflicts with merge branch before HEAD
References: <20181012212551.7689-1-newren@gmail.com>
        <20181012212551.7689-5-newren@gmail.com>
Date:   Mon, 15 Oct 2018 14:23:15 +0900
In-Reply-To: <20181012212551.7689-5-newren@gmail.com> (Elijah Newren's message
        of "Fri, 12 Oct 2018 14:25:51 -0700")
Message-ID: <xmqqzhvf4wcc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The correct order usually comes naturally and for free, but with renames
> we often have data in the form {rename_branch, other_branch}, and
> working relative to the rename first (e.g. for rename/add) is more
> convenient elsewhere in the code.  Address the slight impedance
> mismatch by having some functions re-call themselves with flipped
> arguments when the branch order is reversed.

I've never noticed or felt disturbed myself, but thanks for this
level of attention to the detail.

> @@ -228,7 +228,26 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
>  					      struct stage_data *src_entry1,
>  					      struct stage_data *src_entry2)
>  {
> -	struct rename_conflict_info *ci = xcalloc(1, sizeof(struct rename_conflict_info));
> +	struct rename_conflict_info *ci;
> +
> +	/*
> +	 * When we have two renames involved, it's easiest to get the
> +	 * correct things into stage 2 and 3, and to make sure that the
> +	 * content merge puts HEAD before the other branch if we just
> +	 * ensure that branch1 == o->branch1.  So, simply flip arguments
> +	 * around if we don't have that.
> +	 */
> +	if (dst_entry2 && branch1 != o->branch1) {
> +		setup_rename_conflict_info(rename_type,
> +					   pair2,      pair1,
> +					   branch2,    branch1,
> +					   dst_entry2, dst_entry1,
> +					   o,
> +					   src_entry2, src_entry1);
> +		return;
> +	}

;-)
