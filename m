Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE3C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 11:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiGSLmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiGSLmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 07:42:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB37F3F304
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 04:42:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l23so26666719ejr.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aIXC4LanwAn0BxKty3hRbWxThvE35RC7oKtkz7kB97c=;
        b=PhhyKcQQ/+MXXLKaT0mhseQwLfxWaXHEkpQDeyfp3biXdnLWa9BJnARzkmteP9whR1
         hNRr/yHCHnxzTVaVXX2JRQ/UNBq2ohmvcNFJmmZm+10rO/OAlCslRF+zfJ2nugbPT2eB
         EXBevz7T9+BbstOWOLL9DBXk6lgpnSRFoeVK17+PbySGY0de7f0geZxjoqMK8jqmMnb/
         ftBp2T3Nl0utIm5mV8m0PI8Y3BOZXNePfe+RgvH8Kh+KUYNrnt+iihLiueNZa60r2BuW
         hYAZD2gRvvmxBKEpo6c0sqF/L3wSdqpGkbrcNRkNbzBqmU4uVo4vMQ46SLORglJBl3Xy
         hT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aIXC4LanwAn0BxKty3hRbWxThvE35RC7oKtkz7kB97c=;
        b=UfRliiTPqNZTJoVmNkqs804/r7x8iVBAXdqJvRBX09bApx02w0lo3v0znetOrr533o
         z7Q5jN9oE6XMcO5CtfnBQT9h7mU1eQESgQuT2jdJ/sbWvDxgz5zVYm8LUaWv3+P+t2i1
         sQOYrF9dyDSdxGWNfTNE+1KjICRUYigNHIfS90iIvyMo263VpVB6V6j0vpB1Fj8//rF9
         UacEke1rt0QFQ9fTfQkHvguGtfTTtuVCiKTnXMw22JfrFpfTLkeKbqfGCUGuXTgb5/A/
         yDSv1uXU+JCr2MYB9gHxkWogDf9AYrCH5t2q4G1B/YmheSVsmBNSXrqLSsNZYOooRzDo
         Au7Q==
X-Gm-Message-State: AJIora9w7CIV7iFjAgs+KWMGHynWnShlmuikvs8BoNZnAshfv2cd20An
        g6/XAC+fh1l3QJw0B4Jt/Pq2BOaH+NN2rg==
X-Google-Smtp-Source: AGRyM1v33Jvqbe1lliqmMNMkRki7ExeB7SCXqYNyEyo/xS+44a+0h2cnZS0wBBgRHk5CYnz3Sv0OZw==
X-Received: by 2002:a17:907:7241:b0:72b:347b:17a1 with SMTP id ds1-20020a170907724100b0072b347b17a1mr31592310ejc.32.1658230934055;
        Tue, 19 Jul 2022 04:42:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sz20-20020a1709078b1400b0072b31307a79sm6566938ejc.60.2022.07.19.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:42:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDlcB-003cex-P2;
        Tue, 19 Jul 2022 13:42:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stephen Finucane <stephen@that.guru>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Date:   Tue, 19 Jul 2022 13:09:02 +0200
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <61333be26339440d9bae8f12fd1a4faeb5e68ab6.camel@that.guru>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <61333be26339440d9bae8f12fd1a4faeb5e68ab6.camel@that.guru>
Message-ID: <220719.86y1wpuy5o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, Stephen Finucane wrote:

> On Mon, 2022-07-18 at 20:50 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
>> On Mon, Jul 18 2022, Stephen Finucane wrote:
>>=20
>> > ...to track evolution of a patch through time.
>> >=20
>> > tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 l=
a the 'Change-
>> > ID' trailer used by Gerrit into git core?
>> >=20
>> > Firstly, apologies in advance if this is the wrong forum to post a fea=
ture
>> > request. I help maintain the Patchwork project [1], which a web-based =
tool that
>> > provides a mechanism to track the state of patches submitted to a mail=
ing list
>> > and make sure stuff doesn't slip through the crack. One of our long-te=
rm goals
>> > has been to track the evolution of an individual patch through multiple
>> > revisions. This is surprisingly hard goal because oftentimes there isn=
't a whole
>> > lot to work with. One can try to guess whether things are the same by =
inspecting
>> > the metadata of the commit (subject, author, commit message, and the d=
iff
>> > itself) but each of these metadata items are subject to arbitrary chan=
ges and
>> > are therefore fallible.
>> >=20
>> > One of the mechanisms I've seen used to address this is the 'Change-ID=
' trailer
>> > used by Gerrit. For anyone that hasn't seen this, the Gerrit server pr=
ovides a
>> > git commit hook that you can install locally. When installed, this app=
ends a
>> > 'Change-ID' trailer to each and every commit message. In this way, the=
 evolution
