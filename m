Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B340DC2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D6A206ED
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjoZ96S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgKJBfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKJBfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:35:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D14BC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 17:35:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l2so15254664lfk.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 17:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GUcP51qbaUVwoCkRXETSjmOU3lXgyfczAm8dHMyyegI=;
        b=QjoZ96S5UGcMtpmkQbeeWHfh8Iw++cXZkyWtA801gyvGwaghbgS0sqBdOGYcX1oh+w
         6N/pXBDZ9Mtt75aTUJeWkkzhXNxHoEfFwJocNAIzxtIBdOcxdn7QhfyG4EJMdOkSqZ8q
         /CYUdZxG9GQGvmBnU4RDfLFZsi3qFeY/bGy85DRlDEIGQoAr5pPKMUoSEzUdpCULaeuP
         gk4NRa83+LVx22L64eyDTaoRvDIyFIpIBxf5wd94H65lH7yORHEEZCTVh2YnsQSoFpaR
         IVxHURtOFnrEo48phsQN8AP08fmBrqC/Y8elpSsVND/nj174nWZ95vO74F8mMJGRZufT
         HlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=GUcP51qbaUVwoCkRXETSjmOU3lXgyfczAm8dHMyyegI=;
        b=B3M2yTPe4Mrk9yLq5ySiUbo4q3w8FJozHhcszwfWmT41U452ksTFmz6BZAtJTO+2vo
         NbL0vKe2qSuecMXfpISidvch/HWhCxoKCqEerpd7zzjz6HmohMrheWplXApgY9nw6HE0
         CYOEpiXbYTN32RB8mTDCQgP1M094XKNf1PTYaTiKRfB1kaPE6d5G1yruLyEPmHZg59sr
         3QUVi0l3FvqpA6iTuIaEGhtifMOEyrJjHLEMuwikr8/6Ws68+RubPXElu8MBBCmbXnGd
         d7XTfvKvapelH2aVtW72/qZqduv0ESiHUfEL38U2u8R4tZEbX0nHgMscEp7WHMlNTx1u
         I2Tg==
X-Gm-Message-State: AOAM531E63ygayHGvpCpQNujdk/jbw2oU/+j+X0UFHS8+uB814xQkv5M
        R2gK+rxU+adpxOky4iceztw=
X-Google-Smtp-Source: ABdhPJx3B1R1QnS+q5vV2S1Q5iq8XtsGW2PeUzn8ruMR/aKhrsHoW9vjt7dJg0DjjE/ttjziRz6tKA==
X-Received: by 2002:a19:915e:: with SMTP id y30mr2148911lfj.266.1604972149990;
        Mon, 09 Nov 2020 17:35:49 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id x123sm947196lfa.154.2020.11.09.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:35:48 -0800 (PST)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Extending and updating gitglossary
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
        <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
        <85pn4tnk8u.fsf@gmail.com>
        <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
        <xmqqtuu3k6jf.fsf@gitster.c.googlers.com> <85zh3ujq9c.fsf_-_@gmail.com>
        <8d43335d-a0b4-511e-f132-057343234503@iee.email>
Date:   Tue, 10 Nov 2020 02:35:46 +0100
In-Reply-To: <8d43335d-a0b4-511e-f132-057343234503@iee.email> (Philip Oakley's
        message of "Sun, 8 Nov 2020 17:23:28 +0000")
Message-ID: <85imaej8nh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip,

Philip Oakley <philipoakley@iee.email> writes:
> On 06/11/2020 18:26, Jakub Nar=C4=99bski wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>
>>>> This may be not part of the the main project, but could you consider, =
if
>>>> time permits, also adding some entries into the Git Glossary (`git help
>>>> glossary`) for the various terms we are using here and elsewhere, e.g.
>>>> 'topological levels', 'generation number', 'corrected commit date' (and
>>>> its fancy technical name for the use of date heuristics e.g. the
>>>> 'chronological ordering';).
>>>>
>>>> The glossary can provide a reference, once the issues are resolved. The
>>>> History Simplification and Commit Ordering section of git-log maybe a
>>>> useful guide to some of the terms that would link to the glossary.
>>>
>>> Ah, I first thought that Documentation/rev-list-options.txt (which
>>> is the relevant part of "git log" documentation you mention here)
>>> already have references to deep technical terms explained in the
>>> glossary and you are suggesting Abhishek to mimic the arrangement by
>>> adding new and agreed-upon terms to the glossary and referring to
>>> them from the commit-graph documentation updated by this series.
>>>
>>> But sadly that is not the case.  What you are saying is that you
>>> noticed that rev-list-options.txt needs a similar "the terms we use
>>> to explain these two sections should be defined and explained in the
>>> glossary (if they are not) and new references to glossary should be
>>> added there" update.

