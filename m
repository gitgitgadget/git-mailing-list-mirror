Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5662AC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F2B61051
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhHJFtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhHJFtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 01:49:40 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0365C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 22:49:18 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id y14so3102028uai.7
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYMuSjT09BBgUsE4HMxzg9NWKjybF+sLzDKse07svWU=;
        b=KvHMXVDRmTy095rxXpB+X4GR5WYuwixXwQ6jJB7OeiG6Btv6XAkPk50SPRtmDkVoUS
         FdoxtxQF4kp8Njo4J2Baa5HTiVzze9s06WBs2twVqayi8gLCV0xpcwhn7OlNdwTSIxSy
         jy9/d+9v2sgtTK068PGFAcWmOb+xqff6latpMY7I7EQEpGiCf3b6F2X9ysSpJcqHw97M
         7A227D5rb7uYBZWVrZGPH0y9dkkKLHXItBpSFVJpygF7oZo3sp1SYjBT8RET4459iN61
         2HCtIc4qQIifq74lGzsJdvE7oLw3P0Z8wYpjs8aQwcsSj82ynztUgXzIKzF6Rm85zvKX
         kOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYMuSjT09BBgUsE4HMxzg9NWKjybF+sLzDKse07svWU=;
        b=pH6xZSlIGiMnwPNtp/aVl+AmmjyK5Oi/E4zR8XghykGelkxRRS3AYz1LXcN8qgplPv
         CgtPMYBWFYFJeBgZjCUC46y7YDPm97jYthU3PuIWeTFpb+8ImQvTP/M13VPnDZHgxo22
         Wy0O8NFrihG28Ka7KYd7NFhuZPiTJxdQk0NbVjAI445g5bi1zkkp156yV08nanx7Xwph
         J9VfMGdzPBnzDBp55FDDj8BWDTkf0TRCv9Fntd0jttYfo9qTJQZ9xkqhZDUiifI25Dbs
         8DPiMtSxOSzp7OHd+1JqYWfaDlkDfoH56cLpJSA+f2OAIseOTBboYvpQrrJSNppeyiUF
         YkDg==
X-Gm-Message-State: AOAM533+Iw0w80op8ZMzzEr89u2MtJmFw5RffNQwTBBHXZ8kKGYgZwdL
        JgLcUkke2+G3HIOXrc1MlhSNpFavwvUgo93sdkk=
X-Google-Smtp-Source: ABdhPJwg+23LsfAgbONDrXh68m/xi0N1irgmFF/g8TMUuhnnBxFk/BfzZCF1gYeZiMmDEiDnX9xKT+DzUKIcMh0WUYc=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr19657271uaq.15.1628574557763;
 Mon, 09 Aug 2021 22:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210809063004.73736-1-carenas@gmail.com> <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
 <xmqqpmumftry.fsf@gitster.g>
In-Reply-To: <xmqqpmumftry.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 Aug 2021 22:49:05 -0700
Message-ID: <CAPUEspioazo0js5pZj7TzR2=j-+Aeh+XHr8Nbsszs6cq+WJqmw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 9:49 AM Junio C Hamano <gitster@pobox.com> wrote:
> Jeff, I understand that this is planned to be rerolled post release,
> so I'll not touch these fixups and let you worry about them ;-)

Jeff,

As I mentioned in the cover letter[1] there is an extra patch[2] not
in the series and that also applies to maint, but is not critical and
might be better if included with your reroll IMHO, thanks.

Carlo

[1] https://lore.kernel.org/git/20210809063004.73736-1-carenas@gmail.com/
[2] https://lore.kernel.org/git/20210809072551.94391-1-carenas@gmail.com/