>> > of a patch (or a "change", in Gerrit parlance) can be tracked through =
time since
>> > the Change ID provides an authoritative answer to the question "is thi=
s still
>> > the same patch". Unfortunately, there are still some obvious downside =
to this
>> > approach. Not only does this additional trailer clutter your commit me=
ssages but
>> > it's also something the user must install themselves. While Gerrit can=
 insist
>> > that this is installed before pushing a change, this isn't an option f=
or any of
>> > the common forges nor is it something git-send-email supports.
>>=20
>> git format-patch+send-email will send your trailers along as-is, how
>> doesn't it support Change-Id. Does it need some support that any other
>> made-up trailer doesn't?
>
> It supports sending the trailers, sure. What it doesn't support is insist=
ing you
> send this specific trailer (Change-Id). Only Gerrit can do this (server s=
ide,
> thankfully, which means you don't need to ask all contributors to install=
 this
> hook if you want to rely on it for tooling, CI, etc.).

Ah, it's still unclear to me what you're proposing here though. That
send-email always (generates?) or otherwise insists on the trailer, that
it can be configured ot add it?

That send-email have some "pre-send-email" hook? Something else?

I'd think for projects that care about this they're likely to have a
centralized enough workflow that it can be checked on the remote side,
whether that's some sanity check on the applier's "git am" pipeline, or
a "pre-receive" hook.

>> > I imagine most people working with mailing list based workflows have t=
heir own
>> > client side tooling to support this while software forges like GitHub =
and GitLab
>> > simply don't bother tracking version history between individual commit=
s in a
>> > pull/merge request.
>>=20
>> It's far from ideal, but at least GitLab shows a diff on a push to a MR,
>> including if it's force-pushed. I'm not sure about GitHub.
>
> GitHub does not. Simply piling multiple additional "fix" commits onto the=
 PR
> branch results in a less horrible review experience since you can maintain
> context, alas at the cost of a rotten git log. We don't need to debate th=
e pros
> and cons of the various forges though :)

Yes, I'm only mentioning it because it's worth looking at existing
"solutions" that are in use in the wild, however flawed those may be.

>> > IMO though, it would be fantastic if third party tools
>> > weren't necessary though. What I suspect we want is a persistent ID (o=
r rather
>> > UUID) that never changes regardless of how many times a patch is cherr=
y-picked,
>> > rebased, or otherwise modified, similar to the Author and AuthorDate f=
ields.
>> > Like Author and AuthorDate, it would be part of the core git commit me=
tadata
>> > rather than something in the commit message like Signed-Off-By or Chan=
ge-ID.
>> >=20
>> > Has such an idea ever been explored? Is it even possible? Would it be =
broadly
>> > useful?
>>=20
>> This has come up a bunch of times. I think that the thing git itself
>> should be doing is to lean into the same notion that we use for tracking
>> renames. I.e. we don't, we analyze history after-the-fact and spot the
>> renames for you.
>
> Any idea where I'd find previous discussions on this? I did look, and the=
 only
> proposal I found was an old one that seemed to suggest including the Chan=
ge-Id
> commit-msg hook with git itself which is not what I'm suggesting here.

At the time I was punting on finding the links, and just working off
vague recollection, and hoping you'd go list spelunking.

But I since recalled some details, I think the most relevant thing is
this discussion about a "git evolve":

    https://lore.kernel.org/git/CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1=
QLHOs9fQ@mail.gmail.com/

Which I think you'll find useful, especially as mercurial has an
existing implementation. The wider context for that "git evolve" is (I
believe) people at Google who maintain Gerrit trying to "upstream" the
Change-Id.

Now, it hasn't landed in git.git, and it's been a few years, but going
through the details of why it fizzled out will be useful to you, if
you're interested in driving something like this forward.

There's also these two proposals from Eric Raymond:

	https://lore.kernel.org/git/20190515191605.21D394703049@snark.thyrsus.com/
	https://lore.kernel.org/git/20190521013250.3506B470485F@snark.thyrsus.com/

Which I'm linking to here not because I think they're viable, as you can
see from my participation in those threads I think what he suggested is
an architectural dead end as far as git is concerned.

But rather because it's conceptually adjacent (you could in principle
use nanosecond timestamps as a poor man's UUID), and much of the
follow-up discussion is about format changes in general, and if/when
those might be viable.

