Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EB1C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjECR6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjECR6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:58:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72D77A88
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:58:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab267e3528so4733335ad.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683136705; x=1685728705;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLCNKYlVkZWjn5P/kRL8+BV303MeGEZjOE5L3LDXJs0=;
        b=NbtA/j7b1NzGIrMATH23yWTvMzJ3JacVOOod/vtl29HDetNSoSZ832EFhzVENUE9qU
         M+ONizq60qE36w0mURBzFAxLfCjLU5zyW+o11znKXDVJ1moV3SiR0YdES29msaj/WBr6
         MCGrHdwn1UsLjEvTnVOqdJ0CvM4clC9gxeiHC8PqR1fH25lsfXWcqhjhX3DyEKWWh4lT
         p//HQgljMnjlgdCWtsBP0hu96qyVVnJR9+/Hhz9Q8KSHMmf0BHtHjqG+koQrnOuwRAgX
         dGJ2JKJ2UFzTldbNx48tAJ0mXd65V9z4puqG5wwdimuwIjnEZk6Jmka1WxKoDlZr9BEh
         347g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683136705; x=1685728705;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oLCNKYlVkZWjn5P/kRL8+BV303MeGEZjOE5L3LDXJs0=;
        b=gnySDQkVX4atZg0dd/otY0naruJuz9l5tPnSKFjYrjwxwDbdg3UsmUFo6xH/KyU7EN
         v48BudaGqZ5QruFomUuGbmoAZ1jxBwOSwAYjt4eSH6gJE+Taq/wqsIVljz31JJMIpOXo
         hO5Cg2H6J5h+h71Sva+Q00aGqe5hiLcQwHKi/9Ve18K2O8qUpJ4lhMOhm9hApmRmbjkn
         2kCZ1CsuetSB6/QLCId/ncZLu+AaSO/a7N6HsxDPpzVG2QIyFvBTQdH54WhCKE9Hdf9W
         +GYfr4QlAjHeIF2Wf34Ub7jc2TO/Xm+cvWu/bXK0pkjzw4MfQZMxmGFP8kAQlfhTFNxK
         fTsQ==
X-Gm-Message-State: AC+VfDy4DMDTdWHZCT+cL88Vv1sygE7OV04xgFUbBxyq5f4HcxrISY6d
        84qyGQXd8ovzzT86K/92N0g=
X-Google-Smtp-Source: ACHHUZ5Ozg7wxl3RNJoYTf1K3/n/QaQg3HI4DTJmLDujOsT3ODEgZaNFi6niqPof0TADpbs2T3T5tg==
X-Received: by 2002:a17:902:b195:b0:1aa:fb67:b943 with SMTP id s21-20020a170902b19500b001aafb67b943mr798954plr.62.1683136704937;
        Wed, 03 May 2023 10:58:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b001ab19724f64sm1989530plh.38.2023.05.03.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:58:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] doc: manpage: remove maximum title length
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
        <20230503171658.8996-1-felipe.contreras@gmail.com>
Date:   Wed, 03 May 2023 10:58:24 -0700
In-Reply-To: <20230503171658.8996-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 3 May 2023 11:16:58 -0600")
Message-ID: <xmqqr0rxqou7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> DocBook Stylesheets limit the size of the manpage titles for some
> reason.
> ...
> Moreover, asciidoctor manpage backend doesn't limit the title length, so
> we probably want to do the same for docbook backends for consistency.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Looking good.  It is especially good that we say why we chose to
make it unlimited instead of raising it to some arbitrary value.

The claim that the longest one would fit on a line is not still
substantiated (we could say "git-X manual page" needs the most
columns and people can check for themselves), but I'll let it pass.

Will queue.  Thanks.

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
