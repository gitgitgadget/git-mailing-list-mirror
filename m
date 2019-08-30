Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248831F461
	for <e@80x24.org>; Fri, 30 Aug 2019 15:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfH3PHn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 11:07:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40965 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3PHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 11:07:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so4820865pfz.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoSPIpdU62ePhssETBrXe+7uBzG+k9exSe/qD7eHmcY=;
        b=dYso07THYmaodVujsjuD3Kn4AACQkkydjG1ylVe1taztff/amxUldQtEh6kFFnu/Ic
         hFAWqCJgI0pcm5KzxK6s6PVUXRq9lNrTPfckkNFOIa0qPoeHnO60Ik+U6UPSLyWDBq4V
         BRayWnop1cA6SEi2QnxjOZFjd56cpX79ko3azDwqqpOF7R/gniEWKyRSzGqjFIptYM1R
         XQlf3FlJM35CGbwZUvBnQKf0sQ7vt/anrVkSxIW/zVOcS7PzwsebArFyD59qv6f0L4TJ
         7iT5JJ1TbEZLWG2bSZHt79u+V7mZbK+sdktrdN5r00+1Z3rY7dzLzC0zPgzAraQSsnvg
         axtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoSPIpdU62ePhssETBrXe+7uBzG+k9exSe/qD7eHmcY=;
        b=QFjYE3ZIsp5qUXraZypwiOehhkRjHA6QeT+0Q3bukjwyILOq72PfkCG6FYTnK5LawR
         ZbqwtxmSBCfoZofXg8xBVDGizUwvOATZ9ydqq/6FI4CBU64yMzCqtUuUX8ddyEJED2Qv
         fVqrZmHqCcfaJUeC7+9HlN3M+nKo7Hx49otm++8XKj242aCXI5dF6b7CMvZxCLDIpKyH
         qOcfndi4xX8MCLwYCeqBqKu+4GANdH9b256SOlSS7B7fEuWU+lNvnjxAsnEO5MQ832Sw
         HJA+6h+ZHOualaEJm/33V2cDY3nQGAiFmmQGpaULBqHDoNI24V89SPQZoMpdr3KouN4v
         3Qkw==
X-Gm-Message-State: APjAAAVi22QJMnV7YaBIw8jrpjpBKtnxbZ7QQcaVuyPBxpjHiRvw1fsA
        F2v1W/76L7W5Ek+jUwRkETFvvF3iHVI4B00hNwOkc1/M02c=
X-Google-Smtp-Source: APXvYqzO1IE7MFKpGp23z5S7I+H6MKsEG24x4wwmUvxPmtTZWFx/oepZPj/5dXTlqF2SgUIXoXvow704fe9S1hU7nsI=
X-Received: by 2002:aa7:87d8:: with SMTP id i24mr18462830pfo.88.1567177662940;
 Fri, 30 Aug 2019 08:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190827101408.76757-1-t.gummerer@gmail.com> <20190829182748.43802-1-t.gummerer@gmail.com>
 <20190829182748.43802-2-t.gummerer@gmail.com>
In-Reply-To: <20190829182748.43802-2-t.gummerer@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 30 Aug 2019 17:07:29 +0200
Message-ID: <CAN0heSqZOG6NMJE4=RReKzG3eD_w1mh8EcYaAQWN6WBY3WuZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] factor out refresh_and_write_cache function
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Aug 2019 at 20:28, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +int repo_refresh_and_write_index(struct  repository *repo,
> +                                unsigned int refresh_flags,
> +                                unsigned int write_flags,
> +                                const struct pathspec *pathspec,
> +                                char *seen, const char *header_msg)
> +{
> +       struct lock_file lock_file = LOCK_INIT;
> +
> +       repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
> +       if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
> +               return 1;
> +       if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
> +               return -1;
> +       return 0;
> +}

AFAIU, the_repository->index == &the_index so this patch is a noop on
the converted user as far as that aspect is concerned.

There's a difference in behavior that I'm not sure about: We used
to ignore the return value of `refresh_cache()`, i.e. we didn't care
whether it had any errors. I have no idea whether that's safe to do --
especially as we go on to write the index. So I don't know whether this
patch fixes a bug by introducing the early return. Or if it *introduces*
a bug by bailing too aggressively. Do you know more?

(This conversion provides REFRESH_QUIET, which seems to suppress certain
errors, but not all.)

In any case, that early return introduces a bug with the lockfile, that
much I know. We need to roll back the lockfile before doing the early
return. I should have seen that already in your previous version.. :-(

The above makes me think that once this new function is in good shape,
the commit introducing it could sell it as "this is hard to get right --
let's implement it correctly once and for all". ;-)

Martin
