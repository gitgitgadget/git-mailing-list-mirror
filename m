Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F8920248
	for <e@80x24.org>; Fri, 19 Apr 2019 20:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDSUCE (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 16:02:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40818 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfDSUCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 16:02:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so7432494wmi.5
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V8Ko7cT7rQ5uPk2Tqf8EHU/nFqahmEne+NNiRJAGfNM=;
        b=nIKisGZhi6j6YX2T4bSNlzJCs7rlDWGr82SbFXyiuk5Zn6nJyqq7BFTqB+J/hKMTCy
         yGHuUkO+M0DTPDi2Jx8uIxyAjRCtLf7SPz+5sSM8zGmkbKquCeOg0B+BMAz8x1hdqLWq
         n+o21Vj9e4AeVD22JcTbV38eGw3CLRWRt6jXZ3hV1Xr1/x0L6b4Xrd4GEdKJAWlWBUt4
         rPFy+TrhhZRxSilH+bFVrV79sTcGeH65gvtQi5Qt6QEG4v9tFfcb7pi7LXnkSuZvFNZw
         YUDUWoug/BPkEm26/ApoQCPcS0vf9N5JspZ0OLN2L6YNFbjNCxvl1dgs+iBJYzfdo3Hb
         LPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V8Ko7cT7rQ5uPk2Tqf8EHU/nFqahmEne+NNiRJAGfNM=;
        b=W9XOaPGQ6rLV60RGCMsvBTNj4k1HgZzi77SDN7sp7kqxhTYhDcIz9UST6wELK88PvY
         Rons++voVbF1cDYvIogTboZr/d9zJUVZad6Ty5o0ciG21kVUarykqPUPHoBlboIL3rOp
         REKe28bLIc900h7EknEpxFuMjWxAgSg9ryrkelUItkL0quMcnHvYoM+TpCAb/uumiFZW
         v4Lo7VciawOxG+spP89bx28MBWzZPxfISyJHgRwWimdaPwd4OTY+uefy4Wruxdf/lNdl
         vyexEdnqUrjx4/ZL2rcoH/wzDI6udoxkt8IG7rAq7lJ+SedfEVSBiLB0LJ99is3v6Ohg
         7YtA==
X-Gm-Message-State: APjAAAXpQBE7+8xQWB8YFnTcPJd+7klCdn1WNZDnF9dCpBGUrdmCty+X
        +wKfE9kwTNMvJu+YlBVggt1uN6bWsLU=
X-Google-Smtp-Source: APXvYqyFoCDoO94nznpt2FXPUt7HjUGUppJfyJBlBwmXzLkGPYSPOJ0ectC4t9OIiM8qxvioq7Gnhw==
X-Received: by 2002:a7b:cb15:: with SMTP id u21mr1318288wmj.152.1555651799931;
        Thu, 18 Apr 2019 22:29:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c13sm3964318wrx.88.2019.04.18.22.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 22:29:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] untracked-cache: be defensive about missing NULs in index
References: <20190418211408.GA18011@sigill.intra.peff.net>
        <20190418211701.GA18520@sigill.intra.peff.net>
Date:   Fri, 19 Apr 2019 14:29:58 +0900
In-Reply-To: <20190418211701.GA18520@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 18 Apr 2019 17:17:02 -0400")
Message-ID: <xmqqa7gmef55.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> -	len = strlen((const char *)data);
> -	next = data + len + 1;
> -	if (next > rd->end)
> +	eos = memchr(data, '\0', end - data);
> +	if (!eos || eos == end)
>  		return -1;
> +	len = eos - data;
> +	next = eos + 1;

Yup, much nicer.

> -		len = strlen((const char *)data);
> -		next = data + len + 1;
> -		if (next > rd->end)
> +		eos = memchr(data, '\0', end - data);
> +		if (!eos || eos == end)
>  			return -1;
> -		untracked->untracked[i] = xstrdup((const char*)data);
> +		len = eos - data;
> +		next = eos + 1;
> +		untracked->untracked[i] = xmemdupz(data, len);

Same here, too.

Thanks.
