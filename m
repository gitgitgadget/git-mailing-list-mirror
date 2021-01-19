Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14727C46461
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE8622DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbhASROZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391127AbhASROD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 12:14:03 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738CC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 09:13:22 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q25so21906673oij.10
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 09:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npEuGY1tod3hmtlpPiR/HVekdWcDojq5OvH73ZTdTg4=;
        b=MhnRY3Dl5olf9SXoK4AUC7qEu73u95avGuwPBzEq+G2kPP3nyHHj89Tt3C8XZZspaX
         zwvOrxuAtJ/ni24V3Z6IBUnpSD2rFiEOvTjHQvXw19LdC2ZjHGyoKq9uCvXq1+1jGDM0
         TVvKBt3Ov6eWH8Dq0mMeBTYlb1pW3Ndsr4KEy5eNzCcXDwNLCXi5MXxBg/ru0p3NWuPO
         NXYDSiMoLHFHzA6OqppjfaWE3of7y5G9UQCAChF5BO/c0OjmisRlCux+R0vgQ35wOokL
         e4aEd3QIwC131+xt0KrDkbSHmHICWEwhwdS8WKZLZ+Sd7sMg1cuef6dQ+u8KkAv6tBnd
         zW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npEuGY1tod3hmtlpPiR/HVekdWcDojq5OvH73ZTdTg4=;
        b=MctC36o3q+Wt8jKQyDr5mJ31e9hrzsXC4FE5a/BK1MM63Yt0RO1F0jibfHzRUpKHd9
         a8J57JT9Si2uCmhKYBO9vgvPpKe5KkfJ/EpF1+tzIutstKTef8oXIYUHKhouz1K7RE6c
         NesKIq1tPG/07CgHkNwH8uvfcJiac5RfQ2Cu0W1G4IoiGQblXXMgAdL8WJeTkEQ9dSKa
         lxQWHWvvCRfKoJQSQpSB8VKXPhXgG33jM9hOrOmj27wnAQgU6chI/Y0wZvb5w2IV9m1L
         GA7r39k//iliLeCktWFLsV//9StbhU9vFWBZfz0VAOCAQvm47YZ3AAzmf5S3Cmj47flL
         M76A==
X-Gm-Message-State: AOAM532GRw9FP9TgVRCVnXytZiy/eIkXl+Uz0HbveIu0ANY6sOu7/786
        p8UVDicWo5hV1omOwihVc/QJeHpotjOFO6BYD+hQ75+n+7wfrQ==
X-Google-Smtp-Source: ABdhPJxAc0X2zqGzeJJiWFlWt2+wWn0EBoms4gt+17xOWU7i1j6IAlmlnsOc/LHH3GblELqpHLjOKcw6lh+H18wEVmA=
X-Received: by 2002:aca:f157:: with SMTP id p84mr449577oih.98.1611076401734;
 Tue, 19 Jan 2021 09:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com>
In-Reply-To: <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 19 Jan 2021 22:43:10 +0530
Message-ID: <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

On Tue, 19 Jan 2021 at 20:07, Marc Branchaud <marcnarc@xiplink.com> wrote:
[...]
> >   "pick" for the second and subsequent commits with "squash" or "fixup".
> >   If the commits had different authors, the folded commit will be
> >   attributed to the author of the first commit.  The suggested commit
> > -message for the folded commit is the concatenation of the commit
> > -messages of the first commit and of those with the "squash" command,
> > -but omits the commit messages of commits with the "fixup" command.
> > +message for the folded commit is created as follows:
> > +
> > + - It is made using the commit message of a commit with the "fixup -C"
> > +   or "fixup -c" command. In the later case an editor is opened to edit
> > +   the commit message.
>
> s/later/latter/
>

Thanks, will fix it.

> What happens if there is more than one "fixup -C/-c" command?
>

Upon running interactive rebase, in todo list if we use for example sequence of
commands like `fixup -C`, `fixup -C` , `fixup -C` then it will fixup
content of all and
for commit message it will replace with the commit message of end `fixup -C`

Similarly, if we have sequence like `fixup -c`, `fixup -c`, `fixup -c`
then also it will fixup
up all the content and here it allow user to edit the message, so
opens the editor once
in this case and shows the commit msg of end `fixup -c` to edit and
also contains
commented commit messages of complete fixup chain. So, for any sequence of fixup
chains `fixup -c` works as similar to the `squash` command.

Hope it explains the working.

Thanks and Regards,
Charvi
