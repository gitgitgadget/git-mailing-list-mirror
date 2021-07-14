Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D665C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2616D610D1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbhGNUDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbhGNUBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:01:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC1C021988
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:53:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dt7so5182678ejc.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=h/YJ/nZHofbZGIVPkF43Ls7KHbov+FWwaWvIQjr24d4=;
        b=gdl15WUdCzYLahQS+QgpL7C3qUFm/Mz0TWliNn3mRUb96B+opDmtL6M4y1eQIjViyX
         elBAw/KMhTYldRntJVvKanPyrXSH0uHrTUDT9tE3F9m70HECXACSjcY0e9UiwQUGDC1u
         hT7u6v/X5wFBtbMbocB8fRdkaTGZbYdeUp63YjD8qbu3Pkqb/ANrjmNH6VCUqMnPjrgr
         lftyEgssKGwpXjr7vp1HozYN1LLLKYB655vrXD5XdcwOqmVjA5kBiJUw65VgVKFfUDNV
         S8AaZ55QAhMLk4fYwlSjBscB1E8usSLjwBwHvyjA/xsHbSnqMXphLVBTpeTmSpjRAnBe
         ljqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=h/YJ/nZHofbZGIVPkF43Ls7KHbov+FWwaWvIQjr24d4=;
        b=SL/I9Amv71nd2x4HzyHgPTMcK9VP25eVhMs1JxakZQPkt3L0/o3tWb36MYLs5Le/D8
         As1kIvX3QUoll51Su+MRostDYAMMW/Px4pRdkm5s9qvyre7kECtPgcZ6e6Du6n5E7V/J
         tCgAyhfckbd7UcYaTa14hCr1zPEXq5+sG36idIrCtAyENEyJAO+FKg73P7yX3wk0XXuz
         FsFQXoXwJPwgHWbIQ3uTyjHWLtyRAf3OGnASAMabiAX8NyurSgpGPl5EjhkJ/HWLgwvO
         5MA5hcrtNsLnUNKjKArIOLL6WbI9rTDcm7HPX/yPHRxhQy3CyoCPQKvzE0JTxTXf/xYM
         kZLA==
X-Gm-Message-State: AOAM5300CjDh8673gIyg19UTjyQW2ir0QUyv/4w0EhtTWWtSkzWdfFxb
        2jn57GupnMynIKqykOOd76U=
X-Google-Smtp-Source: ABdhPJxN+9H9btYj/yEfkqZzC7CY4wksVxj2Un/L44ESQBz4VidzBGMf+BE5sONwP8JVrGQv0ghOyA==
X-Received: by 2002:a17:906:1c43:: with SMTP id l3mr14111648ejg.291.1626292404806;
        Wed, 14 Jul 2021 12:53:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i10sm1433671edf.12.2021.07.14.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:53:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Date:   Wed, 14 Jul 2021 21:41:42 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <YO8XrOChAtxhpuxS@nand.local> <877dhs20x3.fsf@evledraar.gmail.com>
 <12435060.NHVMl2pYiE@mfick-lnx>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <12435060.NHVMl2pYiE@mfick-lnx>
Message-ID: <87v95czn7q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Martin Fick wrote:

> On Wednesday, July 14, 2021 8:19:15 PM MDT =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> The best way to get backups of git repositories you know are correct are
>> is to use git's own transport mechanisms, i.e. fetch/pull the data, or
>> create bundles from it.=20
>
> I don't think this is a fair recommendation since unfortunately, this can=
not=20
> be used to create a full backup. This can be used to back up the version=
=20
> controlled data, but not the repositories meta-data, i.e. configs, reflog=
s,=20
> alternate setups...

*nod*

FWIW at an ex-job I helped systems administrators who'd produced such a
broken backup-via-rsync create a hybrid version as an interim
solution. I.e. it would sync the objects via git transport, and do an
rsync on a whitelist (or blacklist), so pickup config, but exclude
objects.

"Hybrid" because it was in a state of needing to deal with manual
tweaking of config.

But usually someone who's needing to thoroughly solve this backup
problem will inevitably end up with wanting to drive everything that's
not in the object or refstore from some external system, i.e. have
config be generated from puppet, a database etc., ditto for alternates
etc.

But even if you can't get to that point (or don't want to) I'd say aim
for the hybrid system.

This isn't some purely theoretical concern b.t.w., the system using
rsync like this was producing repos that wouldn't fsck all the time, and
it wasn't such a busy site.

I suspect (but haven't tried) that for someone who can't easily change
their backup solution they'd get most of the benefits of git-native
transport by having their "rsync" sync refs, then objects, not the other
way around. Glob order dictates that most backup systems will do
objects, then refs (which will of course, at that point, refer to
nonexisting objects).

It's still not safe, you'll still be subject to races, but probably a
lot better in practice.
