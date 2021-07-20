Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D8C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7612E610F7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhGTF6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbhGTF6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 01:58:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F8C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 23:39:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w14so27101398edc.8
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VA/kehePTm8474xy+0xZQ8alLOOV+H3rB/8gezH7QBg=;
        b=nWaVezDNinRILdN8bSwdLy8NMXI/TqVehP9O6c+hnIIWKxJvLKUdkUQKbJ6yV9zbES
         yicyccvqJM7CVNHOLWUSkOasf6We39B9rOb/xEytpSAcpIAmtQ4+xDStZ4B2zsdTGDkM
         P5wn5qOw9V2b20+wTKta3QMmZ1ZCmB7VQX4OlNUSIHjW4KeXFYKzNNNNl6Naf7l27J30
         icK7FJ1KzHCrSUUrSxd+VVP5yBX3Fe+wpllc54Vkqeztbb//xiXKITDD/m8JZeZN7TDm
         jiyHoQ1IbDZJpJA0qhRkp5oDoNRRy5qSTvlaiX71h7O5I79e2XyOkCi3ixuPBcCUFKba
         Uc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VA/kehePTm8474xy+0xZQ8alLOOV+H3rB/8gezH7QBg=;
        b=J02XqffWs0bmBCD5Yth/dkvtJ60UQnGFv/pN2Q3VZuIj0VMmBam/JaJ4hpzmrQJlYq
         uP0v0aiHJvL8VcM5ruB2oWjFLkYa9QHjc3SrgbscyS1Bh/l3vNrPRGRTh0sHvGrU8woB
         ZRXUareS+5LyKS7G9vod5ANB+M7ZIAIU4kJqR1tTxxxjgBBivedtcgeY2gXB1wDhwjAR
         wFAnZYf1rv3Oa9J9chTPbG0fgbcAoLB0RbVXsjBaJry3NHqtfd9U/L7VN/7DH1ppmUpi
         2evc0NInRiS+FpjNNqWMX0z5y/HS+cdMnJpYSR6HdXb956ytXIAqwC0IgcN1f9/jsznp
         BOAQ==
X-Gm-Message-State: AOAM533MasMuG0BEXxkNsp6KJA65NtuDnl+RinBtdq1z4wjHfBV9U9CL
        ZMVvmk2sBPb3j3wWuKLBbw4=
X-Google-Smtp-Source: ABdhPJzP29ePln4ZXlW32t2CxKCMeUUs77PwCElGjE4x1gpLkc9T2j2edFbcEn82HFt4GtiR/oxBFw==
X-Received: by 2002:a50:cd86:: with SMTP id p6mr39277465edi.212.1626763160269;
        Mon, 19 Jul 2021 23:39:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p26sm6775823ejn.112.2021.07.19.23.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:39:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Date:   Tue, 20 Jul 2021 08:32:35 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <12435060.NHVMl2pYiE@mfick-lnx> <87v95czn7q.fsf@evledraar.gmail.com>
 <3112447.ymCj9SdLpg@mfick-lnx>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <3112447.ymCj9SdLpg@mfick-lnx>
Message-ID: <875yx5wkt2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Martin Fick wrote:

> On Wednesday, July 14, 2021 9:41:42 PM MDT you wrote:
>> On Wed, Jul 14 2021, Martin Fick wrote:
>> > On Wednesday, July 14, 2021 8:19:15 PM MDT =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >> The best way to get backups of git repositories you know are correct =
are
>> >> is to use git's own transport mechanisms, i.e. fetch/pull the data, or
>> >> create bundles from it.
>> >=20
>> > I don't think this is a fair recommendation since unfortunately, this
>> > cannot be used to create a full backup. This can be used to back up the
>> > version controlled data, but not the repositories meta-data, i.e.
>> > configs, reflogs, alternate setups...
>>=20
>> *nod*
>>=20
>> FWIW at an ex-job I helped systems administrators who'd produced such a
>> broken backup-via-rsync create a hybrid version as an interim
>> solution. I.e. it would sync the objects via git transport, and do an
>> rsync on a whitelist (or blacklist), so pickup config, but exclude
>> objects.
>>=20
>> "Hybrid" because it was in a state of needing to deal with manual
>> tweaking of config.
>>=20
>> But usually someone who's needing to thoroughly solve this backup
>> problem will inevitably end up with wanting to drive everything that's
>> not in the object or refstore from some external system, i.e. have
>> config be generated from puppet, a database etc., ditto for alternates
>> etc.
>>=20
>> But even if you can't get to that point (or don't want to) I'd say aim
>> for the hybrid system.
>>=20
>> This isn't some purely theoretical concern b.t.w., the system using
>> rsync like this was producing repos that wouldn't fsck all the time, and
>> it wasn't such a busy site.
>>=20
>> I suspect (but haven't tried) that for someone who can't easily change
>> their backup solution they'd get most of the benefits of git-native
>> transport by having their "rsync" sync refs, then objects, not the other
>> way around. Glob order dictates that most backup systems will do
>> objects, then refs (which will of course, at that point, refer to
>> nonexisting objects).
>>=20
>> It's still not safe, you'll still be subject to races, but probably a
>> lot better in practice.
>
> It would be great if git provided a command to do a reliable incremental=
=20
> backup, maybe it could copy things in the order that you mention?

I don't think we can or want to support this sort of thing ever, for the
same reason that you probably won't convince MySQL,PostgreSQL etc. that
they should support "cp -r" as a mode for backing up their live database
services.

I mean, there is the topic of git being lazy about fsync() etc, but even
if all of that were 100% solved you'd still get bad things if you picked
an arbitrary time to snapshot a running git directory, e.g. your
"master" branch might have a "master.lock" because it was in the middle
of an update.

If you used "fetch/clone/bundle" etc. to get the data no problem, but if
your snapshot happens then you'd need to manually clean that up, a
situation which in practice wouldn't persist, but would be persistent
with a snapshot approach.

> However, most people will want to use the backup system they have and not=
 a=20
> special git tool. Maybe git fsck should gain a switch that would rewind a=
ny=20
> refs to an older point that is no broken (using reflogs)? That way, most=
=20
> backups would just work and be rewound to the point at which the backup=20
> started?

I think the main problem in the wild is not the inability of using a
special tool, but one of education. Most people wouldn't think of "cp
-r" as a first approach to say backing up a live mysql server, they'd
use mysqldump and the like.

But for some reason git is considered "not a database" enough that those
same people would just use rsync/tar/whatever, and are then surprised
when their data is corrupt or in some weird or inconsistent state...

Anyway, see also my just-posted:
https://lore.kernel.org/git/878s21wl4z.fsf@evledraar.gmail.com/

I.e. I'm not saying "never use rsync", there's cases where that's fine,
but for a live "real" server I'd say solutions in that class shouldn't
be considered/actively migrated away from.
