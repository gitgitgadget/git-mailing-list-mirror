Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F795C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69615206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTBM8Lxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgEEQDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgEEQDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:03:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67FC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:03:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so2908440wmj.1
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/gRrf3898gEFTL2UsGG4+YDUQOoHSmQaoyNcyILBy2E=;
        b=OTBM8LxwdV8gHmKN42jhwXmGtgHBUVT+s2KHkOICpXPJ4RkkHUO5ESAax/ur+GVGyP
         Myr8XMcQBmCblaUC8j9BAP6fwPHX6KXb2Ka5b03gpZN9nEPWJHTzTTF5gukZE4q83ivn
         iT/n7DPJvBYHlJtkkeCFXqidLmHTlWdN0xHgf9Mte9A3asScbxrCttDVwwp1EhcDrul3
         +YlBSil8Tb7LCRuiMQ74v+PrN7dxdqq6ou5mCq+t/OFcYLSMEkpJ0+gASJac0uU8hFZJ
         AnHuvcfAj4hACeew6hx+MbwdIgba46Ta8GnqsW5H+eJNs3AQ6f+vEwwmMYCsRq2xFcwe
         z/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/gRrf3898gEFTL2UsGG4+YDUQOoHSmQaoyNcyILBy2E=;
        b=m3TG5egGDo91GKmOWCTuxTJ6HrHfStOgw+boh1bWGu6IOQM2BFXDuY3OYhtGqkSjZa
         n4qClzwfkbGlGrg3SG7q1/FsxdshlHYTXfpDs80f5GVPxQBz1tEK/aTdwwaSvULXLyvR
         7GMno7aUGu8IZVwCcb2S+K+uawGmkr5Huk6KPeO0IWk7vPd2pN9vyac4kSamUD200oPD
         stx/WWpMpM6FwpZhxUDpl4WFfTaAryDpdFAPQANfA8TTEJWZfXiBuvxbhJMgKroD3uaQ
         qfE4UJC3oUIcRsaDsOc9m0vIE/RTvdVSk9/f6l7izjHrCL9Zp2IeSZrgQwlCJ/uHYoj1
         ropg==
X-Gm-Message-State: AGi0PuZFxLDimz7iR/LxMUkKzqrwI+20NKAe9sWGtOeFsEARFqowaY/4
        Y93SvruWQCQr3kw0NzP2DIE=
X-Google-Smtp-Source: APiQypJ/wY1inWyAXSAiHFfR/KyVonrxAE9keKIg3qAu9tmj8kujMIX4PoaToDPyvdcLlJaAtRaInA==
X-Received: by 2002:a1c:7d04:: with SMTP id y4mr4195129wmc.10.1588694614498;
        Tue, 05 May 2020 09:03:34 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:4c05:518a:3ad9:8dba? ([2a02:a210:ca2:9c00:4c05:518a:3ad9:8dba])
        by smtp.gmail.com with ESMTPSA id n7sm3886917wrm.86.2020.05.05.09.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 09:03:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] midx: apply gitconfig to midx repack
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <8bd91a14-75dc-76e2-31b4-54eff5bea8dd@gmail.com>
Date:   Tue, 5 May 2020 18:03:33 +0200
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74A7FE73-6B5F-4DCF-9A57-AD11306CFAF8@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
 <8bd91a14-75dc-76e2-31b4-54eff5bea8dd@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

Thanks for a swift and comprehensive review.

> On May 5, 2020, at 15:50, Derrick Stolee <stolee@gmail.com> wrote:
>=20
> In the scenario where there is a .keep pack _and_ it is small enough =
to get
> picked up by the batch size, the 'git multi-pack-index repack' command =
will
> create a new pack containing its objects (and objects from other =
packs) but
> the 'git multi-pack-index expire' command will not delete the pack =
with .keep.
>=20
> The good news is that after the first repack, the objects in the pack =
are
> in a newer pack, so the multi-pack-index will not repack those objects =
from
> that pack multiple times. However, this may be unintended behavior for =
the
> user that specified the .keep pack.

Yup I experienced exactly this when trying to test midx repack/expire
with biggest pack file marked with `.keep`.
Luckily the storage size bump for duplicated objects was not noticeable =
in my case.
You worded the situation precisely.

> I think the right thing to do to respect "repack.packKeptObjects =3D =
false" is
> to ignore the packs when selecting the batch of objects. Instead of =
asking
> you to do this, I added a patch below. Please take it into your v2, if =
you
> don't mind.

Gladly.
This should help me a lot for re-rolling V2.

>> +static int delta_base_offset =3D 1;
>> +static int write_bitmaps =3D -1;
>> +static int use_delta_islands;
>> +
>=20
> Why not make these local to the midx_repack method?

No practical reason except me shamelessly lifted those from =
builtin/repack.c.
I was a bit confused how `git repack` houses these logic in the builtin =
file,
while midx was having these logic in the midx.c instead of =
builtin/multi-pack-index.c.

I make them local in V2.

>> int midx_repack(struct repository *r, const char *object_dir, size_t =
batch_size, unsigned flags)
>> {
>> 	int result =3D 0;
>> @@ -1381,12 +1385,25 @@ int midx_repack(struct repository *r, const =
char *object_dir, size_t batch_size,
>> 	} else if (fill_included_packs_all(m, include_pack))
>> 		goto cleanup;
>>=20
>> +  git_config_get_bool("repack.usedeltabaseoffset", =
&delta_base_offset);
>> +  git_config_get_bool("repack.writebitmaps", &write_bitmaps);
>> +  git_config_get_bool("repack.usedeltaislands", &use_delta_islands);
>> +
>=20
> It looks like you have some spacing issues here. Perhaps use tabs?

Rookie mistake on my part. Will fix it in V2

>> +	if (write_bitmaps > 0)
>> +		argv_array_push(&cmd.args, "--write-bitmap-index");
>> +	else if (write_bitmaps < 0)
>> +		argv_array_push(&cmd.args, =
"--write-bitmap-index-quiet");
>=20
> These make less sense. Unless --batch-size=3D0 and there are no .keep
> packs (with the patch below) I'm not sure we _can_ write bitmap =
indexes
> here. The pack-file is not necessarily closed under reachability. Or,
> will supplying these arguments to 'git pack-objects' actually do that
> closure?
>=20
> I would be happy to special-case these options to the "--batch-size=3D0"=

> situation and otherwise ignore them. This then gets into enough
> complication that we should update the documentation as in the patch
> below.

You make a great point here.=20
I completely missed this as I have been largely testing with repacking =
only 2 packs,
effectively with --batch-size=3D0.

I think having the bitmaps index is highly desirable in `--batch-size=3D0`=
 case.
I will try to include that in V2 (with Documentation).

> At minimum, it would be good to have some tests that exercise these
> code paths so we know they are behaving correctly.

I will do some readings with the current tests for repack and midx.
Hopefully I will have something for V2. (^_^ !)

> Thanks,
> -Stolee

Cheers,
Son Luong

