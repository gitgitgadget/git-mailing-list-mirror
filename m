Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763CC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 00:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKXAve (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKXAvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 19:51:11 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9E10FED1
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:50:04 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c10-20020a17090aa60a00b00212e91df6acso83636pjq.5
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyFXJkVMtZ0cK2lD8OQup4p6T8XynNZbQDlln+LEl94=;
        b=EwxjkNQPt3ivRUYHMUdyvTRCIG9v8RyaV/ggNYGp7Rz2kZW4Z/POFVgDWPTudCXxuf
         4SM1++GRTDgPFzdzMgOnZlXmwx5wUW6IzPt8ealJTzYF65c1mrlTJ1E4uXBXnySTQAn7
         kLTDvCiWqwszukzSBaUQiZ7VoRL2+qWzj2OEpqVonTUOoZkSt9vdo9cJUfyVFrq196Ml
         1SS5t3TaxbLWs2t+kNY0G4o3TJfdnrbXnfvYouIen0yIrahIJT47P7BJIF5t/b0XmCXl
         h/Lg8K9iHLHO6bnj1J2+MxVQ6ORRxL/jvcnbactulJgOpf7o5OiftyLusiy7h/qvHSD8
         m/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyFXJkVMtZ0cK2lD8OQup4p6T8XynNZbQDlln+LEl94=;
        b=wU6sb6B/7pEVzoArS0HXbAtNgV6p4oHU64sb6YfmUxHUzNibiLRpbobvZzzz6IHMmr
         eBxAQP9wvUX66aZKWclWyUcRk+ZtoZq/tkXRHir8YQ/p/a8UbhVGmFoECMsRv4aUZn+v
         nebYQtnEqKJpFKqr+GlbuceAbOVr9KkA7i26ze8GzzqGVGGGAmgIDmOd7d8wDLF9HXm+
         dELjvExwIwGnui7d2fUQmVkYYZ5IJMueMSHcKdNJB3miZwYK1DuCiduJGXmeMOxqpvXF
         X7SAgIbIsgScJMXQWR1Owcayv88X5x4Z/GJGXYJbmGv590JJTxy43pNC1ituzOE3uRqD
         ZkZw==
X-Gm-Message-State: ANoB5plYgCDFS/lbHIEHBJ2Ogn9zegsYf3is3cqcPqR6kMJQigYcoHUT
        4+wqN71JlwGwVleFE5Oou81f33f7sP5wHg==
X-Google-Smtp-Source: AA0mqf5mh/HLrf6u6bEzC556QXVw0ykRv672kgxPPH5kCbKs1QeXvZ4Yl2gKYbwiOwNhzUXEz9+FTK89lKEeDw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9ad6:0:b0:571:8e02:54af with SMTP id
 x22-20020aa79ad6000000b005718e0254afmr14433220pfp.53.1669251003836; Wed, 23
 Nov 2022 16:50:03 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:50:02 -0800
In-Reply-To: <Y30onDTUFmAezkSl@coredump.intra.peff.net>
Mime-Version: 1.0
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
 <221122.868rk3bxbb.gmgdl@evledraar.gmail.com> <Y30onDTUFmAezkSl@coredump.intra.peff.net>
Message-ID: <kl6lwn7lch1h.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] object-file: use real paths when adding alternates
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Doesn't this leak? I've just skimmed strbuf_realpath_1() but e.g. in the
>> "REALPATH_MANY_MISSING" case it'll have allocated the "resolved" (the
>> &tmp you pass in here) and then "does a "goto error_out".
>> 
>> It then *resets* the strbuf, but doesn't release it, assuming that
>> you're going to pass it in again. So in that case we'd leak here, no?
>> 
>> I.e. a NULL return value from strbuf_realpath() doesn't mean that it
>> didn't allocate in the scratch area passed to it, so we need to
>> strbuf_release(&tmp) here too.
>
> We don't use MANY_MISSING in this code path, but I didn't read
> strbuf_realpath_1() carefully enough to see if that is the only case.
> But regardless, I think it is a bug in strbuf_realpath(). All of the
> strbuf functions generally try to leave a buffer untouched on error.
>
> So IMHO we would want a preparatory patch with s/reset/release/ in that
> function, which better matches the intent (we might be freeing an
> allocated buffer, but that's OK from the caller perspective).

Is that always OK? I would think that we'd do something closer to
strbuf_getcwd():

  int strbuf_getcwd(struct strbuf *sb)
  {
    size_t oldalloc = sb->alloc;
    /* ... */
    if (oldalloc == 0)
      strbuf_release(sb);
    else
      strbuf_reset(sb);
  }

i.e. if the caller passed in a strbuf with allocated contents, they're
responsible for free()-ing it, otherwise we free() it. That does fix the
leak in this patch, but I don't feel strongly enough about changing
strbuf_realpath() to do it now, so I'll do without the change for now.
