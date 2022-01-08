Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5FC433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiAHBON (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiAHBOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:14:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C1C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 17:14:12 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id i31so21439513lfv.10
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DmTzwgnZ11uK2GjABkaxvnxbCMdmUy/yIkdHE6nCAUM=;
        b=dr3PCxUuTkMVoqx7tHPRAn/dcD/ScAeaMJPhTao6exVYEiaPmdjzOHZgWUlrM9cJdO
         AmE0hyaqDXzjHeyDzKDsH2WfLsH+6wdHQBKBpS6ByClqbCDIYcAP3pj52tjY9pYPsWnd
         SbnEFhGQvOVdux++V1IehXlGx5U0dpoQZlvX0dvgCBJi46KAWL38DLamigZrKo6IZlED
         1ogHqy79/oIQRZD+VOumS0CDTmEjV10qXhJlRHACbdEdV7+2e7zWFmz/saITmZYRqN4A
         nR6eMittS3rqeH2aQPCK96LzsEgXKuNi/LHQKr1mJg+YG9tb8OTnHlYM17Vhk7Istju7
         0pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DmTzwgnZ11uK2GjABkaxvnxbCMdmUy/yIkdHE6nCAUM=;
        b=hLpbyfYuOimx6kK08rbuX4SP5bchKHtrX977AOWCrHUIEhtrpr0pqg1JIIKTMMKVJB
         UU+CAFM3Ntdowost6X3PVr6SrP3WLvYlpbVRc/svI5BfQ1amRQJWLBdXBT44PeKuAfZd
         gQ60xYudRlOesoZJ9oW4qjN4Vug6s1XqJzJUe2vkvaIggnFJ3uniwIeN5nyehjtGufbE
         f0pWgx8RcWR9VpnnhE8JtXHAmnxV6BiFSgZ62dRqHOyIL09CMnolu5OQVNQvYAy+fHAJ
         QToKaDkw0HUtVcySdvx/VB9frTR+gXz2nf0AP7uISkGMrWoO7p8OF3ft3b4baM/QMCjW
         iq3w==
X-Gm-Message-State: AOAM533kEJy0EJCJMBy9XSWIjNgbbsN57nTny0SmigUVlYG8Qc+Grsv3
        FW6cGM+H++2Icoe4FxsONWM/SrcqVLbOQgox/+9eHPNz1yo=
X-Google-Smtp-Source: ABdhPJw2hPs7reixFj1H5BhLQp7OljmSyW94SVYtT1N8dG+Q/JKH0HMBYC5H39q6vmmav4EyU1wgbBf2sLy7vTOIBjo=
X-Received: by 2002:a05:6512:3196:: with SMTP id i22mr56593579lfe.241.1641604450415;
 Fri, 07 Jan 2022 17:14:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 7 Jan 2022 17:13:59 -0800
Message-ID: <CANQDOddJzgyfQHi8hVMPU5iLwyt4GmpGt5qob0ZrjqTax6K0tw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] A design for future-proofing fsync() configuration
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Everyone,
I wanted to revive this thread in the new year.

To summarize the current state of affairs:
* The current fsync patch series implements two new configuration options:
       core.fsync =3D <comma-separate list> -- select which repo
components will be fsynced
       core.fsyncMethod =3D fsync|writeout-only  -- select what form of
fsyncing will be done

* This patch series now ignores core.fsyncObjectFiles with a
deprecation warning pointing the user at core.fsync.

* There is a follow-on series that will extend the core.fsyncMethod to
also include a `batch` mode that speeds up bulk operations by avoiding
repeated disk cache flushes.

* I developed the current mechanism after =C3=86var pointed out that the
original `core.fsyncObjectFiles=3Dbatch` change would cause older
versions of Git to die() when exposed to a new configuration. There
were also several fsync changes floating around, including Patrick
Steinhardts `core.fsyncRefFiles` change [1] and Eric Wong's
`core.fsync =3D false` change [2].

* The biggest sticking points are in [3].  The fundamental
disagreement is about whether core.fsync should look like:
      A) core.fsync =3D objects,commit-graph   [current patch implementatio=
n]
      or
      B) core.fsync =3D objects
          core.fsync =3D commit-graph    [=C3=86var's multivalued proposal]=
.
I prefer sticking with (A) for reasons spelled out in the thread. I'm
happy to re-litigate this discussion though.

* There's also a sticking point about whether we should fsync when
invoking pack-objects against stdout.  I think that mostly reflects a
missing comment in the code rather than a real disagreement.

* Now that ew/test-wo-fsync has been integrated, there's some
redundancy between core.fsync=3Dnone and Eric's patch.

Open questions:
1) What format should we use for the core.fsync configuration to
select individual repo components to sync?
2) Are we okay with deprecating core.fsyncObjectFiles in a single
release with a warning?
3) Is it reasonable to expect people adding new persistent files to
add and document new values of the core.fsync settings?

Thanks,
Neeraj

[1]  https://lore.kernel.org/git/20211030103950.M489266@dcvr/
[2] https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/
[3] https://lore.kernel.org/git/211207.86wnkgo9fv.gmgdl@evledraar.gmail.com=
/
