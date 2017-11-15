Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932B0201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 20:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbdKOUZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 15:25:40 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:57260 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758416AbdKOUXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 15:23:52 -0500
Received: by mail-qt0-f177.google.com with SMTP id r39so21051788qtr.13
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 12:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f8XPGBb/3OLMu8Vm76vD+7yAvN/a5PHXsvfIzvRXzd0=;
        b=VX1ZTrlDyMikSfR3JY4aa1i0RDTLzgrubuwY3+bfnV7VlU/UAbcSxIztiXIr9RV/U3
         YGvuU22R+Rryfqe9buFEpQkqQXzUK5a8Ruk7YH1YdXdP+mzSorSBM0JREPP5EyVIxzu2
         3neYmQnOpnFTbfC5tZ09kV9Dj1JeuOqpWidMF18Ex4VOfl3L7nCXLM502MeJlDKssSbK
         Hm8ubtVb0bcclqXW8FzuN0hUfJZ7JtDmWbToTtcTUIHOiVI8zkm1utdJWP4O9m38Dbh4
         IaYMpeTJUmNsIzNdRA+P9U6LAW8H/di6o4GVPL6jNhi0xfAVlau+kcf0KkHkV+1eaHvk
         oO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f8XPGBb/3OLMu8Vm76vD+7yAvN/a5PHXsvfIzvRXzd0=;
        b=QInx8vgNFUgo660cTrFbNjWcV1WUyBVxMGLKfQV46GYhZzikPUXnHU+3t/e36scrsA
         b57QQ6219n4T8tlKlaVdf0n49PjsMcFXUyxJuiyEJ4lY9ZO1CJqeTN8+XFtDt38MvXhQ
         PIdr7xOJk5GBufx0vfGYN/14/+Yb4xsi7nkgtsPcKAp7cjGsqt7HqQnpb/d1TWsbSpfJ
         nI6LqfR9IHnw9tZhJ7nUJN0GYsFFceksbYDjUUmMIYPv714oGgQiDkxR/YRBfy1rrSQF
         YrBOBcNDLdNl0eWDMe7tuBVotq0eKYnVjQ7tRmWSk9vL0cml66XP2+beDGskIf/gEAL6
         ymsg==
X-Gm-Message-State: AJaThX7jeaqlNFHknUATyJEnH/4ob5z/bzryQV/nM/3N0uLeSZBQ1n5O
        R+5vvqpABDk8vKT1h6LNMkO1Hs9SJNfXCH41eM0qzw==
X-Google-Smtp-Source: AGs4zMYyJvGpIzMN2O+PdRKoy9NRKqNbReOhHod6B9XqQsXXsHpMEmnvFH9UqRnZDj49iid29PeB2PAp+sIyFOlXe94=
X-Received: by 10.200.55.75 with SMTP id p11mr27004535qtb.298.1510777431200;
 Wed, 15 Nov 2017 12:23:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 12:23:50 -0800 (PST)
In-Reply-To: <20171110190550.27059-28-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-28-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 12:23:50 -0800
Message-ID: <CAGZ79kanxn7+bgMxbEfSPZtSr4KBWzk9NHE9F-g4J+2TXbz_mQ@mail.gmail.com>
Subject: Re: [PATCH 27/30] merge-recursive: Apply necessary modifications for
 directory renames
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +               if (!strcmp(pair->one->path, pair->two->path)) {
> +                       /*
> +                        * Paths should only match if this was initially a
> +                        * non-rename that is being turned into one by
> +                        * directory rename detection.
> +                        */
> +                       assert(pair->status != 'R');
> +               } else {
> +                       assert(pair->status == 'R');

assert() is compiled conditionally depending on whether
NDEBUG is set, which makes potential error reports more interesting and
head-scratching. But we'd rather prefer easy bug reports, therefore
we'd want to (a) either have the condition checked always, when
you know this could occur, e.g. via

  if (<condition>)
    BUG("Git is broken, because...");

or (b) you could omit the asserts if they are more of a developer guideline?

I wonder if we want to introduce a BUG_ON(<condition>, <msg>) macro
that contains (a).


> +                       re->dst_entry->processed = 1;
> +                       //string_list_remove(entries, pair->two->path, 0);

commented code?
