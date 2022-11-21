Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC1C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiKULbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiKULa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 06:30:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961DFB7031
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:25:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so10343371pli.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2HIt4bRzQMINmrzaEdev1fgc6ulwlArzJa6uu0Z8JE=;
        b=nFSSz0EWiBFRk0K1XxgRMtyewAmB01j4B6e0RIIOvVNTZS8I/VkQjYV1O0N2uk7ySB
         zN7HrI/UfrIpwygDxRrZW1H5D7zApmt4ZZZgGfw8GY/7xTEne7lQ+jruyh7zEc8unRwn
         XrprUOnEk3gwyEjjK3EDJ0Ssv5HtxUNyX6M4B8SwvF83xk9w2Gr721yjv0FxpG4X4Bi0
         pu2r+bLLOIYZ4dOsIIrqcHwvmmIUDIu488Un4YrQk7JlQeGWqmjO7Ij4qq29Hkk3LTNt
         qBS/IALEFuKwVeaXOtzi1W5UDOUruB/bG9ZOSN0Bfo4/w8YqsRZhBO2TlL1MdVYY4K9v
         OSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2HIt4bRzQMINmrzaEdev1fgc6ulwlArzJa6uu0Z8JE=;
        b=pO27C6CDdLEM3nFpkRlOP5WunpVW9cfOhYNtz5Yq9grM4dGX5uVMMDdPt09dG8SJpz
         sOcjfWyA68fUztjMuIOpg2br7HTPo29WVx9lonzesL/b5ZVjpqUt/lwju+DA9UXenN6T
         Lkb5E7TICJ+6bHWeTOZFnv2s1D4+AFdQURnARsvDfubJDuGTESqmhYkp8hu90DdWz/Sm
         DaSj7xUA6JuyjBZgN0QNqqDarvFc+/QeoiGcNpbKmHzJfeAKYqN3kho7AyGPse9pMjnb
         ipmd3Xr0BMX5R2+0bT5AD+xbVcpkfKQEGRWZ+PhHAAYlc5y28E0AF3b5JLsNfxauOp4N
         6Niw==
X-Gm-Message-State: ANoB5pktUlRHuiOo0xJYDfZteUsTMETD1nk85cgXt7c/+HA0Q/LU/fPH
        7xV4pplH4sEYodhQebS0grFdrHuFTfWdVBYehrw=
X-Google-Smtp-Source: AA0mqf6C+3molqiKC+wO2OhlmZ0d/N4HwD9prw6veTK11ua6ydw3yRvlkG6nXoRy6WAIoW0zOasJcl8y1z72bEf/u00=
X-Received: by 2002:a17:902:848d:b0:186:8516:cd5f with SMTP id
 c13-20020a170902848d00b001868516cd5fmr11534249plo.11.1669029935046; Mon, 21
 Nov 2022 03:25:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
 <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com> <e56858a3eb212dcd0b8f71bdbf8db96f51c5d648.1668907644.git.gitgitgadget@gmail.com>
 <xmqqedtwyi94.fsf@gitster.g>
In-Reply-To: <xmqqedtwyi94.fsf@gitster.g>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Mon, 21 Nov 2022 20:25:23 +0900
Message-ID: <CAF5D8-uYnNkH-BkW0QNhBybQNN3ym5=S2FwZVjgouaqcXL2MMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] git-jump: add an optional argument 'stdout'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +You can use the optional argument 'stdout' to print the listing to
> > +standard output. You can use it with M-x grep on Emacs.
>
> It is unclear what happens when you do not give 'stdout' from the
> above description.  You say 'stdout' is a way to tell the command
> "to print the listing to standard output", but what is expected to
> follow that sentence is left unsaid (i.e. "you can give 'stdout' to
> print to stdout, INSTEAD OF DOING X").

I agree. I'll add "instead of feeding it to the editor".

> > +# In Emacs, M-x grep and invoke "git jump stdout <mode>"
> > +Run grep (like this): git jump stdout diff
>
> the command line structure of "git jump" being
>
>     git jump <mode> [<args>]
>
> where <mode> is one of 'diff', 'merge', 'grep', it somehow feels
> very strange to insert an optional new word, that is not a dashed
> option, before the <mode>.  "git jump --stdout diff" might be less
> surprising, but I dunno.
>
> But I think this is a good idea.  In fact, it almost feels that the
> interface to produce the list of "$file:$line: <blah>" that this
> "stdout" mode gives should have been in the command as the lowest
> level basic primitive, upon which the feature to drive a specific
> editor using such an output file should have been built, and the
> current code is backwards in that sense.  Exposing that lower level
> primitive directly is a welcome addition.

Thank you for your thoughtful consideration.
The value of git-jump is to launch the editor quickly from the command line.
I think it's rare to manually use the additional option (e.g. M-x grep
in Emacs).
Therefore, I think there is not much needs to expose it directly.
I'll change it to less surprising form "--stdout".
-- 
Yoichi NAKAYAMA
