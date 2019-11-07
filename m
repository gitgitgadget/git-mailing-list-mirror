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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7C61F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfKGCXv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:23:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39059 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfKGCXv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:23:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so1140710pfo.6
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d79hEc7mZA/HrSoVzdqqpsCnJOidnTZJwUekHM1yK+M=;
        b=SGG2FftmV8IJJhWYTSl6kYNtjivfzg2knO1qfPclbI3IZJkj/V2rSaEquhyLDvzE35
         HQ1OftsCprVPT+uvQC4u4Ty7dd8R19z+1e/yg9RfeQkRGKU+KM/rlOwTMQmyggqeo7B9
         /NyjHU3caxg30OWa+zhGrVHNGMXKO4h/63m3sIJGMHwp0tb6EyiVzI4HkWGJtAgq66cC
         4udcqUfm6qZNbbMCW6JeXSyX8APWaLe2fZHf3hHUFOq8naFH5Q+5biz3F5ompCENJePz
         uA5vf9OhI7DIL2LDAgs/YPAL7CYmuZjf05Y9jSewBCsFlg95JRPa9tPse8k7XqKVAUAa
         2GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d79hEc7mZA/HrSoVzdqqpsCnJOidnTZJwUekHM1yK+M=;
        b=U06+27JFMnYakDrbDkaaM+g76tmIo2Ic02p1l/i0vkeNWVHxy3nMovUZFlEXsQq8ts
         2F2FVGELyQrZt8QCK90XjYKlRv9SaejzteVh8PeYWe90Npvo6HOeuOe0B86DAtJnkGo4
         L4SFoLbkOleuMJ6PqLbgN0JM7qgMQSYDBB3T/fd69T1AXBTXSk4tJqb5WHTjK7MT9BDT
         trzcs4uPaaG54C7eNV3ePa5ioQL+hlgNWjSJg5181mwUSOFWdaMzLWJxnJX3WsNc6nFq
         edbRzTZDWDH0QUOEie6+Qe+Sit0KVrvnPETHoZNjTYrzRIxhvszN+5FszKalGAaY9mqd
         KAZQ==
X-Gm-Message-State: APjAAAW3+UzfXN3yP0x+qhkzr/Qb3zvEqF0NJ2lbXiL9hqQv3MEy4Kho
        o5QJwtrZEtqupQL+6ccpJlc=
X-Google-Smtp-Source: APXvYqxh8Jms97XyOOTTbz/HHVc62AnA2S+E9kdzCUUx+IivapaaTTWZTb14OcUxer4it2EDGjPOXQ==
X-Received: by 2002:a63:b909:: with SMTP id z9mr1407940pge.136.1573093430724;
        Wed, 06 Nov 2019 18:23:50 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id j24sm329346pff.71.2019.11.06.18.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 18:23:50 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:23:47 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 31/32] commit-graph.c: fix code that could convert the
 result of an integer multiplication to a larger type
Message-ID: <20191107022347.GE6351@danh.dev>
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
 <20191104095923.116086-2-gitter.spiros@gmail.com>
 <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-06 11:23:00 +0900, Junio C Hamano wrote:
> > @@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
> >  			    num_chunks);
> >  		ctx->progress = start_delayed_progress(
> >  			progress_title.buf,
> > -			num_chunks * ctx->commits.nr);
> > +			(uint64_t)num_chunks * ctx->commits.nr);
> 
> Hmph, do we need this?  I understand that the second parameter to
> the callee is u64, so the caller needs to come up with u64 without
> overflow, but doesn't that automatically get promoted?

Neither num_chunks nor ctx->commits.nr is promoted because both of
them are int. The result of `num_chunks * ctx->commits.nr' will be int
and will be promoted to u64 to pass to caller.

-- 
Danh
