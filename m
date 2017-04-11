Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9B920970
	for <e@80x24.org>; Tue, 11 Apr 2017 21:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbdDKVaB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 17:30:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32793 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753516AbdDKV37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 17:29:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so1706415pgf.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2G+5J1wDE4j5smrI4leLzuJP7C8/9v5mZmbbqTN1VQ=;
        b=a1ovPTd2XyHxqWyP46cTSktA6BCHeKR+2hosIosOKY4eC6N5j6CmtifdGa8v0RckbY
         kQEiwp6KiDy/Oc/KXI8qoKo29qsLlnqXlb7Fn0ZD1JVaYM1abELO/D6WfJof5Sjsv1Gh
         UzmzjICOWhJriGYFRDauBIto9mOs4bN3H590IO+fI19XQBDG8W1RSDbGsYAViMXaIlVz
         kpelAx1NM5B+nrC6KhSKLkuHnD4UgYg5ha4y9VzLW1OuhQL6lPXQU6LaMg7IAb0RSSed
         4YPYH33mC1LJDuUXPkq5yxSK8Q/Vcl4h9ZGNJeBNif0MzI2eycKKhXFWOmaI8O3vShvT
         ydiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2G+5J1wDE4j5smrI4leLzuJP7C8/9v5mZmbbqTN1VQ=;
        b=DWZyMDRNy1z18UPgnDVzH86Oix+tx+zPbmMBaxEmi3mUOEdLU+XbHOMCx8WKafRcM1
         W2MEBn65Lxb1RjM7aJvqzG3F1RAxk1QjBNhFm5rEHAtQy8YzWRzwgpHHpoVrCJtrrfAN
         9z6D/vwcz+FxbokjL9Ax3s3P2fPiWwxBT/ZuXe8ZL7nwTWnmrQ0iwzlldp8S9RlMipbB
         sptB5L3DhgGamx/LnytiOd2yu6UvWxfRjdcaUWcjoI9Cj68U8AW5AvfJBqOETN+vZ9HI
         bQm0EyVCWmmk9Poj9fmU3PGcZysFJSI77U5BMw7UlALkng3n0/6AjgzoiYnKuB1W3n68
         QeyQ==
X-Gm-Message-State: AFeK/H37NQ9CMDtSDd337qp4pXczapewoZhdybp98Dy4LVHCHV7bAuAA0ALV5LKqlH7Ksw==
X-Received: by 10.98.49.129 with SMTP id x123mr40523856pfx.45.1491946198477;
        Tue, 11 Apr 2017 14:29:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id 11sm32257556pgf.28.2017.04.11.14.29.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 14:29:57 -0700 (PDT)
Date:   Tue, 11 Apr 2017 14:29:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 1/2] string-list: use ALLOC_GROW macro when reallocing
 string_list
Message-ID: <20170411212955.GP8741@aiede.mtv.corp.google.com>
References: <20170411200802.31638-1-git@jeffhostetler.com>
 <20170411200802.31638-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411200802.31638-2-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com wrote:

> During status on a very large repo and there are many changes,
> a significant percentage of the total run time is spent
> reallocing the wt_status.changes array.
>
> This change decreases the time in wt_status_collect_changes_worktree()
> from 125 seconds to 45 seconds on my very large repository.
>
> This produced a modest gain on my 1M file artificial repo, but
> broke even on linux.git.
>
> Test                                            HEAD^^            HEAD
> ---------------------------------------------------------------------------------------
> 0005.2: read-tree status br_ballast (1000001)   8.29(5.62+2.62)   8.22(5.57+2.63) -0.8%
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  string-list.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Nice.  After rebasing (or just squashing together) with the p0005
patch as peff suggested,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
