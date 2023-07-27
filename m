Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD14C0015E
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjG0SI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjG0SIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 14:08:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC894
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 11:08:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58378ae25bfso12814577b3.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690481299; x=1691086099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhwlCkW8WLOVNpfeK10l5Z/HHh8P+IH4qP77OGeKVuo=;
        b=6tQ8ymJIFZ5TOgOUgh6oKZuKBZh5qOos7wpPBrrT2AVQH9xZ3eSXqJkiOKJeh8lv/W
         /OEr0C1GReEKSRnjLA8HNLU7X/ePkZ23X76oxwaNMv6DJwuCbdBx0RP45TId3JC8kgtu
         hqwFsBEkj8mkZSkAxY9JJQrgzDOLGBl0iPKdafRJn7vUXwN6SlChH06mhkaVVjOKEL2L
         EvZPoqq0b8jRLeEwhEklPM+ngvSZ2TMiwbhLRZfc8Z/WBJWpapMhENIFITrB/dOnIzRP
         HNbSQEI7YBbAtFD3I+NLujBfFHc5jxw2QJmDhSV49XlilzxCvwU/c56PagwMyRElQjqH
         JXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481299; x=1691086099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhwlCkW8WLOVNpfeK10l5Z/HHh8P+IH4qP77OGeKVuo=;
        b=A6FVaTJivcLoVj6TsmwwyIouZ8S5ryJlk+t06gHaiDRAHB3Hq4qJkCx/4sFHGbg0hD
         J19o5IN8P+lRQqG4i928SDb3X96/2CwwiQw+uNgIl4kjfhFKEjy8bqTbKMC8er0Z7512
         lC41TmaAqbgMSPmuUMUuA9bsXjv1yP/x/xD637wT3X4HBhASLZ+4VeqSoeQU7OVRCDXL
         LR0owKWorUYdzmOUSa0YljI3AmIeff78UJq5ds+fUTmAW/jbarXukNo9TbTrmfp4lG35
         EA9ygb+aj9v2e1S7DeJ8lt0de9GHy6drNQgUvpQdLVaV2XSkqFPSpVctj2djiiPDWHnN
         xyXw==
X-Gm-Message-State: ABy/qLbRorsZMvFkXfte1pCoazgoEqIKinVJX6sIbEjrn66Jfh9+yWm+
        88cZW8nctPUMTk7fwdm1GFRDegW1FehLNw==
X-Google-Smtp-Source: APBJJlHlB2Kq6Ma38VFbbNibw5yM1fedHCunIHx6Urt2DcqyW2v2MDzpIniAUIxPUcYKZCsGsgVCdaURVg8WIQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:100c:b0:cab:9746:ef0e with SMTP
 id w12-20020a056902100c00b00cab9746ef0emr683ybt.12.1690481299481; Thu, 27 Jul
 2023 11:08:19 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:08:07 -0700
In-Reply-To: <xmqqila7h9bl.fsf@gitster.g>
Mime-Version: 1.0
References: <CABb0KFF1vqMLa5DLYd_c9sQeZbhkhQ=Q0bE7W41nmMFmNWB4tg@mail.gmail.com>
 <CAJoAoZnuLxyQ7ufUTrK4mBJ_4sQoyPCqJD9eeS8XfquWue1xQA@mail.gmail.com> <xmqqila7h9bl.fsf@gitster.g>
Message-ID: <kl6lcz0dz0qg.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: includeIf not matching during `git rebase`
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>
Cc:     "=?utf-8?Q?Micha=C5=82_Miros=C5=82aw?=" <emmir@google.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <nasamuffin@google.com> writes:
>
>> Does that mean that the config machinery should also be using
>> wt_status to determine which branch to use?
>
> Not really.  The low-level config machinery shouldn't rely on a
> piece of information from so high a layer (making call to
> wt_status.c or spawning "git status" is an absolute no-no).

"includes" are surprisingly high-level and tacked-on compared to the
rest of config parsing. Includes are implemented using just config
callbacks; config_with_options() does the preparation and
git_config_include() evaluates the includes. And, "includeIf"s already
use all sorts of higher-level information (onbranch: is evaluated by
resolving HEAD, gitdir knows about the repo setup). So I don't think it
would be the worst thing to introduce such a check into config...

> But "we are not exactly on branch X, but doing work on behalf of
> branch X" is a common situation during rebase and possibly bisect,
> and I agree that it is a good future direction to introduce a
> reliable low-level primitive to notice that condition.
>
> I however am hesitant to fully support such an idea, because I
> suspect that there may be cases such as "we are technically on
> branch Y, but actually doing work on behalf of branch X" or worse
> yet "we are on branch Z, but actually doing work on behalf of both
> branches X and Y", where there are more than one plausible branch,
> which is different from what HEAD points at, that
> include_by_branch() could use.

But I fully agree that this shouldn't be a one-off config-only change,
and I don't think we fully understand the ramifications of how this
change will affect _other_ parts of Git. I don't think we'll figure that
out without testing, though. Perhaps we could put this behind a feature
flag, probably even feature.experimental.
