Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104FDC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbiBUPio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:38:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiBUPio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:38:44 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746F4BF61
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:38:20 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id j3so3787200vsi.7
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTbg4Jwui2yII6CwLjslEa9etvvtfDU27lY9uLv5P78=;
        b=XHVdRa7A1/MJukA+34GTQb/xYATw/OG0FL1jergqG9xsoRRFPA7AspG4HQIkxVga/K
         Fs+GGIrMq8KFeOe4ZzXBwKfjVRrLn4CZvNyKs76kX7aKKBYshnn0CLyidxK/SdnglqpZ
         ZHGKf8Gb1zp6RK5b6KtO1V7Nn01YWLnrwBCiSXLuw3nJuZT9YqiGlT+8QECbfYM75MgK
         G1lUbsDt4KtGOyAE695VU32magmnwwDmfUPcpggwUM83L5jpEACi5Y7oLb8zChMSXkob
         teuozXbFJ+S5jdEu7k0ayU8DzvSIZIq8gQ+jta0kHeVgPQ0gOeIFbEpqXVncuAIw+ex/
         s8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTbg4Jwui2yII6CwLjslEa9etvvtfDU27lY9uLv5P78=;
        b=moeooXJ9xKhphbF0Nrot11YQH/21/X/+wDRlOJkzX6F5o7pCwMliFfAftWFw/TTy71
         0yxRPJ/1bEW376aEGok621IyD1ZFmb9VsE9gwhMHWcRw23M0eoFXBjXGHCjJfRBeFw12
         U67vuOxIkG3Z6PF/gZGbFFY5IqDPkcXt3bkl83D6rCpXq4DkE6ORlyg2ov3SEyDaScIS
         DDkUCZajKz80W1kj+F4RSpH5ARLbzNcvevq0OU5Dcy9Q2tATSb8q7bb7htRHpRnyt69f
         zfmlF88kg0els1M0D5VgVA5p2cHJpMMCN4UW//YCYfT2uGc2SGiPYD/c92vj+tneog+Y
         GmXg==
X-Gm-Message-State: AOAM533m2AtJYIcZI+vpCGMkQiQgsrL2U+RT2WzgQT8Q3o0tTr7qPpzj
        gPInhaU0jXp3fl85OkBVeClXgtfkrCtfPccMuMpkBDbItHotxqZU
X-Google-Smtp-Source: ABdhPJzCXWyqULCSYZjnSZ0NYK0T218o6UV/vyNvfv1gQUImTjhODsYQB3GvU13T/f0EV7cf7oJ6HXZWuSf7ZXh+rn8=
X-Received: by 2002:a05:6102:c48:b0:31a:6c5a:a13a with SMTP id
 y8-20020a0561020c4800b0031a6c5aa13amr7853463vss.80.1645457899524; Mon, 21 Feb
 2022 07:38:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com> <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com> <YhMC+3FdSEZz22qX@nand.local>
In-Reply-To: <YhMC+3FdSEZz22qX@nand.local>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Mon, 21 Feb 2022 15:38:03 +0000
Message-ID: <CAFLLRp+JHi6B-RTeaWVPy2bZVHJ-y7EyMpymQy2LBynbZ8RzNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 21 Feb 2022 at 03:11, Taylor Blau <me@ttaylorr.com> wrote:
>
> we would still be leaving repository
> corruption on the table, just making it marginally more difficult to
> achieve.

While reviewing John's patch I initially wondered if a better approach
might be something like `git repack -a -d --exclude-stdin`, passing a
list of specific objects to exclude from the new pack (sourced from
rev-list via a filter, etc). To me this seems like a less dangerous
approach, but my concern was it doesn't use the existing filter
capabilities of pack-objects, and we end up generating and passing
around a huge list of oids. And of course any mistakes in the list
generation aren't visible until it's too late.

I also wonder whether there's a race condition if the repository gets
updated? If you're moving large objects out in advance, then filtering
the remainder there's nothing to stop a new large object being pushed
between those two steps and getting dropped.

My other idea, which is growing on me, is whether repack could
generate two valid packs: one for the included objects via the filter
(as John's change does now), and one containing the filtered-out
objects. `git repack -a -d --split-filter=<filter>` Then a user could
then move/extract the second packfile to object storage, but there'd
be no way to *accidentally* corrupt the repository by using a bad
option. With this approach the race condition above goes away too.

    $ git repack -a -d -q --split-filter=blob:limit=1m
    pack-37b7443e3123549a2ddee31f616ae272c51cae90
    pack-10789d94fcd99ffe1403b63b167c181a9df493cd

First pack identifier being the objects that match the filter (ie:
commits/trees/blobs <1m), and the second pack identifier being the
objects that are excluded by the filter (blobs >1m).

An astute --i-know-what-im-doing reader could spot that you could just
delete the second packfile and achieve the same outcome as the current
proposed patch, subject to being confident the race condition hadn't
happened to you.

Thanks,
Rob :)
