Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC4420372
	for <e@80x24.org>; Mon,  9 Oct 2017 23:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755195AbdJIXgT (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 19:36:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35185 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbdJIXgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 19:36:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so31121435pfi.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZOJW0GN2QT9BiijLqzrfo8fUXrkzIRPPVMOx5QjfFs=;
        b=mOVFrKSonyRtVSi9EcZ3A1jrJs/q61fxUM1qhf8RvqTQ7HwP6+rc5wUHFNZL7nGh2f
         HZbiqDr/u5N3bQom9/PsgGjmSIF2mJ5L500tDoArURbVl+vYpp0wfm+6NAKfk7Qq6uBZ
         NDyvPXQJIOAhFZMoZHkGX0+J2wcaWa4+kLckXJiGPCpJVijwdl8h/7W+4i2MEwK9r8ez
         Fr16R1z0+k1CUTMRhhQGCG5tUTFifKFq3dDBLWcT/ljYR3IbnRDAK3R0ldDCOVEoyxzg
         zgd8v9Oln8/3OLH3jAzPALG9MHPwxKtagoUyoA1HW5JFaRheavT0n1KQ/6M9QQATblSa
         0oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZOJW0GN2QT9BiijLqzrfo8fUXrkzIRPPVMOx5QjfFs=;
        b=hJ3Td39w/EjURxGq6f/tNXUQ5jkJldUkKOcRzlTtz5si4V0Xg6gK+ueUTzIrI+OUVW
         sWELvHhawa2ysactvyj715cQDGRsTQG00XdNs96/NHlNyl8pBDVMfPkopHrlunsUnmOa
         Sr1fndGZDnadigXZ710/uMrNhzjClfw7QfNGeNHzOyh8mIQSoOFrxuakBqiKish+rria
         +XeSmL6GxF4UQJyJxMbDkrj7Lfox9n5/jDtD4mQkFVbq6io5nCKO2jFNxuhLSH9TvhED
         ICI0Vt5F1oHjP2kgVabCbX9NQqgJrOQoW/Ywx5YofsGX1fDMt2Jq/deAhgbWumzH7SGF
         8+Cg==
X-Gm-Message-State: AMCzsaUFYoGYFiIAjQj8m5z89qYhioLLdLL0FsMAvtblsHF45PmmcHgu
        JYvLUrFqDRobMMLq+BQMNQE=
X-Google-Smtp-Source: AOwi7QB8sEcZAdQn7v5wt6lvtomwNp0OCJPleZThMroSLBaPT4ZMX9DSoV69TmY6Mologj20XdJ2gQ==
X-Received: by 10.98.194.143 with SMTP id w15mr11492561pfk.34.1507592178099;
        Mon, 09 Oct 2017 16:36:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id g24sm18784653pfk.0.2017.10.09.16.36.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 16:36:17 -0700 (PDT)
Date:   Mon, 9 Oct 2017 16:36:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 07/24] refs: convert resolve_refdup and
 refs_resolve_refdup to struct object_id
Message-ID: <20171009233615.GK19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-8-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-8-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> All of the callers already pass the hash member of struct object_id, so
> update them to pass a pointer to the struct directly,
>
> This transformation was done with an update to declaration and
> definition and the following semantic patch:
>
> @@
> expression E1, E2, E3, E4;
> @@
> - resolve_refdup(E1, E2, E3.hash, E4)
> + resolve_refdup(E1, E2, &E3, E4)
>
> @@
> expression E1, E2, E3, E4;
> @@
> - resolve_refdup(E1, E2, E3->hash, E4)
> + resolve_refdup(E1, E2, E3, E4)
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Lovely.  I tried putting that in contrib/coccinelle/resolve_refdup.cocci,
running

  git grep -l -e resolve_refdup -- '*.c' '*.h' |
  xargs spatch --in-place --sp-file contrib/coccinelle/resolve_refdup.cocci

and diffing the result against this commit.  With --word-diff, there
are a small number of changes:

- the above semantic patch handles resolve_refdup but not
  refs_resolve_refdup.  This commit does both.

- as mentioned in the commit message, the above semantic patch only
  updates callers.  This commit updates the implementations to match.

Without --word-diff, I also see some line-wrapping changes, which all
seem reasonable.  (Coccinelle's line-wrapping heuristics seem to be
pretty specific to Linux kernel style.)

In other words, this does what it says on the cover in a
straightforward and reviewable way.  Thanks for that.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
