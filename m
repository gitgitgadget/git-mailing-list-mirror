Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCFC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjECRns (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjECRnp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:43:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E64EC9
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:43:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso3139079a91.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683135820; x=1685727820;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y/ZNErgP/mJMCkdNRR4BgiYyKdfoY/1f0G0eJMKqBk=;
        b=OGGOYntKhpdUbeuTGQiLylhnyTETipr/6vTNHM/S3jFfgfyPM9Y9iiDt2gshq4wxmN
         4vh+Ep8QZWMMMdVJyjrBP0a9j8rJuNmt9d6V+jQVV3UBs0IzvRk9CJjmIykr/ia1lDIT
         HaaEB+Y9YOPc4Ion6aU5cY0Le3GkaDaCKr+5pap6HjrYOUtkcdEBJvlcK5l2rHunh8dr
         FqgzwOoyls4xuArTMaLUetBUIWSP1vXvGzN7z7ZR54pEergeeWC+/hUL7rttFlhnYAFR
         97BcX3OK9uASdqALEMwyd4ozx++xBSNDA+3+F5+T04uWIj+fdUncRhUjEocFSr04uaGT
         n0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135820; x=1685727820;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y/ZNErgP/mJMCkdNRR4BgiYyKdfoY/1f0G0eJMKqBk=;
        b=a3xexkTcozQW1fptu8MOfirzu8pSmjzpCiIu6kEyjP9MrvWstxb1mjwfIwUf36158X
         qKxGLQaDe7DUKb5F8tGNSE82QTRpt0G47RWOpVKKdHNkwav/arpSPNQogZ+b62bPE6KU
         N1h5MCC8V/bXUHZ1tZ70VshWyyTuAcTOMG4mLirFiGY6UGVLFz11qauw4d90tpeHiCvk
         ebsQsIKycM5t75VJGwI8oMWTiVJ3qqIYnw2XQUVAP9NDoqYoMNwNcyNHGGoq+jAQlse6
         pblYHVB0O5zNtVCTSBuazbcqw3NYc4ooEoWkky2r5ji5DzVlWvLp7A5OdpinYj5nBquJ
         JUhg==
X-Gm-Message-State: AC+VfDzUsEiczzSBMVZ1BghpLHoK/7rYo5esgOp5IsBaFml/7VtPbnSP
        62IGmq+9GCcDqCT8+A/R31ganFjhOGU=
X-Google-Smtp-Source: ACHHUZ4o/l7NuwnKfoB3D4Uy7lUr4JscktOcpJYHmVmRlnwq2taNxcP3L/ngUsaP8ZMk8agruPJAWA==
X-Received: by 2002:a17:90a:2e12:b0:247:1233:9b28 with SMTP id q18-20020a17090a2e1200b0024712339b28mr20313791pjd.17.1683135820350;
        Wed, 03 May 2023 10:43:40 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090a760e00b0024e134a2408sm4833378pjk.14.2023.05.03.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:43:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: manpage: remove maximum title length
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
Date:   Wed, 03 May 2023 10:43:39 -0700
Message-ID: <xmqq7ctps438.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> DocBook Stylesheets limit the size of the manpage titles for some
> reason.
>
> Even some of the longest git commands have no trouble fitting in 80
> character terminals, so it's not clear why we would want to limit titles
> to 20 characters, especially when modern terminals are much bigger.

I agree with the general thrust, but I do not think we are the ones
who limit it to 20.  It is a value that is "reasonable but somewhat
arbitrary", decided by somebody, and may even vary across installed
versions of DocBook XSL Stylesheets and their customizations, isn't
it (in other words, for some readers of "git log", it may not even
be 20, if their distro tweaked the value to suit their needs)?

Perhaps rephrase it ...

    DocBook Stylesheets limit the size of the manpage titles to
    avoid it (often shown twice, from both ends of the page)
    overlapping with other elements on the same line, such as the
    section name (for us, "Git Manual").  They say it is set to a
    "reasonable but somewhat arbitrary" value by default, and
    encourage "experiment with changing the value in order to
    achieve the correct aesthetic results, where they document the
    man.th.title.max.length parameter [*].

    The longest title we need to show for the Git manual pages
    currently is "git-credential-cache--daemon(1)" that is 30
    characters long, but I've seen on my box with docbook-xsl
    1.79.2+dfsg-2 installed that the "reasonable" default was set to
    20, which would cause the title shown like so:

       GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)

    We could raise the limit to, say, 32 as a conservative choice
    and can get this line show the full title:

       GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)

    but because even the longest one we currently have would fit on
    an 80-column terminal, let's make it unlimited for now.

    [Reference]
    * https://cdn.docbook.org/release/xsl/snapshot/doc/manpages/man.th.title.max.length.html

... or something along that line.

I did NOT verify the claim that even the longest will fit in
80-column limit, that credential-cache--daemon is the longest one,
or that the box the problem was observed was using which version of
the stylesheet.  The above example illustrates the level of detail
needed for a proper log message, but it may contain factual errors
that need to be updated when the patch gets rerolled.

FWIW, my primary motivation behind suggesting update of the above
log message was to make sure that we document that we made a
conscious decision to make it unlimited, instead of choosing another
arbitrary limit (which we can do when we actually need to).

Thanks.

> ---
>  Documentation/manpage-normal.xsl | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
> index a9c7ec69f4..e7aa5df2fc 100644
> --- a/Documentation/manpage-normal.xsl
> +++ b/Documentation/manpage-normal.xsl
> @@ -8,6 +8,9 @@
>  <xsl:param name="man.output.quietly" select="1"/>
>  <xsl:param name="refentry.meta.get.quietly" select="1"/>
>  
> +<!-- unset maximum length of title -->
> +<xsl:param name="man.th.title.max.length"/>
> +
>  <!-- convert asciidoc callouts to man page format -->
>  <xsl:template match="co">
>  	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
