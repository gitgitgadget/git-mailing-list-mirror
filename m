Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA7A1F516
	for <e@80x24.org>; Sun, 24 Jun 2018 10:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeFXKT2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 06:19:28 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45222 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFXKT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 06:19:28 -0400
Received: by mail-yw0-f195.google.com with SMTP id v190-v6so3822492ywa.12
        for <git@vger.kernel.org>; Sun, 24 Jun 2018 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCGrEw96P0QisRsW59ZnmI8gB/DJVppMlsJsNeomWqU=;
        b=QXzhYgEQPw/u6C+eLSzcTrRsvARG4ykVoLMPY/JMmwXq49G8+vEQSuf/zyaAVzrJmY
         uweNa3LxKnPAom1/cZfl9uOlI7krILTwLJHKz/agFcehb4xNJZkUyn3PsddXGhqJYa2m
         MLav8tlQ212eCaOPd4lLQcl49QuaN7x+ginua2ML/YXO9vMYOy6iUAUF6Koj3Mkxsm0/
         3rJkRUQ5T0P96D3DCOmm9iOTXDXUWnJL3KUW01FTkp0gGCrxclSBLrGx+xnFAJWtR7j6
         SuxSJI88doPhvJWE6CHCJ95EpFILC7K2IiY/CZjlwA5pL+lJNzzDATwzLCxoHgCHeVCg
         ufoQ==
X-Gm-Message-State: APt69E2CqRhyNs/ZkuPj4CTLBCnICRdqsonqGAGuBXIn1TeX8EaPAhvM
        KE3zUUkFShrz1yTZzvdyiGcVg2aAo3/q7hl7Jlg=
X-Google-Smtp-Source: ADUXVKJAZ6TMqAWhKZWtQrrTYzra/1ZvFSFz1jouLc+zfpqZJloiI1liVADZhiIwmxa7yB0G282gx8xC0Wt9uBHynaU=
X-Received: by 2002:a0d:f383:: with SMTP id c125-v6mr1584222ywf.98.1529835567525;
 Sun, 24 Jun 2018 03:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
In-Reply-To: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Jun 2018 06:19:16 -0400
Message-ID: <CAPig+cRu8UGVB3MYNRN_Jn0w8Vn=+WdG488hmaePzP=ibtU3TQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: declare "core.ignorecase" as internal variable
To:     Mark Strapetz <marc.strapetz@syntevo.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 24, 2018 at 6:05 AM Marc Strapetz <marc.strapetz@syntevo.com> wrote:
> The current description of "core.ignorecase" reads like an option which
> is intended to be changed by the user while it's actually expected to
> be set by Git only [1].
>
> [1] https://marc.info/?l=git&m=152972992729761&w=2

Thanks for following up the discussion with a patch.

The commit message, unfortunately, doesn't explain the "why" of this
change in enough detail for someone to understand the issue without
chasing down that link (which could go stale, or the reader might be
offline). Incorporating Bryan's explanation[1] directly into the
commit message would likely be a good idea if you happen to re-roll.

    Git on Windows is not designed to run with anything other than
    core.ignoreCase=true, and attempting to do so will cause
    unexpected behavior. In other words, it's not a behavior toggle so
    user's can request the functionality to work one way or the other;
    it's an implementation detail that `git init` and `git clone` set
    when a repository is created purely so they don't have to probe
    the file system each time you run a `git` command.

[1]: https://public-inbox.org/git/CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com/

> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
