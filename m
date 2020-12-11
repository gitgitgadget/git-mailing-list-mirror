Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B38C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 01:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C60423DE3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 01:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbgLKBJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389839AbgLKBIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 20:08:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D4C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:08:13 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r7so7366822wrc.5
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bylm20a9UIibT/wL7ybYVBjwdgvBZAUHg7Tmn6v99T8=;
        b=PYugDPiMEbG1EHhIZSZYH/LH2vBjLpT5aEFS7FMY40TVoSauuo4tRLkmmW1DvwV/F3
         EPY2bTRdiVSFeuEvmO+uXW5Z72axX7mpscpic7grywHFbssxAdRbOSooPsfTnblnkMPx
         ufoVczkpqmEC7xjb6LE/m6VQnVv5SxbnD6zi1rdmzyk4OTStqc/aRJcVfj6dBpEXZc9p
         swUV4CPI1gwuzAdocdPD7ECLdI3693kvfaHmIHmVEtgYwjPUJEQilMvhCI3upKwe4r6P
         jQUaB7RT1UthUdJ38wn4DfT6UV+v6RUJe3HTh1+OZv5mCmkl60RjZkX68wfS9IqJRrlx
         lXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bylm20a9UIibT/wL7ybYVBjwdgvBZAUHg7Tmn6v99T8=;
        b=eJe7RAy9pmv3ToFLT5NMZwKN7lZ93/6W14nhZZL8x2LPgu3DyrJX8EjcrlLv61uPAz
         Guuk9uSoNpJXJ8qquKvxK2qBw1hmgX9Rd+jKTgNBzp7pRBFhqk3fUtOM4WJLiTl3B60n
         I0GgZ90Dhc8wUVxsaThrZf2aLIPVwiKx9AQk3KnsLqHhegOeNz6WqQs36GNEykbS860R
         e8vV/Estlu6Fkbv1/SQXT3Ee5nDr4nb6wnhiXl39M2i6ECwZtjFsjqcF0JjxiSiBjnpX
         k4wEpZ3Oj6vnNANNA52Hjqi5LWT/UccHOZnHXL7xePnDDzE4ds8f/iviPyu7xubDq+vy
         DHWw==
X-Gm-Message-State: AOAM532wvJAaMYyd1uwfv1QQrbuUOC85IiQruyQQrB0xGH5ZQX941V61
        DwSRf7ZxjjKZjLgSyG92p9I/5/Iw9EOHiN2NRZk=
X-Google-Smtp-Source: ABdhPJwlgArQexH5qWt3v9RpG0tcoJltSz/wJzFPTUih8zW8LkP/Y/h0Ma4+2DxloUZMCM8wAS99cm1DI0NUvUJvZbE=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr11039916wrw.139.1607648891863;
 Thu, 10 Dec 2020 17:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com> <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
In-Reply-To: <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 19:08:00 -0600
Message-ID: <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 9:51 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-12-09 at 06:55:36, Felipe Contreras wrote:

> I don't think this should go in this location.  It should go in contrib.
> Here's why:
>
> * We should not ship editor-specific files in the main directory of the
>   repository.

Why not?

>   Even though Vim is very popular, it is one of many
>   editors, and it is not even the most popular editor (which is now VS
>   Code).

Even if vim is not the most popular, it certainly is among the top 3
(and I doubt VS Code is the most popular, I would like to see some
numbers on that, but even then; VS Code is not an editor).

Nobody is arguing to have editor-specific files for "every editor
under the sun", just perhaps 2 (or maybe even 3).

No slippery slope fallacy here.

>   We have editor-independent files, and users can copy this into
>   the root of the repository and ignore it if they want it there.

Which are insufficient. They are certainly better than nothing. Plus,
it's unclear how many people are actually using those.

And I'm still waiting for the argument against adding such a top-level file.

What is the harm?

> * Whether a user wants to use automatic indentation is a personal
>   preference.  I do happen to like it, but there are others who don't
>   and prefer to leave it off.  Similarly, whether to use cindent,
>   smartindent, or autoindent is a preference, as is which cindent
>   options to use (I use different ones).

So?

These options will not be forced on users, they have to specifically
enable them by doing at least two steps, *and* they can still
selectively override them in their ~/.vim files.

> * These settings affect every file that's loaded in the same editor
>   process.

That is not true.

:setlocal [1] applies the setting to the current buffer only, not
globally, and *only* when the buffer is of the filetype specified in
the autocommand.

> So while I agree that these are common settings, they are not
> universally applicable, even for Vim and Neovim users, and we shouldn't
> try to claim that all or even most Vim and Neovim users should use them.

We don't. These are defaults, which a) the user must consciously
choose to apply them, and b) can be easily overridden (as is explained
in the commit message).

> So I think contrib makes more sense here.

Clearly. But you haven't put forward an argument about how precisely
will this negatively affect *any* user (or the project).

Cheers.

[1] https://vimhelp.org/options.txt.html#%3Asetlocal

-- 
Felipe Contreras
