Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE0C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 09:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiHBJfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiHBJfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 05:35:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8782230F55
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 02:35:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r4so9152485edi.8
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=z/Cva2XcWh4sws/NseaJKYFNCORHDiq4Jlhee9cjhtc=;
        b=nUXdEfyvVx0pLXTeJzv3V/5OtGcN7LRoDgT6XdH4AEuoNwZS3WD926Vy9LRl8bao79
         EMs+hW/1OICtcqOAEKki+VJe2UWb0vt84DjskD+Gut5c60ihCQIsPJWPhqoK0ORXw1OU
         lLc6Uttzc5jcgASdvbdYhoVC2yUhDT7DYbs1O4+LiOEDneIJt11+0byy2aJ95zMqWWoH
         j2qpN0fmAULLiVbPmETCR59A/cwpzrmi2q5LR5wPTN++DuuifW+2nlZjq7yKJGG4dz5U
         7iy2ldSMbL8rgycvV4dpWMyUL9jjmxZ8l2uKLw0iSkOkkHlwpTq9oluQlFjDvNvJCHVG
         ihmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=z/Cva2XcWh4sws/NseaJKYFNCORHDiq4Jlhee9cjhtc=;
        b=2doMLe/yDa/uPcOQ+WaJOBdB73vwUOlyPnd90ycsZHmQiUqE59kk/LAwm9inW8lN5b
         Z5oZdzXdHoPzd4t9xfF7c8x+Oh8ENzkacpsjlxRY9zSIujCQLI9wsNHHBqhhhB+Zsx6N
         eOvywdQ5zqN0B8lUXL4nYo/d6NL5AG0PksXglYjQ3Dnn3UXhe0Ry+ZgTbWPCrUd6kTS5
         3q2lzeL5WEYtHls0Ssy2b85gBcCXDaJp0MVXj2PMSvoJrDgPjTka8Sn3wR6ir3622MOx
         wEXh0vFMasyRiZSs9iXbJsb7G/CZ+RBFo8GqK6X/Mkxp2mvi1lY/Wgf4XgsoWQDF76PM
         iZ3A==
X-Gm-Message-State: AJIora/uaPoVMmj5ctS/7oy4aWLV5XXKNEgkbl0GxpQN0hOYT+vB6Zr5
        SpTiqPtYZq4SNabJRPEmB30M/0O3aBI=
X-Google-Smtp-Source: AGRyM1vIW71Lfwnrw4Sblah9B2v0iwR11ZD2O7FHmh+lQthBt6gjk74Di+x2kO07zWhfYN80r4CJSQ==
X-Received: by 2002:a05:6402:54:b0:43b:5cbd:d5db with SMTP id f20-20020a056402005400b0043b5cbdd5dbmr20362625edu.264.1659432931856;
        Tue, 02 Aug 2022 02:35:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a22-20020aa7d756000000b0043df042bfc6sm771974eds.47.2022.08.02.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:35:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIoJG-009Em3-1t;
        Tue, 02 Aug 2022 11:35:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nicolas MAFFRE <nicolas.maffre.external@airbus.com>
Cc:     git@vger.kernel.org
Subject: Re: Git v2.20.1 EOS date
Date:   Tue, 02 Aug 2022 11:26:52 +0200
References: <CAHWqpUPVAvw5bsvS1DgAQDwxhzYmh6_V=r+TfPxekdy-oMZWmg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAHWqpUPVAvw5bsvS1DgAQDwxhzYmh6_V=r+TfPxekdy-oMZWmg@mail.gmail.com>
Message-ID: <220802.8635efgf8d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 02 2022, Nicolas MAFFRE wrote:

> Hello,
>
> I'm working on a project that uses Git v2.20.1 and I need to know
> if there is an "End of support" date for this version of the software Git ?

Yes and no, for v2.20.* it was probably sometime around 2 years ago (see
below).

The Git project doesn't really do LTS or active support for anything
except the current or recent release(s), if there are issues discovered
in older releases they're fixed in newer ones, not in older "maintenance
tracks".

For bugs discovered in older releases they'll almost always only be
fixed in the code that'll become the next release.

For security fixes we do change some older releases, but usually only
the ones from the last 1-2 years. E.g. there was a security release
recently which included point-releases for versions as old as 2.30.*:
https://lore.kernel.org/git/xmqqv8s2fefi.fsf@gitster.g/; So that "2
years" above is just an inference of mine, judging from the last
security release.

How long that Window is is up to Junio's discretion, you can find some
others past such releases at:
https://lore.kernel.org/git/?q=s%3AANNOUNCE+s%3A%22and+others%22+f%3Agitster%40pobox.com

Note that this only goes for the git project. If you're e.g. using some
well-known vendors of LTS software they may themselves commit to
backporting patches to git and other software within their LTS window
(with mixed results).

I hope that helps!
