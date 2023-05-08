Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A47C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjEHTiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHTiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:38:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E61059DA
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:38:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c6504974dso4504127a12.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683574694; x=1686166694;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLvoJ8TlC8niJG4NRf3KANh+eJI/DCNflObMAataRYg=;
        b=qQEJbBqE3jGw/PCigY6l+WI8bAtRlIkKG+bvewOTNUe9pyG6YWXcawTFKRlJjNVpT7
         Ffd9g4dDaz7NngbARLTEJuNDjCgawXQZqEnrMlWEoWPpjtMlSkeKKp4q+bMexSeJyU8/
         e7pUS0N+OUS9GNbsVHHrvuIm/cuL10ECKd4WjeT/OcWhZWcN/K78TcxatSbiX5upo0GG
         JTyMgiCLs0uA1AqQwz432OlTGjTSaL3Ps9ZQJb9irMwqwkVphHfz/6talBFInp+R9n4C
         V2sPqOroOAfz6jmfHlxcLkpbyXVa1Xrk6W4qeSkpCIVsZUjjQ4FH9Os6KPakaHje1ilF
         sb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574694; x=1686166694;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iLvoJ8TlC8niJG4NRf3KANh+eJI/DCNflObMAataRYg=;
        b=MEgneo0Cytwe9jUm5z8XibjB+JopT2tUXTmLLnzcHCyFbnDX7M7yEIovWzPXEhZOcV
         05rMoBHFyD4s35H9AIL/DZnM3/Pf1sPMiXsOTtT0Xg3em9R/ON/om9tCZ+OJDJXF1CuZ
         Nde14bhrkv6yRABmS2VNz2jP8txkxvYOQE0Nelb5npTSGgO+2EF+9D5Gp/u747DVGYbE
         /KgfSL3iEvuSPm0+zrphlPdURt06CYOeXzFlvKxVdoEcMEd+eFdla97BcqzepDkz5ENo
         Im2LwDKovhFWiXRCcyVGCQxznz9DtC1hEw6rpm8T1zbGLHQJj73lFET7XHyCEbcft3aZ
         5YsA==
X-Gm-Message-State: AC+VfDyMztnxmrX7gi2W8pScdCvtN+vuxaJXFesjdexe955IcZXi0X44
        fc5O4sgPXIsIGvfk31Y68JYI1iy6syw=
X-Google-Smtp-Source: ACHHUZ7eGjwNphrsM4Cu6mcunWLfyx6gWcJVLFITpdWYu0mUBfprnNQk7MkwKBO6bHZ1SOVnx1YM8g==
X-Received: by 2002:a17:902:b20f:b0:1a6:8405:f709 with SMTP id t15-20020a170902b20f00b001a68405f709mr12465322plr.20.1683574693812;
        Mon, 08 May 2023 12:38:13 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709029a9300b001ac68a87255sm3723553plp.93.2023.05.08.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:38:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 07/11] doc: trailer: use angle brackets for <token> and
 <value>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <ab11527ca58a7c3f0da657393088919acba78b00.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:38:13 -0700
In-Reply-To: <ab11527ca58a7c3f0da657393088919acba78b00.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:46
        +0000")
Message-ID: <xmqq5y92obq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> We already use angle brackets elsewhere, so this makes things more
> consistent.

Excellent.

>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index c4675d9d3bb..ac448fd732e 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -62,9 +62,9 @@ space or the end of the line). Such three minus signs start the patch
>  part of the message. See also `--no-divider` below.
>  
>  When reading trailers, there can be no whitespace before or inside the
> -token, but any number of regular space and tab characters are allowed
> -between the token and the separator. There can be whitespaces before,
> -inside or after the value. The value may be split over multiple lines
> +<token>, but any number of regular space and tab characters are allowed
> +between the <token> and the separator. There can be whitespaces before,
> +inside or after the <value>. The <value> may be split over multiple lines
>  with each subsequent line starting with at least one whitespace, like
>  the "folding" in RFC 822.
