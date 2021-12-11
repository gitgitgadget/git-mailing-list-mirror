Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A1C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhLKC2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbhLKC2W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:28:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AAC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:24:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id e3so36006977edu.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B3GJYI6+CiFIb61iIcfLQBbw9aAePMF+NQ2TivivLp4=;
        b=eFUWdClCkqrcwgvJzCm/1Ztnx9Oc9kqYUfHAQYpahP4boBL+OZ3HC7j1ln2pwf8JTy
         lwQ01mZ9iMCJbzFrU23dSfiEVnICL0pGmiMLxjgMDBIn9pALX7/pQ7OkRaSLMxmKtUEa
         /b2MBP7dEyk52AZVnsxM9bOuOJSzOZ+9mDGYM19l1oBwV/itlRNFsO460U3kIqAbjxGj
         XHJk1AKHrH6DzchuocSA1chB+eTIQkrEHuMny4q+6fCiCm/hXp4uv3Ra974IXy8F+HZj
         W6U5IsWDHIupzHgbiYVA6JB1NYZLi7dA6EOEgCQLpE7LNbyQ5alYF3SkIH2HefsKrKJY
         Pprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B3GJYI6+CiFIb61iIcfLQBbw9aAePMF+NQ2TivivLp4=;
        b=goOyVdf5BXDq1JOCu5l0Pj/Bw1ijYiVK0md3Ri+ZtiOgDEuOa+c0x/RrsUKsI0NJvD
         2UdxHVvHv5KsNKAID7FsToys/yvvVOVX0Iyagw+hX7mQ6BVYqLLHo7sYLPJtfVn6AuKC
         0QmKbQ2XBP/eSUUZbLJBBi1UiP8sZYTuwpdTV2cNZ9Yzm2fFWHoYJhA+j0ku2w3Uh60p
         kBcvDx2FrVxfI2WCQHBuSzL6aGsKIWkjvlPk3St9mDIiLeU/RvbVHDPndOBCCb8O9ADa
         A1YKWcVcE2Kg6SnX8zVEM9HYPg1+iE4FUpVj6IGObo2VY7WFb4GOIDRUv5zUlQ37Llbl
         HYKA==
X-Gm-Message-State: AOAM531SZAXqud0lYOL6VDQpN42sr0EALLbZt4B39lN11w4mmGXGotPY
        9nDMUbn/6nB6mFZgI2v4/F1ix/71oDzTDg==
X-Google-Smtp-Source: ABdhPJyIM6af9m3xZJWtAZot1AIkFWQopniQ11ifmuFjr4SCPDy5nv4MHgdSmXiDMTL7qq4tv47Fiw==
X-Received: by 2002:a05:6402:908:: with SMTP id g8mr44123483edz.59.1639189484913;
        Fri, 10 Dec 2021 18:24:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m25sm2248743edj.80.2021.12.10.18.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:24:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvs44-000R1q-2f;
        Sat, 11 Dec 2021 03:24:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Date:   Sat, 11 Dec 2021 03:18:32 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YbKHBsl7w1uNhLb6@google.com>
 <kl6l35n19w97.fsf@chooglen-macbookpro.roam.corp.google.com>
 <211210.86ilvxe09w.gmgdl@evledraar.gmail.com>
 <kl6lzgp88ixb.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6lzgp88ixb.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <211211.86ilvvc1zn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Dec 09 2021, Glen Choo wrote:
>>
>>> Josh Steadmon <steadmon@google.com> writes:
>>>
>>>>> > @@ -121,11 +168,18 @@ int install_branch_config(int flag, const cha=
r *local, const char *origin, const
>>>>> >  	advise(_(tracking_advice),
>>>>> >  	       origin ? origin : "",
>>>>> >  	       origin ? "/" : "",
>>>>> > -	       shortname ? shortname : remote);
>>>>> > +	       remotes->items[0].string);
>>>>> >=20=20
>>>>> >  	return -1;
>>>>> >  }
>>>>>=20
>>>>> When there is more than one item in remotes->items, this advice is
>>>>> _technically_ incorrect because --set-upstream-to only takes a single
>>>>> upstream branch. I think that supporting multiple upstreams in
>>>>> --set-upstream-to is a fairly niche use case and is out of scope of t=
his
>>>>> series, so let's not pursue that option.
>>>>>=20
>>>>> Another option would be to replace the mention of --set-upstream-to w=
ith
>>>>> "git config add", but that's unfriendly to the >90% of the user
>>>>> population that doesn't want multiple merge entries.
>>>>>=20
>>>>> If we leave the advice as-is, even though it is misleading, a user who
>>>>> is sophisticated enough to set up multiple merge entries should also
>>>>> know that --set-upstream-to won't solve their problems, and would
>>>>> probably be able to fix their problems by mucking around with
>>>>> .git/config or git config.
>>>>>=20
>>>>> So I think it is ok to not change the advice and to only mention the
>>>>> first merge item. However, it might be worth marking this as NEEDSWORK
>>>>> so that subsequent readers of this file understand that this advice is
>>>>> overly-simplistic and might be worth fixing.
>>>>
>>>> Sounds like we should just have separate advice strings for single vs.
>>>> multiple merge configs?
>>>
>>> That sounds like a good idea if it's not too much work. Otherwise, a
>>> NEEDSWORK is still acceptable to me (but that said, I'm not an authority
>>> on this matter).
>>
>> We haven't used Q_() with advise() yet, but there's no reason not to:
>>
>> 	advise(Q_("fix your branch by doing xyz",
>> 		  "fix your branches by doing xyz",
>>                   branches_nr));
>
> Neat, that should do it in most cases. I think this one is a little
> trickier because the plural advice messages requires constructing a
> list, e.g.
>
> Singular:=20
>   "\n"
>   "After fixing the error cause you may try to fix up\n"
>   "the remote tracking information by invoking\n"
>   "\"git branch --set-upstream-to=3D%s%s%s\"."
>
> Plural:
>   "\n"
>   "After fixing the error cause you may try to fix up\n"
>   "the remote tracking information by invoking\n"
>   "\"git config --add my_new_remote remote_name\"
>   "\"git config --add my_new_upstream1 upstream_name1\"
>   "\"git config --add my_new_upstream2 upstream_name2\"
>
> But perhaps this is not too hard since you've already included examples
> of how to format lists of strings [1]
>
> [1] https://lore.kernel.org/git/211207.86mtlcpyu4.gmgdl@evledraar.gmail.c=
om

You don't need to use the plural facility for that sort of
message.

Plurals in translated messages are specifically for the case where you
need to compose a sentence like:

    I had %d glasses of water with breakfast

But it's not needed for a message that can be rehrased as a heading
followed by a list of 1 or more items, e.g.:

    Things I've consumed in liquid form during breakfast this week:
    - Water
    - Tea
    - Coffe

If that list stopped at "Water" it would be OK. Every language has some
way of referring to items on a list in general terms, without knowing if
that list is composed of only one item, two etc.
