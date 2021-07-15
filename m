Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5AC1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8A761370
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbhGOI0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbhGOI0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 04:26:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C96C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 01:23:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hd33so7882061ejc.9
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iya98PLFwEdN36L1kjQgikE2ZAD/VC0wHZBIW7ZEKcI=;
        b=Xynjo5mKB1BE614kvJ74bMJlZRvn11oic6SFzs2YCFbl7fAREzz8RW/GYRbQM4rrJ0
         Xvb/cLoTEuC+3fsiNa57VAv6HDKe/8l5b10Kg3Q88dO5PJPo+Mh3aNS+lrCRNvX8C2BI
         wVhX4ZfonQ8TezC8sWr5wVVhsKdQ3FVFTQwuCkYAv/5Y19UM+SdOwbL3USGH28RMiwDa
         4ruJ7EZhjzh1cF322KNK3QRPpzg/y8mGVHxkwqsKuBNW199E81SrusBWWXSenNNR3wRf
         XhAHsrxni5aUxYyDIjK5DrCFTfECbELJI4T1dPFmrkW49wwOiqhYL7K8lYOkykDMSigQ
         S7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iya98PLFwEdN36L1kjQgikE2ZAD/VC0wHZBIW7ZEKcI=;
        b=K/d5xtpwv0+oHqxmuUPUCn0lVoWZctJFLmMuTe68AX/3rVC/qUGBa2QKNbNvKKHuOb
         cg65tMN+o5235cwoSk6TaYw3xqr+wDQksKEuGB/r80N49bcqpU6vbU/XeCFWxMdvVfmb
         6gmY+fVwhPBsbqE6QtjxJw4MaeXHO65ARjQdUibwxWZqFGCGNGqrmjrQ4aaXnoU3dOIX
         xxFHVvZwR9121qyp+/0e/axK1jD55Ky53IuH3magTuX6Iexpjih0ktF1iApczel6HLtV
         xGP7luhdjTrWpYIJsM2ZItuk/rXFyk8eKypVUT6ragBtSHVzqs43A/vLkGDN8H/jY4DY
         NcHw==
X-Gm-Message-State: AOAM531595GoxwdFiCSl50TfDQgr/ILw3gJZNN15vMmtMtOIDsV+q2TD
        /rhx9pNGHINNyAohcW9CrkzpLwqJ7PEoXDOl064=
X-Google-Smtp-Source: ABdhPJyOgkNEgEsmEq3db97Wjp8G4247CPsAyjLEBVYwgfgqIKT9kNaM/bpTDZMeZiYX549D1bukXvIBv0MAkElG1yA=
X-Received: by 2002:a17:906:dc93:: with SMTP id cs19mr4187295ejc.546.1626337396137;
 Thu, 15 Jul 2021 01:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <YO8XrOChAtxhpuxS@nand.local> <877dhs20x3.fsf@evledraar.gmail.com>
 <12435060.NHVMl2pYiE@mfick-lnx> <87v95czn7q.fsf@evledraar.gmail.com>
In-Reply-To: <87v95czn7q.fsf@evledraar.gmail.com>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Thu, 15 Jul 2021 10:23:04 +0200
Message-ID: <CAL3xRKee3YmOrV_-4Tu6FmJyRnS2y-tdiAmXp5TjzL_WxQNrtw@mail.gmail.com>
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by configuration
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Taylor Blau <ttaylorr@github.com>,
        Sun Chao <16657101987@163.com>, Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

On Wed, Jul 14, 2021 at 10:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> *nod*
>
> FWIW at an ex-job I helped systems administrators who'd produced such a
> broken backup-via-rsync create a hybrid version as an interim
> solution. I.e. it would sync the objects via git transport, and do an
> rsync on a whitelist (or blacklist), so pickup config, but exclude
> objects.
>
> "Hybrid" because it was in a state of needing to deal with manual
> tweaking of config.
>
> But usually someone who's needing to thoroughly solve this backup
> problem will inevitably end up with wanting to drive everything that's
> not in the object or refstore from some external system, i.e. have
> config be generated from puppet, a database etc., ditto for alternates
> etc.
>
> But even if you can't get to that point (or don't want to) I'd say aim
> for the hybrid system.

FWIW, we are running our repo on top of a some-what flickery DRBD setup and
we decided to use both

  git clone --upload-pack 'git -c transfer.hiderefs=3D"!refs"
upload-pack' --mirror`

and

  `tar`

to create 2 separate snapshots for backup in parallel (full backup,
not incremental).

In case of recovery (manual), we first rely on the git snapshot and if
there is any
missing objects/refs, we will try to get it from the tarball.

>
> This isn't some purely theoretical concern b.t.w., the system using
> rsync like this was producing repos that wouldn't fsck all the time, and
> it wasn't such a busy site.
>
> I suspect (but haven't tried) that for someone who can't easily change
> their backup solution they'd get most of the benefits of git-native
> transport by having their "rsync" sync refs, then objects, not the other
> way around. Glob order dictates that most backup systems will do
> objects, then refs (which will of course, at that point, refer to
> nonexisting objects).
>
> It's still not safe, you'll still be subject to races, but probably a
> lot better in practice.

I would love to get some guidance in official documentation on what is the =
best
practice around handling git data on the server side.

Is git-clone + git-bundle the go-to solution?
Should tar/rsync not be used completely or is there a trade-off?

Thanks,
Son Luong.
