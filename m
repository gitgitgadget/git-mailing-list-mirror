Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91538C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBFWRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBFWRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:17:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60816126DD
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:16:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so38464560ejc.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAVEPwDJ23fk2UQlYVnzs24mIS3j527QW34ujlNeAKQ=;
        b=mtM9SbgcLIWJ4JRVaagsv4Twfg+d1+Tl7v6wfgKbWKriK6Ghf6gemRVuQR0gJmHrwL
         uKf7+n5JtJw1+XPxO/Z69BvrPPYsrGW9wWcvNtjHdy0oQFDknAURIcuLSP0FrodEYREy
         ZysjU3ZcEhK/4FrKNdYqlYj+dkyNAZlOtbBVjnZtAcxx8+TyMoRd3WFCkaXmfkXQfch+
         Hxwi9iPazzlA9FY8dBQRJLcFfPMavSs+6L7kee6KU4P25t1CbQaNWMDFWYhtqFVLWUu6
         3/9L62LqYE7L+fkdtxQxyb/WWiV2ip4tBoFmKhEghx8cQ/gwItlV/IpSqg4KxIKcUZP7
         6Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAVEPwDJ23fk2UQlYVnzs24mIS3j527QW34ujlNeAKQ=;
        b=ilRPbWhvfQjyTq2zTrZP0/60qta71mlZfusPSlTq7ue47Uxp0rhVPTi/XfKDvs736/
         Jm3UN6svQJdHnhENcPatNS1arcTPgdC+mS9f3hH/sTwataW8SI+Ml+5YEQdVSZlbfSko
         ylK2ONyYHrgz8bZpnP32dl8u6Ov0LXWCM0wvyFoyQkh2iuBwHkU6Cc4Oc1Wbn/uPqPbT
         F34k7NdcI0F9a+C4nbvyOm/LQqZRcN+zk4NIZBStIa7f6wnZZoddlaiYULrgVyvrVdFt
         XuMZwfUWnH12aQVwo6aC9vlS7FNmyh4fTmN30dKwtHXwUioeMyiOu893XWDfAmxZ2yLi
         hBxA==
X-Gm-Message-State: AO0yUKXMfVQDK9KlSP1e8bAupk/6Sw/LV+AhI81uS0IpqTqMsUA2yvaK
        GSkOB4IJk3XJVJhIPO76Wj89bXXS8yEYUjHq
X-Google-Smtp-Source: AK7set+9JPXibIbFZKB3jYUvYdpmIsucSBXKQbfnQpkr3sA9rp6qIXsLpP6WsN2HBwcCVH8eQ7vfnA==
X-Received: by 2002:a17:906:b312:b0:88f:8ef7:c71e with SMTP id n18-20020a170906b31200b0088f8ef7c71emr1034118ejz.14.1675721817752;
        Mon, 06 Feb 2023 14:16:57 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906b30500b007aea1dc1840sm5995257ejz.111.2023.02.06.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:16:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP9nE-000YRC-2I;
        Mon, 06 Feb 2023 23:16:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: clarify multiple pushurls vs urls
Date:   Mon, 06 Feb 2023 22:55:11 +0100
References: <20230206195503.3113048-1-calvinwan@google.com>
 <230206.86k00u5ygg.gmgdl@evledraar.gmail.com>
 <CAFySSZCO7M8bm8Cc97x7MpZYHd0qWwRHF_YRDmw1rryF6Q7dnQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAFySSZCO7M8bm8Cc97x7MpZYHd0qWwRHF_YRDmw1rryF6Q7dnQ@mail.gmail.com>
Message-ID: <230206.86pmam4exz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Calvin Wan wrote:

>> > Defining multiple `url` fields can cause confusion for users since
>> > running `git config remote.<remote>.url` returns the last defined url
>> > which doesn't align with the url `git fetch <remote>` uses (the first).
>>
>> I'm certainly confused, I had no idea it worked this way, I'd have thought it was last-set-wins like most things.
>>
>> From a glance fb0cc87ec0f (Allow programs to not depend on remotes
>> having urls, 2009-11-18) mentions it as a known factor, but with:
>>
>>         diff --git a/transport.c b/transport.c
>>         index 77a61a9d7bb..06159c4184e 100644
>>         --- a/transport.c
>>         +++ b/transport.c
>>         @@ -1115,7 +1115,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>>                 helper = remote->foreign_vcs;
>>
>>                 if (!url && remote->url)
>>         -               url = remote->url[0];
>>         +               url = remote->url[remote->url_nr - 1];
>>                 ret->url = url;
>>
>>                 /* maybe it is a foreign URL? */
>>
>> All tests pass for me, and it's selecting the last URL now. I can't find
>> any other mention of these semantics in the docs (but maybe I didn't
>> look in the right places).
>>
>> So is this just some accident, does anyone rely on it, and would we be
>> better off just "fixing" this, rather than steering people away from
>> "url"?
>
> I should've mentioned running `git remote -v` on a config with multiple urls
>  shows the correct fetch url, so functionally everything is working as
> intended -- just needs a doc update somewhere.

