Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1BCC43217
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiBHBFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343545AbiBGXe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:34:28 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F25C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:34:26 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso486335pjq.9
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GIdtoPfNymGYl6on2Q/POoh60kJZmmy1dJWRX/Z75KQ=;
        b=RHq3vR09X01UsiPMeXbvfCx3QRPaQwC+htgV5RlzcFK2jAZ+mHJHAHn+PMwgRhIwQ9
         X58U/W6lLelGO8A9qUm30vuHPr8gQpVCq3Zt6uHvKQklxtBYqx5Xinc6oFH8z4y+rAmj
         0k/VeWfYfwdbQDs5Dfs+X9A8xyczz80CMXSdqs2b8yQCKEaE6gINn+MeY1EoF0d2NX9c
         JHjT29GuHpzoTH9GzLhGD9o1VvL7T7noSwRDKOpellleUPxp+np5+JO5JSFQIDKyVGJ6
         bEgFzFjNF1odB7JYR0/Sv4pWwjOMdCSyCe7hjbPnhhLUBF34BwVoz34Iqzm5T8lAX7UB
         vCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GIdtoPfNymGYl6on2Q/POoh60kJZmmy1dJWRX/Z75KQ=;
        b=NV/8eRc6XaDppoMXDc37BEXyBK8uzR7oGoGDkgnUjEA3SBZ2UAaOJux9PlvrV1W3I+
         BR/w2M0S77uu8vC9efkDH1Ut2YQVXh77w0YJC4vwG0AXhid6p1jmebF8KNA6Vwxr7m4R
         HUQ+MULDlmAbD2kaP/pKKNu+/iyEucsaI8JOH5iVWDFMuPoxK145j3yAiV/3FQX0ZoH3
         zk8TEftUm+ujBIcpU8hgQHqqr8uv559U7x5lquuQHhJCPCU0vMkEdDGC68hvlUngE7Lm
         nNO/FtfsJtqfvPRYAwONVua1DDl7cOo5kD5ixUyJMQrBwvHlUAhwDijc9JXr6AT/8XXJ
         WOYg==
X-Gm-Message-State: AOAM533dQsA3Gm4y+TknnNe3HAklAj3Q6qktwvNdp+MfSHWmKTXZx29t
        qRWN646EF/7RTlQWZ/st5MaXisCDTEISJs6ltnPW
X-Google-Smtp-Source: ABdhPJxYvk/cdQU2NYjGBhHfRQezQRS36rBK6xCxsmcx8p47cQ0+gai79DZYhyhYCU+L+wuV1Zf62XAZIHGMjbRsNziZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1b46:: with SMTP id
 nv6mr1370965pjb.105.1644276866314; Mon, 07 Feb 2022 15:34:26 -0800 (PST)
Date:   Mon,  7 Feb 2022 15:34:22 -0800
In-Reply-To: <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
Message-Id: <20220207233422.14094-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        gitster@pobox.com, sunshine@sunshineco.com, johncai86@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> However, if we had --batch-command, we wouldn't need to keep both
> processes around, and instead just have one --batch-command process
> where we can flip between getting object info, and getting object
> contents. Since we have a pair of cat-file processes per repository,
> this means we can get rid of roughly half of long lived git cat-file
> processes. Given there are many repositories being accessed at any given
> time, this can lead to huge savings since on a given server.

One other benefit is that with explicit flushes, in a partial clone,
this makes it possible to batch prefetch objects.

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index bef76f4dd06..618dbd15338 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,25 @@ OPTIONS
>  	need to specify the path, separated by whitespace.  See the
>  	section `BATCH OUTPUT` below for details.
>  
> +--batch-command::
> +	Enter a command mode that reads commands and arguments from stdin.
> +	May not be combined with any other options or arguments except
> +	`--textconv` or `--filters`, in which case the input lines also need to
> +	specify the path, separated by whitespace.  See the section
> +	`BATCH OUTPUT` below for details.
> +
> +contents <object>::
> +	Print object contents for object reference <object>
> +
> +info <object>::
> +	Print object info for object reference <object>
> +
> +flush::
> +	Execute all preceding commands that were issued since the beginning or
> +	since the last flush command was issued. Only used with --buffer. When
> +	--buffer is not used, commands are flushed each time without issuing
> +	`flush`.

The way this is formatted leads me to think that "contents", etc. are
CLI arguments, not things written to stdin. Some of the commit message
probably needs to go here.

I just looked at the commit message and documentation for now.

If you have time and are interested, we at Google are thinking of a more
comprehensive "batch" process [1].

[1] https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
