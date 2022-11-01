Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F0C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 04:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiKAEy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 00:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKAEy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 00:54:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A6F16587
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 21:54:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b11so12191575pjp.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 21:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzOuVLs0n5f3LJir06yf4EUVsiL43e//z8aAkwWNPP0=;
        b=noMhz5qNMwsmUVxwRumSmhkaBXOSRuR0naUgu/PPFBYCKd+aVGIdQyS8aIUBd6cvKc
         I/+60w/u97gSptXc8eiFq7IqehFWuHdSyMSxxA7/jiTxAWf8AKQds09dTESlSjKnyXsa
         sMZtFTyYBIw+oV2+jdU7k8pYuUoCFQvlrW9ubOteqFlJ1nfoDuVbPPaWhUJyoq5nfUk5
         xUchj8zr0A7rWCm5u9KfZ88fhN3mFqVRm1RwjS7tssShOIMfspVPs3yAXQKltnOWSKZ6
         WpD5AD52vNYcmlTaSjRmtx/C5xW9DpVh1bAopWvZTG5wcQHrzYsgPg4PWm+4wyVl4xNz
         3eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WzOuVLs0n5f3LJir06yf4EUVsiL43e//z8aAkwWNPP0=;
        b=E5c6v9rLH6rm2yq8OAGQ0FQHbNjY5H4dZwHw4ReSW1j2Yu4+gh35GSoT8lhxYknmWo
         Wz44rR3P9pneCKkP/oKm+2g5i17vDnLNLx7cRxjJNSuxOsCv317BsbtwF00etrRSsZG8
         Ui2NxuktiPYTxruQ2H0Y/1LE5wkPvCBkybnOCQ1kG+1zYMZUlyrt28LcjSQ4apiqIMS6
         YQKjUCtJO/GZxLKrsCBtbBTTncjiJig3yA64gkjVfmWUAeepsmfWfpxucB9o1N5cEPKD
         IGnJcCgeIouwMcLUAlf3cjBrpEn78RhR2c6THnvx/aowvc0fzKR+xmi2jjWN/FN9+qxG
         hDrg==
X-Gm-Message-State: ACrzQf2GoBMcZHnx4kgHJQj6dn5TeYS6idAnXTYx2v8grLR0sbSq3CJO
        Fm9nbtw/ncg9UxUZqd2KyUM=
X-Google-Smtp-Source: AMsMyM5cenO/64E+awdWTQQ1NusGciaUANUkjD7fdbo/bCcIHQrxVeSd0J4n1V+T++u2FimdY+P0hg==
X-Received: by 2002:a17:902:f651:b0:184:6925:d127 with SMTP id m17-20020a170902f65100b001846925d127mr17604282plg.140.1667278464798;
        Mon, 31 Oct 2022 21:54:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ft10-20020a17090b0f8a00b00210c84b8ae5sm5042208pjb.35.2022.10.31.21.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 21:54:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
        <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
Date:   Mon, 31 Oct 2022 21:54:23 -0700
In-Reply-To: <Y2CD6GBl6ORqKsug@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 31 Oct 2022 22:26:48 -0400")
Message-ID: <xmqq5yfze0lc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It is unclear as to _why_, but under certain circumstances the warning
> about credentials being passed as part of the URL seems to be swallowed
> by the `git remote-https` helper in the Windows jobs of Git's CI builds.
>
> Since it is not actually important how many times Git prints the
> warning/error message, as long as it prints it at least once, ...

Sorry, but I do not quite see the value of keeping the test to
expect success in a weakend form.  If we think we are emitting three
warnings, whether we do so by mistake or by design, and some of them
are lost and not shown for an unknown reason, is there a guarantee
that at least one would survive?  And when all three are lost, even
the test in the weakened form would fail and stop the CI builds, no?

If we do not know why we are losing some messages, and if we do not
have resources to track down why, that is perfectly fine.  Fixes can
be prioritised.  But wouldn't test_expect_failure be a better way to
express "we think we ought to get 3 but for some reason we may not
get all of them and we haven't figured it out"?
