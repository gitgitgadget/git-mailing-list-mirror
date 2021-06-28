Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DAAC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6002E61CBC
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhF1UU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhF1UU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 16:20:28 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF4C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 13:18:01 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id k206so4553865oif.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uI89sRdjtxTL3UVVBjlJKhsJbCdA5wk0INqxL+iW0Rc=;
        b=JJGgi37UVxpwSGZXpgtRTQREoXw65BYsR+xRk4gYsZ8EnotCRLH7wtHFY+5i6KAiBS
         DH0blcOzn7Mb9ACy+HHKHX0T2HPenJu5vzqauopVUoECKtHGLY9S2AdxU2m6eZDIJ5Gd
         ViP2mxkVueZrT8s26jsqv0Mmq9RJqOE7QJhfrtH6DF2hqQQgkLk1vVWHGArTR2r0TdB7
         F+Ok2kLT/F32R9iJmee3TsBowkBvZS2EoXPcmkXo5cwHAjly4BlFJBVzLPbne+YXzfSG
         L3W+Cc+R0WaJiY/OiU6yWCyusJ8KNRJfGBrBsI+lSG3n6k+AIvQrpXGgmHBguF+kwzHh
         1exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uI89sRdjtxTL3UVVBjlJKhsJbCdA5wk0INqxL+iW0Rc=;
        b=roI0tuU06D6QI2pnEaBY2q9EnUETcjgo5v/0EUTWcuqzB7/w37cr9a35IPOhUfXLAS
         LwkdZH4q/WeFpJhekMg9sDpsSXKVZd/FIKt+vbhZFVQqUmuM1GeItqCNjSMigJY0hXTZ
         NxllIVe1qa3T67iXQ8612IQN4X8AgtkzHtbtKZ3F6P1XK9ylRDQWaJ8C67si0Yo6EgDE
         pLWh0Nw6KnO7NIinIp5eQSbydWliu2i0FlgXgAKo0s8eqiz5ARBlAZXlmv1Vs+CsI0Y5
         3keMjGiKlouykQ18SHmmxtplaOsGWLVk5RukJLzawBFPSapXilx3kbB8/n6P9Z+BGXKM
         RrZw==
X-Gm-Message-State: AOAM533DG1Xfnrngju2vLL93nirGkfjNv7VG3vZ4Ss1f1PJSqd+IZETd
        ebE6A+aIKtiNrTGI8/XolPw=
X-Google-Smtp-Source: ABdhPJz3FY1j3ijMfnpwCAYnWh3d/YWAaiYN42qIBZjQBWTxmTYSiwki1Q6UALtl89D9MVueMAD3cQ==
X-Received: by 2002:aca:f12:: with SMTP id 18mr5169107oip.123.1624911481020;
        Mon, 28 Jun 2021 13:18:01 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y17sm3405758oih.54.2021.06.28.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:18:00 -0700 (PDT)
Date:   Mon, 28 Jun 2021 15:17:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Jeff King' <peff@peff.net>
Message-ID: <60da2e775c3fb_1da1f2086c@natae.notmuch>
In-Reply-To: <029701d76c57$f4d42f60$de7c8e20$@nexbridge.com>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
 <60da10df509f0_1b95d2089c@natae.notmuch>
 <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
 <60da1c8de0ca7_1cdb420832@natae.notmuch>
 <029101d76c54$9f713c50$de53b4f0$@nexbridge.com>
 <60da2692e8029_1d6fc20855@natae.notmuch>
 <029701d76c57$f4d42f60$de7c8e20$@nexbridge.com>
Subject: RE: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On June 28, 2021 3:44 PM, Felipe Contreras wrote:

> >Clearly this would work on every platform that has less and color and it's technique-independent:
> >
> >  setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
> >  setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
> >
> >Would it not?
> 
> Less is obviously used across the board (git log, git help, etc.). The
> assumption of the same starting point for all situations is not valid.

I did not assume any starting point. I don't think you are following
what I'm saying.

I do not want to rely on bash, or any shell, or any version of less, or
any function in the user's .profile, or any wrapper in the users's
~/bin.

Junio and Jeff are the ones that think it should be up to the user to
setup colorize tricks in all their environments. Except they are not
specifying what those tricks are. My question "How dow we educate our
users to configure less?" is a rhetorical one, because I already know it
can't be done (although somebody could prove me wrong by showing such
magical configuration).

I'm saying the **opposite**. I'm saying this should be done in
builtin/help.c *not* .profile.

> Admittedly, I am in a highly complex situation, but it is a real one
> (ok, two because of a diverged path between NonStop and MVS) and there
> are hundreds in a similar situation.

My patch [1] should work in all your environments.

Have you tried it in any of them?

Cheers.

[1] https://lore.kernel.org/git/20210626025040.104428-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
