Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF040C2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD83420722
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 15:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnDa5/iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLYP0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 10:26:22 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:42107 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYP0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 10:26:21 -0500
Received: by mail-qt1-f177.google.com with SMTP id j5so20447974qtq.9
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmnvNGTWLOSRGyHV3OmSfu5QwmF2MYqWrcPP0LC0VE0=;
        b=RnDa5/iX7383Ov8j8BoMmKDV4tgxiSFymDiQza0KJ6vFlMfa3VC2gsyD7IcUP6D2Nm
         BNTTclZTJJL3WxfGo8y9EhfXh6+GgyyB9CGXyK7kTDvTYlMgmc6MQSpwxmAzexgd9kaH
         qyIL76RYAEgJrGgdexLq9pHkH+VINUGdE7wZmTAOpo9E1OieF4NAwM0TVEHl1WF2bU+f
         3JDLdFX6WErL17nzo+GtGgIUQg2zloTNvLQBUIvtgNswmSWYd2hgYAfHheOFvgAMM/AH
         JIwkSnKDtQDVae0SCJEvcoRwXju81cQTtv//pypDDD1fXlVyq/U/3bQYGqrLlOp7tKWB
         jbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmnvNGTWLOSRGyHV3OmSfu5QwmF2MYqWrcPP0LC0VE0=;
        b=LSkiq5EkSub41Z4WjObK9LHTO46wKDBnEQCabRcUmd1KMzYViYQ5vUHRd4NQMFAIQ1
         kpU8hV45JYyIIis8q4q4EWaEYzIYoz5NEKgZxIUmjj4NNwVY/dApe0VsSbyU5TZVT3pV
         4r7L7avNOMwMmMIihowRbPA/rtu1Tia3OPyiEPHeB6Z9oNHOGFpsDlx/hkmvlR+3px2o
         Marvy2hiknuZcDMeunpoYX4xARFjj6uons91j29G9jLKeBqN3UO2iukSFLnmj7UELpT8
         7KvDoH4g75RdoBJGNUMil/etMambFlTKsDR4tijh6wXgl/h1neMoXkamj3Xd8HZ0MuqO
         2Mow==
X-Gm-Message-State: APjAAAWEUDsWaLGh95mJ4MJbHar945pcy1kSHlUStAeJjOjPT3pNWuE+
        VW/ZC234ii+9JTx0azR7xasJn35Er+cKWROg0xw=
X-Google-Smtp-Source: APXvYqw7eApl0BZujKyaGSfa2p4STY/skbPlDiBtKodHqcTD0EPGi/+cZMBH6lXZ0tuuZtIAI/Iu+UPTfn9g8mTffaQ=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr30830378qtp.224.1577287580765;
 Wed, 25 Dec 2019 07:26:20 -0800 (PST)
MIME-Version: 1.0
References: <CA+PpKPm0_zXr978Mw8h7owHBChx-uqVCdjrtuh45uOS-A_0qrA@mail.gmail.com>
 <xmqqy2v14iwc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2v14iwc.fsf@gitster-ct.c.googlers.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Wed, 25 Dec 2019 23:26:05 +0800
Message-ID: <CA+PpKPnCrSciiNinC9g6BVX7DHXPDq8k2zegK+-9Yg2CPzF_bQ@mail.gmail.com>
Subject: Re: [BUG] `git diff` treats an unchanged line as modified
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Dec 2019 at 03:34, Junio C Hamano <gitster@pobox.com> wrote:
> IOW, there is no *single* diff output that is correct.
>
> Among many "correct" diff output, there are ones that readers find
> them easier to understand and those that look suboptimal.  The
> differences are often personal tastes.

Thanks, this explanation is clear for me.

> "git diff" has options to tweak heuristics it uses to choose among
> many "correct" diff outputs, like --patience, --histogram, etc.
> Perhaps using one of them would produce one that match your taste
> better?
>

After understanding the correctness of diff algorithm, the default
algorithm also suits my needs now, although the patience algorithm is
more understandable in some special circumstances.

Regards,
Hao Lee
