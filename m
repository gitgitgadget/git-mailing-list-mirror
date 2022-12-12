Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730BFC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiLLALR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 19:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLALQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 19:11:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E595A0
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 16:11:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g10so10362298plo.11
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7urcx9V/HSvJ/IbD73mn8S5++e1ZjuhyX7K9ImhLCNA=;
        b=EAH4/5YeLcA+PzsgHwQQO0ZSP1pHvJSey+YzJO8OoyVBN+uHx3MIYFUjZr4zNTt7M5
         R82y+y7CX3AUlMvTtOMJb5sZTcbtG0gM0CffAdkWVDpwYLzr6cp5O5bdmeoqruXBi9dG
         AqbD79dwcaj6AgxecYoAX5yTIKwLZWo23KWfSMxLmvM/Ko2QAmPtOwmE7McPoJlAWiYl
         5MeugzwFHx6V03O855e+ksngGpFWhl6S9j3svZYfbOBuXCSqwLxHeIjAqiNvmlNmbGtq
         fBgrfZjDr8I7JTFN/aB8D7LXnPD5D4sRc8RVtTkOEdMDtdbNgJWye8YWbHrEFIMQ8ByE
         7SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7urcx9V/HSvJ/IbD73mn8S5++e1ZjuhyX7K9ImhLCNA=;
        b=F9Ke9wIO6EK5fdiOh+uixMDbaKwsbZMrWDxFsd5kbczRN1LyWV0hwHD8ZtBWI7LcxE
         f8ngp/2+Msu9li0/cv9uii+2P/rKdD95ff/NksMwFPFR69mfdYmdyQsQZADFlJS4rftd
         xTWR3ViLk0j/yUagXp59lJ9Rge+P8JTs80ODOnb1H0PZ9OX32rYNwO9V7lPpDzax1AL1
         krWvjG1HGarKRu6xHORxAzia4cVf1gOCVS4yPqVOakdYOmhKSlU8o/idlAjbXczK7s3Z
         oyAEiW/rvwVdySXCo/dJ1UEuJQnztaaW3RuUgM4h1Z/LeO1YW1obNWDdYccTH4A3He9I
         ++3w==
X-Gm-Message-State: ANoB5pluVBjvmtS9YVYb55AoIJE9wyZZpr8vrs+Ffy9vPloRDdYM6wNt
        fxECAEHKk/zPDyPQSEtyj3g=
X-Google-Smtp-Source: AA0mqf6HHD1vr+YqKV84KoT+0Q6kurfIHM0oADCwm7sTTWZhyz9je7x9LZPORo8CehdCP0xZSkB+TQ==
X-Received: by 2002:a17:90a:cf05:b0:21e:1282:af44 with SMTP id h5-20020a17090acf0500b0021e1282af44mr11079814pju.2.1670803874287;
        Sun, 11 Dec 2022 16:11:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a670900b002190eabb890sm4213653pjj.25.2022.12.11.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:11:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
References: <20221209150048.2400648-1-toon@iotcl.com>
        <20221209150048.2400648-2-toon@iotcl.com>
        <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
        <xmqq5yekyvrh.fsf@gitster.g>
        <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk>
Date:   Mon, 12 Dec 2022 09:11:13 +0900
In-Reply-To: <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk> (Phillip
        Wood's message of "Sun, 11 Dec 2022 16:30:54 +0000")
Message-ID: <xmqq8rjdv5um.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Without "-z" you cannot pass object names that contain newlines so not
> quoting the output does not cause a problem. We could start quoting
> the object name without "-z" but we'd be changing the output without a
> huge benefit.

That's fair.  The next question is from a devil's advocate:
is switching to the full cquote the best thing to do?

If we were using the full cquote from the very beginning, of course
it is, simply because that is what is used in all other places in
Git.  Using the full cquote does mean a LF byte will be protected
(i.e. instead of shown literally in the middle of other letters
around LF, "other\nletters around LF" would be shown), but pathnames
with backslashes and double quotes in them that have been shown
without problems would be shown differently and will break existing
parsers, which are written lazily with the assumption that they are
perfectly happy to be "simple" thans to not having to deal with LF
(because in their environment a path with LF in it do not matter).

A bit safer thing to do is to replace LF (and not any other bytes
that would be quoted with full cquote) in the path given in these
messages with something else (like NUL to truncate the output
there).  As these answers are given in order, the object names are
not absolutely needed to identify and match up the input and the
output, and properly written parsers would be prepared to see a
response with an object name that it did not request and handle it
sanely, such a change may not break such a parser for a path with
any byte that are modified with full cquote.

The above is with a devil's adovocate hat on, and I do not care too
much, as I do not think butchering backslash with full cquote would
not hurt even existing Windows users (if "HEAD:t\README.txt" named
the same blob as "HEAD:t/README.txt" on a platform, doubling the
backslashes in the output would have made quite a lot of damage, but
I do not think we allow backslashes to name tree paths).

By the way, there is another use of obj_name in batch_object_write()
that can show whatever byte in it literally to the output.

Thanks.
