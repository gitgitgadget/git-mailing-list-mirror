Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E67C54EBC
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 03:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjAIDIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 22:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjAIDIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 22:08:11 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD3BCA5
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 19:08:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c26so737134pfp.10
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 19:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLDFMwcTHGqipmi7sxmuZg1FSvwd/30iJdVxPUbbVi4=;
        b=Y9S9M3en5G9RQGDbS5nXc5NBFbO0vI70HUAZk7mFmcy4Davn7Am4Cmr72MGYWizQoq
         rsoAO2Wl5mjOCsLERUvO/7tp9GZAqIdN+4dUKXQW1TVgUA8oZXzS5jbQzaNpcnks7XaG
         NGD5vvNWsev4vPBTWN19L9HhDQAawYqDiTSbSF08IicZpvQGvLii9ALkKjdchfosBWQP
         JtDKj4Ab06AU3Ykbc39kOlwlTO806K01t0Zp2fj4oIHV7wuJkr39ipLYj4SiH9dqqQBO
         QtfqK0A9DXdJbn2ZJ44HmfvDnYpNPL5h4xlSCUT5IJ2fL6tSCha3v2fDYYP3k7OCvK2I
         AYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SLDFMwcTHGqipmi7sxmuZg1FSvwd/30iJdVxPUbbVi4=;
        b=SUf2wydMItVbIsvRyoTH4FB5/rMc8dUIAayPokViDk+PXuDuJfaj+I3pNjwh3tw7Cb
         owzdZ9VWqUFik8T1Q+yIh5yHjBCXxQe/VDPOxZhK/Egv7ZlIVoZ9SBYCBwxXfI0U4Xj9
         yodLiCN1TBwrKIWIKoqpwe1YUapnYZb2c5WPvqyKaFMagQozhu6kcrZeVZI9827+PG77
         AVq9d6Ocdq/9MznMTjtb1Z52QMXwM4l2jLQgRrukia7xp0YQRV1zw38DEzc4MWTxa0RF
         cIJOkrtWIGOOyUULR07/BkMR4io2ZHPIcheYRZQNIPL8GHZmO/HtGx6jK5QxsmHfNfYF
         EPAw==
X-Gm-Message-State: AFqh2kr8OP9iHbcEgBGi9ISqbVQaus1hAG9E3urw48eVgCE4vky2Wg0n
        PJaDalTqzjinb9BV9hSPfRo=
X-Google-Smtp-Source: AMrXdXvYAuB6M87NSTldE4TtCxLBtDyLfsTnyBi7p3UDGY9tau2J2yI7+zmeIErIC2skEFPW++/Byw==
X-Received: by 2002:a05:6a00:3490:b0:581:947a:b701 with SMTP id cp16-20020a056a00349000b00581947ab701mr44670845pfb.17.1673233690411;
        Sun, 08 Jan 2023 19:08:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w2-20020aa79542000000b0056be4dbd4besm4854531pfq.111.2023.01.08.19.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:08:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/8] bundle-uri: parse bundle.<id>.creationToken values
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <a1808f0b10cfb519613bc292e30b884962a83275.1673037405.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 12:08:09 +0900
In-Reply-To: <a1808f0b10cfb519613bc292e30b884962a83275.1673037405.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 06 Jan 2023
        20:36:40 +0000")
Message-ID: <xmqq8ricxv52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!strcmp(subkey, "creationtoken")) {
> +		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
> +			warning(_("could not parse bundle list key %s with value '%s'"),
> +				"creationToken", value);
> +		return 0;
> +	}

We tend to avoid sscanf() to parse out integral values, as it is a
bit too permissive to our liking (especially while parsing the
object header), but here it probably is OK, I guess.

> +	/**
> +	 * If the bundle is part of a list with the creationToken
> +	 * heuristic, then we use this member for sorting the bundles.
> +	 */
> +	uint64_t creationToken;
>  };

Is the idea behind the type is that creationTokens, while we leave
up to the bundle providers what the actual values (other than zero)
mean, must be comparable to give them a total order, and uint64
would be a usable type for bundle providers to come up with such
values easily?

Thanks.
