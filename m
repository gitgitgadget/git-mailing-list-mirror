Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7782BC433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiB0RgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiB0RgE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 12:36:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B89522FA
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 09:35:27 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r13so20509934ejd.5
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 09:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=udc4OOdFA48VSGGa8kda/JqN4hAnIcMnBN61+3WGgAg=;
        b=n7dK1jd6pEoQ+CFnwLZUA4qI7ogp++lBxeTDJOFW8ZW2omLW937MefOoPAeBzBxKmb
         TbGCn2dFlSs0yJCqjMpO7NnG02y6IlFZOURD2PxnFSR+Mmz2j9goqx4HEqBxtTQSnJLM
         3REB9VYoaDXkxyHozzQO5nDft1I63FXFNjRe5lCkwFTH8aSXcu2crIZfNFPazCxmVZHn
         WZwxlrOlND70g8dC2YJ3unUSNfTFdUm5i/9cV+OD+tfmfeiScnjYVtZ0XvXjID2KIYMk
         pgJkEWGRIUMSNs8aHnlG4jhmv5l1lQm38tyQJH15LGcbUFYEc7OVB75Ca9N8YEAMwkMt
         UWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udc4OOdFA48VSGGa8kda/JqN4hAnIcMnBN61+3WGgAg=;
        b=Skg+PMf/TF/1kyJ+PAOMWlQQgftFTO0GW8gRVad0Ym7ZA0pbpxf9TvndIPapXjA8Tr
         ZfoYLBboZUfs0P/WDesz2ww+UtREl4SGldgp662tnD5Se102mIqXbrUG2gFMzVZw/Os6
         Ag6axh7xY3H/9CRiPrRfxXHLnemo/Ms0NnHNgVxXgCHPcOS/JqFZVLCvcuDT3QEa9qmr
         54LIzUXT5QFo7PXsfvixtCofv2YwX6QyNI0r7xLaPcBsdlReTH71gidWhD+CL/Ggd/7k
         mwlHaXjHzEkzl6Q/J54rcjaU5fbfuV2JU5dTqhJjSVTTSdr6esXmXUAfUOy4K1jX+kdw
         ovFA==
X-Gm-Message-State: AOAM532nrcCtjuAX+ymw5PH+880eCfbZ/J/SYgN8/5Kg/CpD9jIzAJvy
        udDcffsTUPRmnIe1rKD1r+s=
X-Google-Smtp-Source: ABdhPJzVrJG1zhIjR6CaO3uEN0dCP432SI2SzMZ4cjhmOaj+OtfT5R3IWkElHP48430KB5RVF0eGDA==
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id dx21-20020a170906a85500b006cdba2039c5mr12490992ejb.100.1645983326164;
        Sun, 27 Feb 2022 09:35:26 -0800 (PST)
Received: from gmail.com (91.141.32.73.wireless.dyn.drei.com. [91.141.32.73])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm4800494edb.14.2022.02.27.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 09:35:25 -0800 (PST)
Date:   Sun, 27 Feb 2022 18:35:22 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
Message-ID: <20220227173522.wfshhu2rsyss576e@gmail.com>
References: <xmqqy22tx8t1.fsf@gitster.g>
 <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g>
 <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
 <xmqqee3wt5g3.fsf@gitster.g>
 <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
 <xmqqczjduz2h.fsf@gitster.g>
 <CABPp-BEsYTz35XpXy_j09J9-ke4UoCTED4z3L1sq0vYHuvuKPQ@mail.gmail.com>
 <xmqqee3skp3x.fsf@gitster.g>
 <xmqqh78nj0q0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh78nj0q0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 03:36:55PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It is more like
> > ...
> 
> Actually, I misspoke.  It is a bit different.
> 
> In my mind, the building block hierarchy would have been
> 
>  (1) Take three tree objects A, B, and O, and do the three-way
>      merge.  No history relation is assumed among them.
> 
>  (2) Take two tree objects A and B, with one or more commit objects
>      Os; use (2) recursively to reduce Os into a single O and then
>      apply (1) on A, B and O.

Accepting multiple bases is nice (because it frees users of having
to recursively merge their merge-bases),

Let's say we take this series in its current form:

	git merge-tree [--write-tree] [<options>] <branch1> <branch2>
	git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)

and later discover we want to add (2), one possible syntax would be

	git merge-tree --write-tree [<options>] <branch1> <branch2> <base>...

(or put the bases in the middle like merge-file).
Though the mandatory --write-tree leaves a bad taste.

A separate option is a better alternative:

	git merge-tree [--write-tree] [<options>] --base=<base1>,<base2>,... <branch1> <branch2>

Anyway, no need to worry about that now, especially since the root cause of
the ugliness is the legacy --trivial-merge, and there is no way avoid that,
even if we add this now.

> 
>  (3) Take two commit objects A and B.  Compute Os out of A and B and
>      use (2) once to merge A and B.
> 
> I think the basic primitive that should be exposed to an external
> world (read: plumbing) this year, after all years of experience with
> merge-recursive, should be (2), not (1).  
> 
> If you have (2), then (3) is trivially possible (it is just a single
> call to get_merge_base()).  "git merge-tree A B" without having to
> spell out bases is so convenent and you do not have to write
> "git merge-tree A B $(git merge-base --all A B)", so I am OK for it
> to exist, but it is not essential.
> 
> If you have (2) and exposed (2) as the primitive plumbing,
> cherry-pick and revert would be a narrow special case of passing
> only one O to the machinery.
> 
> And coming from the above point of view, exposing (3) as the
> primitive plumbing to scripters and system builders, and later
> having to _add_ support to allow (2), felt backwards.  It should be
> trivial for us to make (2) available before we can even offer (3),
> but what is happening to this new plumbing command goes in the
> opposite order.
> 
> It may be, as you said, the problem the underlying ort API has that
> somehow makes it harder to expose (2), in which case, yes, I think
> that is what bugs me.
> 
> 
> 
