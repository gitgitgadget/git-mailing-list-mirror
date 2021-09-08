Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF98C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5087C610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351884AbhIHOYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhIHOYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 10:24:33 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CDC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 07:23:25 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id a21so2154474vsp.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AdDKderTlF941x7oABY6SF2PM6Cp9QrrIRPbtbX3CrM=;
        b=e0QcHPFOuvq/H18FyRFu/0YdtkXhp8GKey3O0U5ynvKgIjDDd0mj1heCvot+ODZRg0
         HrJVhVmuerEsPFhbE/LZh7VGWMrbvuqvVcj4zRjhiWu2eyKBRR8fIy/QBpe0D01Wb/gL
         /jqGcWbWjEO+L3Jt5j5dVfAh9XxKssqbU2Y+Zv3N89Xqlh6esr3h9GfVVSnMz8qXdldc
         hKLwFFI/wRmiBtqpaqFS6dykZZvHvf3n8UXumUvF6tFzAV1R3hs7l2/xzBQWj3zJsSPO
         zL+ouETYZzQ3HxJMUma+DTn6y+AEEzfwcX+I7DagjmbPa2A/UsBuliikhvGat/gS0YyO
         zp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AdDKderTlF941x7oABY6SF2PM6Cp9QrrIRPbtbX3CrM=;
        b=YaFMF31BhOEIWKQ+p2y82CMXP4NH8tD01gxD6QLG9cxJNOzM9SqbNn0oA+vsHogdNV
         HA4rbSCromDd9180eZ2hvxi9lOFje0we65TLDwjLnAuTCgqq2/hou5xS0srY6cv/H43y
         TeX80DNFkMWGQji9Dk02JMsBCIkHA/E3DT0Eg/keafIPOvt1rsT7t2nyoQR0FWPIihxd
         bgDPaJZmSZt56gAIUUOD9wSpGj2Rji3dWrglGfJc9ZGAq5OxJw3eK8FSmRDUnY6H1sVG
         b3lbYrMCWSFlQLbELUDDfCwi5nZ5NgtowRA0xBy3x0ws2GsOZBLf6e0iEVfxXB81fjnO
         6JKQ==
X-Gm-Message-State: AOAM531yGWitIAwwHJHHx2545rYxqa+TVcK3CyIAjEA7lKNihSLeFcTm
        QAYuYCdmFdn7oolshXbBHHUEPzRwisCAk/Qotd4wag==
X-Google-Smtp-Source: ABdhPJxkCq1WxVt2BLxdQVlqnxzk5fjD8oVfVWYuvnRPkp32SdjNENLdg8CD+684ycPaumnDn5hK9ahcdWWQOaJ5D3M=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr2381800vsl.9.1631111004767;
 Wed, 08 Sep 2021 07:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
 <066e186a-ffa5-3548-1b7d-a769bbd296f2@gmail.com> <CAPJmHpV2c_EubO4-GpV5Yi3RLpgvcaake=fz0rfgD_SZZcawOg@mail.gmail.com>
In-Reply-To: <CAPJmHpV2c_EubO4-GpV5Yi3RLpgvcaake=fz0rfgD_SZZcawOg@mail.gmail.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Wed, 8 Sep 2021 15:23:08 +0100
Message-ID: <CAFLLRpJGORS4S-FkqY7+c9rkV2RL=wSrqmmKv4Ef-Y=JjOa9Kw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Compile-time extensions for list-object-filter
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Andrew Olsen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrew Olsen <andrew232@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Andrew Olsen <andrew.olsen@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry, life got in the way at an unfortunate moment. And it should
very much be tagged "RFC" =E2=80=94 thanks =C3=86var and Bagas for reading.=
 Here's
the additional background you could have used earlier on =E2=80=94 I've
bundled it together, but I'll happily follow up specific questions
individually. I've CCed in a couple of other people who might find it
interesting too.

So Andrew & my motivation here is to provide some specialised
filtering at clone/fetch time. In Kart[1] datasets are organised
(simplistically) by primary key, but for spatial data we want to
provide an orthogonal spatial extent filter which isn't part of the
tree path, so we can't reuse the work done in the sparse filters. For
a fetch obviously the server-side will require support for any
indexing and ultimately deciding whether a particular blob should be
part of the tree or not.

In the original filter implementation [2], various "profiles" were
alluded to as a case where the server operator might know a lot more
about how the developer would want to use the repository than the
client does, and a named profile for the server to interpret would be
a reasonably clean approach. Referred again in [3]. Sparse filters,
subject to the performance issues hopefully being improved by the
cone-mode changes, cater to a lot of them. The existing built-in
filters are fairly simple and there's a relatively simple interface
for them to implement, extending them seems like a reasonable approach
to me =E2=80=94 potentially allowing people doing interesting things with
partial clones to take it and run in a general way without too much
effort.

So the key element to clarify/understand for this proposal is that the
main change to Git is the ability to use
`--filter=3Dextension:<name>[=3D<param>]` which passes through to
git-upload-pack on the server side, to rev-list, which looks up /
validates the filter name/parameter and applies it. So if you want to
offer a custom filter, you build & set it up on the server and any Git
client (if this is merged) can make use of it without any additional
code.

Wrt IPC, my very first proof of concept used an external process that
rev-list launched, passed a series of oids/types via stdin, receiving
yes/no responses via stdout. Even after quite a lot of OS-specific
efforts to optimise the data flow across the pipes it was slow for
non-trivial sized repositories (where it matters) =E2=80=94 essentially
boiling down to too much context switching between processes.
Reorganising the existing filtering approach to do batching with
deferred responses and parallelising the filtering into threads seemed
like an awful lot of effort for potentially little gain, in a niche
use case.

Moving it in-process made it perform well: CPU use moves into the
"deciding whether this object is in or out" phase rather than burning
it in IPC & context-switching. I did build up a basic runtime-loadable
plugin approach, but there was a reasonable amount of the internal git
API that the filters need/touched (even things like hash sizes add a
pile of complexity to it) unless it was reduced back to passing
oids+types. My approach for plugins was basically "could I potentially
implement the existing filters?" Without more of the git API I don't
think this would be feasible. Plus Git would have to agree on and
support a public ABI going forward, which for a potentially niche use
case didn't seem reasonable to propose.

Hence compile time: simpler; no ABI issues; the internal API doesn't
change that much wrt things that filters are likely to do =E2=80=94 if some=
one
creates a plugin then it's on them to keep it building across git
upgrades on their server; platform support is simpler; and if others
find exciting uses for it then a runtime-loadable plugin API is always
possible in future. And only the server ever needs any custom
binaries.

Licensing =E2=80=94 yes, any filters would need to be GPL-licensed since
they're compiled with Git. Only the server operator needs to concern
themselves with complying with this (& associated licensing for any
external libraries/etc a plugin might need) since that's where the
plugin code is linked & runs. With the usual issue around internal use
within an organisation not qualifying as "distribution" under the GPL.
FWIW, for Kart we'll be GPL-licensing the server-side spatial filter
plugin code for anyone who's interested.

Hope this clarifies a bit.

Rob :)

[1] https://kartproject.org =E2=80=94 building on Git to version geospatial
datasets. Not sure if the videos ever got released (thanks Covid), but
I did a talk at Git Merge 2020 on it when we released the first alpha.
[2] https://public-inbox.org/git/1488999039-37631-1-git-send-email-git@jeff=
hostetler.com/
[3] https://public-inbox.org/git/79b06312-75ca-5a50-c337-dc6715305edb@jeffh=
ostetler.com/
