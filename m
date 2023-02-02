Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40182C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBBQXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBBQXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:23:21 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4428858
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:22:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h24so2382578qta.12
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbiYnTxaPpoHgtHheJjb5fmc3yFioCD18/02KHwg3Nw=;
        b=d87GVLDwI2RviHCgvO2MXRdqqc6Kyca+xDhAleIU4DsIPf/BXxRiY+8TL2uQE6l2Yg
         dr8MNc5drGt2dKQN/xmgvUfN4zemRrV3LrkXcTd6EH/MC8zpQZGAYCmDay85HYE3k8TG
         nTUqSOYj1OhR5aJpMNQeYV2uL+DuBg6GDhfoNx+LQeFv/4GQLg34G6dVzpL1l0rOUtVb
         zV6ifJHU8NqpOnT6bq5FjgwRLyPITbQZ30RZt2wqR7Jmr76nlvL62PzI/uDo0GR8oLjw
         1XWyrNZRZx4qQzbXsjT6TzXoAb2QZbWtKgfvG12tXBuFDtRMfnRBGz0mP4aLguJ53yRV
         TKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbiYnTxaPpoHgtHheJjb5fmc3yFioCD18/02KHwg3Nw=;
        b=ub1o5+JzcDs7uGU9eSkPVGRAdudNs2bPwKPKvBoEZ9JbMFceSvCtwUEcmQqfdh+84w
         65sFnS69DHf1U9R+mZL4zoEoZBMX61vZm3V5OhkxiYoWIFrZWFDk0v0xkCQulVcxQctZ
         dulK65539Y1Mfk8jXqZKQJgofRzXunstOxgj1NgzF3UWnjZpcTCOKSTy8DuYl0Flazw5
         aVlKQdEfztsEviGwCcalENNe5IwVM5U1LjabqmzbinAa0QCTwL+dtDZKY/nt8kYT8ZT+
         JLr1I4Fu8gqpMwYfvEYnizL9XGbAzMU88cewJAE+PR4PVSesYdXJp70eVnds50xtzIcm
         wcEA==
X-Gm-Message-State: AO0yUKUnsJ1c943sVbBLsrgnvLNp6P3PfWw1oKkgBjrIfw0vkzxKkzrO
        i3EvyfZBS25SXWoO/4NUU+fmjS1S+XGeEFY0EgA=
X-Google-Smtp-Source: AK7set97Ca0dd1XPEgtjJEl3gsXHFQl0u0JCqpAMiWDAcGik5WqnQLAajkqpiV2W2MUZ3zRV8jZ10sf2Qx3MIRrLvcs=
X-Received: by 2002:a05:622a:1ba9:b0:3b4:6444:546b with SMTP id
 bp41-20020a05622a1ba900b003b46444546bmr624590qtb.295.1675354968572; Thu, 02
 Feb 2023 08:22:48 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com> <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
In-Reply-To: <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 2 Feb 2023 17:22:37 +0100
Message-ID: <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Jeff King <peff@peff.net>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Feb 2023 at 00:03, Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 01, 2023 at 05:09:33PM +0100, demerphq wrote:
>
> > > Failure (using Zsh to produce the characters; I think there's a Bash
> > > equivalent):
> > > ```
> > > # git diff --word-diff --word-diff-regex=3D$'[\xc0-\xff][\x80-\xbf]+'
> > > fatal=C2=AC=E2=80=A0: invalid regular expression: [=C2=BF-=CB=87][=C3=
=84-=C3=B8]+
> > > ```
> >
> > FWIW that looks pretty weird to me, like the escapes in the charclass
> > were interpolated before being fed to the regex engine. Are you sure
> > you tested the right thing?
>
> I think the point is that he is feeding a raw \xc0 byte (not the escape
> sequence) to the regex engine, which is bogus UTF8. And the internal
> userdiff drivers do the same thing. They contain "[\xc0-\xff]", and
> those "\x" will be interpolated by the compiler into their actual bytes.

Thanks, that was the bit that threw me off. I had completely forgotten
that C supports \x escapes :-(. The Perl internals and regex engine is
where I do most of my C hacking and it uses octal exclusively AFAIK.
(I guess it uses octal because of the "where does the escape end"
problem that C seems to have with hex escapes). So I had assumed that
something else, or the regex engine itself was interpolating them. I
appreciate that you took the time to set me straight.

> So the regex engine is complaining that it is getting bytes with high
> bits set, but that are not part of a multi-byte character. I.e., it is
> not happy to do bytewise matching, but really wants valid UTF8 in the
> expression.

Yeah, that was my first thought too, but as I said above the hex
escapes threw me off.

> glibc's regex engine seems OK with this. Try:
>
>   git grep $'[\xc0-\xff]'
>
> in git.git, and it will find lots of multi-byte characters. But pcre,
> for example, is not:
>
>   $ git grep -P $'[\xc0-\xff]'
>   fatal: command line, '[<C0>-<FF>]': UTF-8 error: byte 2 top bits not 0x=
80

I expect that has something to do with how you are configuring PCRE,
and that with a slightly different config it would be fine with this.

> There you really want to feed the literal escapes (obviously dropping
> the '$ shell interpolation is a better solution, but for the sake of
> illustration):
>
>   git grep -P $'[\\xc0-\\xff]'
>
> But I don't think we can rely on the libc BRE supporting "\x" in
> character classes. Glibc certainly doesn't. I'm not sure what the
> portable solution is.

I've been lurking watching some of the regex discussion on the list
and personally I think it is asking for trouble to use "whatever regex
engine is traditional in a given environment" instead of just choosing
a good open source engine and using it consistently everywhere.  I
don't really buy the arguments I have seen to justify a policy of "use
the standard library version"; regex engines vary widely in
performance and implementation and feature set, and even the really
good ones do not entirely agree on every semantic[1], so if you don't
standardize you will be forever dealing with bugs related to those
differences.

I think the git project should choose the feature set[2] it thinks are
important, and then choose a regex engine that provides those features
and is well supported, and then use it consistently everywhere that
git needs to do regex based matching. Anything else is asking for
trouble at some level or another.

Cheers,
yves
[1] Leaving aside advanced features, even something as simple as
alternation can vary by engine.  Consider "foo"=3D~/f|fo|foo/. Some
regex engines will match "foo", and some will match "f", depending on
whether they implement "longest match" (as most NFA/DFA engines do),
or if they implement "leftmost longest match" (as Perl and other
backtracking engines tend to do).

[2] Personally I think that features like recursive patterns, named
capture, negative and positive lookahead and lookbehind and branch
reset are so useful that it would be wise to choose an engine that
supports them, but some might argue for other priorities, performance
being a likely candidate.

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
