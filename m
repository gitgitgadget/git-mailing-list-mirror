Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3297E20248
	for <e@80x24.org>; Tue,  9 Apr 2019 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDIUqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 16:46:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33012 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDIUqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 16:46:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so5829093pfo.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hza3l/kpfgXNC2MGZ8JuaQavRVovSeJ7RromsVvBVeo=;
        b=tZtyv1PKhix/uSKKfO3mozfG2mrbH4oCcA+x6SJB0HCCXtehunaZIVyyw2wKRBXrkw
         qUjz4X6ux1xT947P3ZUK7RG98lYqEhiS8VAzRhaCS3nZ54O0fBv1KVHGj9hg5LEOaWjF
         pDDOSIYh/YkuzsJ0dFWiPQlMgAY3Ap2DpRpyO2EC5ccmerqvXrcUcZEpphNZhlWB73Ip
         3ijw7Jlp+/aH1igMGHTMzz5xlHkjKWhYFzhUv5H4OQvX6o3SseKIkzkngP7zacpd+rqV
         4Hs1XUNLY45o+pBR80Jij75CbBnSbw5dRDU99dXpWDZT0OlFCZOBzvGMJw0deGuCh2D5
         LzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hza3l/kpfgXNC2MGZ8JuaQavRVovSeJ7RromsVvBVeo=;
        b=rBjxyL8WadFWwxNm5SYJfKRGAh6rf4JzAJyBx3qoveqDQPou0gOuf0cghML33nsEQH
         iuOdIO4fRlaF6H5BapVxIJIilqq3vjY6o8e621eGVDrQ1aHFOfI7r5HX19wlylzDlVis
         5fwDSEo2ZeuqMTbpIAfE0q8cWALLh04U/X2vC4dU1dwh1g4aEUak7XlSBg4v8qKKAsVQ
         rlRQ7BYki8YXpjkrgjF22miQ4btcz/uORNu/Zg7J1lnqXXfBMMWuh9UiygrzWTVt03SA
         yXk03LZbZgxE33DXGc/BXzzurLSPTBpwsIStAq9kAuupwDqfWtscirGznJ1TwKn7PYXD
         RfNg==
X-Gm-Message-State: APjAAAW0eus6RwzmOcaVmlR4VgRywzDV+xHVujK6rQk17sJ03AwULfgs
        K1S1S4zLeBXrO/igBYBtbcE=
X-Google-Smtp-Source: APXvYqySwkZW9YEs2w+COLwE10SV1B01BomO2mct6TrM7KE25Ng2RG2+8nm9qAZDRfc+VmoBEL9H+A==
X-Received: by 2002:a63:6983:: with SMTP id e125mr35032968pgc.370.1554842778205;
        Tue, 09 Apr 2019 13:46:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id i3sm49421235pfa.90.2019.04.09.13.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 13:46:17 -0700 (PDT)
Date:   Tue, 9 Apr 2019 13:46:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/2] clone: send server options when using protocol v2
Message-ID: <20190409204616.GB92879@google.com>
References: <20190405204413.93900-1-jonathantanmy@google.com>
 <cover.1554841624.git.jonathantanmy@google.com>
 <142c25abd2c5c5c477c44d0e47cb20a3d504ab1c.1554841624.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142c25abd2c5c5c477c44d0e47cb20a3d504ab1c.1554841624.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Commit 5e3548ef16 ("fetch: send server options when using protocol v2",
> 2018-04-24) taught "fetch" the ability to send server options when using
> protocol v2, but not "clone". This ability is triggered by "-o" or
> "--server-option".
>
> Teach "clone" the same ability, except that because "clone" already
> has "-o" for another parameter, teach "clone" only to receive
> "--server-option".
>
> Explain in the documentation, both for clone and for fetch, that server
> handling of server options are server-specific.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/fetch-options.txt |  3 ++-
>  Documentation/git-clone.txt     |  8 ++++++++
>  builtin/clone.c                 |  6 ++++++
>  t/t5702-protocol-v2.sh          | 21 +++++++++++++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
