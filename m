Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7FBC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB7C61208
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFGVjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:39:53 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36592 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGVjw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 17:39:52 -0400
Received: by mail-ot1-f44.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18275292otl.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Wx0WMXhrFrPWRqs12sYmTkcK+HxE44wa/rk3b6RpY8s=;
        b=rTnBONkoW4GCKT5iNwadtJHWn2dya6zZlNQNaAnE0W1JL71+MzRzfIs0JBDoG7HTQp
         p6rhIBJc/yPpOAnnKXuJ6fVWKsn4siHY+vDaVXomgy+2gi0kBx+sTQztlUX6GeICKWZb
         /f2pMrh4E7squlAKB7ilqkNUtR/BCrroQKWOVqG3OYlUWtgx2z1YqzI38lsTC+/8LVYB
         ohA4Kfwf/2NnYrCQlumqknzfMgRdLKLb8LztbAbq3UyOVlET2zXWl5ihGLwrUN+cAug6
         9mwyH+iC0aib2qysk7k7fXH0cgAuJvsMOV+zOz8y2ImtjScSQAEOyubWY8MpMBxxlxcV
         yt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Wx0WMXhrFrPWRqs12sYmTkcK+HxE44wa/rk3b6RpY8s=;
        b=hD7ZHyH/r8BoqXEkQLmb5qT8YyLf8JJypyFUrctDGfo/jj/iyHgL4RudR2QCwY5uZb
         PpGU943ml8N9o4hKpCE+ZdGt+pYxKqnYuTK9D6iLvblc80pf/O+6XAJSK3fDFySbYf+t
         vjGzVVWoIE+WxHY64W7UHYqugztZd7fSai/BIRqW/X87SUFPAaU3OdREbY+wlfC34G0w
         VqbUFhViz1cQ9eFjocL6GkRlVVa/UNPgoYNun/9GVEMnrZJ5+6ms2Mltr2s+S+j6HnCx
         Nav3QKnuryKI0Yd3Vo5N27lI0uHrHdpuOsbTpP5M3ufBK0brPkkHy8iho3kpkJ9QlKPW
         XP7g==
X-Gm-Message-State: AOAM531FhV7U7hMN3KV7d/Vv8tPSRWDdffHN1Vlqo03UveqVsfOOS3UW
        9ONRA88Qxip/7HCTUKXYx/Y=
X-Google-Smtp-Source: ABdhPJzWv/VtKYLB8a/+MskFneVZ3urc46jpWue/hVIpbY5yDYolPGjYjPNF4VkKvm22YZYA/+mB3A==
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr15344082otq.303.1623101820291;
        Mon, 07 Jun 2021 14:37:00 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i4sm2625647oth.38.2021.06.07.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:36:59 -0700 (PDT)
Date:   Mon, 07 Jun 2021 16:36:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60be91757c6ca_db80d2086e@natae.notmuch>
In-Reply-To: <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
>  . `Acked-by:` says that the person who is more familiar with the area
>    the patch attempts to modify liked the patch.
>  . `Reviewed-by:`, unlike the other tags, can only be offered by the
> -  reviewer and means that she is completely satisfied that the patch
> +  reviewer and means that they are completely satisfied that the patch=


This sounds completely alien to me.

Granted, I'm not a native English speaker, but aren't you supposed to be
trying to be inclusive?

It took me a considerable amount of time to train my mind to think in
English, and now I don't have to think in Spanish, but "he" is "=C3=A9l",=

"she" is "ella", and "they" is "ellos", or "ellas". And that has been
more than enough to read 99.9% of documents I encounter without
problems.

And now you come out of the blue with a pronoun that doesn't match any
of my mental models.

There's many Spanish speakers out there, but this probably extends to
Italians, French, and all the other Latin-based languages.

But to be honest I read a lot of English, and I virtually never
encounter this usage. And at least 58% of the Usage Panel of The
American Heritage Dictionary [1] agrees with me.

