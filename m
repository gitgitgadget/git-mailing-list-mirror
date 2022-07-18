Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64547C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiGRTAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiGRTAS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:00:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898D2B26A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:00:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b11so22979820eju.10
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8QWbDYOeOT9/l9tYG6jKfhpliInm5SspF09bcb7yc/A=;
        b=TdOh2H8hbYkonh56qKP4w0Pmgv/AR5b952gL46XmedZYGOsNDjAR9mUUg560qvEj06
         CIWlcjr/oO2EWfnxbJQpGYcpusznCX6X0oMN8d2JaAVRG5hxFESqox6MP/8QsU4KCsYY
         XwB8mUigbCYVNeQR2IAfUJ/wPjBbpXMVv5fbPpIuBX3DDPvmedcE7G3roQqYGJhg7HQx
         62dKWetqAW/Y5EkhEy1PgF+q/rXUmJWRGJtMll8N0/qbzzEpSKIbjbyATII+K7y9kWkQ
         BmhcM8Y9QPRpnTWLeCpypKx+19QwrxpKKQFLRZMTmV1Aq28fEnEy/XFgT9KgQpDtVL1/
         xyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8QWbDYOeOT9/l9tYG6jKfhpliInm5SspF09bcb7yc/A=;
        b=wbENhlX6o89ZKaD7nrnRGE3BjD56DF8g1Yow8ygzgQUWpltHNDO64tY0PU9Rkh/xvN
         7hfwKrRZQeF/kWxZjlmiE/1VZI4tXzG38ueWWYZgutKz0Hhm2kurr6UhQs08cwSSkNPE
         fKRbToYS4w5b2FWA0rUqSpUP15Rv6SQoSxzdyTL00yV7KLCVfn28NjrCsGxblvXz3/hZ
         90lMeFp6q6o1aIh+3IepgHvW01mjsr+UNSmWviRU9vy7VjdzOeuwqybCApurFR7dbjVO
         NvYzWftZSpQ+x/s+jqcMgrMeBBkBLP4GeET7534kQ1YCyJqm88EC7C2brsUhasPeh4bf
         +NYw==
X-Gm-Message-State: AJIora9GUx21QWKgGk8qUKfkqzORqbpr9bE9G7EIQNXWAqTmcul1PWm7
        cTVTDRCVDDgqrrdtLtrgmxWOq81hgPjUiw==
X-Google-Smtp-Source: AGRyM1tNUNX+G1nQaBq1ivJ4kCZpj4Wl9geOWxeQ+dFMWr7RTG1cYbwg+FSEL4U9VN34o1rI4Ltlsg==
X-Received: by 2002:a17:906:93f0:b0:72e:d01f:b882 with SMTP id yl16-20020a17090693f000b0072ed01fb882mr23790520ejb.273.1658170813182;
        Mon, 18 Jul 2022 12:00:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0072f4f4dc038sm133189ejf.42.2022.07.18.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:00:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDVyV-003KMB-JK;
        Mon, 18 Jul 2022 21:00:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stephen Finucane <stephen@that.guru>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Date:   Mon, 18 Jul 2022 20:50:31 +0200
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
Message-ID: <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Stephen Finucane wrote:

> ...to track evolution of a patch through time.
>
> tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=A0 la t=
he 'Change-
> ID' trailer used by Gerrit into git core?
>
> Firstly, apologies in advance if this is the wrong forum to post a feature
> request. I help maintain the Patchwork project [1], which a web-based too=
l that
> provides a mechanism to track the state of patches submitted to a mailing=
 list
> and make sure stuff doesn't slip through the crack. One of our long-term =
goals
> has been to track the evolution of an individual patch through multiple
> revisions. This is surprisingly hard goal because oftentimes there isn't =
a whole
> lot to work with. One can try to guess whether things are the same by ins=
pecting
> the metadata of the commit (subject, author, commit message, and the diff
> itself) but each of these metadata items are subject to arbitrary changes=
 and
> are therefore fallible.
>
> One of the mechanisms I've seen used to address this is the 'Change-ID' t=
railer
> used by Gerrit. For anyone that hasn't seen this, the Gerrit server provi=
des a
> git commit hook that you can install locally. When installed, this append=
s a
> 'Change-ID' trailer to each and every commit message. In this way, the ev=
olution
> of a patch (or a "change", in Gerrit parlance) can be tracked through tim=
e since
> the Change ID provides an authoritative answer to the question "is this s=
till
> the same patch". Unfortunately, there are still some obvious downside to =
this
> approach. Not only does this additional trailer clutter your commit messa=
ges but
> it's also something the user must install themselves. While Gerrit can in=
sist
> that this is installed before pushing a change, this isn't an option for =
any of
> the common forges nor is it something git-send-email supports.

git format-patch+send-email will send your trailers along as-is, how
doesn't it support Change-Id. Does it need some support that any other
made-up trailer doesn't?

> I imagine most people working with mailing list based workflows have thei=
r own
> client side tooling to support this while software forges like GitHub and=
 GitLab
> simply don't bother tracking version history between individual commits i=
n a
> pull/merge request.

It's far from ideal, but at least GitLab shows a diff on a push to a MR,
including if it's force-pushed. I'm not sure about GitHub.

> IMO though, it would be fantastic if third party tools
> weren't necessary though. What I suspect we want is a persistent ID (or r=
ather
> UUID) that never changes regardless of how many times a patch is cherry-p=
icked,
> rebased, or otherwise modified, similar to the Author and AuthorDate fiel=
ds.
> Like Author and AuthorDate, it would be part of the core git commit metad=
ata
> rather than something in the commit message like Signed-Off-By or Change-=
ID.
>
> Has such an idea ever been explored? Is it even possible? Would it be bro=
adly
> useful?

This has come up a bunch of times. I think that the thing git itself
should be doing is to lean into the same notion that we use for tracking
renames. I.e. we don't, we analyze history after-the-fact and spot the
renames for you.

We have some of that in git already, as git-patch-id, and more recently
git-range-diff. Both are flawed in a bunch of ways, and it's easy to run
into edge cases where they don't spot something that they "should"
have. Where "should" exists in the mind of the user.
