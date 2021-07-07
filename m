Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1667DC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB77C61C90
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGGBir (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGBir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:38:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748EC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 18:36:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so2673371pjl.5
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 18:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2JgEa9Eqg3o3Gg1ULeQCUp4qiru8pOtVCi9o/KRPaX4=;
        b=IYh/AOYCZeKbbz2Tv+vm4rSIKc9WWEcxWwLjBnG/2absGOb1FHg3rS9xphhKUe251x
         n26ZIJOgrXmGnxMZPyT2E9Z9CmtWsRQocsdIqIXF3ebl5RUBLsoiJBiorh9bwlsHfLBr
         g3rtAwu/bYFlX6JRLyx/sC3aRkSeBX2cZFkcQ2G0LwdJqR5MSHCbe+OFg/QFK+hO6Y08
         vvKiLuS30pgGcis/9haSWzdKrPaK9M8bU69klSYW5bgWSbPFikIGl5fiQyghQcvgNziu
         XP/GP33cf+r2hmPMaLw0FuEcPga1WP1vnRMmZi4oq5NJp4V+94uYKFpMmufBAD7kwDcy
         ImDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2JgEa9Eqg3o3Gg1ULeQCUp4qiru8pOtVCi9o/KRPaX4=;
        b=PPguzNCX8yZYrTIE6+ArLycHD4Gv+RgMfyN0N3MnpVGxQQ+BxLp/VXlMuAg1j+epYL
         W+wSo7ouwWVZ7rGT+P9fGELu+eMS/HQq0drxy9QxnXV5e5BXMVjivsQr/q1MVg3F29hb
         s7fw5RaWKcRR6v/QRlUcypW4YyCnbihequMLew4jJeR3UbqZprlWakXctOppIP/WpOh9
         oufVxe73Rrv5SGIE+CBiYzKoq6jqoS4RnQGWGFNLCefCG1bEmbFMCIgoEiD35tiIfg50
         bDsCvjpXQFZM3Rk+ywvWMvkAAS1x8/prFfaNmK1ZXadNHvj7ybtG+S1NqigJcyToY9Fp
         riFw==
X-Gm-Message-State: AOAM532Z7Utbj6tN8WojXZ1c2OoOz2Th90KnxuMAdengNRYv6+CusA0Q
        GZVUZT8WveOqbq40GC+lqFskXVKiw/wVIq2o7Bq+kvRD
X-Google-Smtp-Source: ABdhPJzfzKRblzqEifIZaAyow2q20Pzau4w24wLDHNemm9kR1nLvkmTXxfB2sS9HBRtOL9QzGpgWw68/11L/qij44cg=
X-Received: by 2002:a17:902:9042:b029:129:7ee5:ac27 with SMTP id
 w2-20020a1709029042b02901297ee5ac27mr13630313plz.83.1625621767050; Tue, 06
 Jul 2021 18:36:07 -0700 (PDT)
MIME-Version: 1.0
From:   Aaron Hall <aaronchallmba@gmail.com>
Date:   Tue, 6 Jul 2021 21:35:30 -0400
Message-ID: <CADrEZfE+LuDnhWkRHPMwHq7aGYcvDeqken8uZzPgHREtf0iqjA@mail.gmail.com>
Subject: Default ssh command
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to push some binary files (PNGs) over ssh and found some
files inexplicably wouldn't successfully push.

I set, in my .gitconfig file:

[core]
        sshCommand = ssh -e none

And it works now for all files (that I can tell).

From a close examination of the output where I noted escape codes
showing up, I believe the problem to be ssh escape codes.

`\n~.` for example closes the ssh client.

Therefore I think the default ssh command should be `ssh -e none`
instead of `ssh` for the benefit of users who won't recognize the
problem, unless `git` is expected to make use of ssh escape codes.

I'm new to the mailing list, sorry if I missed some protocol here.
Thank you so much for working on `git` and making your work
 available to the rest of the world. Cheers!
