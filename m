Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488CFC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF62264F5F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCHMLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCHMKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 07:10:37 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D847C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 04:10:37 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id z12so1685815ooh.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vOwktvzdhzqjvmF7/a+eAa4I81e/TCuUY7b3G304xFk=;
        b=hwkPBg2KWGVq/lWGZoTD9dBrGJWUMDqi91DMHYtIQwgy9ddWOJBBBBzLiwxVFbijI+
         fm76FpR+I+ashfcap/qG74ASJHHqtaNBza7bXu1A3O2l8C/TPh2+H54bU8ScwsJuSobA
         ZUnA93oPZbRIdm+UwT8sagra0+mUATTXuxgxWbDQBoTECDbj03EkHdFbRenLrTShEgEU
         rNFSLCEyI0etvx673Nr4WQ+6dQu97OW8mrZcOz8G1oyoO34wJUV+z5w79GQ/wI3i6iGQ
         Vsdmwquri2A3DZR7mEXnXb+3e0X78nnFfSVmDkMhWQuHa7u3LAu97IgxgRxPfa5KzTcw
         vlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vOwktvzdhzqjvmF7/a+eAa4I81e/TCuUY7b3G304xFk=;
        b=Dwb2mXn+NHB4WuHNcTIb2LvLp6wn7kOki/XYgRhXI4SzntkX4wQWaax7QxySVPdfYu
         6WVCoK5JcS7akUn9mCPI0zTIBDJUeHxihuMi0WCa+WH5HtoPdsWOm8if/DHvDapC09FG
         zq+DI9cy3cbVo8PDyKxPJGrX+qkqSv9uWy34jXPzaqZXNWCSWCn2Af/F2r4/QoxETqL4
         L+r8UBV/7/g6dlQURF15359cm0wCPzbS7d7CsxLpo6qSW0FWp2roQxlxWVLxvhD+jylw
         RunwoNNvv50T0cQjTv4I46dm4FeRrqShcdla4EW+1+SvtKxkPnAuZi/hW9CFyt+ef2dQ
         z5WA==
X-Gm-Message-State: AOAM533KYEGPH91AWAQ/mHT/V8cUYBQKnWpdX7dJOA+MTwufSgcPLmLP
        xrFofj2t1RzJ2AV4it0fnSBMqBYweCMVfQrDVPMCCiGZaI4=
X-Google-Smtp-Source: ABdhPJyl7IFamRSqBpU8RaFei0lfCUwj4z99vzb5TjqnknCazo+7fz5BMqIEr2AJJx9dtLv0cniqcMdiL0pOg0A1iZ0=
X-Received: by 2002:a4a:de56:: with SMTP id z22mr18269502oot.14.1615205436596;
 Mon, 08 Mar 2021 04:10:36 -0800 (PST)
MIME-Version: 1.0
From:   Fabien Terrani <terranifabien@gmail.com>
Date:   Mon, 8 Mar 2021 13:10:25 +0100
Message-ID: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
Subject: remote.<name>.merge missing from the git-config man page?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I was recently trying to understand the git-push command's behavior,
especially regarding the configuration values's resolution. I read the
following in the EXAMPLES section of the git-push man page:

> git push origin
>     Without additional configuration, pushes the current branch to the configured upstream (remote.origin.merge configuration variable) if it has the same name as the current branch, and errors out without pushing otherwise.

I then had a look at the git-config man page and I was surprised to
notice that there was no documentation at all about a
remote.<name>.merge or remote.origin.merge configuration value. I am
definitely not a git expert but this looks strange to me. Am I missing
something? Is remote.<name>.merge used by git at all?

(before mailing here, I tried carefully examining git's source code to
see if there was a remote.<name>.merge value used somewhere. I can't
be 100% positive since this was very complex to me, but I personally
couldn't find anything referencing remote.<name>.merge, while I found
code using other values like remote.<name>.push, push.default etc.)


Best regards
