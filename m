Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E765EEC8745
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjIGPYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjIGPVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:21:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0C810F9
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694100081; x=1694704881; i=johannes.schindelin@gmx.de;
 bh=WpFu9HXoRWf4F0zScZxELV3clLjKxAtbmYyOyfbI3CQ=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=CS2knLva62sEwljepC4Ro6mg7YNK8qvll5mZTnVl0bBneWXp/OdV02jWC0dVBWzTI8B50X2
 WMWMzT5zFaCD+KwJrUBL8j9Dqs9g+/1HBavOzG26f+RELNVX2bj5RRxmezdalYlLq5KHI6qQw
 ikFpNtF7Ga5YIPaKdZqNhOebWSNgeFgg4oTxj+aTPDq3b5dtRZqdBGIjhteQ0jAIuXtqxbzlY
 DcWC8o3zt27nc7JM6TUgs6sbCWeF/JgGLVGYh+cU4Gtt+XojLsOU3OpskbpfbbKickOKw8gaY
 MJgIJCmuI0GTjgNMaIQVIBBfP0ACxzz7qnEQfyM3n2954Z8+2UPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1qFUNt0T3u-00S9Li; Thu, 07
 Sep 2023 13:01:35 +0200
Date:   Thu, 7 Sep 2023 12:22:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
In-Reply-To: <CAP8UFD2KMikjJJQ0FGXO1EYYHRNWHH2n70UATU_o61PJ411f2Q@mail.gmail.com>
Message-ID: <4a648214-2627-c9c0-0be2-5a694e8c3b3c@gmx.de>
References: <20230407072415.1360068-1-christian.couder@gmail.com> <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com> <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com> <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com> <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com> <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
 <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com> <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com> <58f7918f-6ca3-2158-7d9e-bfcd8eb24b0d@github.com> <CABPp-BGRtcBQ_6fkMrTskV9dk71ffycXZ8hEE_RaOrAdza_wLA@mail.gmail.com>
 <f74fb509-0e1a-9542-d80c-0bec2a1e6740@gmx.de> <CAP8UFD2KMikjJJQ0FGXO1EYYHRNWHH2n70UATU_o61PJ411f2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-867962872-1694080451=:115"
Content-ID: <bf063906-c8b0-a683-2b73-d710593f7f95@gitforwindows.org>
X-Provags-ID: V03:K1:+Xf844MRW5Mu5KLinsue7pM+XpsGEFBn4+dVQfh8yWP6fqhjj95
 q2jM3lBeZjqA0+4VN9Ck78OkWDXDvdVYJgIuIQpXPYmEj9O/ekP+P73GIYVL2VvfWZuUvPB
 Zm3PvBrkB8QrNy7lZDPkSBUzRXmAcxGj7b3wAd1Usm2czxu6Hw9268pqb8+24ihyBOmbWpE
 /WGDbrRcQd4GKoIFZE9Bw==
UI-OutboundReport: notjunk:1;M01:P0:eSpCMe2i1+c=;0UU3DqHoj1YDj2pwl3WwNbd/zwu
 9OuQ39M5rt2hsyD7xJ/lglUoGmgCZpBE5c6gmDp3a48zhuC5NwqywCI+PNuj9ac+Rr5v9q/s4
 lc61UQB56+4QcIDYyLmvv5bHgotbH52NDYmCcPKl9wHfTSSTbrjkaa0mnhNoEb5taNFTyTsBs
 eBb7wjTdfdRRPOs5ByTW90jdoLLpCeCx5kal1FS71xQh2/u4UVx0kLllN9EM651+msH3GYJsu
 4bpdn6iaV6PfmkgNl4gzdPHzGEnseLf8jPYGlBKki0vPi0L2007kd30z4HEZBzPks5OUnDihD
 Ue5ZcsUBJlTtrL3dNb8qebb8vu/GzQ6iJ/QL8RCfMj1S26RaJgYvsuwhtTGPb1qeGPXg3LGB6
 0ifX41Lb0AV/L5DEJh1gjTP1DvskU8xWrm9jZbUM+oIcMhsH8F0R8gl8NbfSVElHAjCtek/hg
 y3/pjR32+aU5+rNsFLZRFmaPn+vN7mEJamYf69nc6tJi9kxyeu8eUCTiKJ3bUzs6BXaHnLrz1
 zfMxQNg8qmYb1h4ttSMyzv1daXFtaGm4jlTWJ2XZL5VvU6A1EC0yMfqAiyWXpPL3RMl3q6Xb6
 NAOPkreAmqSshFCB9Rgb3dHYYbFp1qWZ8Vr7GXmhcwP3YfXXBGjL0FpN8GPFif6OEkIr8i49A
 5APTW5cIAI32BwAZVqsyPRlD2gz57Zd8YzRingLwZCQZoMDXKipqEU2EcJVdlHuqqjZxaF16s
 l88qWIPw+r81LxyAozkaflV0/64r66gbuRxU8Su+TX5KR9LO4vfw7DnAuHIDqhz4UwdT6N4BD
 ViLMTsQ0VdE8yW3fL5QOeVqQhNfVjcIwxElyMY+SEApKd1FxvJI3dIJuNU2618aLTMbknov+f
 WV4IaXf8UXvDYW7OGcDUelk78ExOmvcx4Ellqr9H+rgHULOTMnpcWU22qORBUpIrU+zobJrI3
 zx/KTS9oCw4o5V2YRVpVWJ7gk8E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-867962872-1694080451=:115
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <f0c0e5ab-4be8-592e-d0fd-ada6cccc828b@gitforwindows.org>

