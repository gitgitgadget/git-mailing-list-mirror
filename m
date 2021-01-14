Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D060C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483FC238EC
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbhANHlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbhANHlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 02:41:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3763C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 23:40:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g1so4043711edu.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 23:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4cd9zv2llPSZJMFu3Cf/Mwi8kB3R2HtK8+fIDRUQI0=;
        b=of+a/p9lLBufAtNrCibZSkZ3QDgWLLxZJcbBSdOGmFn158MFyELaEF66vS3au6F5pO
         vPbfUvRpytLUlRL+BOcBRF9AP9P3ecPZYYEfpzvENdvtAhhxjIjim1w0tmnWLpfE8Td9
         cHikkmScwx8FmI8Ipo0A5maRR5dETZGPK6jp4jIiHyOncm7GlJ9dnzOeUNQSxceIK6jK
         1jbyWLRrj+e5H4fm9yOphHuY3/t1NdIeipnylOI5ISo2nQXuQ1rmTi1GrWz+hJ8liUq8
         8QtBYTmQv3kMUReOzERJfNtnkbek3zxwdznqjyiXgaLD2okTCdLGfiMyydOmwL4bQoUu
         mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4cd9zv2llPSZJMFu3Cf/Mwi8kB3R2HtK8+fIDRUQI0=;
        b=Pj1ipnxqDgl+ZG+t0g26V9TYfABzo6YqaPCrIa1qx6TnRFhH7bBBeoEvdtE8QV7DpB
         TU7E6PEBFd7BCU/Gi/FiHmJUsGu2vIfmA4rPXa2NV5HT//NOMGoA5LCBG5oy7rRYsi1Y
         nnZs8R+JsC+4ZdTdW3XmOKFPRWdeBBsVQ307MXHilHLh2XZLiw8NiP0wEZAsiTk9DVnn
         NBo8Hws1cKxSgSDJ96lX91wRHvENOfWdCA2qIMqzv+7M5vWkl7+lA3t0QS817rBfjlCZ
         nq9lewiOttGpa52nLZiVIlnYbdPq3YDwEuXEPPihyeZwqUfJKa86TK+BUKfjq7VYwwgr
         pssw==
X-Gm-Message-State: AOAM532+CPOsgtK8ao8bJnnhiEVL6lBMNAs/VDG/wCKo1o57c7GQq7fm
        EojBQNwalq0Ir8cC01chQzoUH6cyu48bglSnEU8=
X-Google-Smtp-Source: ABdhPJy+QcViKZEI2FqsSuBPgj9IhOLP2dhEpTlztb3ZKEigdiS5kp2WCX/7w517jsl/QuaoIXfT736i70zmbtDQ9WE=
X-Received: by 2002:a50:8744:: with SMTP id 4mr4710315edv.362.1610610037323;
 Wed, 13 Jan 2021 23:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-6-charvi077@gmail.com>
 <X/9GrVjBmnJUZcGn@nand.local> <xmqqv9c0wp2i.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9c0wp2i.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Jan 2021 08:40:25 +0100
Message-ID: <CAP8UFD3yhh+UO+pQ9Zr5Rwxy8ma1HENq5dNuani3qyJBYiBKkg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] sequencer: use const variable for commit message comments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 9:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:

[...]

> > The other nitpick
> > is that its typical to see 'char *foo' instead of 'char foo[]'.
> >
> > So, I'd write these as:
> >
> >     static const char *first_commit_msg_str = N_("This is the 1st commit message:");
> >     static const char *nth_commit_msg_fmt = N_("This is the commit message #%d:");
> >     static const char *skip_nth_commit_msg_fmt = N_("The commit message #%d will be skipped:");
> >     static const char *combined_commit_msg_str = N_("This is a combination of %d commits.");
>
> I actually am OK with []; it saves sizeof(char*) bytes from each of
> the variable, doesn't it?

Yeah, that's my understanding too.
