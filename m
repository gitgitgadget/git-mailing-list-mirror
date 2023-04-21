Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D0BC77B61
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 16:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjDUQfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjDUQfE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 12:35:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE67015446
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 09:35:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a68f2345c5so20946095ad.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094902; x=1684686902;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sraz9fCukuOH8XMAJ3q1MNRlSVssglI6jeNieYP/brQ=;
        b=oFrip7hnIdCFlyfrAuAIWpyMeUI63aA+TmOHArfTy1S1Aa67YW47UFIVj1yzL+I+ez
         0V9Kuy3cwsqdATbTe9U0B47moHPweSQ9hY6Lk12UlD7UpBqzmGXCuBwr6xwG1DpWvmSI
         de1CQCHhBLoZGKlbqhYgo2zr6Yh9yDMjrBUgmL+jk0HLF6gCivQ3JExS5vfXPttuCIWe
         DLFndkH51jdSnIJTmhymgFF1oOqcXHNDSphUA3RtKglI10VlmTWbpkNu5nZwjEGpclDA
         q4sFGrfIq1HL/OAGNuLsiKo7RU1FsuRBrikd4xF8pBgtsbceFU1yDUFRjGZL2WEANxBV
         t+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094902; x=1684686902;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sraz9fCukuOH8XMAJ3q1MNRlSVssglI6jeNieYP/brQ=;
        b=lUKKpE4Uz1D9Z8MOvlQaMaZZT3oIPXqzqAcrDDD5nUkbEDAcTxQLm3JToOCTd5pfA1
         BY9aDREyH7cGjwBLE5LqkSKQyO+t5cQDdRBRSScXYTmg0JukhyJ6D55z3mDViJnqdhtc
         NytHQHJ6qjxE7DrtJFmcnel7jSnWXDwfW5A00qvdKzYP5cFgmxOUHfyPxr3H46VCQL9W
         4Nh6wGa//nK+m+t3ku6zE/r3Ek7PXlOIUWacwM6b9pbyY0VNF7LeLauYz1HN1K6y5oDl
         MyAxoQAzmNdalhml/8Lu/x6M6BkSE8JKGatQV+x6GY8xDh2C1jZFQfo3RupIw+e1w+Ul
         bNaQ==
X-Gm-Message-State: AAQBX9cuZaN4VfJokSyHGQsvGkXUfYZw846FMdxJAnv885XDrl5A6hhX
        qqnCmISmX/AugfDg8AMDmQlhnF64/Q0=
X-Google-Smtp-Source: AKy350ahcgYaKPPj+EnritVyC0sGkef2mTzuC7/GV9oFsaTXrzcUh+SECYHIoCjAnZOUi/sxo6JJbw==
X-Received: by 2002:a17:903:188:b0:19f:3797:d8de with SMTP id z8-20020a170903018800b0019f3797d8demr7068839plg.9.1682094901867;
        Fri, 21 Apr 2023 09:35:01 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902744a00b001a922d5b18fsm2964560plt.31.2023.04.21.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:35:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de
Subject: Re: [PATCH] docs: clarify how the text and text=auto attributes are
 different
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
Date:   Fri, 21 Apr 2023 09:35:01 -0700
In-Reply-To: <20230421055641.550199-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Thu, 20 Apr 2023 23:56:41 -0600")
Message-ID: <xmqqo7nhkxca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> These two sentences are confusing because the description of the text
> attribute sounds exactly the same as the description of the text=auto
> attribute:
>
> "Setting the text attribute on a path enables end-of-line normalization"
>
> "When text is set to "auto", the path is marked for automatic
> end-of-line conversion"
>
> Unless the reader is already familiar with the two variants, there's a
> high probability that they will think that "end-of-line normalization"
> is the same thing as "automatic end-of-line conversion".

True.  

The prerequisite to understand these two seemingly contradicting
sentences is to know that "attribute" can be "set" (in the sense of
Boolean "yes") and can be "set to value" (here in this case, to the
string "auto").  They are treated differently.

It is very good that you decided to clarify it.

> It's also confusing that the explanation of how end-of-line conversion
> works is in the paragraph for text=auto even though it applies equally
> to the text attribute which is described earlier.

Good observation.

Instead of half-duplicating the same explanation in two places, it
is very good to do so just once, in the introductory description of
the 'text' attribute before the individual description of what
happens when the attribute is in any of the four states.

> On top of that, "When the file has been committed with CRLF, no
> conversion is done" implies that normalization is only suppressed if the
> file has been committed. In fact, running `git add` on a CRLF file,
> adding the text attribute to the file, and running `git add` again does
> not do anything to the line endings either.

True again.  The conversion happens between the index and the
working tree, and "committing" does not have much say in the
process.  Interestingly, the description of what happens when the
attribute is "Unset" (in the sense of setting it to Boolean "no")
uses a better terminology---"checkin or checkout", which is about
getting things out of or into the index.

It is very good that you decided to clarify it.

> Rephrase the documentation of text and text=auto to be clear about how
> they are the same, how they are different, and in what cases
> normalization is performed.

Thanks.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/gitattributes.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 39bfbca1ff..6db4ecd794 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -131,9 +131,12 @@ linkgit:git-config[1]).
>  
>  Set::
>  
> -	Setting the `text` attribute on a path enables end-of-line
> -	normalization and marks the path as a text file.  End-of-line
> -	conversion takes place without guessing the content type.
> +	Setting the `text` attribute on a path marks the path as a text
> +	file, which enables end-of-line normalization: When a matching file
> +	is added to the index, even if it has CRLF line endings in the
> +	working directory, the file is stored in Git with LF line endings.
> +	However, if the file was already in Git with CRLF endings, no
> +	conversion is done.

I think most of the new text should go to the paragraph before this
hunk (i.e. "... its line endings are converted to ..."), where not
just CRLF->LF conversion is described, but how it does and does not
happen depending on the eol, core.eol, and core.autocrlf are set.

>  Unset::
>  
> @@ -142,10 +145,9 @@ Unset::
>  
>  Set to string value "auto"::
>  
> -	When `text` is set to "auto", the path is marked for automatic
> -	end-of-line conversion.  If Git decides that the content is
> -	text, its line endings are converted to LF on checkin.
> -	When the file has been committed with CRLF, no conversion is done.
> +	When text is set to "auto", Git decides by itself whether the file
> +	is text or binary.  If it is text, line endings are converted as
> +	described above.  If it is binary, they are not.

This side is good.  "As described above" can still be used as-is
even after the explanation of eol conversion is made before we start
enumerating Set/Unset/set to auto/unspecified.

Thanks.