Hi Christian,

On Thu, 7 Sep 2023, Christian Couder wrote:

> On Sun, Sep 3, 2023 at 5:47=E2=80=AFPM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 29 Apr 2023, Elijah Newren wrote:
> >
> > > On Mon, Apr 24, 2023 at 8:23=E2=80=AFAM Derrick Stolee <derrickstole=
e@github.com> wrote:
>
> > > > Basically, I'm not super thrilled about exposing options that are
> > > > unlikely to be valuable to users and instead are more likely to ca=
use
> > > > confusion due to changes that won't successfully apply.
> > >
> > > Oh, I got thrown by the "right now" portion of your comment; I
> > > couldn't see how time or future changes would affect anything to mak=
e
> > > it less (or more) confusing for users.
> > >
> > > Quick clarification, though: while you correctly point out the type =
of
> > > confusion the user would experience without my overriding, my
> > > overriding of rev.reverse (after setup_revisions() returns, not befo=
re
> > > it is called) precludes that experience.  The override means none of
> > > the above happens, and they would instead just wonder why their opti=
on
> > > is being ignored.
> >
> > FWIW here is my view on the matter: `git replay`, at least in its curr=
ent
> > incarnation, is a really low-level tool. As such, I actually do not wa=
nt
> > to worry much about protecting users from nonsensical invocations.
> >
> > In that light, I would like to see that code rejecting all revision
> > options except `--diff-algorithm` be dropped. Should we ever decide to=
 add
> > a non-low-level mode to `git replay`, we can easily add some user-frie=
ndly
> > sanity check of the options then, and only for that non-low-level code=
.
> > For now, I feel that it's just complicating things, and `git replay` i=
s in
> > the experimental phase anyway.
>
> I would be Ok with removing the patch (called "replay: disallow
> revision specific options and pathspecs")
> that rejects all revision options and pathspecs if there is a
> consensus for that.

Well, since you talk about "consensus" and I already made my strong
preference known, how about you add yours?

> It might not simplify things too much if there is still an exception for
> `--diff-algorithm` though. Also it's not clear if you are Ok with
> allowing pathspecs or not.

I want to remove all the rev-list-option-disallowing code. Including the
pathspec one.

> The idea with disallowing all of them was to later add back those that
> make sense along with tests and maybe docs to explain them in the
> context of this command. It was not to disallow them permanently. So I
> would think the best path forward would be a patch series on top of this
> one that would revert the patch disallowing these options and maybe
> pathspecs, and instead allow most of them and document and test things a
> bit.

I understand that that was the reasoning.

What I would like to suggest is that we should treat `git replay` as a
low-level (or: "plumbing" in Git Speak) command.

That would allow us to leave the option for stricter command-line
parameter validation to an _additional_ option, to be added later (or
never), and to stop worrying about this tool being used in ways that make
no sense (or make no sense _to us_, _now_).

> > And further, I would even like to see that `--reverse` override go, an=
d
> > turn it into `revs.reverse =3D !revs.reverse` instead. (And yes, I can
> > easily think of instances where I would have wanted to reverse a serie=
s of
> > patches...).
>
> I think this might deserve docs and tests too,

I agree.

> so it might want to be part of a separate patch series once the existing
> one has graduated.

Here, I disagree. This is a bug, from my perspective, and needs to be
fixed before graduating.

> At this point I don't think it's worth delaying this patch series for
> relatively small issues like this. There are many different ways this
> new command can be polished and improved. The important thing is that
> it looks like we all agree that the new command makes sense and should
> have roughly the basic set of features that Elijah originally
> implemented, so let's go with this, and then we can improve and
> iterate on top of this.

If it were for a small issue such as a typo, sure.

But it is a bug that `--no-reverse` is hard-coded (in a confusing manner
so because the `reverse` attribute is set), and the
`--no-reverse`/`--reverse` options are ignored, silently so.

Ciao,
Johannes

--8323328-867962872-1694080451=:115--