What terms you feel need glossary entry?

>>> In any case, that is a very good suggestion.  I agree that updating
>>> "git log" doc may be outside the scope of Abhishek's theme, but it
>>> would be very good to have such an update by anybody ;-)
>>
>> The only possible problem I see with this suggestion is that some of
>> those terms (like 'topological levels' and 'corrected commit date') are
>> technical terms that should be not of concern for Git user, only for
>> developers working on Git.  (However one could encounter the term
>> "generation number" in `git commit-graph verify` output.)

To be more precise, I think that user-facing glossary should include
only terms that appear in user-facing documentation and in output
messages of Git commands (with the possible exception of maybe output
messages of some low-level plumbing).

I think that the developer-facing glossary should include terms that
appear in technical documentation, and in commit messages in Git
history.

> However we do mention "topolog*"=C2=A0 in a number of the manual pages, a=
nd
> rather less, as yet, in the technical pages.
>
> "Lexicographic" and "chronological" are in the same group of fancy
> technical words ;-)

I think that 'topological level' would appear only in technical
documentation; if it would be the case then there is no reason to add it
to user-facing glossary (to gitglossary manpage).

'Topological order' or 'topological sort', 'lexicographical order' and
'chronological order' are not Git-specific terms, and there are no
Git-specific ambiguities.  I am therefore a bit unsure about adding them
to *Git* glossary.

- In computer science, a _topological sort_ or _topological_ ordering of
  a directed graph is a linear ordering of its vertices such that for
  every directed edge uv from vertex u to vertex v, u comes before v in
  the ordering.

  For Git it means that top to bottom, commits always appear before
  their parents. With `--graph` or `--topo-order` Git also avoids
  showing commits on multiple lines of history intermixed.

- In mathematics, the _lexicographic_ or _lexicographical order_ (also
  known as lexical order, dictionary order, etc.) is a generalization of
  the alphabetical order.

  For Git it is simply alphabetical order.

- _Chronological order_ is the arrangement of things following one after
  another in time; or in other words date order.

  Note that `git log --date-order` commits also always appear before
  their parents, but otherwise commits are shown in the commit timestamp
  order (committer date order)

>>
>> I don't think adding technical terms that the user won't encounter in
>> the documentation or among messages that Git outputs would be not a good
>> idea.  It could confuse users, rather than help them.
>>
>> Conversely, perhaps we should add Documentation/technical/glossary.txt
>> to help developers.
>
> I would agree that the Glossary probably ought to be split into the
> primary, secondary and background terms so that the core concepts are
> separated from the academic/developer style terms.

I don't thing we need three separate layers; in my opinion separating
terms that user of Git might encounter from terms that somebody working
on developing Git may encounter would be enough.

The technical glossary / dictionary could also help onboarding...

>
> Git does rip up most of what folks think about version "control",
> usually based on the imperfect replication of physical artefacts.

I don't quite understand what you wanted to say there.  Could you
explain in more detail, please?

>> P.S. By the way, when looking at Documentation/glossary-content.txt, I
>> have noticed few obsolescent entries, like "Git archive", few that have
>> description that soon could be or is obsolete and would need updating,
>> like "master" (when default branch switch to "main"), or "object
>> identifier" and "SHA-1" (when Git switches away from SHA-1 as hash
>> function).
>
> The obsolescent items can be updated. I'm expecting that the 'main' and
> 'SHA-' changes will eventually be picked up as part of the respective
> patch series, hopefully as part of the global replacements.

Here I meant that "Git archive" entry is not important anymore, as I
think there are no active users of GNU arch version control system (no
"arch people"); arch's last release was in 2006, and its replacement,
Bazaar (or 'bzr') doesn't use this term. So I think it can be safely
removed in 2020, after 14 years after last release of arch.

In most cases "SHA-1" in the descriptions of terms in glossary should be
replaced by "object identifier" (to be more generic).  This can be
safely done before switch to NewHash is ready and announced.

Best,
--=20
Jakub Nar=C4=99bski
