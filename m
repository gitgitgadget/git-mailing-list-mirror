Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF5620282
	for <e@80x24.org>; Tue, 20 Jun 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdFTV7p (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 17:59:45 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36567 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFTV7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 17:59:44 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so49045824pgb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwnIfo0WTGEqid3SyPD2pcwNXuIAekGCU66XgFuIkQY=;
        b=ghBFFBAY23ytqRccSJOhILTSIrv14CwTDlNEnq2cb3ubugejAnYZJJZ2SZYN1LFMKC
         X2f2kfAw+mAjX32CuhogWVz7ChooBhyklLGKVnkoIUY25ItoUAc7+xkINdeOJ/PUzJen
         qA8OHP6gJY9gP7OKByX1BtfBPv+Y/KtJQsk6O3PfZxlSyYdEpHbGjMbY4YsyPIgNzAY6
         Y789Xjuasf4WUgWqUBEDrlOA2SYRiauYAYe9+qWpu7VUwVrkbkYzaoe5nvgoF48D2Vw1
         DYY4neKQwHjjVPmuYP1Stelh4GEpbPkSnCYfjhCAa8hTiSYwXl6MjrGNYb0Ri/A/BpqD
         u3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwnIfo0WTGEqid3SyPD2pcwNXuIAekGCU66XgFuIkQY=;
        b=hMkUZtl6oR6dLkpsU20LrwHdRDZ9fr7ce8ivecvqZfFYIIhX6n3CCnx+sVxzY4iYWA
         1VqTeh4Vfv14/p1DJ18lUqIAVc/OgFF7EJ+m0O7aEnRV5GUxVHnrX8b3ghz+QNyVGlg/
         lb915k6VXyMFCuEp8XDKVTM0a/h6p7uQiqmjsoeowxGiVf7o4doem2FXM83lByUJjZSR
         hJJLeyJFG81drYwSbL2M8ZwTacMegkcTRSObJ+8kZ8pRk0KL6xpnwrN4X0l9drqKbDXb
         T6J3d0oySp0iqOawddndfIw8rVijOzrHwpz33lWVfQRRjZp3TWQ854t4RgWAqLve3aJi
         ey9g==
X-Gm-Message-State: AKS2vOzPW0AfdNESrt8iP2rgyngqOl6Qcea27zRIYlMBnyFI7B5Sh6qr
        RmPqqlUmzdzNTPh763AW9ilY
X-Received: by 10.84.229.71 with SMTP id d7mr21146686pln.231.1497995983901;
        Tue, 20 Jun 2017 14:59:43 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id b2sm27415318pgc.16.2017.06.20.14.59.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 14:59:43 -0700 (PDT)
Date:   Tue, 20 Jun 2017 14:59:39 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 05/20] environment: place key repository state in
 the_repository
Message-ID: <20170620145939.1caa78db@twelve2.svl.corp.google.com>
In-Reply-To: <20170620191951.84791-6-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-6-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 12:19:36 -0700
Brandon Williams <bmwill@google.com> wrote:

> Migrate 'git_dir', 'git_common_dir', 'git_object_dir', 'git_index_file',
> 'git_graft_file', and 'namespace' to be stored in 'the_repository'.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  cache.h       |  1 -
>  environment.c | 58 +++++++++++++---------------------------------------------
>  path.c        | 11 ++++++-----
>  setup.c       | 17 +++++++++++++++--
>  4 files changed, 34 insertions(+), 53 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 7c81749a9..cd64cbc81 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -771,7 +771,6 @@ extern int core_apply_sparse_checkout;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
> -extern int git_db_env, git_index_env, git_graft_env, git_common_dir_env;

In the commit message, it is probably worth mentioning commit 557bd83
which added these fields to attempt rewriting a path in do_git_path()
only if the appropriate _env flag is set, and that this patch removes
this optimization.
