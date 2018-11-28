Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5C51F609
	for <e@80x24.org>; Wed, 28 Nov 2018 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbeK2Dxe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 22:53:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40922 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeK2Dxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 22:53:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so22663401edx.7
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=TTLRAkF5fB27OxVmLYIVrTlysRT17bOoN/3RPqBYVpM=;
        b=X7JW0VrXFgrXonH+JrNpQ0RpRjuT8LZQXud3wwUwZy0t0Dgezy/PWtNpmTemoK4El+
         vjJvW3T5zR11skIRC9LN+7664vU5bBxpynctIOpzEUxHiV5+x5+LOJxR0k2DtOIhBe15
         OzzJcmoK7/veby54v+YQbPI/C6fKwjccJE+S0YncE6AzUnRXzAIa9Uoq1RnGYP4cwGBC
         OX87WPoNHoHkUtWGtiv6UjZs+NHSwwEz9CXER/j6AwrTGNIs2VNW6OX37dQQPD51XciX
         9Z62IGuK3juzraeE398ZumdeuMd6TwrJ1R3YMoXUcubyFrtjwG+kThNgbpN0BIlcbuSC
         9uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TTLRAkF5fB27OxVmLYIVrTlysRT17bOoN/3RPqBYVpM=;
        b=eLLFOjTVySAT0tij4RPH+Bvo7oZ1VxPvUrJRUs9whtvA4VHWREblnzC3VlTZNyU6jn
         r9IkG06x2TgY8CGO40PFZVmRbe/PxivCmg+c2eYZHdO/vR/o7EExI7U0H07x+MmXsp/8
         6BVkW7Q90aNGvYBRBsxzT7pDx3x6PqEf9KdNYbzrfA7FfrzXYFzIfC6qOsfHzmYf1vwk
         Bd9311KiOGGSASHlokhL2m1K1yGnuGj6qhLsPbCp7X6YhGxHLEhmp1BUGGvwPPIg4P8F
         S54Lqnb8qvnIL3OrFQCTGbaTip77NwTaIZySgyQKSZD/gqB+c6YYM/uva8E+wAXufIXQ
         lQYw==
X-Gm-Message-State: AA+aEWY5cuVe2wpdBCl7hYoOuDFbctecCzbCFJ+d2JnBE+okGEGXEAg7
        AMJO3hg4IRQ1z/ePjpAGFT/6lnhv2tD79RMOFqLz8F66pML+y2W9
X-Google-Smtp-Source: AFSGD/Xs9MEnOqc2cmYlqkZ1viiyPtZWKOm26KFrbDgHLvABKXk/nmBOuiX4+552xNi66RhDasIvxX6CsebfVo+wDQQ=
X-Received: by 2002:a17:906:7087:: with SMTP id b7-v6mr8105705ejk.194.1543423875169;
 Wed, 28 Nov 2018 08:51:15 -0800 (PST)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 28 Nov 2018 17:50:49 +0100
Message-ID: <CABUeae-e33Jc4s4MezjhpVsEJ_0sO8QZ1mpa1z_79ZGuQWM-Xw@mail.gmail.com>
Subject: Simple git push --tags deleted all branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(using git version 2.19.2.windows.1)

I've just encountered one of those WTH moments.

I have a bare repository

core.git (BARE:master) $ git branch
  1.0
  2.0
* master

core.git (BARE:master) $ git tag
1.0.1651
1.0.766
2.0.1103
2.0.1200

I published the repo using: git push --all --follow-tags

This succeeded, but there seem to be no tags pushed, just branches.
So, I followed with

core.git (BARE:master) $ git push --tags
To XXX
 - [deleted]               1.0
 - [deleted]               2.0
 ! [remote rejected]       master (refusing to delete the current
branch: refs/heads/master)
error: failed to push some refs to 'XXX'

And, I've found out that all branches and tags have been
wiped in both, local repo and remote :)

I restored the repo and tried out

git push origin 1.0
git push origin --tags

and this time both succeeded, without wiping out any refs.

Could anyone help me to understand why remote-less

git push --tags

is/was so dangerous and unforgiving?!

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
