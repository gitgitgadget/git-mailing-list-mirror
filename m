Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63611F462
	for <e@80x24.org>; Mon, 17 Jun 2019 19:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfFQTZ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 15:25:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33890 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 15:25:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so11277574wrl.1
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P5Z14QHsaqLMBEV1OzU11kzBxulWlp4q+Lx905e1TnA=;
        b=Gr98vA2yijQRuFPcoUmAZfjzki1IGODKaLpP3MhQS111cYVm/UpiKGWpy1MwK1vz7m
         gWEdaGZiKWfnMdHLAKt1353VcfMTngKan0FlQw/4bNnhO4bsngtwpyyuqvQLpY/x35MV
         9SjTg6sZRRydRCyOdYJXOJgT7LUvKa3liAb4vdqCVwB5qEICy9qdkAl6pUI3YdDbJnBM
         6x1PfjpzUmdaLUyKi3vkz3mowOOmHyqn+UG8MhgYdBz0ARTNs6mhmUHCayTZJ9rUjmug
         3M0pPo9kBsqm6RkumtTXkTzJQ8l5pBrtix2a7+iH3zirlAF+TjBQALP904o4WwpjibcF
         6djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P5Z14QHsaqLMBEV1OzU11kzBxulWlp4q+Lx905e1TnA=;
        b=b/nsgRY3sJL+2EMix8c8Cqyh1YaA55779tBKhmCKVXtTdvj1yZdgFDu88bDmbNtlAx
         NW8UkWRkzUHscy+r0sZXbzqoAOO0iNuqFBsiELk6UXhTc5nzS2pjJQKKtexCBIpoKMvt
         lqRA7l2QHiWtaFo4vYfLLyzn3ceiijPMoc3LcXfE+vXLLrSOzPvSr2NYsVgQUYwpg/Vq
         UAAo6c2LnCqs9Knd4Cb6e6b9JbdtNl5P6Au3K0NgqnEftALlFq/YpxlkhUPNCoSuletQ
         DkYAg2N4SGPi8dz3F4qNKjq4nrd9pEgw/Fp7lDkmQwAbbFNSJbaO8x5tW4jLHyA8PKw7
         dhaQ==
X-Gm-Message-State: APjAAAWTZx5PSft0CM7SgUMfpNHBkQyfi+lQusWi9Rtx+sZQ3vAel9TO
        AWANoiZDHtFIo0AWf36Oecc=
X-Google-Smtp-Source: APXvYqwXEl2J/xICblo/2sa9TTjMCMLKaTq1bqm6679msQm2x540Bx9dA0PWqvTyc+inCDjl4mrUQA==
X-Received: by 2002:a05:6000:106:: with SMTP id o6mr276207wrx.4.1560799525078;
        Mon, 17 Jun 2019 12:25:25 -0700 (PDT)
Received: from szeder.dev (x4db66496.dyn.telefonica.de. [77.182.100.150])
        by smtp.gmail.com with ESMTPSA id v67sm168947wme.24.2019.06.17.12.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:25:24 -0700 (PDT)
Date:   Mon, 17 Jun 2019 21:25:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190617192522.GM31952@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190612194106.GJ4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet>
 <20190617191328.GL31952@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617191328.GL31952@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[resend to Matthieu's current email address]

On Mon, Jun 17, 2019 at 09:13:28PM +0200, SZEDER Gábor wrote:
> On Fri, Jun 14, 2019 at 08:42:29PM +0200, Johannes Schindelin wrote:
> 
> > The `SHELL` thing here is important, as t/t3404-rebase-interactive.sh sets
> > this to the empty value explicitly:
> > 
> > https://github.com/git/git/blob/v2.22.0/t/t3404-rebase-interactive.sh#L63-L68
> 
> Hmm, hang on for a sec.  Why does it set SHELL to empty?
> 
> So t3404 sets SHELL to the empty value since cd035b1cef
> (rebase -i: add exec command to launch a shell command, 2010-08-10),
> and the in-test comment highlighted on the above link says:
> 
>   # "exec" commands are run with the user shell by default, but this may
>   # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>   # to create a file. Unsetting SHELL avoids such non-portable behavior
>   # in tests. It must be exported for it to take effect where needed.
>   SHELL=
> 
> Furthermore, the corresponding documentation added in cd035b1cef
> says the following:
> 
>   The "exec" command launches the command in a shell (the one specified
>   in `$SHELL`, or the default shell if `$SHELL` is not set)
> 
> IOW if SHELL is not set/empty, then it will run the default '/bin/sh',
> but who knows what it might be, there's no guarantee that it's a sane
> POSIX shell.  That's why we have "Define SHELL_PATH to a POSIX shell
> if your /bin/sh is broken." very near to the top of our Makefile.
> 
> So while setting SHELL to the empty value might indeed avoid
> non-portable behavior when the user in general prefers a non-POSIX
> shell, it wouldn't help if '/bin/sh' is broken.  For that it should be
> set to $SHELL_PATH (or perhaps $TEST_SHELL_PATH nowadays...).
> 
> Though cd035b1cef is now close to 9 years old, plenty of time for
> somebody to run into this issue in the wild and speak up...
> 
