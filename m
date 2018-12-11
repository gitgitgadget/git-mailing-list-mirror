Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0455C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeLKGEq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:04:46 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40353 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLKGEp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:04:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so8188823vsf.7
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 22:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2B5/oot3XBzWEVVn6v7MtC2FhMkjDJCYyyt0JmDL6YE=;
        b=SybVSV01Y8BLj+zLIYkB5HUgu91YKHHBlerjKEd/M1Dr5luaHjqu1jPrq71MKdiVD2
         5EWSwgNejE5iT/mMG632itltS2DhMYorJPyIbS4XpS9r3HL8W4oorcvGViLKx7CWNs9r
         LUnVwNoVyAkOhIDRG99P3JvZAJSnDP2653g//Iv8/cOsEIXgZWPrrgVYAcb/I+fghyeG
         8SnOHENxQvO80IBFwAAZGcJqlVWwuf6XOniHBj9QTgOUWntr6w63gImzSzXHL0zGyWkX
         ZtORqH+lHV8LMWxUNOHf4NOw6PiwqA9R8uCWuJhhps3dlq3GaBisEpKx8+WzqtcZa4nU
         JfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2B5/oot3XBzWEVVn6v7MtC2FhMkjDJCYyyt0JmDL6YE=;
        b=hDjZrB/l7BZh73089K199xQWPaIYe67aOlFIYXiiRfALjd1PplDPu5x86nljlaiZRI
         Ls+XqtE7wor4+pdFebJ9jYXYCto0Qlj6gYtA80PZD9QQqJVB1PiME4hX7AFcF9H2iEjj
         WBRLQ51NuFjpa0nk8KaHzpUMz/FVmeoNNYy1p5MbWI/bjMYCp0i/z4AwJ5oz2ZrdpyV7
         ce/BK+C19ExDihScg+cotDXfYZZAlOmjw65zobJCzhXAjAuE4G8T++vD92kU0aea1H2Z
         yCmrUWbrp8OvkIdzxMV8KmKPodr4LgoGjgL8RxRmzEziuhLhAv8PEyU/Pak1964w0E1A
         hl/A==
X-Gm-Message-State: AA+aEWaPLa/7JU7gKlp+a8HJtJ8kEBM153Zh8829ewAYufHMOXp40/O7
        xrLWvYunBWnu5zq9vFvldEqAvMQx9Wq8TaS0HqA=
X-Google-Smtp-Source: AFSGD/W+BA94JmRr6W8nfnsdJviFOgNUBlPwAAgtBycj9hi7H/l8HIPkXXp1Da+0DNcCYNZqRgBbtKx99LNnthA8ofQ=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr6634204vsa.117.1544508283631;
 Mon, 10 Dec 2018 22:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-6-t.gummerer@gmail.com>
 <CABPp-BEk+7n2wcbjETishqnMBs5DGrTEvD7gahLtEj5bZ2AYvA@mail.gmail.com> <xmqqzhtclq22.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhtclq22.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 22:04:31 -0800
Message-ID: <CABPp-BG-n6vw7qQ=PQgnyAqmSechbz6eaSduNxuA6_Mdp4D-ew@mail.gmail.com>
Subject: Re: [PATCH 5/8] checkout: introduce --{,no-}overlay option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> Note that 'git checkout -p <tree-ish> -- [<pathspec>]' already works
> >> this way, so no changes are needed for the patch mode.  We disallow
> >> 'git checkout --overlay -p' to avoid confusing users who would expect
> >> to be able to force overlay mode in 'git checkout -p' this way.
> >
> > Whoa...that's interesting.  To me, that argues even further that the
> > traditional checkout behavior was wrong all along and the choice of
> > --overlay vs. --no-overlay in the original implementation was a total
> > oversight.  I'm really tempted to say that --no-overlay should just be
> > the default in checkout too...but maybe that's too high a hill to
> > climb, at least for now.
>
> You are exhibiting a typical reaction to a shiny new toy.
>
> The original "checkout paths out of the trees and/or the index to
> recover what was lost" is modeled after "cp -R .../else/where .",
> which is an overlay operation, and you wouldn't imagine complaining
> that "cp -R" is wrong not to remove things in the target, to be
> equivalent to "rm -fr where && cp -R .../else/where .".
>
> Each has its own uses.  We just didn't have the other half of the
> pair.

Ah, modelled on cp -R.  I think that rather than reacting "to a shiny
new toy", I just had always had a different mental model AND failed to
figure out what the original model was, leading me to always view it
as buggy.  Thanks for giving me the model I was missing.

> If anything, I would consider "checkout -p" that does not do overlay
> is a bug that needs to be fixed.

Yeah, --no-overlay being the default for -p, and --overlay being the
default otherwise is rather inconsistent.  (Though I'm also fine with
that being fixed by some future patch series.)
