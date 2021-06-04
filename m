Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF50CC07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD198613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 15:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFDPve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 11:51:34 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35331 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 11:51:34 -0400
Received: by mail-ot1-f46.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9530051otg.2
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1lXc5D6Vuqgh6C+vRLFSYmHpUEC3zCdzbAJoW6ewXL0=;
        b=T01MUrvoPJrqEnn4Stb1njRnSIjbMuC83ynhUN7+/+mXHZLVvHxkKYahsP5Cz5ehCp
         G1RZbJSTdIc+TXmBIFcJtf0GH7ppPyV071bS3DQmgiIdlbCMypXkCneGtZmKGjyJcTPd
         l6aO/IQ6o8aOB9OGH+oODBsFrsjV4XMRZdUrmaoJRVRXQQqbvl/6IUbbm8FHrXbD2AYO
         iIOMGqUDHdKcpXRBSxRPb81yfQVoOpAUj49uLBsmJSJNJdE9C0CUZJEHYE5c+Ghfcm+0
         a6pnjfldEGOR9m7xAi0mTvy55e3G0Y7z0s2+/MlbRBMQGYcS/3OctzINttj83ZBSbIEc
         xsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1lXc5D6Vuqgh6C+vRLFSYmHpUEC3zCdzbAJoW6ewXL0=;
        b=e0TlCrK8RG4Yv9o5GOtD/ltXhjj9m97dqgIa1gYnKHw6cOAccm9gS69PeqBBNiJ8x+
         DzklpjLS9tql0egtYA2KW6R+M8S6/yw1SzPNolDYbPKgTZaZRdC1ITr+czar/7nDxn/4
         +CRUUEaBB9Ny7fuJhVCqrnTBRoDAIrKSMPb5BG3gUaBOcIRGqlFkBkkY+fdDk9aC0XR4
         Q3pymzPjGNmnWqqhe3gbzjvLuZVWnMts4NlqMnSdhxT9mPEahAwMsHXZ3A/klHgamfmi
         y6GYD5M5L1hpEFW9QVpFyw4vYVSqdRq+iVXKDcYZy8/HAFP0ePDW8raMSjeE/FbVF6yq
         /FWg==
X-Gm-Message-State: AOAM533qagBrXsn1xWxosVDBap7/7iO+3yYMz5zWKwRfE4KrLl9zAhMZ
        r5una4eH1meVuVh1nTd6lTIuvH8AoxeNNfyO09A=
X-Google-Smtp-Source: ABdhPJzwb9pC4M8pHDgblZqJUJ7dGE2HBDcYY3UAtePz4JyQYszpMQWJcTR9esvVrni20zl/DdMvkRHqEWsLJM7r/8A=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr4176278ote.316.1622821712735;
 Fri, 04 Jun 2021 08:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com> <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
In-Reply-To: <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Jun 2021 08:48:21 -0700
Message-ID: <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed stuff
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 6:11 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/4/2021 12:39 AM, Elijah Newren via GitGitGadget wrote:
> > This series depends on en/ort-perf-batch-11 textually, but is semantica=
lly
> > independent of it.
> >
> > Changes since v2:
> >
> >  * Made suggested minor tweaks from Stolee on Patch 1
> >  * Dropped patch 3, for now
>
> With these changes, I think the code is good to go.
>
> >  * Added Stolee's Acked-by
> ...
> >  1:  c4a0f6a9510c ! 1:  f63ffc2a7c22 merge-ort: replace string_list_df_=
name_compare with faster alternative
> >      @@ Commit message
> >               just-one-mega:   500.3  ms =C2=B1  3.8  ms   480.1  ms =
=C2=B1  3.9  ms
> >
> >           Signed-off-by: Elijah Newren <newren@gmail.com>
> >      +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
>
> I believe the sign-off should always be the last thing in
> the message. Perhaps Junio is willing to fix this without a
> re-roll?

Interesting, this is the first I've ever heard of such a requirement,
and I've submitted patches this way numerous times and have seen
others do it.  A quick search through git.git history says there are
5133 commits that place such trailers before the author's
Signed-off-by, and 1175 that place them after.  While the former is
clearly more common, and some of the latter could have been Junio
adding trailers while applying the patches, there still seem like
plenty of counter-examples suggesting that there is no rule here.

Digging into Documentation/SubmittingPatches, I find three places that
suggest or state something about placement of trailers.

'''
[[real-name]]
Also notice that a real name is used in the `Signed-off-by` trailer. Please
don't hide your real name.

[[commit-trailers]]
If you like, you can put extra tags at the end:
'''

Which isn't definitive but seems like it could be easy to accidentally
construe as a rule that says the opposite, namely that other trailers
come after the Signed-off-by.  Another part of the document states:

'''
you add a "Signed-off-by" trailer to your commit, that looks like
this:

....
        Signed-off-by: Random J Developer <random@developer.example.org>
....
'''

which possibly suggests that the relative location compared to other
trailers does not matter.  The wording in that document that comes
closest to your interpretation is

'''
At the beginning of the
patch should come your commit message, ending with the
`Signed-off-by` trailers'''
'''

but if it had really meant to convey the rule you suggest here, it
should have said "ending with your Signed-off-by trailer"; the
"trailers" here to me suggest the phrasing here has a totally
different meaning than your rule.

So, if "Signed-off-by should come last" is a rule, then neither
existing practice nor our documentation seem to cover it.  I'll assume
it's not a rule for now.

> Feel free to replace Acked-by with Reviewed-by.

Thanks.
