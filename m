Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451F81F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbeDMTdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:33:04 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46730 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeDMTdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 15:33:03 -0400
Received: by mail-wr0-f176.google.com with SMTP id d1so10757415wrj.13
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+FedfutmQctNnHoU6APNHghZmqohWvhADtDuT6BGB3k=;
        b=ZKb2GAr3Vs5vQKotrXnkiwR6XaytaC9tf4zMw22oygP+lAeBIFfyex3SMLSyyI8pAv
         KxcsmL+NHoyObXYJoXq/7hGFaX00uvmrmroUhLeY7XOJgg3qYXlKo7+/hlKUoOxw9zqO
         QJEkJHwmQwlTCtlAwf3Kc13DwQpCgcNeCf1j3PEOwmNg+D46Us4PHrlVe7cxUqN5Yz+g
         +6S6RGjtqXo3TtII+Tj0dUfHU7zZO/0YSI+JH8p1E5YjW0TN2TCk2jXLsGPVXBInnEXy
         kVIseYHFPAJILFUrGWK1lylouqu6kiV+/obzT2Mjy0vPhmtCuC/R4DENafE/+IRTFC0o
         dkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+FedfutmQctNnHoU6APNHghZmqohWvhADtDuT6BGB3k=;
        b=ryuBOz7w96MmvLZ9m8Cmjllh1HhSGsddcL64IEODVdRAf5VekkJne4MW9cpygm+aSC
         eLaWqYnAlwKNbfLZM0WRLEhrPh0Urf7obO6zAF5P4/ughs6tsZYZ0CTLEnjfcMRTFyvh
         +LwzAWmWvMgzSPyK8ni8C/Iexufzc0f0rEt7ilcI8B3QplW4Ufv8eqeEWyR4ihPrFxJj
         0zl1HlTdRalNWSEinO553ngXYAU92VzYIOSwEc5fekGKazyES2mxgWbxVN04PnJ5bvId
         cIDrMhMxKRW7w3EIha6fx5F8LN8ui9E7TrOB70RdkshWlY8v7vebfaSzJCL2dOP4OEgu
         zeXw==
X-Gm-Message-State: ALQs6tD7VICT/fVbDA+uFOzYj6z/8+GsSL5yNqbWh17qQW9Hf5QNZQTY
        9OYbGsDwM7TOWsEMgYMMiQO2qd3j
X-Google-Smtp-Source: AIpwx49BxDDQ42x8ZIMRf/AieImp1MYDtzNOt2y7n0/wY7+6gGebp0AScdSnPqG+AU02t7lu2HTzDQ==
X-Received: by 10.80.187.14 with SMTP id y14mr22263047ede.175.1523647982002;
        Fri, 13 Apr 2018 12:33:02 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id s27sm3671551edm.78.2018.04.13.12.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 12:33:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Vogt <mvo@ubuntu.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Add "git show --follow-symlinks HEAD:symlink"
References: <20180409090047.lfru2ul5fbnggfg7@bod>
        <87in90zq2a.fsf@evledraar.gmail.com> <20180413094314.GA2404@bod>
        <CAGZ79kZDUnxkKfqRnZiLhweJ4HNO5sSGUfxkEvJPGagV4wmtkg@mail.gmail.com>
        <20180413174819.GA19030@bod>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180413174819.GA19030@bod>
Date:   Fri, 13 Apr 2018 21:33:00 +0200
Message-ID: <87h8oegavn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 13 2018, Michael Vogt wrote:

> The update patch is attached as an inline attachement.

Your patch still just shows up as a straight-up attachment in many
E-Mail clients. Note the difference between what your patch
(https://public-inbox.org/git/20180413174819.GA19030@bod/raw) and a
patch that's not an attachment
(https://public-inbox.org/git/0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de/raw)
look like.

Try to "wget" both of those and apply them with "git am" on top of
master, and note how what you're doing results in a broken patch.

This is why Documentation/SubmittingPatches suggests using format-patch
& send-email. You don't *have* to use those tools, and can use something
that's compatible with what's expected on-list, but what you're doing
isn't that.
