Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F744C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 16:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBOQhd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 15 Feb 2023 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBOQhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 11:37:32 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300435258
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:37:24 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id bd35so8123335pfb.6
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676479043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd+X4ZF6jOnyajBJ+PnixkwaaANSQx07RvBwG9UvadE=;
        b=N3VXXSJMDxMYnLj0vSTQZueKV1aIKsYHTKEmxD/3UtoMB9UUKXII2hoq81SxYA+OBk
         ykqYwNveHtG7BzDasAYmGmKcsMlx/aIxNy0UAall7EoZ6IYj2lPN2dsebPjzvTQaHxNE
         lqmSIiH0f/XrIP5Jkt7VZV95AtKpx83CbS3ZNW/6py+z8NZ1h9WO8efpgMfnvsCmzLQB
         haCAMKkLIwLx3q1MNFn4/mbWh2i/EyhXHL01PxIISK83XLlueto+NTWMcj+Qg9bQF6ZN
         yl2wyIrFY2BPfOKkEEXK8O7LSMGZ0jwMukG5Qp4UiQy77U3axgw6n+6eTz8SXu3WkLHa
         0qnw==
X-Gm-Message-State: AO0yUKWSs3BoH0OtGlm7LVvHSQlnTsu6Pva5bFEwV2v5eOf8yx4B1VyU
        cVfjsmVEYm4OJjjsHQbYMk2RMWCf30ESt4sAkWY=
X-Google-Smtp-Source: AK7set+9IDAiR98FpuvsHtzVFj4B3rjR2YGnNPqqSEmfstEBuXyka/AeHgYtcvtnBCMivJIepOgGa53dOdJ7JPI62Aw=
X-Received: by 2002:aa7:8eca:0:b0:5a8:c0e0:3b2 with SMTP id
 b10-20020aa78eca000000b005a8c0e003b2mr449015pfr.45.1676479042928; Wed, 15 Feb
 2023 08:37:22 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <20230215162648.py7diaasrymezntl@tb-raspi4>
In-Reply-To: <20230215162648.py7diaasrymezntl@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Feb 2023 11:37:11 -0500
Message-ID: <CAPig+cRmgGssbN=dDmeDeNeBJhcjvtzxg6O_ZNX5U9kWY0jfZg@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 11:33 AM Torsten Bögershausen <tboegi@web.de> wrote:
> It would be helpful, to pipe the result into xxd:
> git symbolic-ref --short HEAD | xxd
> And then see, if there is any garbling inside or outside of Git ?

Here's what I get:

  $ git symbolic-ref --short HEAD | xxd
  00000000: e6b5 8be8 af95 2de5 8a0a                 ......-...
  $ LANG=C git symbolic-ref --short HEAD | xxd
  00000000: e6b5 8be8 af95 2de5 8aa0 2de5 a29e e58a  ......-...-.....
  00000010: a02d e58a a02d e5a2 9ee5 8aa0 0a         .-...-.......
