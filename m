Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8537D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 22:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeGFWSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 18:18:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54079 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeGFWSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 18:18:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so16107572wme.3
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qM6b5vOv/ToB9BwJOa0eI2/CHwN/rpR4TV9aqN4Fvro=;
        b=prvbJeT7jaJbYCVsL5xUe+6syieJEoK4mKY+EbNq3Sa8T71Gr9KlEuUrsZlJ8DFa3O
         NKQrkYNbekpPYlqJHwJqkn7ZqC/hwrKtbqUkDjxVQREmWPMUmgJOrH7LfWh1k3ap2dvU
         Ee2+QMdDgT70PIMM6C6r+8a2XclScMb8fVvI2TNMmJbz2+7iEID/Chk3MwTpdZPqVCaJ
         Tjm6bUiNG82jhV7gr/i4Vbs5foAJ8SyqpvQDavOEAebM4cU9zrLlF7/IVxWPsrpgWRgU
         Dhcv3/0X7SXtfNi5vawo90pzQJcaxZDdgTR5hWxNbWNgkG7lgjHnVp+D0uHPDjCXm796
         B0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qM6b5vOv/ToB9BwJOa0eI2/CHwN/rpR4TV9aqN4Fvro=;
        b=arToYFHTcOJASkOVABpOI5+nd2h0nX5FK7LsoZMvCjZXOrCXN3yllJLAMSv+dJX+r1
         gnm50kIIiy5aKFSfMufX/ttSvcVHGXce0d2U4cyPB5kCPtvQy+ZuL30kOFQyMRX/Pf/d
         hTRXJ1v+afMw1pA6ydTuORejIz5SUtIYlzbGVujoDFpwbGzFQmqHr5WlOzD7pK47nP94
         KWwyxP36wDDvBTDPsCnpZwM9iCx4YI77qOcKGSX1daX5ZrhMu8Q3NAWdlEMtzyugyZCa
         +c9RawD7odBZvg2PBuEurJubzbPCIgEgvlYKgS0VqmBeboqHfIINZmkwTzbgjpgcHvDD
         YtFQ==
X-Gm-Message-State: APt69E1ccrABTyh/FqgDThbx0miWw0J2orvnGHyW1t+BjbqUO79IJJfD
        fdHPMB9cC7nGVAov1Nhz8Ws=
X-Google-Smtp-Source: AAOMgpdz3rYZZ28X0Q/m++BasQR5TPKhZD0fBARKjZ9OHO6tea+2EaKXR01FEN58158DoHvnVDVr3Q==
X-Received: by 2002:a1c:f308:: with SMTP id q8-v6mr7066555wmq.6.1530915509216;
        Fri, 06 Jul 2018 15:18:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v9-v6sm12852919wrn.97.2018.07.06.15.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 15:18:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
References: <cover.1530905323.git.jonathantanmy@google.com>
        <20180706193847.160161-1-jonathantanmy@google.com>
        <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
        <20180706212957.GD6195@aiede.svl.corp.google.com>
Date:   Fri, 06 Jul 2018 15:18:27 -0700
In-Reply-To: <20180706212957.GD6195@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 6 Jul 2018 14:29:57 -0700")
Message-ID: <xmqqy3eogg98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The upsides are that
> ...
> - down the line, it should make operations like "fetch just this one
>   tree" a little simpler, since you can use
>
>    filter blob:none
>    filter tree:none
>    want <this tree>

;-) 

I think this example, especially without the first line, would have
a practical use, i.e. "grab the contents of this directory without
recursing", and as such is a very convincing argument to support the
approach taken by the solution presented here.

> ....  So I'm comfortable with the direction
> this series goes in, though I haven't looked at the patches in detail.

Likewise.  Thanks.
