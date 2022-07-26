Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE802C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 18:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiGZSrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiGZSrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 14:47:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9A20188
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:47:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i13so9640204edj.11
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tHgSjxTG/ZZJO4NttCW/rW4QOj7qNyyZ6PCRizRCpWk=;
        b=PsBilXFzkTfyQ8TkLzP3RYUc8xDWIKoU/cdBzo25MOWFhjZGV8N3imnketxrzwU1WW
         aTpn/SWZxjgt+zVwXPM5KuUN5ru1oNq+UUSDKGb4pLzFPow9RxHbJpKncbP6kO0ELnqi
         6uYd6sEBWCaizvArULrQ5Ol+sCnFwDP8yoOM2QTZH//PzWk2JXHCZNf8TatEO5WWmRFi
         QpUDnUoWdJzyBrgPccY7xuN1RX3BQM1Zdmh+97cb5Hdb7zG2FmxvFm0kSwYuguxuPBCz
         CFqZsSYbjwzORG0/nZ4gRb4nfGN3t0Nn6W26NX87TDRGhQG1Pu1fRgaoqq4VXtcC4SDJ
         dwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tHgSjxTG/ZZJO4NttCW/rW4QOj7qNyyZ6PCRizRCpWk=;
        b=Gf0SDY2K9+jJD0F8Qjtypj4XrlxSD/a4sAjUhB7SoRPzjQ3L9xlwTf6mBQ11DRO5H+
         6zcE/wHD8IsEd/WE+/35AJ0ZIU6NIbTRwqwpPGD1vW0jfs0UCgBnYAuA88YnAhFIbHor
         eVPZyOhphfQ+/izZclAP1PxKlSdvQuZqX2R9HW328rQ/U86ur+25RZYUmgLSPuBNbjq/
         JApCINGfpyCFvdy5Ei7wJuSPpJYdCEvWUsk8FtVoPPKIGLt5oYTR+3Yf39tuLs41kSSB
         CQ2wiWYfqmDfAiVwBreloiCysoYIaUuDJnNrAETv4AgccB9fMg6juExZJwfj8Rt1JJQ9
         syOg==
X-Gm-Message-State: AJIora+So0H/c5RshUidk4rtU+IZmNtcrY8M9i+DECS8GH/nP4YPHxhp
        USt1jEotGVQW2KCAJFNIs6A=
X-Google-Smtp-Source: AGRyM1sg0BLb1Wj7+FiyrHeczeVlpoAr8LPjwwDnruiEMT8frWnkOFftqqsupmju1Yjb+3ZG53v+ZQ==
X-Received: by 2002:a05:6402:4386:b0:43b:e989:25a1 with SMTP id o6-20020a056402438600b0043be98925a1mr13852743edc.283.1658861222419;
        Tue, 26 Jul 2022 11:47:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b006fe9f9d0938sm6812351eja.175.2022.07.26.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:47:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGPa8-006EJZ-UV;
        Tue, 26 Jul 2022 20:47:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
Subject: Re: [PATCH 0/3] log: create tighter default decoration filter
Date:   Tue, 26 Jul 2022 20:19:40 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <220726.86tu73ncf8.gmgdl@evledraar.gmail.com>
 <c3b14045-01a1-e207-a60d-2e3290ab8001@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c3b14045-01a1-e207-a60d-2e3290ab8001@github.com>
Message-ID: <220726.868rofn23f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee wrote:

> On 7/26/2022 10:44 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Jul 26 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> This was previously reduced by adding the log.excludeDecoration config
>>> option and modifying that config in git maintenance's prefetch task (to=
 hide
