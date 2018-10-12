Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6E61F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeJMHFE (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:05:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34246 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeJMHFE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:05:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so6600300plr.1
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xl+JOX5SqO0gF5h55Zm0+rnnTgWGA5JneffCS78Jjs4=;
        b=Az9MfU5V7m9ofUAH04AGCC2GbhzNnCjwwZLkaIhPvWAdAZL57bUl7od9rt8becz9Yd
         EVVGEHPVua9OZO/FNxz0W4Q4TWarA6sVkVGXDtYU+SQH6W3pKQ28py0Vnvue6oW6mbMP
         qS6FRRYl4kHTWRD0QxJwPpD3p/uv+AbvLKaRfhHLitNw7Otge/HwXiIJ6Z9cWUObxPoQ
         Cde9O1Apa7fxRX7pE5pY692qVeUtnmLsHKptZ4JC0uYQ6uajTX5IC+icGBQjHCwJOCLy
         S1i/dXDGJ6Z/CiBkfS4z+CYcor2NIgZhMzyouKd9HjDLDub0PsCXfZNXW38lhrz6nacy
         eMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xl+JOX5SqO0gF5h55Zm0+rnnTgWGA5JneffCS78Jjs4=;
        b=PefYuwsRY0QblJ1Ixpgu6fntj/lDibFx3IRMXSYvRw516dhLQlJPHmuWEHujC9/Uy+
         GZWF2ssheE8kGPgYl8WkrOi1QVL2ZKv3rBYViflX/pKMv1Q9eRl5YK3zPGzLbn3Zdq+O
         YjoCCyUZMwDK4Wo9UMYMU4F2IxNnkyvlMEcvf3NmQbIrV4/nOT2/qbzVjgLx9fs1VcRC
         zs2ybD1YgdQHa6ho4HtdVdLmOwvzFt3tqbpy0H4Rgl2x8NTQ06uAH+kts9LvY37zmXEq
         v/gI7STZR34mJugJ31lA9Ol/9Zj4v11F2fzAY9jtnI/1aaVGuq6o4eKGeetytY/Hxa3V
         WsXg==
X-Gm-Message-State: ABuFfoirs3SZfg1rYievTILSOOKP8odBytjc8OuBJwEcPDt+UZmZOHP6
        d7fR+H4wkL1mWx3UlQIXS9k=
X-Google-Smtp-Source: ACcGV63MDW6kI0Zm7aHn+VhVST56Xk6TBfzDYuCd2eJRcJF2wmeY+XQoSSbZh+tKJi2NQ0+bXnrVDw==
X-Received: by 2002:a17:902:103:: with SMTP id 3-v6mr7762341plb.58.1539387020364;
        Fri, 12 Oct 2018 16:30:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id d2-v6sm3266844pfn.118.2018.10.12.16.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 16:30:19 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:30:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181012233017.GD52080@aiede.svl.corp.google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com>
 <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
 <20181005001817.GB32105@google.com>
 <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
 <20181010235303.GB12177@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010235303.GB12177@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Josh Steadmon wrote:

> So this runs into problems with remote-curl (and possibly other remote
> helpers):
>
> builtin/push.c can declare whatever allowed versions it wants, but those
> are not carried over when remote-curl is started to actually talk to the
> remote. What's worse, remote-curl starts its HTTP connection before it
> knows what command it's actually acting as a helper for.
>
> For now, I'm going to try adding an --allowed_versions flag for the
> remote helpers, but if anyone has a better idea, let me know.

There are some external remote helpers (see "git help remote-helpers"
for the documented interface), so alas, they can't take new flags.

That said, you can add a new remote helper capability and then
communicate on stdin, or in a pinch you can use the existing "option"
capability.  Remote helpers are also allowed to query "git config" if
they want to (either using the config machinery in config.h or by
running "git config").

Thanks,
Jonathan
