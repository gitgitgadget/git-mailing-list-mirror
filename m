Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B6F1FAE2
	for <e@80x24.org>; Tue,  6 Feb 2018 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeBFWyJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 17:54:09 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43201 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753602AbeBFWyI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 17:54:08 -0500
Received: by mail-pl0-f67.google.com with SMTP id f4so2206479plr.10
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 14:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noBYG3R3FHMN/dx5M+0s5itVIjx2RRoW8DKqzo8CYPM=;
        b=qQSNYdhg89C1yxLqBl/b7LbOHrkvGJ4LB+TCVgwcw6KUk1fhgqyxHikbQlpIevONBt
         OZ7BxGfAxmHAK+bG77fTiKkiO789Xs76y0a1RJblQPYmyR2k/RLy5rPHBwA6z8oonI+A
         FDNFp4xLA5Q0mYrcekEJVhVbQzgL9qxGhh3k6AAod8aYKK2+CWaUhAuzUFBVKkZqP/LZ
         jK3cAnW88bmhZtuX7vxU6SyGt7p5D8VubUfwpg1mOzRVpYqhKuEyrmXMhgSFh8qYCO+C
         IjASX7XGVOz6qgZ6he49hw0WGvegm2rYo3SzaQe6GrWVNArdp+Hzi/P6XcWcrTlwff2E
         1nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noBYG3R3FHMN/dx5M+0s5itVIjx2RRoW8DKqzo8CYPM=;
        b=mukWrzkA1O3IsqW8PuacdEbB21Zy/tzs2c9whdOmwsYUADo2KxtKXP30aG9RncG1fj
         QmbK58mQBsAP41gyvc1GzSRF9vKqBDctJrfII/MqUJsv+mqdDdIswDrlyZLyAA7ONged
         bhkUnhoyxawT3W4ruuI7HQMFgl0LOOKs8FWudNUYV9H9JcNm6SYAwywLIhydmnKi+pmx
         zk1vgcZJwxELwPvIzsLU1RhaZCMmwYQ04VXCf2jvrD44hjssH4jGhI70tUewwyqKCoyS
         xA/Gdbxza86FxQbtm1rkEDlIy6McL7fKGEpMWcjyaAi0u4B3KzA8b7RE+Eej26skF4Hi
         6hwg==
X-Gm-Message-State: APf1xPA7R4INRsYTh8Fk6wAXnetO0jK0UIG4a852l52AhQJxTVNvNgWy
        G1g5MRsZDNGkdb7NCGwpmZ0oXg==
X-Google-Smtp-Source: AH8x227wvgL2Fv23wy/zenAdM0Yo47xhVUQaS9eN6Ntxyj5kyNSXyOGR8lhMj4rOnwJdr4aVs0W2Hw==
X-Received: by 2002:a17:902:7486:: with SMTP id h6-v6mr3943089pll.236.1517957647993;
        Tue, 06 Feb 2018 14:54:07 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q82sm124617pfa.58.2018.02.06.14.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 14:54:06 -0800 (PST)
Date:   Tue, 6 Feb 2018 14:54:06 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v1 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
Message-Id: <20180206145406.b759164cead02cd3bb3fdce0@google.com>
In-Reply-To: <20180202045745.5076-2-pc44800@gmail.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
        <20180202045745.5076-2-pc44800@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri,  2 Feb 2018 10:27:41 +0530
Prathamesh Chavan <pc44800@gmail.com> wrote:

> When running 'git submodule foreach' from a subdirectory of your

Add "--recursive".

> repository, nested submodules get a bogus value for $sm_path:

Maybe call it $path for now, since $sm_path starts to be recommended
only in patches after this one.

> For a submodule 'sub' that contains a nested submodule 'nested',
> running 'git -C dir submodule foreach echo $path' would report

Add "from the root of the superproject", maybe?

> path='../nested' for the nested submodule. The first part '../' is
> derived from the logic computing the relative path from $pwd to the
> root of the superproject. The second part is the submodule path inside
> the submodule. This value is of little use and is hard to document.
> 
> There are two different possible solutions that have more value:
> (a) The path value is documented as the path from the toplevel of the
>     superproject to the mount point of the submodule.
>     In this case we would want to have path='sub/nested'.
> 
> (b) As Ramsay noticed the documented value is wrong. For the non-nested
>     case the path is equal to the relative path from $pwd to the
>     submodules working directory. When following this model,
>     the expected value would be path='../sub/nested'.

A third solution is to use "nested" - that is, the name of the submodule
directory relative to its superproject. (It's currently documented as
"the name of the submodule directory relative to the superproject".)
Having said that, (b) is probably better.

> Both groups can be found in the wild.  The author has no data if one group
> outweighs the other by large margin, and offending each one seems equally
> bad at first.  However in the authors imagination it is better to go with
> (a) as running from a sub directory sounds like it is carried out
> by a human rather than by some automation task.  With a human on
> the keyboard the feedback loop is short and the changed behavior can be
> adapted to quickly unlike some automation that can break silently.

Thanks - this is a good analysis.

>  git-submodule.sh             |  1 -
>  t/t7407-submodule-foreach.sh | 36 ++++++++++++++++++++++++++++++++++--

I think the documentation should be changed too - $path is the name of
the submodule directory relative to the current directory?