>>> refs/prefetch/*). I then followed that pattern again for the bundle URI
>>> feature [1], but this caught some reviewers by surprise as an unfortuna=
te
>>> side-effect. This series is a way to roll back the previous decision to=
 use
>>> log.excludeDecoration and instead use tighter filters by default.
>>>
>>> As noted in the last patch, the current design ignores the new filters =
if
>>> there are any previously-specified filters. This includes the
>>> log.excludeDecorations=3Drefs/prefetch/ set by the git maintenance comm=
and.
>>> This means that users who ran that command in their repo will not get t=
he
>>> benefits of the more strict filters. While we stop writing
>>> log.excludeDecorations, we don't remove existing instances of it.
>>=20
>> Leaving aside the question of these magic refs, and if we need new ones
>> (e.g. refs/bundle/*) I have sometimes made use of out-of-standard
>> refspace refs.
>>=20
>> E.g. when I build git I create refs/built-tags/* tag object refs
>> (i.e. not in refs/tags/*), which is a neat way to get "git tag -l" and
>> the like to ignore it.
>>=20
>> But to still have it show decorated in logs (e.g. I'll see what my
>> "private" branch is at), and "for-each-ref --contains" still knows about
>> it.
>
> You also have the unfortunate UX of having the refs spelled out entirely
> ("refs/<special-place>/..." instead of "<special-place>/..." like how
> "refs/remotes/" is dropped from remote refs) and not having special color.
> But that's beside the point.

Whether that's unfortunate UX or not is debatable, since we expose the
"refs/" prefix explicitly in other parts of the UX, and e.g. "HEAD" or
"ORIG_HEAD" or whatever in in that "/"-relation to
"refs/heads/whatever", and not "heads/whatever".

E.g. try:

	mkdir .git/FOO &&
	git rev-parse origin/seen >.git/FOO/BAR &&
	git push origin FOO/BAR:refs/FOO/BAR

And then:

	mkdir .git/refs/FOO &&
	git rev-parse origin/next >.git/refs/FOO/BAR
	$ git rev-parse FOO/BAR
	warning: object-name.c:970: refname 'FOO/BAR' is ambiguous.
	[seen SHA1]
	$ git rev-parse refs/FOO/BAR
	[next SHA1]

I.e. we really do understand FOO/BAR as meaning .git/FOO/BAR, as opposed
to .git/refs/FOO/BAR. You really can't assume that you can strip a
"refs/" from a multi-level ref and not end up with ambiguities. It's
*not* the case that we just have the .git/<UPPER-CASE-HERE> and
.git/refs/* namespaces, and nothing else.

Are we *almost* there? Yes, I vaguely recall experimenting with trying
to get us 100% of the way (just locally, didn't make it on-list) a long
time ago, and there were some tricky edge cases, and we don't know who
in the wild is relying on it.

I think it would be interesting to explore getting there, but I don't
think eliding information on the display end like that would be the
right way to start.

Although to be fair e.g. "git for-each-ref" excludes these entirely, but
that's a ref-filter.c specific edge-case, per the above try it on
e.g. "git push", you'll find that you can push one or the other.

I think I was poking at this at the time because I wanted to have "git
show head" mean the same as "git show HEAD", or at least for us to start
enforcing the rule that thou shalt not use refnames that are head, HeAd
or whatever mixed-case version we have of our magical all-upper special
refs. This matters because you have commands like "git rev-parse head"
that'll work on case-insensitive FS's that promptly fail on
case-sensitive FS's.

>> Now, that's a rather obscure use-case, and I suspect other "special
>> refs" are similarly obscure (e.g. GitLab's refs/keep-around/* comes to
>> mind).
>>=20
>> But I think this change is going about it the wrong way, let's have a
>> list of refs that Git knows about as magical, instead of assuming that
>> we can ignore everything that's not on a small list of things we're
>> including.
>>=20
>> Wouldn't that give you what you want, and not exclude these sorts of
>> custom refs unexpectedly for users?
>
> Instead of keeping track of an ever-growing list of exclusions, instead
> making a clear list of "this is what most users will want for their
> decorations" is a better approach.
>
> Users who know how to create custom refs outside of this space have the
> capability to figure out how to show their special refs. My general ideas
> for designing these kinds of features is to have a default that is focused
> on the typical user while giving config options for experts to tweak those
> defaults.
>
> You're right that this series perhaps leaves something to be desired in
> that second part, since there isn't an easy _config-based_ way to enable
> all decorations (or a small additional subset).

Yes, but this is just side-stepping the issue. Your X-Y problem is that
you want to exclude certain refs that we're specifically creating.

I think that's fair enough, but I don't see why we're not specifically
excluding just those then.

It'll just be these bundle refs, filter refs, or whatever other magic we
want excluded. Why would we extend that to refs that we don't know about?

It seems like a safe assumption that if we don't know what it is we
should include it.

Both because that's what we do now (least chance of breaking workflows
in the wild), and because the entire point of the feature is to display
the log in relation to points on the ref namespace. If we don't *know*
that they're meaningless let's leave them out of the exclusion, no?

I'd also think that we'd want to consider this holistically. I haven't
checked, but aside from HEAD (which I think is the only special-case,
but maybe I'm wrong) isn't there a one-to-one mapping between what we'll
show in decorations, and what "git for-each-ref" diplays?

>>> I'm interested if anyone has another way around this issue, or if we
>>> consider adding the default filter as long as no --decorate=3Drefs opti=
ons are
>>> specified.
>>=20
>> I think the resulting UX here is bad, in that we ship hardcoded list of
>> these if you don't specify the config in 2/3. So I can do:
>>=20
>>       -c log.excludeDecoration=3Dthis-will-never-match
>>=20
>> To "clear" the list, but not this:
>>=20
>>       -c log.excludeDecoration=3D
>
> The thing that I forgot to do, but had considered was adding a
> --decorate-all option to allow clearing the default filters from the
> command line. You can already do "--decorate-refs=3Drefs" to get everythi=
ng
> (except HEAD).

...and some other exclusions, e.g. it won't show ORIG_HEAD even with
--decorate-refs=3DORIG_HEAD, but perhaps I'm doing it the wrong way...

> As far as config goes, we could also create a log.includeDecoration key,
> but we'd want to consider it to populate the same part of the filtering
> algorithm. Similar to having any instance of log.excludeDecoration, this
> would clear the default list. To get all decorations again, you could add
> this to your config file:
>
> 	[log]
> 		includeDecoration =3D refs
> 		includeDecoration =3D HEAD

If we're considering new config I'd think anything that worked like this
instead would be *much less* confusing:

	some.config =3D refs/*
	some.config =3D HEAD

I.e. per the above your HEAD will presumably either match HEAD/BLAH, or
treat "refs" magically as "refs/" and not "refs".

Now, I don't think you can delete .git/HEAD and/or make .git/refs a file
and still have a functioning repository, but the same general rule
applies to "FOO" v.s. "FOO/BAR" and "custom-refs" or whatever.

We use that wildcard syntax unambiguously for the refspec matching, we
could just use the same machinery to match this.

> Alternatively, we could instead create a "filter default" option such as
> "log.decorateFilter =3D (core|all)" where "core" is the default set being
> considered by this series, and "all" is the empty filter.

Sure, for any key that takes N arguments we could have some way to say
"if you do this it's the same as enumerating these X values", as long as
it's not ambiguous whether you mean a special "aggregate label" or a
name of your own...
