Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF7C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 02:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLRCQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 21:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRCP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 21:15:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049B6327
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 18:15:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 17so5954658pll.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXUDdOA3UBvhpYKDrXGeB9+WhcOUSQ9WHEzr1zBIEEY=;
        b=C7wd9LgeWlV0NjaZDQFaAP1YcbbljuUwtJ7YFCWopkYFcaOPjgjWlp0F6Ggkpqioxg
         bLSD5vfnZ7nsiI0sZYImoTbJ/0n/4sSwxD4jV64Y3nznWIFBjQ1hW0R9Z/sRGZ7qV3Pm
         TY4SuuXfZWV7AHvZ1IAha288nUxUO4iVTaEjO7oKzTyPEeIkAhPaTvbWCMAwHi7kGEBU
         fz5PC04j1++SmLrd5Gk/ldoT1h7YiSzrNyqt7+12yDEwZvGeKLHFCjpSPrXkFAv+UF8X
         MZMTpdxc49Ux4BHUfr+umacsTXzMwpT3EvPO9ApKLL0/hrEiQ4/gbr4IbhqT7O6cLfVV
         9l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OXUDdOA3UBvhpYKDrXGeB9+WhcOUSQ9WHEzr1zBIEEY=;
        b=wem7eVktCiFjNlyBlkSYgIm0HdeYTxV+hIlQY5QvvSXabVm93s4LkYEuhrWUlCpVaz
         dOWWFaJTE6m3rg2egyJLS/Px9TKp6p0qxKlFoo4NZTgmUczrO/mgXaZUESFr7AsWfZxB
         HNUZrTKZFXrYvPrIxTh0SA1UKeXcQQ1hDqUGiqnnUOhvVJO/zgxjiPDb6bbKUa/Lh893
         /AZ0lEwVy8srWRkGFql6rle/EHtpBK+TpFwKpPOi6kho0VIn39OTZabPRpEXdzrv2v6F
         TN6vrAGLO3lmWVr9FYZH0zj9llzWbE8HV/is5SFV0MLinrqTSgvVhXoOc+mhfq0wJwc4
         e0MA==
X-Gm-Message-State: ANoB5pnJ1N1bR/M/tNm4xWc96vtx6/goKUM7jLQtVCwkaj+7Xt/l/36f
        K015L342axGQzDF6MrFSeQM=
X-Google-Smtp-Source: AA0mqf58EWVAtoBW35uzGxaUJG3whwmCiDB48+3oNGHEja7vndsxt57L8DX29W7DP7rtn+gsh9szcg==
X-Received: by 2002:a17:90b:fce:b0:219:3ad8:9190 with SMTP id gd14-20020a17090b0fce00b002193ad89190mr38480604pjb.23.1671329758325;
        Sat, 17 Dec 2022 18:15:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090a380800b00218f7c1a7d4sm6908232pjb.56.2022.12.17.18.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 18:15:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     "Harshil Jani via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH 0/2] Remove MSys Support
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
Date:   Sun, 18 Dec 2022 11:15:57 +0900
In-Reply-To: <pull.1433.git.1670274213.gitgitgadget@gmail.com> (Harshil Jani
        via GitGitGadget's message of "Mon, 05 Dec 2022 21:03:31 +0000")
Message-ID: <xmqqmt7lxxr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Harshil Jani via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The msysGit and the MSys v1.x has been dropped into this patch and the
> USE_NED_ALLOCATOR variable was duplicated here in the implementation so its
> deduplication was also made in this patch.
>
> Signed-off-by: Harshil-Jani harshiljani2002@gmail.com

Thanks, Harshil.

I do not do Windows, so I sent a few drive-by comments to suggest
improvements that may help to make the patch more understandable,
but more importantly, I did not see the patch asking input from
anybody who have worked on the port of Git to the Window system, so
I ran the following

$ git shortlog -sn --no-merges v2.39.0 -- compat/win\*\* compat/mingw.\* | head -5
   100	Johannes Schindelin
    56	Johannes Sixt
    41	Karsten Blees
    23	Erik Faye-Lund
    13	Jeff Hostetler

and then picked those names we still often see on the list to
attract their attention.

