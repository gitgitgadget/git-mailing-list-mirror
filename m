Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E6C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 15:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849212468C
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 15:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPci7R48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgARPmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 10:42:19 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44038 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgARPmT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 10:42:19 -0500
Received: by mail-vk1-f194.google.com with SMTP id y184so7446733vkc.11
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vJjVEgjO1axLy1m9N5QREDoP4AJQsVQJtd2/xJSHqY=;
        b=MPci7R48a/5ZKUqIIckudw+xXX5NHqE2eInZ7gC6AcXWNnkAOd1cyQZhGCdTApbdY1
         py8HxSRWzva2AHJuD9A741VmkAg4Ce750KM/slp5P5g4BcT9SPmLtNACjEENs8oPEbxY
         W/ReOE+0cCqzsGOSWnzacHDLWPA/7agMBwujWXt7QcqkJkN6ZDZKlVRv67L6uWdXxyH2
         iDLbqw1sQOeJ5pqeaCRt5McvBDQQnNesXHfO0HCRQY7bRjNfrHm0H/FiGvM/6jGtRR+l
         vSvnZTmDRzFxV6CWJ79+hwuiKk++SUgpKRfBAy8MO5kZq3V/8Hm0RL3L5bhD3r0SzIf3
         2lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vJjVEgjO1axLy1m9N5QREDoP4AJQsVQJtd2/xJSHqY=;
        b=fTFNkhAYLNU3NSuRzzQXsQJoRXhU3iLmGStH5gOoN5OdX7NU8LTLZnrKXinqQgXVEB
         eR/t/tcRKTLyAqJ8GpUcq7gv5ZJ+VfHyfww6uE4z9qHTexXwLcCZsW6I9Ogflap0BqZz
         J9+kasjbkF10RuPuTz/jTtGPI6nHAx5eIUpyxwFnhe2u14yF0zOGPSTpVm+ZaYJ1lcJe
         oP6Q+zoKXouISfWXc5GttEJERpGK2C254livLU8ITgTwImxdSKZFGttDZR8rgp8RHTng
         UdnQMBqqI1o6Pml2ju1lAzF9V9r3mnNJEdKuMgmGWEVnzud7HAAIQ5d/s5VGpcBoPj7A
         nPbw==
X-Gm-Message-State: APjAAAVTwU+OygnB6l+pOjsCtmoaxkEFpBpiyZu6DoET1RRZINXdTt2R
        0rei4NYTLwVDF321nBkALTfCVG4xNIPRwGJBQ8A=
X-Google-Smtp-Source: APXvYqzyQ7knACK7nQOfWynM6/veh71r/Z1d7llriGAnPcxLSLuXgzSa4VM0u0Trg3m7hJFwrefVE/Inn1Yb+IVebB0=
X-Received: by 2002:a1f:94c1:: with SMTP id w184mr23916631vkd.40.1579362138030;
 Sat, 18 Jan 2020 07:42:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
 <pull.478.v3.git.1579275102.gitgitgadget@gmail.com> <61ff3c64b5bdec4aaca71caa63efc23888713315.1579275102.git.gitgitgadget@gmail.com>
 <xmqqsgkddbjz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgkddbjz.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 18 Jan 2020 10:42:05 -0500
Message-ID: <CAOjrSZvFphMaJ7Yaj4pq1qp+UJixgULN7qSf8v_xKKRePgXceg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] config: add '--show-scope' to print the scope of a
 config value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The HERE-DOC is over-indented.  All the body lines should align with
> cat and EOF.  The same comment applies to many "<<-" added by this
> patch---mimick the "<<-" that appear in earlier part of the same
> file.
>

I was mimicking the style of the --show-origin tests, and didn't realize this
was a style violation.  This is done in a few tests, so I'll add a patch
that just goes through the file and fixes that for the existing tests as well.


> I wonder if we want to revamp the tests for --show-origin that wants
> to make sure a funny filename is quoted properly.  For that purpose,
> CUSTOM_CONFIG_FILE is given a funny pathname, and it would have been
> OK to use that only for a single "do we quote properly?" test, but
> instead we use that same funnily-named file as the source in many
> places where we do not *care* how --show-origin quotes the pathname
> at all, and end up having to skip with !MINGW.
>
> It's a bad tradition that started at 45bf3297 ("t1300: fix the new
> --show-origin tests on Windows", 2016-03-23), I guess, and is not a
> new problem introduced by this patch, but it should stop so that we
> can have a better test coverage everywhere.
>

Agreed.

> Other than that, I think that the new feature added by this series
> is a sensible one.  Thanks for working on it.
>

You're welcome!  And thank you for the careful review.


-- 
Matthew Rogers
