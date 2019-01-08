Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B861F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfAHS0a (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:26:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44927 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfAHS0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:26:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so5029886wrt.11
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X2XC1qDB5IIZVi3PIfhLqD7RHkS0gY1IOdSZy71Rhqc=;
        b=jRFNHBdrmXeCqlwt2pOa812F5JJQ2M/oFIwBCfJriFNH/44FCZrIVUtlB8JteORal9
         eoqQBSHRvpYV3RWiejDtSvGmXTNE/u2M7BvTGnWKk6C5s6T1Vj/0ajnpUvu00Lvimy3n
         /60BNSmao5imVlVBtFaxa45AOGdpalVLnCuhoDYVZqefS8AygR85xRl/nT2PVW9D7iXo
         GNN3lzPoJgmijq3CusdI40jIoMNfgHWhY/PGcoVIFSd/BiAZ7xHYC/7lALC8XwFcoVbq
         MV/NUBqUy6JyjY/y1MkugsaAR1/bNNHrdDCoIuRtHykwGsXomaltGOE5W1RXouyU6/rJ
         v/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X2XC1qDB5IIZVi3PIfhLqD7RHkS0gY1IOdSZy71Rhqc=;
        b=bi9KMOcTzn5VM/2Yc57ivmW6lAeHxodnMM23OuwkyDmx+0F7vvNq8dkI7cQWoKKzOy
         PF1INKZRT/qGYLPQDhdek0+k+2qP2nQS8ovlrajABu+v4FXRfX58ifDD9uF5xiDIauQC
         nzgUaEgy4wQnNK377DzqollqjB8VBiKE99GunQgK/+p9NHFy82HqcUhi9OhArg3KXrCi
         rTQ8RMUKitFArh3gEO1pxHxwWJGpGUQCtlODdqQYNeU5ImlMLZ9+Daqj7ef+x0iMZLoz
         ANtmOPIwI/7FR51lWgnoSMFbXpCviKPYm7cuKNi91o3Fl+bSpNuAVbdMxpD9IIRtZeF0
         F0RA==
X-Gm-Message-State: AJcUukfEpLIrblsWOR+pcFOIcGzniR0Sr/6VqCCHQfqFKWPhzw+mMqMg
        LsGkcqMGzkpr6j7ErhZuTjk=
X-Google-Smtp-Source: ALg8bN7Zc7IBuVoCByn21PA6cUl13qowjT5a8X5V+1EN5HqLAXU9oG4iewdSSO11oui+PE9xuvSENg==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr2370270wrs.272.1546971987876;
        Tue, 08 Jan 2019 10:26:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k26sm8532753wmi.28.2019.01.08.10.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:26:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
Date:   Tue, 08 Jan 2019 10:26:26 -0800
In-Reply-To: <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com> (Barret
        Rhoden's message of "Tue, 8 Jan 2019 11:27:42 -0500")
Message-ID: <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

>> A policy decision like the above two shouldn't be hardcoded in the
>> feature like this, but should be done as a separate option.  By
>> default, these shouldn't be marked with '*', as the same tools you
>> said you are afraid of breaking would be expecting a word with only
>> digits and no asterisk in the column where line numbers appear and
>> will get broken by this change if done unconditionally.
>
> Since users are already opting-in to the blame-ignore, do you also want
> them to opt-in to the annotation?

Absolutely.

After all, the users of a moral equivalent that is -S
never needed such an extra annotation, which tells us two things.
(1) the claim "It's useful to be alerted to the presence of an
ignored commit" in the proposed log message is merely a personal
preference and universal users' requirement; (2) if it is useful to
mark a blame-source whose parents (used while blaming) do not match
the actual parents, such an annotation would also be useful while
running -S.  So probably it should be a separate option that can be
given when any of the --skip-commit=<rev>, --skip-commits-file=<file>,
r -S<file> option is given.

>> Obviously, an interesting consideration is what happens when a merge
>> commit is skipped.  Is it sufficient to change this description to
>> "...will get passed to its parentS", or would the code do completely
>> nonsensical things without further tweaks (a possible simple tweak
>> could be to refuse skipping merges)?
>
> If we skip a merge commit, it might pick the wrong parent.

Actually after thinking about it a bit more, I no longer think a
merge is so special.  In this topology (as usual, time flows from
left to right), if you are skipping M,

        ---A---M---C---D
              /
         ----B

you'd simply pretend that the ancestry is like this and you'd be
fine, no?


        ---A-------C---D
                  /
         --------B

That is, when inspecting C, pass_blame() would enumerate its true
parents, notice that M to be skipped, which would cause it to
pretend as if C has M's parents instead of M itself as its parents.
If M in the true history is the first parent of C, then M's first
parent in the true history becomes C's first parent, M's second
parent in the true history becomes C's second parent, etc. (if C
were a merge in the true history, such a rewriting would make C an
octopus in the distorted history)

> The wrong commit is blamed.

So... I still suspect that it is merely a bug in your implementation
and there is nothing inherent that forces us to avoid skipping a
merge.

>> Somehow the damage to blame.c codebase looks way too noisy for what
>> the code wants to do.  If all we want is to pretend in a history,
>> e.g.
>> 
>>     ---O---A---B---C---D
>> 
>> that commit B does not exist, i.e. use a distorted view of the
>> history
>> 
>>     ---O---A-------C---D
>> 
>> wouldn't it be sufficient to modify pass_blame(), i.e. the only the
>> caller of the pass_blame_to_parent(), where we find the parent
>> commits of "C" and dig the history to pass blame to "B", and have it
>> pretend as if "B" does not exist and pass blame directly to "A"?
>
> I originally tried to skip 'B' in pass_blame() when B popped up as a
> scapegoat.  That broke the offsets of the blame_entries in the
> parent.

Why?  When inspecting C in order to exonerate it from as many lines
as possible, we'd run "git diff $P C" for each parent of C, but in
the distorted history (i.e. instead of using $P==B, we use $P==A).
As long as the code reads from "git diff A C", I do not see why "the
offsets in the parent" can be broken.  Care to elaborate a bit more?

