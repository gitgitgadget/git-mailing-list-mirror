Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD1F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 02:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfA1Cdj (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 21:33:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34480 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfA1Cdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 21:33:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so16398733wrp.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 18:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BXKR/jz7AwAcFWUmf8ARWKNSq0m2X1sbr9mM2sMW+R4=;
        b=iznyTF0S3RAeWoPSjS5mie35BZBPv121jCWoZYQu1o97mQy3eB2mTf5BxD23o/FPRv
         cX2jx/sdDs7HHnCJ3vWArm3vKDC0BitQnIRUgApqnITRPsFF+N/yQLFphI+fg3CoKTuo
         eumvqkciX6YnSb/bilImqzEZ8MX5Wb2MGw8lpvWZlNzSWBfQ1HbRVxCRFMdfySmZUMnc
         17SqG0PsgiM2XsGyFjizoS+Sm14xUm6feThw2N9exExa5SXA/Ny0esE0Mr2z+WM+PG1x
         mJOH7MvOs2SGQRWJJtV76TeVUKLcimYLPRIlDRsYsMIEpWFP0lhzBK4orlrloxnHLAZ3
         DFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BXKR/jz7AwAcFWUmf8ARWKNSq0m2X1sbr9mM2sMW+R4=;
        b=n2lJHNc3kHtTvsR4yjCSDkqHpV6WzQMOob/EQ1tHdJMD4zQjt+CkbmGEtNq0k9Yy17
         DUKi4TUyQl6Eg5WzBsj9swq4lM12eu5cFKVvP1XiAq6lY8mfer0o/UDogFOcaTv48uTi
         XqUcveJ+1QmqdMv4F4tdTuDy9uTM/D0yU3LvllchOHjz0gft8nOmOHIa1WeZ1AB2sKrG
         yWoD5jIDdkUicEstRgfZzKD9qLmOebTylH2bYq7Uz18EyYv2NcYDYVcLus18lLYUvgwu
         yEM3ScKw2hz2lvJwslsZHokdF6DWr8/tMKu4mRgRVcef5/abdqiwR6tErOE+a725FNZb
         i46g==
X-Gm-Message-State: AJcUukcu1Z8JOExUSiOugJjLDG+L0NXLHZKvQDe3eY1qKW61/DW9rY9C
        RWwpIzebykDYvniFoiwdhHc=
X-Google-Smtp-Source: ALg8bN7a1QlZpuJ2abSqtVLT3lQVCwl0pvm60ljhR00V3532G7ynAplcL0TVpuUNIU2+qMmTyfVJ3w==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr19347758wrg.230.1548642817342;
        Sun, 27 Jan 2019 18:33:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r200sm2799057wmb.36.2019.01.27.18.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 18:33:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sven van Haastregt <svenvh@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-submodule.sh: shorten submodule SHA-1s using rev-parse
References: <20190127192740.8678-1-svenvh@gmail.com>
        <CAPig+cRLLTYB=tVOY39dojLYZqoX=yxPRZY9fjo9z+5+P2BKKg@mail.gmail.com>
Date:   Sun, 27 Jan 2019 18:33:36 -0800
In-Reply-To: <CAPig+cRLLTYB=tVOY39dojLYZqoX=yxPRZY9fjo9z+5+P2BKKg@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 27 Jan 2019 18:46:10 -0500")
Message-ID: <xmqqy375bjen.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This could be made a bit easier to follow by using indentation and ||
> rather than &&. For instance, rewriting the entire block as:
>
>     # Shorten with hard-coded fallback if rev-parse fails
>     sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src ||
>         echo $sha1_src | cut -c1-7)
>     sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst ||
>         echo $sha1_dst | cut -c1-7)
>
> In fact, the code is clear enough that the comment isn't even needed.
>
> By the way, if git-rev-parse does fail, is it going to produce an
> error message on stderr that needs to be suppressed?

All good points ;-).
