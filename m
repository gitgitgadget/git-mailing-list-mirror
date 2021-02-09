Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1BBC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5E864E9D
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBIHOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhBIHOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:14:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C74C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:13:23 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id r21so8115917otk.13
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFW4HPK2SRlrhXFl3IU3FgeDdWzOWuZocsSdQ2zHf6k=;
        b=KYJ+95mJMPNswWyxpaeUN8/a7CkXV45AucfyJP16bPuBm93FqelyJLDFqt2M8qaDw/
         uXT0lZ7+frGer/g7yDp2JURg41KBpdmcqwlIH1ZM6CRR8a1fZA6xmYv7r9pFShWlXNY/
         YZwUU+96f+rwlOS/ZzV8j7n+FjAvwPsplidx4YB9NMuRc8adQqJQN4zzubCRg0XzXIlQ
         voYDD5MJnOjn789oAHSZIjXb+cH2FNcVfn105JBCpHp3IfJ2o77/hjluOjUUBbtSUVtQ
         +bwE4UhT0NJ3qNzFW82nmFD7/nTLOAaStS7rj5edzgz0TXktqW4S72SROgkSwyntSPaY
         BktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFW4HPK2SRlrhXFl3IU3FgeDdWzOWuZocsSdQ2zHf6k=;
        b=iYQvkkX1jrym00X0EaVCLJC+wnVJbDhhe2/GxIc19UnkrFclqNCX7UEJ2WqwuCRyFn
         cY+iMkNcChqbxPVSkhdHjQ9dwiAJCrLD4MoPRT+T2hJ47GOVhUJNsYrYADBwiNvG8K+Z
         2GpCeebT92VaW9ZZyNlDq6jEBXS91f0jYC/MgYpgfA6c5wVPRe/R7VzMkv0hC9kV2F3S
         Iq5EpznVxZP5fT1QL/sX+D8R5B7WrVFRGjNCcNnzji7h8NmmKUbgntcyUteA4/2GrirA
         nCpITMWqDut6JNs6EiiTLlWPuXQdJJFMp2bl/kEGyy0n+CamT8rWdOAIU1Q1S9gDgpKW
         pkrw==
X-Gm-Message-State: AOAM531WXx7drOj+u0ZrCmJsrwODU3guZh088pmmizchIWeY0kHdZ866
        sEkn7dgWO/EeBZ+60W/EEW7fQflCOYm6ic/GqPk=
X-Google-Smtp-Source: ABdhPJzA5jo+ffzi2c/rIf3awBfPnaEpP6e1b30k28aqS5SRzQ3P2hVwDYVy4Z7kZyUVB5mQdgFkH5dLKCdUT+eH/bQ=
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr11977427otq.210.1612854803349;
 Mon, 08 Feb 2021 23:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-4-charvi077@gmail.com>
 <xmqq5z325k3j.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z325k3j.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 9 Feb 2021 12:43:11 +0530
Message-ID: <CAPSFM5dN=gs7m8VskCPMzD10i42ETQ_7UzuGKmi=X-xs2QkYSg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c'
 rebase-todo help
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> >  "f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
> > -"                   commit's log message. Use -C to replace with this\n"
> > -"                   commit message or -c to edit the commit message\n"
> > +"                   commit's log message; use -C to replace with this\n"
> > +"                   commit message or -c to edit this commit message\n"
>
> The goal is good, but I am not sure if this "the commit" -> "this commit"
> is an effective enough way to fix the issue.  Here is my attempt but
> I do not think it is not 10x better to be worth replacing yours X-<.
>
>     use only the log message of the "fixup" commit, discarding the
>     message from the previous commit.  While "-C" uses the message
>     as-is, "-c" lets the user further edit it.
>

Okay, but in this patch we are also removing period and capitalization from
rebase to-do help of commands. So, maybe we can replace it like :

f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
 "                  commit's log message; use -C to use only the\n"
 "                  log message of the "fixup" commit, discarding the\n"
 "                  message from the previous commit; while -C uses \n"
 "                  the message as-is, -c allows to further edit it\n"

If it is okay ?

Thanks and Regards,
Charvi
