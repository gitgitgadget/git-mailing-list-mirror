Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A97F1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934864AbeFLAp2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 20:45:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36620 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933267AbeFLApT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 20:45:19 -0400
Received: by mail-it0-f68.google.com with SMTP id j135-v6so13335451itj.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mMM4GOvZxE/mLAGIQKheeOUxLC7KFmiBkD+Rqsl6CHc=;
        b=cGAEdEpR/0zgu+lKthqhvQ9y0mWpt49eIVNkP9NUco8FHXe3PhbyymBO/qQ6CuArq/
         127yAIOYr3/wfT5A+G8GYi850uc25PWPhkBNYZKcY0KYqJQcMhhrSa578LpZz7nYdv/q
         5ChGfkx4Ncn7xfVa7xtI2fswzOR3qwPe1ex0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mMM4GOvZxE/mLAGIQKheeOUxLC7KFmiBkD+Rqsl6CHc=;
        b=Sok5icBMZIHOYrHp+PqDHhMUQiXOoteaP5d3nvCsz7/K9MXm6hmMQ0vJKDP2hPeJD+
         9uiW66nT5v6FCeNbWeANDXzz1RJtu5wa+Bw2NOfO8ViM25HG6u5e3jb20ryCpsKGYTd3
         /Z1eqCaZqk1O8Ov29h95Y13p8m66sqTi9erkZl/wZgvnsPGmkkiLNVMdMgiHadL5gIMh
         ZWgTtpfXtENAFMUMZ6q2pgG5TQjscX5kUiGkuCRtmV8gePGtqNASfIjoMvFVirFSMuwI
         EpVJWvO+d5CpzUwjkDTDZ/fKH1nNwS8luZVqGulpJinYHH1x0ipAonhkQQYiRk3iVY1h
         nuLQ==
X-Gm-Message-State: APt69E2MWt2kogpsFoxWFBGluCqFRphyinj4S0PIbjnVu74fjvFdN8l4
        8mAZcHSWpJXATkdYNeFf9BTY+RLIwXJMgSKsdQ0=
X-Google-Smtp-Source: ADUXVKJvRYSWYQQaZ47XBETc5OF4LoZ+JbI40z58+ISbF4wLa+g93lB9av1xlQqyagsc+l2bA6soVWFdaqTMZGjoPD4=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr1125929itb.1.1528764318785;
 Mon, 11 Jun 2018 17:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <CA+55aFw+E9GT7TKC_EgPTVcvHR8HDSipNPa7VQ1ASeL1M68xMQ@mail.gmail.com> <878t7kx5t3.fsf@evledraar.gmail.com>
In-Reply-To: <878t7kx5t3.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 17:45:07 -0700
Message-ID: <CA+55aFyVOeNQPMRj=+qpGY8Ti-tqp9OC6MkfQ9o4OLAfsX14Vw@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, agl@google.com, keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 4:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >
> > And no, I'm not a cryptographer. But honestly, length extension
> > attacks were how both md5 and sha1 were broken in practice, so I'm
> > just going "why would we go with a crypto choice that has that known
> > weakness? That's just crazy".
>
> What do you think about Johannes's summary of this being a non-issue for
> Git in
> https://public-inbox.org/git/alpine.DEB.2.21.1.1706151122180.4200@virtual=
box/
> ?

I agree that the fact that git internal data is structured and all
meaningful (and doesn't really have ignored state) makes it *much*
harder to attack the basic git objects, since you not only have to
generate a good hash, the end result has to also *parse* and there is
not really any hidden non-parsed data that you can use to hide the
attack.

And *if* you are using git for source code, the same is pretty much
true even for the blob objects - an attacking object will stand out
like a sore thumb in "diff" etc.

So I don't disagree with Johannes in that sense: I think git does
fundamentally tend to have some extra validation in place, and there's
a reason why the examples for both the md5 and the sha1 attack were
pdf files.

That said, even if git internal ("metadata") objects like trees and
commits tend to not have opaque parts to them and are thus pretty hard
to attack, the blob objects are still an attack vector for projects
that use git for non-source-code (and even source projects do embed
binary files - including pdf files - even though they might not be "as
interesting" to attack). So you do want to protect those too.

And hey, protecting the metadata objects is good just to protect
against annoyances. Sure, you should always sanity check the object at
receive time anyway, but even so, if somebody is able to generate a
blob object that hashes to the same hash as a metadata object (ie tree
or commit), that really could be pretty damn annoying.

And the whole "intermediate hashed state is same size as final hash
state" just _fundamentally_ means that if you find a weakness in the
hash, you can now attack that weakness without having to worry about
the attack being fundamentally more expensive.

That's essentially what SHAttered relied on. It didn't rely on a
secret and a hash and length extension, but it *did* rely on the same
mechanism that a length extension attack relies on, where you can
basically attack the state in the middle with no extra cost.

Maybe some people don't consider it a length extension attack for that
reason, but it boils down to much the same basic situation where you
can attack the internal hash state and cause a state collision. And
you can try to find the patterns that then cause that state collision
when you've found a weakness in the hash.

With SHA3 or k12, you can obviously _also_ try to attack the hash
state and cause a collision, but because the intermediate state is
much bigger than the final hash, you're just making things *way*
harder for yourself if you try that.

              Linus
