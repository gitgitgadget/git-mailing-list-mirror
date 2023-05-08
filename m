Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2BC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjEHTu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjEHTtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:49:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9344A3
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:48:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517c01edaaaso3208584a12.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683575236; x=1686167236;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C3VZL20qXQlf56izCE+Aa0GUIxWVglRONT6IOLtNBA=;
        b=ewZ+opcroimoAEPDPX/QJyMeUFeU6JpUmfd3urzoHllFC0av8DAB7rMSGLkbBW5sjz
         tPecM9lAaAuVbY1QmoS6kE1HGUbZ/jf3qZ6jOcbTNB05+aozdLalo8QNOz9AqoH5WyeO
         YvYgMWtmDsPJzpNuOMjcpYkP5swmaC6BOKie+6iBCTmwn87F4/fZjK28GeVuSwxlwpCz
         scdrJ5w7rUi7phTGCtdFWL367cYWWcpeXOyF3iDyG524AHFreSST+TK9z3TLfWojHjZZ
         xLSUzXNvntgeTzXIByp2WAn9xasx4ml8KUDJ2KcjuGEFW6gz3cLq87gGAmEkyOYLgi7f
         Mohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575236; x=1686167236;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8C3VZL20qXQlf56izCE+Aa0GUIxWVglRONT6IOLtNBA=;
        b=fGnetFG0WEcowT1AWjxsFN53W7PaHAkP5wWQCrs/DSPiDUwTxFasrM1OEqYObApdhD
         6QIs1k5dPTsM49ayW2Gu2wZfoXMp6ggRyKMz9LOu3mQVWnHyiHclt/AQEO50fiO5lkcr
         nW2yIbnKGOIKK+bttgochvGZ/Oab/XyjogrgZA2HVDv8NWCtZMrGPerAo27/AFBHJJ0S
         jSBT8BN7WiJSwyu/paa5+0Ju0sv701pSi7mZ1mprVA5gmeKNsL0dRJ81M4YRsEEz8tyt
         lVlwKIjD+l0NYvjmdvp72hkGoqDBuqDXJS3oLeq8iYzFRqJZd3d3TXLHXKGW01sLVqV+
         0zaA==
X-Gm-Message-State: AC+VfDximfn+hu331Qb6Mgn7/VgoBxj4aoWmM1dr84JxezzaxJd3qoRb
        VuNEi4q5wyJ6sPW6CGOk6y8=
X-Google-Smtp-Source: ACHHUZ73NjJAL1KBF/fLa6vpzhDib4tW6QZAOD3jfmiiiQWt5U6HyIGS2ymsJQmfYJtwR3OF3BpwpA==
X-Received: by 2002:a17:90a:5293:b0:24d:fcae:d455 with SMTP id w19-20020a17090a529300b0024dfcaed455mr11330303pjh.41.1683575236547;
        Mon, 08 May 2023 12:47:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ih15-20020a17090b430f00b0024e3bce323asm10938665pjb.26.2023.05.08.12.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:47:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 08/11] doc: trailer.<token>.command: refer to existing
 example
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <5980432179352054955e602cf97b57e97694a28c.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:47:15 -0700
In-Reply-To: <5980432179352054955e602cf97b57e97694a28c.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:47
        +0000")
Message-ID: <xmqqwn1imwqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

This patch has more annoying "just rewrapping the text in a strange
way without changing anything" than the real change which is to
enclose <value> inside the angle brackets (which is good) and adding
a new sentence.

We are discouraging the use of .command and recommending folks to
use .cmd instead, by the way.  At some point we may drop the
example, and adding a reference to the example would mean somebody
needs to remember removing this when it happens.

> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index ac448fd732e..5ca758e363f 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -234,10 +234,11 @@ trailer.<token>.ifmissing::
>  	that option for trailers with the specified <token>.
>  
>  trailer.<token>.command::
> -	This option behaves in the same way as 'trailer.<token>.cmd', except
> -	that it doesn't pass anything as argument to the specified command.
> -	Instead the first occurrence of substring $ARG is replaced by the
> -	value that would be passed as argument.
> +	This option behaves in the
> +	same way as 'trailer.<token>.cmd', except that it doesn't pass anything as
> +	argument to the specified command. Instead the first occurrence of substring
> +	$ARG is replaced by the <value> from the trailer. See the
> +	'trailer.see.command' trailer example in the "EXAMPLES" section below.
>  +
>  The 'trailer.<token>.command' option has been deprecated in favor of
>  'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
