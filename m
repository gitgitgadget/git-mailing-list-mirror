Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19944C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 17:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbjD1RUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1RUG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 13:20:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB82720
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 10:20:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b5a2099a6so127460b3a.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682702405; x=1685294405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBk/OkIn5LbetV5i81m79Y5KCWthdKweu6NhQlk/2J4=;
        b=KQ4ZyXuk0g3gEb9mM5MWVkKKeiDGkmHeBWB2at4CwNM4PotVps56Bpcwqlgrf6GpBk
         +6LDkWe9mnuHs9MeZTzpRfr0ekIBTnDU5/l15huTH1cI7/YtuojFTy08E8/zTtFvelwW
         rW26EIWkQRoVBCSo9Wm1IW/yEy/ib4Rhc57U5aCYEpPTLcDbEWW7528ynkNuKroWpSq4
         zsIWf1SasDLxDFDwi1oLN0wr73/YF+XXmp1TxX7x7GYxO5t5DuY4RR3eKZU2sAkj9RIl
         pgZ92zbaUWoiO0zGzfcW1QuIUxBxVRvmwJJ/UGrpraz9Mfd9bztMMed30aNJ17WOE75w
         xA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702405; x=1685294405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBk/OkIn5LbetV5i81m79Y5KCWthdKweu6NhQlk/2J4=;
        b=MwravZVNVWEY1jEU297zKlixBRlq7Afx/pZKyUC+vTBWprI1AwwE6hrVd8gaztgSZu
         KRYYkfhf91AaaTvB9cq35h5j5asQobCE4NAr8xfO28+PTXdbICFwz+cezNpYd4kdFoaP
         yO4u7GOLZ6uj5SaAZrG/qmVSSdvUyZ1h4pRgzws2CvFo/ZSJbJa9pnLckHcj8HtZbGwN
         mHK82THypCG7VxGyMeVsZGNqQ9rk+ThFagN2PekL14CShkhnear2uLCn7RzQX4HU4+b1
         rLpoKldtDIPqNSDHQyzipc86st9cK6fSZKdq1svJ3U2hkm90DT11OvnRQ4YK31PmDUdZ
         iOJw==
X-Gm-Message-State: AC+VfDzcjqdbFHrgj3C0bncM4puiG7WYibcWOHBiYRJQ1O0urBO/sp1u
        j9oqoekfUeLr35i5d2iZug068PLLe3fpZw==
X-Google-Smtp-Source: ACHHUZ4IUb4CTVN4/keUyNHQ0nwCpnjv9catQ5YWLeRTJ1M1+f697XRJ0SUzI4G4i0Xk7F6SGPHSzLl8YPjRgQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:bc2:b0:641:86a:428 with SMTP id
 x2-20020a056a000bc200b00641086a0428mr1601612pfu.1.1682702404778; Fri, 28 Apr
 2023 10:20:04 -0700 (PDT)
Date:   Fri, 28 Apr 2023 10:20:02 -0700
In-Reply-To: <ZEuJFOBCdnCLdGc5@ncase>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
 <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZEpVSrz-uUcfN_3_@ncase> <kl6lfs8knc9f.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZEuJFOBCdnCLdGc5@ncase>
Message-ID: <kl6ledo33ovx.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 8/8] fetch: introduce machine-parseable "porcelain" output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> I'm happy with either approach as long as we don't have to bikeshed
>> about the "perfect" porcelain output :)
>
> Agreed, and that's why I'm currently defending the "good enough" format.
> It should likely work for most usecases that exist out there. The target
> audience is going to be quite small here as this is not a user-directed
> feature.

Okay, I agree that this is "good enough" for most cases and we can
extend it if needed.

>> My full thoughts on this are in
>> 
>>   https://lore.kernel.org/git/kl6lildhlz3i.fsf@chooglen-macbookpro.roam.corp.google.com
>> 
>> but the short version is that I'm not sure if I expect something as
>> innocuous-looking as --output-format would imply other, machine-friendly
>> things (like stdout instead of stderr), and using --porcelain might make
>> option precedence clearer in some situtations (like if -z is given).
>
> I'm not even sure that `-z` makes sense in this context. If we see cases
> where not using `-z` can cause the machine-readable interface to become
> unparseable then this is a bug in the output format, if you ask me.
> Mostly because the whole intent of it is to be machine-parseable. So if
> we output data that can e.g. contain newlines, then we must not use
> newlines as part of the output format or alternatively escape them. Why
> let the author of the script shoot themselves into the foot?

Agreed. I think the current output format is resilient enough, just that
"-z" is something we choose to support for plumbing anyway.

> Anyway, I'm digressing. It's hard for me to decide what to do right now.
> The thread with Junio and Jacob points into the direction of keeping the
> `--output-format=` interface, while this thread points into the other
> direction. I'm naturally more inclined to keep `--output-format=`,
> mostly because I personally feel like it's the more obvious interface.
> But I also see your point, so it's not really a choice of right-or-wrong
> here, but rather of style.

Yes. All sides seem to understand the tradeoffs, but we value them
differently.

I'd personally prefer to err on the side of consistency, because even if
the existing behavior is less-than-ideal since:

1) This makes it possible for us to fix it in a consistent, well-thought
   out way, so we don't have to decide the future for the whole project
   in a git-fetch series.
2) At least it still behaves how _some_ users have come to expect it.

As for which is more consistent, a grep for --porcelain over
Documentation/* shows:

- git-push
- git-status
- git-worktree
- git-blame
- git-commit

Most of them already output to stdout. The lone exception is git-push,
which does exactly this "use stdout for the main output, but keep using
stderr for debugging output" behavior you added, so using --porcelain
seems somewhat consistent.

On the other hand, I couldn't find any other option that switches from
stderr to stdout (we sometimes say --stdout to say "use stdout instead
of a file", but that's different), so if we added this behavior to "git
fetch --[output-]format", this might be the first.

(Sidenote: most instances of --format are for templated-style format,
but "git-replace" does accept an enum for it. I don't think this should
weigh heavily in our decision though.)

For the other, non git-push commands, --porcelain is treated like an
output format and respects "last one wins" regular option precedence,
e.g. in the case of "git status --porcelain --short". I find this
behavior somewhat confusing (I'd expect --porcelain to win, or at least
be incompatible), but at least we can consistently change this in the
future [*].

That said, I'm willing to accept that I'm biased toward my own ideas. If
others don't find "--format=porcelain implies stdout" confusing, I can
accept that decision.

[*] In all likelihood, we probably can't make the change to --porcelain
for backwards-compatibility reasons, but we could introduce a synonym
with the behavior we want ("--machine"?) and have OPT_PARSE_MACHINE
handle both --porcelain and --machine.
