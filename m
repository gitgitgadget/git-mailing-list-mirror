Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466571F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934411AbeF0Rxo (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:53:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43320 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934318AbeF0Rxn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:53:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id c5-v6so2893320wrs.10
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TBao6HJbXbR0n1y57URXBwJAf5Y9+S9Vc/AhsPWMWzo=;
        b=OtcOW5xOdm3/Vd6IZbdnKPnGPXK98yFSIP2yV4KUt3dviwKkj7ioQZBMrSEHIJBE1M
         sxSV+0zC+CgktsrFnRm8hfVVN2hfgunSQ7KgSAV1xJ9J5KmHyeCYYm1Mvz0UfGSGoyvI
         W34C0vooD5+C7eifnePKxgax0ZpYQMGGDV5tfzLLqkwBBDp+teH9CoWk7DYIuAvQqHQ2
         ODU/ZOvc/IWBPJFZTmJgcKRv3AJwIQfsm45zrCrHludZblm+QJw0UFuytbnt+63ipYfW
         Ey26Saf0DRcECvYslq29wBGMKwubiG/AE4MyVTIbWtocA4WXh95G7TNe9nTovoJQW1yi
         d1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TBao6HJbXbR0n1y57URXBwJAf5Y9+S9Vc/AhsPWMWzo=;
        b=eqkoObEK/U0e8ysUo7rFk4R8YvBM2dtcES9lMT9Y7bJDO0Pa/q82Ukv173XdvjE878
         UJKmBRdN1yV+Hxd9qK0Q7fkZKm/gpJBOuwgqncD8af7QKlvcND/wqI+AgZrI3COeEyly
         R4GRUtJWGqC4hTw5Bb4nSmcsx4f64rhV7VduLx1rgnniv9mD3f+AshMfP65UbXcXsJms
         5QRanAZwfC14UtGCFp8v8DLfjwHQ9YSX1xE0p2PSwKtn9fS51G8FfGJKNmRwBX63mn1P
         mnrD8Sd/rmSvcGJ9o+GKQpWueCTotr9O7U6+mPkAyIkUnDWVnBEu6uai5I6BGEXJV16n
         W77g==
X-Gm-Message-State: APt69E3Mw0Iw92Q9Q+oDAulziMYzuU4UsFWF6caW6gIbeG1NpMwTL+Vf
        fYOpyhQ0ezh6+VEbxCUJPj0=
X-Google-Smtp-Source: AAOMgpf7Ruy/tv2K0jTzWAt57OLUK1+HKu28T1Aygfwoe/O4X0/VA4Jt5i+2xHqyUPVY0ZhnIeqQBg==
X-Received: by 2002:adf:f3d2:: with SMTP id g18-v6mr5777247wrp.279.1530122021955;
        Wed, 27 Jun 2018 10:53:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b1-v6sm3323908wma.23.2018.06.27.10.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 10:53:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 20/22] commit-graph: add '--reachable' option
References: <20180608135548.216405-1-dstolee@microsoft.com>
        <20180627132447.142473-1-dstolee@microsoft.com>
        <20180627132447.142473-21-dstolee@microsoft.com>
Date:   Wed, 27 Jun 2018 10:53:37 -0700
In-Reply-To: <20180627132447.142473-21-dstolee@microsoft.com> (Derrick
        Stolee's message of "Wed, 27 Jun 2018 09:24:45 -0400")
Message-ID: <xmqqy3f0f74u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> diff --git a/commit-graph.c b/commit-graph.c
> index a06e7e9549..adf54e3fe7 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -7,6 +7,7 @@
>  #include "packfile.h"
>  #include "commit.h"
>  #include "object.h"
> +#include "refs.h"
>  #include "revision.h"
>  #include "sha1-lookup.h"
>  #include "commit-graph.h"
> @@ -656,6 +657,23 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
>  	}
>  }
>  
> +static int add_ref_to_list(const char *refname,
> +			   const struct object_id *oid,
> +			   int flags, void *cb_data)
> +{
> +	struct string_list *list = (struct string_list*)cb_data;

Style: "(struct string_list *)cb_data"

Also please have a blank line here between the decls and the first
statement.

> +	string_list_append(list, oid_to_hex(oid));
> +	return 0;
> +}
