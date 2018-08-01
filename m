Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EAE1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbeHARFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:05:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52231 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389656AbeHARE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:04:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so7382219wmh.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHcPPNRk/84SQUdV33wl+dzpIvKQa81B08IeizGmMRs=;
        b=QwJYFXLj68fn0LthI1rgMkG5luJcgkDedFwXmHqeHf+RkFyNt9x1cXbfAc9KRD/26T
         xASNql+t7B7ZHFAbfHgr9u4TCcjKTIfEhr3e8OWkZoWDcZbvfhYjlVQ4fUSNZSmG+glK
         ZYjcMoOJqsPCBC3aTnhXjWxQ0M2+lybmWtguSKcCdXovOALCaF+1Qvw021U4xM0/7uXv
         /AcNb0inoJFiydx3yePc0S4G+q2SskGlABrrB3dnt/XMDGV+RXtss/sWMJCWlpW0DRet
         KbgfWTwnZ74/iGYXaSITZvqeCfm0E1ulRSTZfBBvyMKKH522VigPqdDzO07k9IZboFi7
         HsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHcPPNRk/84SQUdV33wl+dzpIvKQa81B08IeizGmMRs=;
        b=SWF1OWu9G35MsGEP/feSI7olu46lu+X6mxgMnh0LuPZ2+TgqSXGDjEE5Ca9OtNs25n
         RIl6SMV6NOW96WI9Yak4JNSoS2W+3ZMpA6dhBNLH1r2QDMptxsYJFyjoRQp7nkHbOetS
         gaOd7DayUgRoGaXaHBE6D0rBGxRDBV2eRqnx7/PAP6AHBbYpeitJxc4KlB4YQyDVUrM0
         bkOsckDWCp0h5u00PZdQjSXN0Na5NeKo9/oDA4Ma7/rPfLkgXTH1jIdtOkB3Y+x1YBD6
         hIvzUsPTwZojB/zCIG6rI28Ro4qOLAkEkKmOFTH+aBhheS6vLExCg8T2xC0n2LCCD6hP
         w4dA==
X-Gm-Message-State: AOUpUlFmC42iUU8y+CamMzn5sUEGTkXRU9giAYkuPPnuynhbW/hwCyTv
        6mRWdz+0tEhRvJJAF0AXFlsWB6hEReg=
X-Google-Smtp-Source: AAOMgpe2FRFjqkbfv7BbKMtmfWCOjjLt9T+ybivJicsa1sHCEbVTc3V4RNMo88eI5NTWHl1gWIo4xA==
X-Received: by 2002:a1c:b709:: with SMTP id h9-v6mr3245160wmf.104.1533136726129;
        Wed, 01 Aug 2018 08:18:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 2-v6sm6324008wmi.17.2018.08.01.08.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:18:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] negotiator: improve recent behavior + docs
Date:   Wed,  1 Aug 2018 15:18:33 +0000
Message-Id: <20180801151835.9182-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731180248.42787-1-jonathantanmy@google.com>
References: <20180731180248.42787-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31 2018, Jonathan Tan wrote:

>> > +fetch.negotiationAlgorithm::
>> > +  Control how information about the commits in the local repository is
>> > +  sent when negotiating the contents of the packfile to be sent by the
>> > +  server. Set to "skipping" to use an algorithm that skips commits in an
>> > +  effort to converge faster, but may result in a larger-than-necessary
>> > +  packfile; any other value instructs Git to use the default algorithm
>> > +  that never skips commits (unless the server has acknowledged it or one
>> > +  of its descendants).
>> > +
>> 
>> ...let's instead document that there's just the values "skipping" and
>> "default", and say "default" is provided by default, and perhaps change
>> the code to warn about anything that isn't those two.
>> 
>> Then we're not painting ourselves into a corner by needing to break a
>> promise in the docs ("any other value instructs Git to use the default")
>> if we add a new one of these, and aren't silently falling back on the
>> default if we add new-fancy-algo the user's version doesn't know about.
>
> My intention was to allow future versions of Git to introduce more
> algorithms, but have older versions of Git still work even if a
> repository is configured to use a newer algorithm. But your suggestion
> is reasonable too.

I think 01/02 in this patch series implements something that's better
& more future-proof.

>> Now, running that "git fetch --all" takes ages, and I know why. It's
>> because the in the negotiation for "git fetch some/small-repo" I'm
>> emitting hundreds of thousands of "have" lines for SHA1s found in other
>> unrelated repos, only to get a NAK for all of them.
>> 
>> One way to fix that with this facility would be to have some way to pass
>> in arguments, similar to what we have for merge drivers, so I can say
>> "just emit 'have' lines for stuff found in this branch". The most
>> pathological cases are when I'm fetching a remote that has one commit,
>> and I'm desperately trying to find something in common by asking if the
>> remote has hundreds of K of commits it has no chance of having.
>> 
>> Or there may be some smarter way to do this, what do you think?
>
> Well, there is already a commit in "next" that does this :-)
>
> 3390e42adb ("fetch-pack: support negotiation tip whitelist", 2018-07-03)

That's awesome. This is exactly what I wanted, this patch series also
fixes another small issue in 02/02; which is that the docs for the two
really should cross-link to make these discoverable from one another.

Another thing I noticed, which I have not fixed, is that there's no
way to say "I don't want to you to say that anything is in
common". Currently I'm hacking around in my script by doing:

    parallel --eta --verbose --progress '
        if git rev-parse {}/HEAD 2>/dev/null
        then
            git fetch --negotiation-tip={}/HEAD {}
        else
            git fetch --negotiation-tip=ref-i-have-with-one-commit {}
        fi
    ' ::: $(git remote)

I.e. the way I'm doing this is I add all the remotes first, then I
fetch them all in parallel, but because the first time around I don't
have anything for that remote (and they don't share any commits) I
need to fake it up and pretend to be fetching from a repo that has
just one commit.

It would be better if I could somehow say that I don't mind that the
ref doesn't exist, but currently you either error out with this, or
ignore the glob, depending on the mode.

So I want this, but can't think of a less shitty UI than:

    git fetch --negotiation-tip=$REF --negotiation-tip-error-handling=missing-ref-means-no-want

Or something equally atrocious, do you have any better ideas?

Ævar Arnfjörð Bjarmason (2):
  negotiator: unknown fetch.negotiationAlgorithm should error out
  fetch doc: cross-link two new negotiation options

 Documentation/config.txt             |  5 ++++-
 Documentation/fetch-options.txt      |  3 +++
 fetch-negotiator.c                   | 12 +++++++++---
 t/t5552-skipping-fetch-negotiator.sh | 23 +++++++++++++++++++++++
 4 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.18.0.345.g5c9ce644c3

