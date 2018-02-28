Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8B11F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeB1Sr0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:47:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39071 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeB1SrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:47:25 -0500
Received: by mail-wm0-f68.google.com with SMTP id i3so5599235wmi.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oQ6vNGupR7ohijdgIJq3RPxe6TE7Y8YciuoXmG3fxss=;
        b=Bh0SmceXCS4xz7VNSH+EU7fxObKlszFVbDQvEPKPJOKD5F836wIpzsGXf/hIkwv0dn
         ZL1loouR5BQLfLVaPJhzi/jZqm0We7YAeQ1BL+HVoZZIu+b1RaiSWC9LdKgTlm8MAhzY
         rMcn/5pgcz+vuFRMFFJoOasZi+ihcFHkPuPcgou6SIYCgsVruHaVjQ2VHslbfueN5gHL
         6Akv1ZtlNsjWtQl/8pElGH128zxyh/uYb/Wf+6S3dw6v0VtFo0j5eCGx9B37UWJzqef2
         AdgJOOZ4lRxdTBoVOLT6kmPZnDVqAhhC9csLLai5ZebHrzsVPOTCU1lZgqDLumKRGyt+
         ZhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oQ6vNGupR7ohijdgIJq3RPxe6TE7Y8YciuoXmG3fxss=;
        b=mPTaygRKb8qvRqhyi7IY5ea7ntTTNvF1E9iQ7KrNJ6I4jt6JY+VKzTCuoZ2h+poNLz
         yhJIAcXayzlnpJLKOfNzUX8qhb0WtVEyAwKfHGuTrgmF2fUt33DIxLii4uSdA2WxmYtv
         55yxO3opBxW00sNTwTpiZlhdIkjcnpNigOMzsmjiucoAbq36N642bj0AHY1u8jQ/nVt5
         k83gN8XSW5RxWM9fxfHw7Jix2Yln+sLgqnc4czzahx1en20eiE7hAhndsVp9I7XhUeAQ
         fk8E2MLQlr0Kr2z9/wtGdAILUKKGL08Wk5Fpv4ugvpnDOKvKXcPnmKbI+Vy9HXiJ8lv/
         fhWQ==
X-Gm-Message-State: APf1xPCD6E2AO4rXfdB14agEtCNRH8QPjnT1sHK41R9kuALNQwUOD5nJ
        DFZ4Zus5ADJJIOj6sqW7iaU=
X-Google-Smtp-Source: AG47ELsRDM+yVk20S+NXMutNemFqqZRdoxDjI7cGc1h2dFM4WY37FSC9jaPT1QvYA+xgvdPp6wdyCg==
X-Received: by 10.28.239.18 with SMTP id n18mr13545143wmh.56.1519843644061;
        Wed, 28 Feb 2018 10:47:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p29sm3459182wmf.3.2018.02.28.10.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:47:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
Date:   Wed, 28 Feb 2018 10:47:20 -0800
In-Reply-To: <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:17 -0500")
Message-ID: <xmqqinahkl3b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> diff --git a/commit-graph.h b/commit-graph.h
> new file mode 100644
> index 0000000..dc8c73a
> --- /dev/null
> +++ b/commit-graph.h
> @@ -0,0 +1,7 @@
> +#ifndef COMMIT_GRAPH_H
> +#define COMMIT_GRAPH_H
> +
> +extern char *write_commit_graph(const char *obj_dir);
> +
> +#endif
> +

Trailing blank line at the end of the file.  Remove it.

t5318 has the same issue.

Thanks.
