Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A8FC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC0D20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQilZ0eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHBBA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBBA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 21:00:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9196DC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 18:00:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so11391195wmd.4
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1tRON9jhY9UZYVyZ4TSNzdUCkvfOqasMGbfxYOxRlNg=;
        b=GQilZ0eZaTbz670z8ykaXWTswwfYa0DpjHqfV0JfpegbKFHofqaEHUFTRBvUrTHRhm
         P9moqvAe51vurp3qEmiAW+IAA28mJwVqqcdr+mzJVhvwoBWXVTOTMfnK1duTLN2gkMum
         dPM1lPbB2PPuABaf3hflKEyBnxOl2E/LEgt849pKbjODPBqIFNGSxpUyCBcNye7wLQ1N
         enln5jxBpWlXhWU2Z3XHaqLjQrekTHhAVdaDwXgfK0kjOPIrFEumr3SB5ud4zThe9d58
         PZWRjrVGskM6Ady26ikEfotzWwUHzI/u1YNSgEQ2KpSZ9KVn41tQV+/8w5ESbpfQK87k
         cjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1tRON9jhY9UZYVyZ4TSNzdUCkvfOqasMGbfxYOxRlNg=;
        b=hzZrPzdHjiyzbg3lvAEkqg5ZshsPmfpdfRv1N0+J8jSkumFkiDYPX3kYnAK9BK3i6C
         yyh03/4OvzRDYIsU07NRXAyY35NGckf9hzFA1F2a7DLns4OTqXD0bOrpL5pa40PCOQS8
         eVds0Z/g8MNAJ12VFsPN8FwTgrXXjtoZXrEsF/MLRZgmrb6tlE/BS9F/oxJ1zZyeDuwY
         P6eBXIrWyX9a3hIkVAH6lW33rMSXbAxYvTpPCGgoHKdZVAGHkZYYAKWcS1Juh02JSkJe
         JLgdTVhsKBKG1glJUBAs86rjoNOg9shYao0rCbCu5t32EFxW7sjz3DS7qaHQpa5z3E1o
         9SMw==
X-Gm-Message-State: AOAM5324VrHelLfJNKmNsefcJ+UawiJnnxRyiuyXqReEufLHJkjevLAZ
        J/3y3NwdQgLIOBLPYMcqAlHJap9mBbgZRuT1rhA=
X-Google-Smtp-Source: ABdhPJzd/n3AO9H6wauncqThmCWgLhBIftRLkiic12/Vv31i3bv3FxbvNxHZojw58TIr00T3cOspwwq9ye2ouvSR42I=
X-Received: by 2002:a1c:a513:: with SMTP id o19mr9631681wme.119.1596330056250;
 Sat, 01 Aug 2020 18:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200801220611.10453-1-martin.agren@gmail.com>
In-Reply-To: <20200801220611.10453-1-martin.agren@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 1 Aug 2020 18:00:45 -0700
Message-ID: <CAPx1GvcZFVfmP8aTdXu_epdSn1EDy_cP6-=hi65c_5DbNEq+FQ@mail.gmail.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 1, 2020 at 3:08 PM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
>   printf '\0'
>
> to generate a NUL byte
[but]
> end up injecting the ASCII code for "0", 0x30, instead.

> -       printf '\0' | dd of=3D.git/objects/pack/pack-$pack.pack bs=3D1 co=
nv=3Dnotrunc seek=3D12 &&
> +       printf "\0" | dd of=3D.git/objects/pack/pack-$pack.pack bs=3D1 co=
nv=3Dnotrunc seek=3D12 &&

In sh/bash, this should make no difference, and that's what I get here.
Am I missing something?

$ printf '\0' | hexdump
0000000 0000
0000001
$ printf "\0" | hexdump
0000000 0000
0000001

Chris
