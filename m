Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0EC47097
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED158613E3
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFCSFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFCSFX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 14:05:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF6C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 11:03:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c3so7132132oic.8
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=k0h414cr7jSj7m8CTGYWojSul75iHEzSdXYDjyrA1jw=;
        b=Ac5QNzR7b5FRzNEv2NCskw6xqdow76dNDJZGudhm+MnX8nwQU9qxoXy9k6b642iEms
         hXx9z3G25DqoTnQwBNSWLLA7MJf6AYKL+1JcR8sDmlBusRAFZU9nbEfYNoGtV7tplx6G
         f958QuLEGKG8V3X3wz6twrAdrIM+3Rn/YRhdgrTXQlGI5q0NGxdKfp8CIDX5rbJqkh1F
         yJ5s+bfkQmW7KQxgcpq2qcHJVujbCEHeRtFqV0Pjwc1ditGcY2h3EdvPT9/KC+uH2Sfg
         SbH/Ig7pDEaeeuhCUfIC14PQ1J7eDhkaIjX/eOrbhlBlx9KFQ8w2IboXO+eeS4I0dz3X
         QUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=k0h414cr7jSj7m8CTGYWojSul75iHEzSdXYDjyrA1jw=;
        b=aro1pWCVkiHYJS1ty5vMyiKaOit5dg43cirzTgoZ0CLT0fULvIz3VuK9HO2fGTwB3A
         tEar7xB4f2RxSywPDfHhE4XrUKT43KSDyQJq9lK63pVJ90XoLSmMoPcpXkydAGja0kti
         TzP9I9Aqzo7TDh4t2GywNk/F0HKeC73tQyz3TSa6/hLT+WRcdSsF7oeV1eayo1FnvZuE
         D23+8rGKmNy8Nzko5ggbGKmbET+Y2cU/XJsUWpvWJaBHC1L3N+t3KpHaQ4vyFYiJZe4c
         Y1ThkH32OwhvOL0sIqbkvgiV3OX/6hFOv7FtMXHiHFh8wh2YmD1b/VkWFiCe4W6W52fW
         MMpw==
X-Gm-Message-State: AOAM531FXE1aiJCPiOrPsNOxq5gFF4UYPiFsSwzFjsdvfZ4+fgielpa0
        hPciMuNdWl1wn/KlO3ex2x8=
X-Google-Smtp-Source: ABdhPJy5gQ/okDgQPaPfO27GSrwwgD2rD9TUJBOxUCd08pTJB1e6xaCAhF+5NAC1v3VHvmqEPkTwGA==
X-Received: by 2002:aca:f354:: with SMTP id r81mr8358396oih.4.1622743405708;
        Thu, 03 Jun 2021 11:03:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b3sm820649otk.54.2021.06.03.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 11:03:25 -0700 (PDT)
Date:   Thu, 03 Jun 2021 13:03:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Message-ID: <60b9196c238c_2588012081d@natae.notmuch>
In-Reply-To: <87h7if74vd.fsf@evledraar.gmail.com>
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
 <87k0nb77lq.fsf@evledraar.gmail.com>
 <87h7if74vd.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -299,9 +299,8 @@ pathname::
>  	is expanded to the value of `$HOME`, and `~user/` to the
>  	specified user's home directory.
>  =

> -
> -Variables
> -~~~~~~~~~
> +CONFIGURATION VARIABLES
> +-----------------------
>  =

>  Note that this list is non-comprehensive and not necessarily complete.=

>  For command-specific variables, you will find a more detailed descript=
ion
> @@ -312,10 +311,24 @@ inventing new variables for use in your own tool,=
 make sure their
>  names do not conflict with those that are used by Git itself and
>  other popular tools, and describe them in your documentation.
>  =

> +
> +advice.*
> +~~~~~~~~
> +
> +These variables control various optional help messages designed to aid=

> +new users. All 'advice.*' variables default to 'true', and you can
> +tell Git that you do not need help by setting these to 'false':
> +
>  include::config/advice.txt[]
>  =

> +core.*
> +~~~~~~
> +
>  include::config/core.txt[]
>  =

> +add.*
> +~~~~~
> +
>  include::config/add.txt[]

This looks much better to me. +1

>  include::config/alias.txt[]
> diff --git a/Documentation/config/advice.txt b/Documentation/config/adv=
ice.txt
> index 8b2849ff7b3..35d6b0e20ff 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -1,126 +1,119 @@
> -advice.*::
> -	These variables control various optional help messages designed to
> -	aid new users. All 'advice.*' variables default to 'true', and you
> -	can tell Git that you do not need help by setting these to 'false':
> -+
> ---

...

> ---
> +advice.*fetchShowForcedUpdates::
> +	Advice shown when linkgit:git-fetch[1] takes a long time
> +	to calculate forced updates after ref updates, or to warn
> +	that the check is disabled.
> +advice.pushUpdateRejected::
> +	Set this variable to 'false' if you want to disable
> +	'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
> +	'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
> +	simultaneously.
> +advice.pushNonFFCurrent::
> +	Advice shown when linkgit:git-push[1] fails due to a
> +	non-fast-forward update to the current branch.
> +advice.pushNonFFMatching::
> +	Advice shown when you ran linkgit:git-push[1] and pushed
> +	'matching refs' explicitly (i.e. you used ':', or
> +	specified a refspec that isn't your current branch) and
> +	it resulted in a non-fast-forward error.
> +advice.pushAlreadyExists::
> +	Shown when linkgit:git-push[1] rejects an update that
> +	does not qualify for fast-forwarding (e.g., a tag.)
> +pushFetchFirst::

I presume this also has the 'advice.' prefix added (and so do the rest),
it was just an example patch.

Cheers.

-- =

Felipe Contreras=
