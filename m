Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE1C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DC22083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV1QnWo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA3Weh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:34:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgA3Weh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:34:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so2245524pfn.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWnBdEAMry23U5dzoJpUlvuOkZopne+5h5Xyps72DX4=;
        b=qV1QnWo/kfHHssJcVffOZn8MpoaF2D9Q/gs0POKzjjWGkTfRY2Pjyk2wG85ccz52cH
         pBi0LoQvWMXRuOyxfgfYYCyCB1cHbveoND4AK1FBnDmGqGNxQCZJINRZtTNleJVIqa/t
         F39HsZtFBwj0WA8LC94vkPFXJ/HWb76zIw+X+AyscSudle1OkuFxzBWJpbs7W+Hgy1Yx
         L3RDsn3i+bk9Y9pjxcnaMlK4gx4Jwua5bn/BGTeu4xJADnI4ajKJ/ou5S4DSt5ZUIdpZ
         +mk8dZBnXe8BamdokBvZ6VvQX5oziTPfgK1aNwX3Q/zQO69tyE/gmEegO7u3iA68td0E
         pPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWnBdEAMry23U5dzoJpUlvuOkZopne+5h5Xyps72DX4=;
        b=r43KoSeGODVLhu7jaX9Bh/wocvbKhFJOl10le7tN1Bxl/mjidVdGHZUSUuDtwhd866
         JkRf/4qFmGuFGv4yiFEhMMqZZHkhIJfZ8hR64A8L3t+F2v9HY+9P5oWGW52t9ZCPFvm1
         rH/zF9ZMEv+leSX2ZurMSpcR0fr7mquhksQNHwVwdn1cVU5aggrpu9afCP7f4Ea57MbN
         myRGt4/SfG/xdlaNhr3m+ZO7BeGGju5mkE3C2S9hroEQS8SX5hob0by1R3a9LLgXFFws
         EnnBVkWo53uXWAw8krQk+tGzCkneS1NYk5Jfx2+d6Gz94wwKS4/87xz/7giU1eEROIuC
         CxUQ==
X-Gm-Message-State: APjAAAUYa7Op8HUXxbjFz/w/rX53uxASUxFcyP5GNX0q18oWXrDa2pAa
        px2AEEcDogyPElkFXHtDPvTAr3qWGNyThO/TQYw=
X-Google-Smtp-Source: APXvYqyBVqr0h9PjoBK5K5ZvFJ8W01nBWEMmkSjgeHme7e2tN9++9TXGVwk505T9fNVHNcpDE5IHT2jfS4H8fCo/dlE=
X-Received: by 2002:a63:4282:: with SMTP id p124mr6689645pga.155.1580423675685;
 Thu, 30 Jan 2020 14:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-10-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-10-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:34:24 +0100
Message-ID: <CAN0heSq_i4EitqYH-qrZyXBU+=PUNcSXOOJDHLSnJ1ufV0WtaQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] bugreport: generate config safelist based on docs
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:35, <emilyshaffer@google.com> wrote:
> Add a new step to the build to generate a safelist of git-config
> variables which are appropriate to include in the output of
> git-bugreport. New variables can be added to the safelist by annotating
> their documentation in Documentation/config with the
> "bugreport" macro, which is recognized by AsciiDoc and
> AsciiDoctor.
>
> Some configs are private in nature, and can contain remote URLs,
> passwords, or other sensitive information. In the event that a user
> doesn't notice their information while reviewing a bugreport, that user
> may leak their credentials to other individuals, mailing lists, or bug
> tracking tools inadvertently. Heuristic blocklisting of configuration
> keys is imperfect and prone to false negatives; given the nature of the
> information which can be leaked, a safelist is more reliable.

I sort of wonder whether safelist/blocklist is to prefer over
whitelist/blacklist, or if it's the other way round. The former are new
to me, whereas the latter are the terms I would have used. But that's
just me, of course. I was a little surprised, that's all.

> Implement a new no-op "bugreport" macro for use as
> "bugreport:include[x]" to annotate the config keys that should be
> included in the automatically generated safelist. Use "exclude" for the
> others.
>
> With Asciidoctor, it's ok to say "bugreport:include[]", but AsciiDoc
> seems to want something between the brackets. A bit unfortunate, but
> not a huge problem -- we'll just provide an "x".

I recognize this reasoning :-) and I'm not terribly opposed to it, but
after some nights' sleeping on this, I have to wonder if
"annotate:bugreport[include]" wouldn't be better than "bugreport[x]"
with that ugly "x". Maybe this isn't the biggest problem, but if we
expect this macro to eventually sit right next to ~90% of all our config
variables...

> "doc-diff" reports that this macro doesn't render at all. That is,
> these are both empty after this commit:
>
>   cd Documentation
>   ./doc-diff --asciidoctor :/"bugreport: add tool" HEAD
>   ./doc-diff --asciidoc    :/"bugreport: add tool" HEAD

That was true in [1], but alas, no more. In that patch, it's sort of
obvious from the diff how it adds a "class" which "end"s.

[1] https://lore.kernel.org/git/20190817203846.31609-1-martin.agren@gmail.com/

> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -37,6 +37,10 @@ module Git
>            output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
>          end
>          output
> +
> +    class BugReportProcessor < Asciidoctor::Extensions::InlineMacroProcessor
> +      def process(parent, action, attrs)
> +        ""
>        end
>      end
>    end

But this one doesn't add an "end", and Asciidoctor trips up badly.

> +  # The bugreport macro does nothing as far as rendering is
> +  # concerned -- we just grep for it in the sources.
> +  inline_macro Git::Documentation::BugReportProcessor, :bugreport

(I never much liked this copy-paste comment then, and I still don't, to
be honest.)



Martin
