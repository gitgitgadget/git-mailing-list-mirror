Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132471FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933680AbdBPVcR (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:32:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34101 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933087AbdBPVcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:32:16 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so2958496pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OaDLwtj4KslEkOheSlnZmeA66/ztmRtOCGI1V9qudx0=;
        b=JRa3Y7GYh48h8G0yDOghASgEpBj/gAdJfl7rDCYNwX48zptOxcQI/XorSmm/iQZU2k
         3BDpQ1+zVTyKnaWf91VAgVYAjkl5wXvXa7EGBqVcAi4wL8uelZumWjsn21N/PaP6VzvI
         4RR5/vJyqSejsILkr2U7AZLnlwQrcadJb/PLPXm/Ac2/KIn+Uc8+3E3ddDat70COEnuu
         UZIBeItShQvUJ69fAjYNWnXZn1lh8nOC7Bv09rWrJ/pA3eanpcVyFP8NwjI+0X0aQCfQ
         d1zD66fFkjYJEiw1+c/F5/8wi5d7eLi811OrNajiseFqbbj4ntRykLbiVJI+V81YQhtJ
         7vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OaDLwtj4KslEkOheSlnZmeA66/ztmRtOCGI1V9qudx0=;
        b=jWrR41ZRS8Yz/5REAFTJ6wCbpJOCFjve7nfVHLlcNj/iQKxuc0gbhWTDxV9DP7DDrq
         MyUIlmyvUmsa7l5OA31MwsHAA1YhazLihaXwTQsD8gpy2yOCSk+dk676CJhWU+D+34TY
         87O8TTaDYIZ8WxSkShSXPkVJoiX1QUP9TigzsCmISpXWVnUmImtkOXypQ3Ee5B+Xz/8C
         3j5hOm+8b6Yc+Yb3Besc4R0M8rGjGq87eUqaKxk91vCEMxpopOOqUQ5Jev7VtruzGcW0
         m+oF+IvEH1eX2zkiwbCcsbDiCvEQhU8J4JFkAsiQyE/ji9CXmfC6j8eW4LW/hq8ipUKU
         Fb/g==
X-Gm-Message-State: AMke39nzdVgK9BcNA1OahxDJEuLAGP/xx1JAIPQerP++l3UksbZFKhJtIGI64Q6FziLYxQ==
X-Received: by 10.99.170.5 with SMTP id e5mr5620032pgf.89.1487280729918;
        Thu, 16 Feb 2017 13:32:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id p26sm15424821pgn.39.2017.02.16.13.32.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 13:32:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 13/15] read-cache: remove_marked_cache_entries to wipe selected submodules.
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-14-sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:32:08 -0800
In-Reply-To: <20170216003811.18273-14-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:38:09 -0800")
Message-ID: <xmqqpoihvn3b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

The title was ungrokkable to me, but after reading the code I think
you are teaching the normal codepath where removal of working tree
is done to match what is done to the index that submodules are also
in the working tree and need to be removed when the corresopnding ce
is removed.

Which makes sense.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  read-cache.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 9054369dd0..b78a7f02e3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -18,6 +18,7 @@
>  #include "varint.h"
>  #include "split-index.h"
>  #include "utf8.h"
> +#include "submodule.h"
>  
>  /* Mask for the name length in ce_flags in the on-disk index */
>  
> @@ -532,6 +533,8 @@ void remove_marked_cache_entries(struct index_state *istate)
>  
>  	for (i = j = 0; i < istate->cache_nr; i++) {
>  		if (ce_array[i]->ce_flags & CE_REMOVE) {
> +			if (is_active_submodule_with_strategy(ce_array[i], SM_UPDATE_UNSPECIFIED))
> +				submodule_go_from_to(ce_array[i]->name, "HEAD", NULL, 0, 1);
>  			remove_name_hash(istate, ce_array[i]);
>  			save_or_free_index_entry(istate, ce_array[i]);
>  		}