Ah, yes, it seems to prefer the first configured one, whether that's
what anyone intended (and should we use last configured?) is another
matter.

But in any case, figuring that out and having a test in-tree that fails
if you pick the first or last of the list (depending on what we go for)
would be most welcome...

>> Surely if there's confusion about the priority of the *.url config
>> variable we should be documenting that explicitly where we discuss "url"
>> itself (e.g. in Documentation/config/remote.txt). Just mentioning it in
>> passing as we document "pushUrl" feels like the wrong place.
>>
>> But I still don't quite see the premise. "git push" has a feature to
>> push to all N urls, whether that's Url or pushUrl.
>>
>> When I configure it to have multiple URLs it pushes to the first
>> configured one first, if the source of the confusion was that it didn't
>> prefer the last configured one first, shouldn't it be doing them in
>> reverse order?
>>
>> I don't think that would make sense, but I also don't see how
>> recommending "pushurl" over "url" un-confuses things.
>>
>> So why is it confusing that "fetch" would use the same order, but due to
>> the semantics of a "fetch" we'd stop after the first one?
>
> I agree with you now that updating the documentation in
> Documentation/config/remote.txt is the ideal way to go about this, but

Aside: I actually think near where you made the change in
Documentation/urls-remotes.txt is probably better, in remote.txt we just
point to git-fetch.txt or git-pull.txt etc., which in turn include that.

It just seems we'd need a short blurb about how URLs are selected, we
prefer the first one, and for fetch it's always "stop at the first", and
for push "push to all, from first to last".

I may have gotten that wrong, but that's my current understanding from
looking at it briefly.

> I'll mention what my original thought process was:
> If a user wants one url to push/fetch to, then he defines 'url'
> If a user wants to push to multiple urls, then he can either define
> multiple urls or pushurls (one of the pushurls can be the same as the url).
> But if a user has say url #2 and #3 defined, they act as pushurls anyways,
> so defining them as such removes any speculation as to what else they
> could do (and also clears up the confusion when running
> `git config remote.<remote>.url`).

I'm coming away from this with the impression that we should almost
never recommend "pushUrl", not that it's worthwhile to use it to solve
this ambiguity.

Trying this out, given a config like:
	
	[remote "avar"]
	        url = git@github.com:avar/git.git
	        url = git@github.com:avar/git1.git
	        url = git@github.com:avar/git2.git

I'll get:
	
	$ ./git remote -v|grep avar
	avar    git@github.com:avar/git.git (fetch)
	avar    git@github.com:avar/git.git (push)
	avar    git@github.com:avar/git1.git (push)
	avar    git@github.com:avar/git2.git (push)

So, the semantics of "url" is that the first one is always the fetch,
there's no such thing as multiple fetch URLs, and the push URLs are the
list of all "url"'s.

But now let's change that to:

	[remote "avar"]
	        url = git@github.com:avar/git.git
	        url = git@github.com:avar/git1.git
	        pushUrl = git@github.com:avar/git2.git

Which gives us:

	$ ./git remote -v|grep avar
	avar    git@github.com:avar/git.git (fetch)
	avar    git@github.com:avar/git2.git (push)

So, by defining a "pushUrl" all subsequent URLs in "url" have been
shadowed.
	
Maybe that was considered at the time, but it wouldn't surprise me if
that's a blindspot in the original "pushUrl" patch (203462347fc (Allow
push and fetch urls to be different, 2009-06-09)), i.e. shouldn't we at
least warn on "push" now or somewhere else about the useless second
"url"?

So, back to "pushurl". It seems to me that the only real use-case for it
is the case where the URL really must by different in the case of
"fetch" and "push", which I daresay is increasingly rare these days (but
used to be more common when dumb http read + ssh write or whatever was
more common).

Whereas the more common case is just wanting to fetch/push from/to
github.com, and also wanting to mirror to gitlab.com or whathever.

In that case using "pushUrl" requires you to duplicate the "fetch" url,
whereas just having multiple "url" sections without "pushurl" does the
same thing without the duplication.

