Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B0A1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCNVdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:33:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37045 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCNVdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:33:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id z12so6254284wrg.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s2tIIxTzM1m7+xMEUShKGD12XufNSfSKv2BK38vDcng=;
        b=eqvN1yEBFluZbbPazv2QayIdbT/xBOX9OnKM/CQ3B9yYH7VkQwXUwdFWcuNnX7ryZf
         mPKMAV6V+rGx7Dwx3oOqvZJ8NIErhbk38Bnw1lhBAyO7SnVpMJeQMCCj8WeYOfziHOm0
         4DUWIV0R4xg0CIBvYdhBOPRHHVkWM8flmbWVmv5/lpKg9lynQpP9zXYyLnwFdbErtNN5
         aBmTT5p6c8lAL0zQ4i7I8CC55/Q3CaNBJNXXjAFblHxsmF73Cw6JN1+AmLMf8HHIH9ic
         1zGpcDAw7LMhgYJPiNLqpz7MPwT58jkQGogZqQf/HxJxgZ+NVC2MupR7iFEv8FTQjibB
         nHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s2tIIxTzM1m7+xMEUShKGD12XufNSfSKv2BK38vDcng=;
        b=rpY0Zks1WtqmO+cLXZ8J2/Qlr6gZDok9gEdHfQta3f//Ud2yWb1pnCeo7jbkQd6P8a
         tlzWJHXheJYrG8EtdwFqRQmrUfGicEa4F1cjjxkTiFfcaucc0GlwIdKcbum3xThZDhMk
         sN+gBL8VXgH1nMuXD3zwjHZ+ZjM+g6tQZ0/jkH9eqRWejuQFJS3y0eLmR1casByJAJFN
         X0C+sNecZ0t60c60PaUPZTc2zh4tD4qeCaSgy+JHJdemmhIymp8wBOnj8QPedX+6abiE
         l6i8bO+1FvI0cA5Bn6h6KqmW57zWRmZlZjEBPJV0JSFLKFTpsGgkIHxapBn2bnENRTiP
         e5tQ==
X-Gm-Message-State: AElRT7HFqYAMTyrx0Cs6a4x2lori09WsDiYeyTZx/GDa8sFfTKuIxlZu
        GqkP6tx42hp2ObYVFjTyzpY=
X-Google-Smtp-Source: AG47ELsijbexB0v5+dXlePx1U5YScqojJsC2jol2K6Lb0E6r0Oomz8WWqbZBurP4X3+NVO5BOHZY6A==
X-Received: by 10.223.197.139 with SMTP id m11mr4982843wrg.198.1521063221981;
        Wed, 14 Mar 2018 14:33:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y68sm5394458wrb.73.2018.03.14.14.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 14:33:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 01/35] pkt-line: introduce packet_read_with_status
References: <20180314183213.223440-1-bmwill@google.com>
        <20180314183213.223440-2-bmwill@google.com>
Date:   Wed, 14 Mar 2018 14:33:39 -0700
In-Reply-To: <20180314183213.223440-2-bmwill@google.com> (Brandon Williams's
        message of "Wed, 14 Mar 2018 11:31:38 -0700")
Message-ID: <xmqq1sgmz6j0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +/*
> + * Read a packetized line into a buffer like the 'packet_read()' function but
> + * returns an 'enum packet_read_status' which indicates the status of the read.
> + * The number of bytes read will be assigined to *pktlen if the status of the
> + * read was 'PACKET_READ_NORMAL'.
> + */
> +enum packet_read_status {
> +	PACKET_READ_EOF,
> +	PACKET_READ_NORMAL,
> +	PACKET_READ_FLUSH,
> +};

EOF was -1 and NORMAL was 0 in the previous round; do we need to
read through all the invocations of functions that return this type
and make sure there is no "while (such_a_function())" that used to see
if we read NORMAL that is left un-updated?

I just have gone thru all the hits from

 $ git grep -n -e packet_erad_with_status -e packet_reader_read -e packet_reader_peek

There are a few

	switch (packet_reader_peek())

which by definition we do not have to worry about.  Then majority of
what could be problematic are of the form:

	while (packet_reader_read() == PACKET_READ_NORMAL)

and they were this way even in the previous version, so it seems
quite alright.

Will replace.  Thanks.