>> We have some of that in git already, as git-patch-id, and more recently
>> git-range-diff. Both are flawed in a bunch of ways, and it's easy to run
>> into edge cases where they don't spot something that they "should"
>> have. Where "should" exists in the mind of the user.
>
> That's a fair point and is of course what we (Patchwork) have to do curre=
ntly.
> Patchwork can track relations between individual patches but doesn't atte=
mpt to
> generate these relations itself. Instead, we rely on third-party tooling.=
 The
> PaStA tool was one such example of a tool that could do this [1]. I can't
> imagine a tool like Gerrit would ever work without this concept of an
> authoritative (and arbitrary) identifier to track a patch's identity thro=
ugh
> time, hence its reliance on the Change-Id trailer.

I haven't used Gerrit or Patchwork, so much of this is from ignorance on
that front, but I have spent a lot of time thinking about this in the
context of git in general.

I think as users of git go the git project itself makes very heavy use
of this, i.e. sequences of patches are substantially rewritten, split,
squashed etc. all the time, or even split into two or more sets of
submissions.

Having said all that I can't see how a Change-Id isn't a Bad Idea(TM)
for all the same reasons that pre-git SCMs file formats that track
renames explicitly were a bad idea.

I.e. yes you can come up with cases where that's "better" than what git
does, but they didn't handle splitting/merging files etc.

Similarly what happens when you have 3 patches each with their own
Change-Id and you split them into 4 patches. Is the Change-Id 1=3D1 or
1=3Dmany. I'm suggesting that you'd want a solution that can be many=3Dmany.

And also, that those many=3Dmany should be dynamically configurable and
inferred after the fact. E.g. range-diff will commits that are similar
enough that two authors with no knowledge of each other independently
came up with.

I think that range-diff is still lacking in a lot of ways, in particular:

 * It matches entire commits (log + diff) on a similarity score, I've
   often wanted a way to "weigh" it, so e.g. a matching hunk would have
   3x the matching score of a matching commit message.

   Now it often "gives up", you can give it a higher --creation-factor,
   but that's "global", so for a large range you'll often start
   including irrelevant things as well.

 * It only does 1=3D1 attribution, and e.g. currently can't find/represent
   a case where a commit with 3 hunks got split into two commits, with 2
   and 1 hunks, respectively. It'll (usually) show a diff to the new 2
   hunk commit, but the "new" 1 hunk will be shown as new.

   We could continue to drill down and find such "unattributed" hunks.

> Perhaps we could flip this on its head. What would be the _downsides_ of
> providing a persistent, arbitrary identifier on a commit similar to Autho=
r and
> AuthorDate fields? There's obviously some work involved in implementing i=
t but
> assuming that was already done, what would break/be worse as a result?

That "Repository formats matter", to borrow a phrase from a classic post
about git[1]. Once you provide a way to do something it will be used,
and when that something has inherent limitations (think SCM rename
tracking) used to the exclusion of others.

You can't provide something like that as an opt-in and "upstream" it
without it inevetably trickling into a lot of areas of Git's UX.

To continue the rename example, now you can just re-arrange your source
tree and not worry about micro-managing it with "git mv" (in the "svn
mv" sense), git will figure it out after the fact.

That's a sinificant UX benefit, we can provide a *much simpler* UX as a
result.

What would be the harm of an optional "rename tracking" header? After
all the heuristic sometimes "fails".

The harm would be that if you really wanted to lean into that (even
optionally) you'd be forced to add that to all sorts of tooling, not
just the cheap convenience that is "git mv" currently.

Likewise everything from "cherry-pick" to "rebase" to "commit" would
inevitably have to learn some way to know about, carry forward and ask
the user about Change-Id's and their preservation. Don't you think so?

Otherwise they'd be much too easy to lose track of, and if they only
reason we did all that is because we didn't think enough about the "work
it out after" approach that would be a bad investment of time.

But I may be wrong about all of that, I think one thing that would
really help clarify this & similar proposals is if people pushing it
forward came up with some basic tests for it, i.e. just something like
a:

    series-v1/
    series-v2/

Where those two directories would be the "git format-patch" output (or
whatever) of two versions of a series that Gerrit or Patchwork are now
managing, along with some (plain text?) manual mapping of which things
in v1 correspond to v2.

We could then compare how that manual attribution performs v.s. trying
to find which things match (range-diff) afterwards.

1. https://keithp.com/blog/Repository_Formats_Matter/

