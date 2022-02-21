Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADDAC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 23:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiBUXeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 18:34:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiBUXeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 18:34:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302924BF4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 15:33:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cm8so23000974edb.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:user-agent:message-id
         :mime-version;
        bh=+5Vig6JIOvRsTj7bPaQTBCr432vs+U+vn/sfEyq+DM4=;
        b=ZYAndfHHjKZWsm7mrBgXXDrfLeoD74xL7l0ZBdfJv1vQoYGjeGMMXff4iem8xS6Cih
         aWl/F4caJ3lr/gSlwFUEto5Ppna8p/ShjAE7i0ouFe0/PwP5Qy/NMic1o/3FRsXRIEAC
         TVQaBtJAI8oG2Ebx8dxdUeRnH3UYa/M5bju2FjTG4wJQo3FpoAMqU+vQbJ+R7aCG9Dmf
         KL9GvsN4/gwk8PJpAExpu0oNijWLfVYHqMJSZLu8SkwZUgsWw5zuaUkdSc0aKK1mLDef
         6vdAYIqwsuLaRY0rfkNhibKeS5puzTcsaxHG0hjqt3z+vmRT2nn6gnwZDj/CULzi5poq
         pOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:user-agent
         :message-id:mime-version;
        bh=+5Vig6JIOvRsTj7bPaQTBCr432vs+U+vn/sfEyq+DM4=;
        b=tphwbIbZ9CMJWu/8zPpUWtZqmztpmxcOk8MvW/BG5hShGYk3ZTvK6bqX7ptOFvHKAz
         h6SPLW4E5UtTfj39QrFc2LW3+n4DBJPp1z1Xwe87t9yUbWJWmIuHS5CuPyTcl/RVvFqw
         nKeE45c/bWcy/mLV1b8y5dHZtCUl0PMTgpWEa3o8c2npFFYSW3EoFxLX1Wlj/4clULT8
         onPf8NsBsj7zVdjMnHIt1upn31fPsE8aCcheP4+A1H1OzYV8nwdbubQKvEsLhh3n4vW/
         cpCTZzmWnTv33/8cbSso8wb6EshZh2XuUZPZNP/opKwqcUZmJrWpxGpR1Veb9lHtdxJs
         yJ7Q==
X-Gm-Message-State: AOAM532Zf7LHaj9P4BJBFmSpdsON6WqNxNLGc3UoGcneANQ5y/436Coa
        8bI2wK3tjPQiatZ4p04OYwXI3iDnYID9RA==
X-Google-Smtp-Source: ABdhPJx2YIuZs0FQfvawxFv9i/LPqj0HkT2RPUBeyAIyWCKDs6U84SEphwnMKSO+Qfw28sTOnUR89A==
X-Received: by 2002:aa7:c60d:0:b0:404:abd9:d645 with SMTP id h13-20020aa7c60d000000b00404abd9d645mr22990283edq.227.1645486421109;
        Mon, 21 Feb 2022 15:33:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bv2sm5623753ejb.155.2022.02.21.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 15:33:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMIBY-005s1w-28;
        Tue, 22 Feb 2022 00:33:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Raphael Bauer <raphael@pdev.de>
Cc:     "Git ML" <git@vger.kernel.org>
Subject: Re: Pretty format color bug
In-Reply-To: <b5b7cb21-30a9-32b8-cadd-1a768f5b98b2@pdev.de>
Date:   Tue, 22 Feb 2022 00:29:48 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
Message-ID: <220222.865yp7aj6z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I think I found a minor formatting bug when using the custom pretty format:
>
> * What did you do before the bug happened? (Steps to reproduce your issue)
> git log --pretty=format:'%h%Cred%+d test'
> [...]
> In case of ref names / a second line, the color is missing completely.

I think you've found a "bug" or unexpected feature, but it's not in git,
but in your pager.

Try:

    PAGER=cat git log --pretty=format:'%h%Cred%+d test'

I'm assuming you're using "less" and are about to read about its
behavior of resetting colors that are still in effect when it hits a
newline.

I hope that helps.
