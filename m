Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03AD01F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIEBLF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:11:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35564 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeIEBLE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:11:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so5356471wre.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rs+BzwOcLLeMWTVGZn3HdaJGD2gnBAbkywMerJqbkxs=;
        b=a6dQWViSDfD8KrvIYUY6UllIcyWkIENRH3t+i4pc4IGTQ1A1A9SDljIdlSEusw/hr5
         mOwiF2FneNsE8xatOZugfs/xU3z+YPbqG42uCIlpO7OWz/BB0AmusZGQaT4/HshV3kx6
         ucEM0jD/8P9s4FMj31bjXHijQohop1mdqo6bHs7x1P5j/N9PDrA9v0PRWud1Ll9NSk7x
         xq35qumIN8Dtw0uPJPAuEIHtkoueAnUbgffOmgD/MMNu53EdihpWUAz/br28obChskco
         brJZ8psW1HRPoeot49sFf6pT8SKEWKOB+AcPSvDW0uDm4QgPwhTxwW8yEQphJhsJ87X4
         9f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rs+BzwOcLLeMWTVGZn3HdaJGD2gnBAbkywMerJqbkxs=;
        b=FAdJtxFN4iCq2QarK+sTb5EruXgZ7EqPmLRYoE7vWCjgItuOIKgEhTOSYeBbtcN+yg
         cUzEZ2oPUQYNx7UuE7X2lwL7Jg8MKlxzTi2Nma4ehKAAJ9UwVS+z9w+/bro/f57UdWD1
         WvcnPpuZibkIHkaqp4Xt7gnxKilxlm0fhdCzX0lAWGxpAR/XRmACuzwtUuZvN4laU4Ul
         Lojpq/frNGRee+wxRghfbrGkH2mGzKggRt/KArSK1HJiiNaXPCD0SO35+aP8inaliur1
         6ik2MqL1dtZNO0Y7UTv854NxjxCunB7x5MsDyKWor+VPpS9e5QoF9HhpP+FCZvfu8E5F
         yNUw==
X-Gm-Message-State: APzg51C2fRBsZF//n0OcSlGWbRsghTIsqhOr3jF0YHULSoe5SobIO6rX
        RTXbR+dWQSdo4g3164dAZeU=
X-Google-Smtp-Source: ANB0Vda5vOUmldTb0uAf6J2ZEGf4WgRmKxYjcWdTJc2azdD2/lds2IZa4tmfFezJyiA1t1LjzcfE1A==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr4752435wrc.119.1536093855536;
        Tue, 04 Sep 2018 13:44:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm15564048wru.64.2018.09.04.13.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:44:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v7 7/7] list-objects-filter: implement filter tree:0
References: <cover.1533854545.git.matvore@google.com>
        <cover.1536081438.git.matvore@google.com>
        <956f0c704f5492680928f4dc9ce9411e7f80bba4.1536081438.git.matvore@google.com>
Date:   Tue, 04 Sep 2018 13:44:14 -0700
In-Reply-To: <956f0c704f5492680928f4dc9ce9411e7f80bba4.1536081438.git.matvore@google.com>
        (Matthew DeVore's message of "Tue, 4 Sep 2018 11:05:50 -0700")
Message-ID: <xmqqwos16li9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> @@ -50,6 +50,10 @@ static int gently_parse_list_objects_filter(
>  			return 0;
>  		}
>  
> +	} else if (!strcmp(arg, "tree:0")) {
> +		filter_options->choice = LOFC_TREE_NONE;
> +		return 0;
> +

This is not wrong per-se, but I would have expected to see something
like:

	... else if (skip_prefix(arg, "tree:", &param)) {
		unsigned long depth;
		if (!git_parse_ulong(param, &depth) || depth != 0) {
			err = "only 'tree:0' is supported";
			return -1;
		}
		filter_options->choice = LOFC_TREE_NONE;
		return 0;

so that "tree:1" is rejected not with "invalid filter-spec" but a
bit more descriptive "only tree:0 is".  Accepting "tree:00" or
"tree:0k" is merely an added bogus^wbonus.

