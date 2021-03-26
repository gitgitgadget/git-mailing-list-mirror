Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8568C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7145B61A49
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZKnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCZKnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:43:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8968C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:43:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so5760924eds.7
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/ph4ALhCB3mINVigumZEEguBAGzdDdl8xTTt361rSrw=;
        b=j+ZmIh66F9WtYfzbCrHsyIK67H8LCsPhAhd/hZFKEqyxJP2Yb9bSq9eVwkbtcCa5l1
         lP8YVtwd7F+kY8U7h6n3j+p8nqgTEsnKt6uEnRSZSa7HAheXN9vOUOzVDzlfWDVkvt/s
         tdh1K+ZHuVDtnc7jZwHEFbHHQJApS3Jj0FlexNfVi585/ViBUG6196KAra5jZWFAYr3M
         /wLNWgo/krVUSS+eXXD1YhGd68cHdK4W2UIMEzLd4SZomkiJLFWMAqAnlJHKY3VegH/v
         1zVxG52P0nUkhEkmnYtUay646wniyWCWSsazTmLCjwMUSknQy4xp/rZ42JxkeBCdIm1+
         EUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/ph4ALhCB3mINVigumZEEguBAGzdDdl8xTTt361rSrw=;
        b=McckbTlBL2zpTCo/ecPVM/eQzmuhA2W0Kp8KcD/gF6u9RE03Mv89wpJYDesDAI2OL+
         m0eTmpEj7GcY+qVsRfu1r1E3SVIz8CwtgVnyC8wvFld7spvfW6Pgo4/ToiaDlcjyDfz0
         m9uawZxCPquO04JF7aXqkyLg/H7r7KmW9SbsDXOeg1DzYo5Npaog5dxDQTpAFMgHMh2g
         VsqKPXPBw6wWvyokIGBcslv1YA1Z/p4ugq0bjhzsYjVLcSg8B+Fb8STbMl5ToFI/JPug
         WBrqOCuRaGN7ZDXu7u5//rX2aeBi35CBKjFXHpX3YSpwbIFRLvxOattaRokPVEuku0+x
         Bamw==
X-Gm-Message-State: AOAM533C4OkbXl+ORsb2wBxcE3ssmzq4WjSTd8OG1tkFEUk07qPn/p2G
        T0NaqnhHcKBWd+LMVJ/3VsM=
X-Google-Smtp-Source: ABdhPJwMbXxUuqcurgSgd+NrSrEoSF1T1WteKseSxb+eBzALga+OLp9Dg4by6Zos47iHcY2xYstWYw==
X-Received: by 2002:aa7:dc49:: with SMTP id g9mr13891070edu.60.1616755383332;
        Fri, 26 Mar 2021 03:43:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b4sm3663556eja.47.2021.03.26.03.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:43:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     jost.schulte@tutanota.com
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Configure default merge message
References: <MW_aJot--3-2@tutanota.com> <xmqqk0pwxqvt.fsf@gitster.g>
 <87a6qsourb.fsf@evledraar.gmail.com> <MWhDNa_--3-2@tutanota.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <MWhDNa_--3-2@tutanota.com>
Date:   Fri, 26 Mar 2021 11:43:02 +0100
Message-ID: <87v99enqkp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, jost.schulte@tutanota.com wrote:

> 25 Mar 2021, 03:02 by avarab@gmail.com:
>
>>
>> On Wed, Mar 24 2021, Junio C Hamano wrote:
>>
>>> jost.schulte@tutanota.com writes:
>>>
>>>> Hello all,
>>>>
>>>> I'm using git mainly with BitBucket repositories. When I pull from a r=
emote, the default commit message will be "Merge branch 'source-branch-name=
' of https://bitbucket.org/ <https://bitbucket.org/jibbletech/jibble-2.0-cl=
ient-web>repository-name into destination-branch-name".
>>>>
>>>> I'd like to configure git to omit the "of https://bitbucket.org/reposi=
tory-name" part. How can I do that?
>>>>
>>>> Regards
>>>> Jost
>>>>
>>>
>>> =C3=86var, is this something we recently made it impossible with 4e1683=
33
>>> (shortlog: remove unused(?) "repo-abbrev" feature, 2021-01-12), or
>>> is there more to it than resurrecting that "feature" to do what Jost
>>> seems to want?
>>>
>>
>> Perhaps I'm using it incorrectly, but I don't see how that repo-abbrev
>> feature ever resulted in the insertion of this munged content into the
>> actual commit object.
>>
>> The shortlog examples of "..." in 4e168333 are of shortlog's output
>> being modified on the fly. Not of them being inserted into commits.
>>
>> You can run "git merge" with "--log" which says it inserts "shortlog"
>> output. So I thought that maybe lines that were not the first "Merge
>> ... into" line in the message could have gotten munged in this way
>> before my change.
>>
>> But I don't think that happened either, and reverting 4e168333 and doing
>> a merge --log locally with e.g. "# repo-abbrev: branch" does not munge
>> the string "branch" in either the subject or the body, it's retained,
>> e.g.:
>>=20=20
>>  commit 02c864e58da (HEAD)
>>  Merge: 353c73510dc c6d63de00ff
>>  Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>  Date:   Thu Mar 25 03:00:21 2021 +0100
>>=20=20
>>  Merge branch 'to-merge' into HEAD
>>=20=20
>>  * to-merge:
>>  Merge this branch blah blah
>>=20=20
>>
>> That's because "merge" never used the munging.
>>
>> If you look at the code in 7595e2ee6ef (git-shortlog: make common
>> repository prefix configurable with .mailmap, 2006-11-25) when this
>> repo-abbrev feature was first added the "merge" would use
>> builtin-fmt-merge-msg.c to format the "shortlog", which implemented its
>> own function to do so, and didn't use the mailmap.
>>
>> As to Jost's question. I think the way to do this is to use
>> fmt-merge-msg, see 2102440c17f (fmt-merge-msg -m to override merge
>> title, 2010-08-17) for an example.
>>
>> That seems like it would also be simpler than Jeff King's suggestion in
>> the side-thread in <YFvAJU3Euxhjb+uw@coredump.intra.peff.net>.
>>
>
> Thank you for the detailed explanation. Where can I see the commits
> that you mention?

[It's good practice on this mailing list not to top-post]

4e168333 is a commit in your copy of the git.git repository.

The 02c864e58da, 353c73510dc and c6d63de00ff are just something that was
part of a throwaway experiment I ran locally.

I created two branches based on git.git's 238803cb409 (the commit before
4e168333), one added a repo-abbrev line to .mailmap, the other had a
string in the subject/body that would match that repo-abbrev.

So the merge shows that the "branch" string was not replaced with "...".

