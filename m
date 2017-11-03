Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AD720450
	for <e@80x24.org>; Fri,  3 Nov 2017 20:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdKCUcd (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 16:32:33 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:54937 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdKCUcc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 16:32:32 -0400
Received: by mail-io0-f173.google.com with SMTP id e89so8862279ioi.11
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzZ4LAxu+dT7sM5ttsgS5M4wLqwOE32YD7eAg2qtqSw=;
        b=NZuHXoD+y+kf9+Zz92Z+HoRczDq7nyMV3cpL1DV9LoYVgVcok/C1Ap+Ud/BmjKtXsx
         8+M2ljpWCpKL4bwVxTHgayGOx7o2k4gMwnlG6TiOcqzzCtwq5EElHQTZus6bo3mqcG5B
         u8nQyEelrfSL1BIxDRW0xBfzWBUSFeIVs58fvo3oJv2xgpNHJnukJpDCQVa7LsO23KxJ
         cp9wUc5mGG6pLfvDtpBUdlVQVkRJwpWqhm2mPy+prmeTtokKCgiNyJaiJoQNUQYJnPq1
         LqAZ6dbCydlcsVfCVTLJLk5oMC43y14KB26zTU6idw376ftOZAfM1HgVUnZq8dwj518T
         vDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzZ4LAxu+dT7sM5ttsgS5M4wLqwOE32YD7eAg2qtqSw=;
        b=m55JcbVlSm85z795lAhMFvgeqI7vivnzp+xhEVunsT8Cp/QXyBvlE3HMpuHdr/miCf
         6huK7dXZSl8qMNIzJD1paOHHZKoa+x57nrDyk92nLUbVFblIuvokh62KoW9TDprq8tmp
         Q60E/DX11XH47hnfZJCYPe7S39EfoQ8Q7uPdkId8LCkRCW0JpKKbucpk1sDV8mibULcK
         s7YMMnP0vTOagRX7uNPjk+/4y6jpAfZbgTSJqhhjg+IUHacfm6ogLio7HkmhxbGIHCph
         TzDDwBLbRLCeBxrDCRt3GeSKi6M6HmhVay9Nxm7+dyS6z4im/qlAabva6SdywBZCzkDF
         C37g==
X-Gm-Message-State: AJaThX6P1zXFOlVw0XBn2EUuKqy52MgEtSC8mt+0sAWKcbHDDKIWRqsy
        6vBeMdsojXn84f6zxWGR98uoM+hC9nU=
X-Google-Smtp-Source: ABhQp+S9V4WC/wt9M+y0Y7VwQLdqxgbLWoJMCMq7RJrunE37qSqLeWNuNOYgpf29Y2+sKyqVuuz8eA==
X-Received: by 10.107.29.138 with SMTP id d132mr10763571iod.201.1509741151053;
        Fri, 03 Nov 2017 13:32:31 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:5949:10b2:8e2d:2f6])
        by smtp.gmail.com with ESMTPSA id 81sm1606593itl.20.2017.11.03.13.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 13:32:30 -0700 (PDT)
Date:   Fri, 3 Nov 2017 13:32:29 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 02/14] clone, fetch-pack, index-pack, transport: partial
 clone
Message-Id: <20171103133229.1612a60560469af53c380a76@google.com>
In-Reply-To: <20171102203129.59417-3-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
        <20171102203129.59417-3-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 20:31:17 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/clone.c      |  9 +++++++++
>  builtin/fetch-pack.c |  4 ++++
>  builtin/index-pack.c | 10 ++++++++++
>  fetch-pack.c         | 13 +++++++++++++
>  fetch-pack.h         |  2 ++
>  transport-helper.c   |  5 +++++
>  transport.c          |  4 ++++
>  transport.h          |  5 +++++
>  8 files changed, 52 insertions(+)

I managed to take a look at some of these patches. Firstly, consider
separating out the clone part, since it will not be tested until a few
patches later.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a0a35e6..31cd5ba 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -222,6 +222,16 @@ static unsigned check_object(struct object *obj)
>  	if (!(obj->flags & FLAG_CHECKED)) {
>  		unsigned long size;
>  		int type = sha1_object_info(obj->oid.hash, &size);
> +
> +		if (type <= 0) {
> +			/*
> +			 * TODO Use the promisor code to conditionally
> +			 * try to fetch this object -or- assume it is ok.
> +			 */
> +			obj->flags |= FLAG_CHECKED;
> +			return 0;
> +		}
> +
>  		if (type <= 0)
>  			die(_("did not receive expected object %s"),
>  			      oid_to_hex(&obj->oid));

This causes some repo corruption tests to fail.

If I remove this and rebase the fetch-pack tests on top [1], the tests
pass, so this might not be necessary (for now, at least).

[1] https://github.com/jonathantanmy/git/commits/pc20171103
