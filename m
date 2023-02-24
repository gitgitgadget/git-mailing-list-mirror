Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F576C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 07:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBXHGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 02:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXHGs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 02:06:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493C5E85E
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 23:06:28 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b10so4437920ljr.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 23:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww1UFp/DIGOtWF4K4aZJAU1btipHr8KFA/h5Xs6NqNg=;
        b=hev5ABQOPOcpMqrMEbtAVZqRK3nBJAYLbB7O/659Zb3ZtBMdtWag9SSlnqbTNwUS6w
         ZKYBdeTvHQVL4gGQtCzATx1FK5DDCrT44ZtY5yRDkEI9CSYoTqu1ywQLOE9uemhTHDPF
         latSQsMOT7t8kB9IJfId0kJ7FsqPHisnlBcaLHbJU0f+tC+T2fv4A7XUIHJtUh3PTwH5
         1aYMphv1cYSExvXpZq7Rt0mhMyab196RI0zSwUf4MGOH7cZqlw3OO/mNvndy3B/q9b8R
         alODAHGJA78G4ccwbkP1k+VgVRihznfSPcNByBJRy+NbAdm8yiXSM9wpsQ4ULFaUluB3
         IyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww1UFp/DIGOtWF4K4aZJAU1btipHr8KFA/h5Xs6NqNg=;
        b=QQXysKJdQz5PieUpyvq52mlpm2BBQPlc6YJQ/A/Nuup4GlWExxf7LoSIeHxTekA8tW
         M+T2BSqiTlB7Y5Nrcj4rMWD0WUS7rgtIEYr9YepMxUOYAuQHzO2YBFGvUjFyZ7+1O4C4
         pSxw1b/TFEjl7PC0ctdEjv64yGnGZ06eeF3N4SgvaNIPts+5zt1vJWslxs3W83+jdW1F
         K4fke3QxSFVlR4fS07z731/Sc4Tlv00mGzxEwC/SqSUiSjZgq9xYM8MLy+BQu4H7+Awn
         pYPADq+dU3finSeqLnpbs2KMdlaJgg8rKsySTqLfkd8iS6AcpwmRyMJME7c+1DSMnAXu
         RSoQ==
X-Gm-Message-State: AO0yUKVST8KdZ4/Kkzy0TznD64w0xDO8elUVZiLZUHU8JK2Y9RDkyoSB
        dQ+ExOWagJ3re5ODUgIkZ9Gu6yput+40FuFx6rv6DsgxrRLeBw==
X-Google-Smtp-Source: AK7set/sHvoEeO0+rTJRVDiBs4a6A5FJrb9dX68UieFOvsTLhAK8jD1c1X2tuZSaix05lCAUldfDFwDUbsHCBclp/co=
X-Received: by 2002:a2e:b5d0:0:b0:292:f86f:4315 with SMTP id
 g16-20020a2eb5d0000000b00292f86f4315mr4513480ljn.6.1677222386289; Thu, 23 Feb
 2023 23:06:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com>
 <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com> <CAPMMpohrEjZQwRbRAZfPfArNxEBDBzq8yJfsOAerhQ0qr6sWjQ@mail.gmail.com>
In-Reply-To: <CAPMMpohrEjZQwRbRAZfPfArNxEBDBzq8yJfsOAerhQ0qr6sWjQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 23:06:13 -0800
Message-ID: <CABPp-BGqAxKnxDRVN4cYMteLp33hvto07R3=TJBT5WubJT4+Og@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 7:01 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Mon, Feb 20, 2023 at 6:21 PM Elijah Newren <newren@gmail.com> wrote:
> >
[...]
> > Obviously, your users are ignoring that advice, and feeling pain.
>
> "Ignoring" is a strong (and in my opinion, strange) term to use here.
> They are *not seeing* that advice, and I think you can reasonably
> assume that many, or most, users will not see almost any of the advice
> you can possibly offer. As software designers I believe we all strive
> to set things up so you need to learn as little as possible to use
> something usefully, and safely.

Yep, fair enough.

> > We could just bite the bullet and start
> > explaining, but these caveats and gotchas are completely incidental to
> > the implementation, and are in no-wise fundamental to the desired
> > operation.
>
> We already *do* explain, right? We've already retired --preserve-merges!

But we didn't suggest either `--preserve-merges` or `--rebase-merges`
to general users.  The only ones who used it went looking for it.
That's fundamentally different than recommending it to all new and
many existing Git users.

> > Granted, this is a trade-off.  You have users experiencing real pain.
> > You want a solution now.  I want to not recommend features with known
> > implementation shortcomings and known solutions, until those solutions
> > are implemented, and I know that will take a while.  What to do here
> > is a judgement call, and I was merely giving my opinion on the call to
> > make.  Other folks on the list might see things differently than I do.
>
> I think there are many options, and I'd love to understand which one
> you advocate for in the immediate term, with respect to the specific
> issue I noted:
>
> * Replace the pull conflict hint only, as I initially proposed
> * Engage on an "asap" replacement of default "git rebase" behavior to
> "--rebase-merges" by default
> * Change the pull conflict hint in some other way (that removes the
> copy-paste footgun)
> * Do nothing, accepting that we will revise all this in some future,
> and it's been like this for so long, what's wrong with a few more
> people hitting the classic issues?
> * Some other proposal for short-term relief of this very specific problem?

My personal opinion is that we should avoid long term problems for
users and maintainers of rebasing merges by pushing it too early to
too many folks.  For short term relief, I would suggest some mixture
of the following are worth looking into:
  * Attempt to improve the message shown to users, perhaps referring
them to somewhere in the docs that point out advantages and
disadvantages of each choice.
  * Possibly make the message shown to users be "smart" rather than
hardcoded.  For example, you could check the local-only portion of
history; if there are no merge commits, or if the upstream branch is
"origin/main" and the only merges within the local-only history are
'Merge branch "origin/main"...' then suggesting a regular rebase is
fine.  If there are other merges, then adapt the wording (and perhaps
in that special case, actually bringing up rebasing merges is okay,
though it'd still be nice if the docs with advantages/disadvantages
pointed out its shortcomings).  This might be an expensive check, but
if only users who haven't configured pull.<whatever> have to pay for
it, then perhaps it's a useful thing to spend cycles on.

> I should note here, that for "my" users, setting the new config option
> Alex proposes in "rebase: add a config option for --rebase-merges" by
> default, in all their repos, is sufficient for me to ensure people
> will stop hurting themselves, and that's something I can easily do
> if/when the patch is accepted - but the main reason I hang out here is
> to try to advocate for users *like* mine, people who use git because
> it's the best or only game in town, rather than people like me who
> think it's so friggin awesome and are fascinated to learn all its
> arcane mysteries. In my environment, that's easily a 10:1 ratio. I
> suspect that's a reasonable reflection on the universe of git users
> generally.

Yes, I understand.  It's frustrating when something you need isn't
there and we only have a suboptimal approximation.  I want to make
things better and have put a lot of time into it; some things that
already went into merge-ort were designed around this problem space
and I'm planning to do more here.

But, also, remember that I'm only one voice among many.  Others may
disagree with me and agree with you on pushing this earlier.
