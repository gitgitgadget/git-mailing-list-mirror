Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70261C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5275C60FF4
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhGTFvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhGTFvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 01:51:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFCC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 23:32:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hr1so32734611ejc.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GxiOuycDpcAmvkrEQ7QXmcAPcGZ13AKHKmyiBPGo0ic=;
        b=tDXydXunNEraR7bzmx9brHkGEMniLnCydLU4/g5OXroEUIIMLpvlfLsThIrpZjWK7+
         EWiivxciq1ktvgtS9+SzCaETZsLgq+Hmd55AOVWc5jMpBTTWyEYKpK3NhZwOrBZbW/q+
         8F+1bSGmuqLuZRir4E2lzttwwuXXdBP3iR5LczwJUigqGKqScmm2mE0WNdROQlJ13PGA
         fWRrXEloKzfEFL1mgdxEV+Fh56LR/oxMnoxeo8dYY99JS5Wj1MbKZ4mnoMxQ7ne9Xsae
         7X646DoMYG/CrptIXsFSw6xBb2Lt3GOfUI/5t7VaGGsRA40Z9E7zRrp57CDPbaQ44lJB
         lVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GxiOuycDpcAmvkrEQ7QXmcAPcGZ13AKHKmyiBPGo0ic=;
        b=rjFIDhkO/u27GJnGmR1BoiBLpMk7S8jXRWmnY2K2o2MSJUV74UniQUyVUTU7UPe7NX
         QiKi3KZcK00e5wRd87GQ3bza5EhEs/8XIgdVCUG64hiWuv7jtiSLYhd2xPb3lnlRI0AH
         YAF/gLsQe973scNESnYNDWXFwRGVJhE5oPH38meq6ZXq8qOyqqBghcWFMPNrs8niCj62
         lnVHIEm4+rr60ZWLlSmikInhbjuOqCOZRP/82aE3IgkC4lFROUt+Fbo2a+BWQ77DSy6L
         hGBOegkbSlbOKKDtaJXys+lMjkWd0B7aGvFVGvFNuflid/z+lOnnWWs5qQcldWBu2Mix
         3yWA==
X-Gm-Message-State: AOAM533N/wsKHoZtyK4UsCUJxGYmwMSays4e1tQEbI0VOd2TSZ4Gxps9
        Hx+aS2MQdHLi5Y+iwSPUvcg=
X-Google-Smtp-Source: ABdhPJw60l3C/mM7rSBqBXs5Gmb6IMb1H6tW+78rm2fWl3EbXrDHz9ncheGmoR5Rtma6qIAuECBTTw==
X-Received: by 2002:a17:906:eda7:: with SMTP id sa7mr31280406ejb.135.1626762730749;
        Mon, 19 Jul 2021 23:32:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id qp12sm6749017ejb.90.2021.07.19.23.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:32:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Taylor Blau <ttaylorr@github.com>,
        Sun Chao <16657101987@163.com>, Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Date:   Tue, 20 Jul 2021 08:29:17 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <YO8XrOChAtxhpuxS@nand.local> <877dhs20x3.fsf@evledraar.gmail.com>
 <12435060.NHVMl2pYiE@mfick-lnx> <87v95czn7q.fsf@evledraar.gmail.com>
 <CAL3xRKee3YmOrV_-4Tu6FmJyRnS2y-tdiAmXp5TjzL_WxQNrtw@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAL3xRKee3YmOrV_-4Tu6FmJyRnS2y-tdiAmXp5TjzL_WxQNrtw@mail.gmail.com>
Message-ID: <878s21wl4z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Son Luong Ngoc wrote:

> Hi folks,
>
> On Wed, Jul 14, 2021 at 10:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> *nod*
>>
>> FWIW at an ex-job I helped systems administrators who'd produced such a
>> broken backup-via-rsync create a hybrid version as an interim
>> solution. I.e. it would sync the objects via git transport, and do an
>> rsync on a whitelist (or blacklist), so pickup config, but exclude
>> objects.
>>
>> "Hybrid" because it was in a state of needing to deal with manual
>> tweaking of config.
>>
>> But usually someone who's needing to thoroughly solve this backup
>> problem will inevitably end up with wanting to drive everything that's
>> not in the object or refstore from some external system, i.e. have
>> config be generated from puppet, a database etc., ditto for alternates
>> etc.
>>
>> But even if you can't get to that point (or don't want to) I'd say aim
>> for the hybrid system.
>
> FWIW, we are running our repo on top of a some-what flickery DRBD setup a=
nd
> we decided to use both
>
>   git clone --upload-pack 'git -c transfer.hiderefs=3D"!refs"
> upload-pack' --mirror`
>
> and
>
>   `tar`
>
> to create 2 separate snapshots for backup in parallel (full backup,
> not incremental).
>
> In case of recovery (manual), we first rely on the git snapshot and if
> there is any
> missing objects/refs, we will try to get it from the tarball.

That sounds good, and similar to what I described with that "hybrid"
setup.

>>
>> This isn't some purely theoretical concern b.t.w., the system using
>> rsync like this was producing repos that wouldn't fsck all the time, and
>> it wasn't such a busy site.
>>
>> I suspect (but haven't tried) that for someone who can't easily change
>> their backup solution they'd get most of the benefits of git-native
>> transport by having their "rsync" sync refs, then objects, not the other
>> way around. Glob order dictates that most backup systems will do
>> objects, then refs (which will of course, at that point, refer to
>> nonexisting objects).
>>
>> It's still not safe, you'll still be subject to races, but probably a
>> lot better in practice.
>
> I would love to get some guidance in official documentation on what is th=
e best
> practice around handling git data on the server side.
>
> Is git-clone + git-bundle the go-to solution?
> Should tar/rsync not be used completely or is there a trade-off?

I should have tempered some of those comments, it's perfectly fine in
general to use tar+rsync for "backing up" git repositories in certain
contexts. E.g. when I switch laptops or whatever it's what I do to grab
data.

The problem is when the data isn't at rest, i.e. in the context of an
active server.

There you start moving towards a scale where it goes from "sure, it's
fine" to "this is such a bad idea that nobody should pursue it".

If you're running a setup where you're starting to submit patches to
git.git you're probably at the far end of that spectrum.

Whether it's clone, push, fetch, bundle etc. doesn't really matter, the
important part is that you're using git's pack transport mechanism to
ferry updates around, which gives you guarantees rsync+tar can't,
particularly in the face of concurrently updated data.