I have read Steven Pinker's (a renowned linguist) style manual: The
Sense of Style. He specifically mentions singular "they", and he
explains the cases where it makes sense, and where it doesn't.

It is not so straight-forward, and to show why, here's an example:

  A contemporary example with an unambiguous female referent comes from
  a spoken interview with Sean Ono Lennon in which he specified the kind
  of person he was seeking as a romantic partner: =E2=80=9CAny girl who i=
s
  interested must simply be born female and between the ages of 18 and
  45. They must have an IQ above 130 and they must be honest.=E2=80=9D

In this case "they" is grammatically singular, yes, but it is
*psychologically* plural, since the person is picked from a pool.

I don't know how a native speaker parses this "they", but as a Spanish
speaker I cannot leave it unspecified. "They must" translates to
"deben", which is plural, if it was singular it would be "debe", which
in English would be "she must".

I have read many instances where English speakers argue it's a singular
"they" but to me it's not. According to Steven Pinker it's because it's
psychologically plural.

Pinker uses singular "they" very occasionally, and only with
semantically plural antecedents, the rest of the times he alternates
between he and she freely. And I try to do so as well.

This is his conclusion in his style manual:

  Because of these complexities, writers always have to consider the
  full inventory of devices that the English language makes available to
  convey generic information, each imperfect for a different reason: he,
  she, he or she, they, a plural antecedent, replacing the pronoun, and
  who knows, perhaps someday even using thon.

  For some purists, these complexities provide an excuse to dismiss all
  concerns with gender inclusiveness and stick with the flawed option of
  he. Gelernter complains, =E2=80=9CWhy should I worry about feminist ide=
ology
  while I write? . . . Writing is a tricky business that requires one=E2=80=
=99s
  whole concentration.=E2=80=9D But the reaction is disingenuous. Every s=
entence
  requires a writer to grapple with tradeoffs between clarity,
  concision, tone, cadence, accuracy, and other values. Why should the
  value of not excluding women be the only one whose weight is set to
  zero?

He does however, provide tips to avoid some hurdles, one is to express
quantified descriptions as plural, so we would have:

  `Reviewed-by:`, unlike the other tags, can only be offered by the
  reviewers and means that they are completely satisfied that the patch
  is ready for application.  It is usually offered only after a
   detailed review.

That reads perfectly fine to me.

> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -244,8 +244,8 @@ Imagine that you have to rebase what you have alrea=
dy published.
>  You will have to bypass the "must fast-forward" rule in order to
>  replace the history you originally published with the rebased history.=

>  If somebody else built on top of your original history while you are
> -rebasing, the tip of the branch at the remote may advance with her
> -commit, and blindly pushing with `--force` will lose her work.
> +rebasing, the tip of the branch at the remote may advance with their
> +commit, and blindly pushing with `--force` will lose their work.

This one does read correctly to me, and is in fact better than "she".
And it is because "somebody" is semantically plural: he or she comes
from a pool of people.

As stated above, writing is a tricky business, you can't just
s/s?he/they/.

Not even renowned linguists dare to prescribe point-blank rules like you
are trying to do.

This is part of Usage Note on "singular they" from The American
Heritage Dictionary:

  Resistance remains strongest when the sentence refers to a specific
  individual whose gender is unknown, rather than to a generic
  individual representative of anyone: in our 2015 survey, 58 percent of
  the Panel found We thank the anonymous reviewer for their helpful
  comments unacceptable. A sentence with a generic antecedent, A person
  at that level should not have to keep track of the hours they put in,
  was rejected by 48 percent (a substantial change from our 1996 survey,
  in which 80 percent rejected this same sentence). As for the use of
  they with antecedents such as anyone and everyone, pronouns that are
  grammatically singular but carry a plural meaning, by 2008, a majority
  of the Panel accepted such sentences as If anyone calls, tell them I
  can=E2=80=99t come to the phone (56 percent) and Everyone returned to t=
heir
  seats (59 percent).

I do not think the Git project should jump into these muddy waters.

Cheers.

[1] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-=
they

-- =

Felipe Contreras=
