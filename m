Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83FBC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjEHTU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHTU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:20:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D749F9
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:20:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab032d9266so46525455ad.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683573625; x=1686165625;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUlDZKuqKf4DcRNkyfopGFqAQsmM9WCpIzXPDMzOprE=;
        b=nopyGQ6SiypsoxDUU00Kag1KZNE/fWSFHV8nUtr56DDB5TE6HxkvOkGHDm+qlQlK97
         RwhjGIRF4JWOVgNTDUPAYlN3udGyYCzqIvGnLByGt7YgArWpv1dY8JDrqUoiNk1cDj6+
         mYXqCGTR5bQ8vAjFQmnHKb5ataRDoTrwtz0zu+Ty58F+JxPaI2tPw+mD7y/kzslsdYsG
         hAZ8BHZppZwThB8DWUMb1so9HjVUMsFHk9adVF+lZUFM7lKk9L/xbWQIieJ5ktG7PHZp
         rOFKM26xO+JZVAmHUtrCQzySLQUWhX0tgfuW3qNtiSD3wpgmjZFzvsqThczXv2p1gByB
         PvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683573625; x=1686165625;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUlDZKuqKf4DcRNkyfopGFqAQsmM9WCpIzXPDMzOprE=;
        b=RIjaQ7Rx6anGb78zQR6ibZ/JEjCliYsfmSjQ9Ag0bRGGIELHZPaa6ccaPHggALAd58
         Nbo9rJR20LU3+ti+4HhB0CoKekL6gXAc8Y7erJ2SK3fU6q5ycYsg1UI7v/agKCc34hxW
         UFCfZU4yLIiIiVTZ/0fqJ1Qc5q/Y0MHK1uz125vzjhlkIXBPKVZRsGbLyZLGEEvNbrX2
         w9JwwoKBOHQQv3PVjXWWwfo2bYwQ5w3722Y4gO3hMLy7SZM8eHoV6B4i7jedDw6W6dRs
         eKwu9DsR3Hy/eBk9FLgoPuBkmoz2rN5R0cTorZmQPIOuj9IWZW7kFwFlODXw0y8OMBD4
         PuHg==
X-Gm-Message-State: AC+VfDz+izspnPQGVHYwaSNjemRIWtXFgIwnz0apfcCV/T6wbSzwmZcH
        Lvo2aCuEZLVFdH4S8pUAtw8=
X-Google-Smtp-Source: ACHHUZ4GDr1nBFWSlmb7jrxKJ8PEpz77QqXsgnmKZzY4mRpRdEOK53gOKRD/8R1eNl96+/8y9ijfew==
X-Received: by 2002:a17:902:ec8a:b0:1aa:f3c4:7582 with SMTP id x10-20020a170902ec8a00b001aaf3c47582mr15577502plg.31.1683573624804;
        Mon, 08 May 2023 12:20:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709028a9000b001ac7c6fd12asm2360758plo.104.2023.05.08.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:20:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 02/11] doc: trailer: swap verb order
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <b771742443723e74459a998fd3b1d0207165b167.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:20:24 -0700
In-Reply-To: <b771742443723e74459a998fd3b1d0207165b167.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:41
        +0000")
Message-ID: <xmqqlehyocjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This matches the order already used in the NAME section.

The change makes sense, and the explanation above is also clear.

>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index e695977fbfa..593bc1a1f4e 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
> +Add or parse 'trailer' lines, that look similar to RFC 822 e-mail
>  headers, at the end of the otherwise free-form part of a commit
>  message.
