Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C62C1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 22:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbcLIWx0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 17:53:26 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34942 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcLIWxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 17:53:25 -0500
Received: by mail-qk0-f173.google.com with SMTP id n204so32384174qke.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HqO6lL4xh7pvePoCO/9CAnV8khQbzXtrSJc+HTG5XOk=;
        b=XCtKARCk5ADNnYv9KC56S6dOBmnCvWEp4lWi4qx2L2bh2Wo0MRu/DtYoRV2vYDHytE
         3d7JviW/zNBdXfW0q9/elg6qDZTMVGVBd8yiBtjYDOEV9kO052P+Ny6vdYa2x8vdX4kI
         SjQeFj+GIXRnQ8DwlTya4E3LMwYcVFz7OIzOvA5+YWGg2kM1fz3OYnoPRstcXos+luMm
         zVXmH1xD+wbc6q97EXXq7Sh8Bs+qsJg6WpetNCnAKEf+6ETTd6KkGKHgT9uB97O6WJeL
         iH4vQ6VFM59fSYpXYCIVJXx2G5xIfjzJlPjnbP1lzdgfkxBgqnGtk1rm2cN+CY9/U/2w
         KQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HqO6lL4xh7pvePoCO/9CAnV8khQbzXtrSJc+HTG5XOk=;
        b=PQhPuyXpjgUwS/wqR65SIyrSTkWicB1IZ79rsF7dmLJSLUIlCvU/MkmAb88c/MUFuq
         sez7l8IyMSisOlZY1VUihTKeewdJWqtiZJwL/9e5vUQSsdt96xxNxr+VVV8AKRakJTCv
         v0HDpTYLzNlJoqkoPfI72XbPZvrce/wzmaAM4o+UUS3NbtupvIk1ahwEWWwIgXW/TsFd
         pml9fWHCrXgOfOXGKZzPTC5k9BTVLYYqvG3K+GftJehtahAqz32lJBlpwHC20CR+QAaY
         YLO6iXObappcZEFwXU1jYzGX3+E6T9FvdEkED2LwVoOqbUCiUJvirjZpGn5z1OL1YzYZ
         r4wQ==
X-Gm-Message-State: AKaTC02/W3uGYf0E1L1l9RmpakSExvlnukhufSB7wGz9Dg/caDmFGP9obzTJjnUaYB/ft7E7jxb5Ay+D7paKbQX6
X-Received: by 10.55.191.134 with SMTP id p128mr68214807qkf.58.1481324004762;
 Fri, 09 Dec 2016 14:53:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 14:53:24 -0800 (PST)
In-Reply-To: <xmqqfulwraq2.fsf@gitster.mtv.corp.google.com>
References: <20161209203449.17940-1-sbeller@google.com> <xmqqfulwraq2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 14:53:24 -0800
Message-ID: <CAGZ79kaqw=XqrNF5+Ta8CwcD7FyA853UQUdMxHmBAaMHPMHrXg@mail.gmail.com>
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I doubt that this is the best place to call this hook, because the
> called hook does not have access to information that may help it
> make a better decision.

As the commit message may elude, I chose this place as it would be
sufficient for checking for ChangeIds, missing signoffs, or even
rudimentary check for coding style and commit message line length.

>
> For example, because the hook gets one patchfile at a time, it does
> not have the entire picture (e.g. "are you sure you want 01/05,
> 02/05, 04/05 and 05/05 without 03/05?").  For another example, the
> hook does not have access to the decision git-send-email makes on
> various "parameters", which are computed based on the contents of
> the patchfiles and command line arguments at this point in the code.
> (e.g. @to, @cc, etc. are computed much later, so you cannot say "do
> not send anythnng outside corp by mistake" with this mechanism).
>

So you are suggesting to
* have the check later in the game (e.g. just after asking
   "Send this email? ([y]es|[n]o|[q]uit|[a]ll): " as then other information
  such as additional @to @cc are available.
* the hook should not just be called one file at a time, but rather
  we would give all file names via e.g. stdin. With the current code
  structure this contradicts the first point.

I wonder if we want to have multiple hooks for these different things
of either looking at the big picture or looking at each in detail.

For me currently I am only interested in the small picture thing.

Stefan
