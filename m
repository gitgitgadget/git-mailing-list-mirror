Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7BEC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C50120671
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnWUCOMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEOPZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726241AbgEOPZx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 11:25:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D4C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:25:53 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j145so2544435oib.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqbqTcczSoAOScJcjiaz87sNogj9utuPyA+OJBLTHgA=;
        b=hnWUCOMKKtn9d0x4tExhd9iHl8hEJKO8bPRBK/L3JgpdxxsCFFKklF51n3s5c9hSRj
         4CEJBIdlw+yU5xfCe5pxNdppZynrwOhBzjlkCAkShokOfrFElSdBQNVPxfLr9WIADWtk
         F/GpVx02JcMMptsdtB7l3hQlJJSofjk74WwCAA8jisTbF4ZFLK10J9gImOV5bBoZJ8mB
         1HfVKeyNAP1UNEfVDB5XIMZMH+3fjaLpOUCZqw3x19yPYl8ppGlHkzSE4f9Zvr2lle5v
         S6wW4Pqh1Z4V7bTPeOwzqsfQuPGGqpzqd9e+gSnZKEBPVN23XFDdoFjC/aRG431qhOvW
         n3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqbqTcczSoAOScJcjiaz87sNogj9utuPyA+OJBLTHgA=;
        b=NVqEkAb6MGotOkzMry2SATTTmKfSARfQ45VXRk70TX5gU1jY8+lkoLWYELFdx6mF3d
         In2K4a6BbQPN6xt4N4rE/hJNDzUjiqlMK4d+SvanCCO0q+dH9jjJTdTDfdYeAlzrCR49
         H61i58tRPp+F9+BQuiEEs/rpHP533HYDHCgcJtidbZbccrW9ZkFnjHJ2c5W5h4gujBYk
         xDzJg5jyd/hlGoHyPyNuRjKiug4rirChUz+I56m1iVABtOqtxNAkYehDbZXSKAD2/dWS
         akg4S8KOva+syqf1ohI0K/SvDIdxuyetTaX6cyz991+hjC3VEfmALba+G3DlSL+LDBk0
         GOww==
X-Gm-Message-State: AOAM532DTD2KkZdKTkYaA8wxjRFDL2Qqk0oHthvoG7i9DSAePWxrGX+D
        4aPkIO0lfPHRn6WX+oTLfrjh4tfp77APDzQ/SO1HIHWi
X-Google-Smtp-Source: ABdhPJwJvaVgCMHCSomUnH+jCTBQk5bAn6RsRLiqQ7/DSu8lUVnQigchbwjLn+DXshsUZOM5IxJIrXtVbGFSMtRO0Q0=
X-Received: by 2002:aca:40d4:: with SMTP id n203mr2589761oia.39.1589556352582;
 Fri, 15 May 2020 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 May 2020 08:25:41 -0700
Message-ID: <CABPp-BF2Nh8LntDfw7-zSry00QKWg68qKOFW9QHvtqrSvU=Utw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2020, #05; Thu, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 6:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/merge-rename-rename-worktree-fix (2020-05-14) 1 commit
>  - merge-recursive: fix rename/rename(1to2) for working tree with a binary
>
>  When a binary file gets renamed and then merged with a minor
>  change, the copy on the working tree while conflict resolution
>  sometimes got "their" version and not "ours".

This summary feels misleading; it's not simple rename + content merge,
it's double rename + content merge.  Perhaps:

When a binary file gets modified and renamed on both sides of history
to different locations, both files would be written to the working
tree but both would have the contents from "ours".  This has been
corrected so that the path from each side gets their original content.
