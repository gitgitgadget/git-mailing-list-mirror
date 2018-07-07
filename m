Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261841F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 16:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeGGQYL (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 12:24:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45125 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753696AbeGGQYK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 12:24:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id u7-v6so6850837wrn.12
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J0oO7byc7Sv1AiX/qhp2euQHKvCMdh9F9A9tY/WSm8A=;
        b=U4Dhyug33J2eF04Qwp0CaQICHLnhCKOP7Hz1Y9QMiOOEC83IeX8z0TCGuH1rcK86mg
         DYlGZLnC5DTA3sQcdP3RXaXP5ShMgX8NM62NfhrL8J8BcqgDz9i34C6iFuDs0RFTOgN9
         Js5//U7HUYwnhce1KouzBIsoZH7rKX1pDQrZxWCKsydE64RMhkvU1x3opqjMdsmDbKS0
         ZOQduiQrlxcoBg/8L2ijA8JCe+k+63XFpGiRg4ZwqOZA4C42kpix0E4lRYHz90McdFwQ
         kWbB34b1eY4ZP0MiG6mRFSxYrnbQzb3NEL0azCflxP6TTk1Fz8F3JDsIIOerU7SLUPaa
         gH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J0oO7byc7Sv1AiX/qhp2euQHKvCMdh9F9A9tY/WSm8A=;
        b=f7/9hY96UuAgaCLIl5JCEgcG3+UBLuM/iU9qT0U8VqLDLJDmkwLSZ2tSHzT05ppeNK
         fWAbf9G2fOwm9GyRgMz1WB91pGrlSOn0BsIOje5ejJ6fh2O+03B/B7xQh7jXUEG+8vCC
         Wkv7wKRe5n08ohhEXrY2J+8dXA4IJosUO87tb73HOATEw/Ap/hP0zjD5n25gzZfRaY60
         4eOOS0gtQELvLV2QIR1xOUkHcgarRUhEA6KwPBtLviWSiv4l0A022bSyVMJ9nvdIK3UW
         gFS50B2M529iZDn5yqpxCIXgkbs7Pgua2Zb7w3O4G4G1APDkxVRdF5J+bkVzDccvM+eL
         gRWA==
X-Gm-Message-State: APt69E2Cvi3If25PvlXW52PJXR8q/gq1IiatnWDg2eSulHHEz7zfgCz+
        XFd3lyCVW8ayYC2wlL9px14=
X-Google-Smtp-Source: AAOMgpddD44Uxq/HX6ZljIOEopwwVIBJUWgpLmAYMVeIQNGNGyxLywPIbyYF9igqAroV3my4NJUPwQ==
X-Received: by 2002:adf:9148:: with SMTP id j66-v6mr10933261wrj.118.1530980648772;
        Sat, 07 Jul 2018 09:24:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t124-v6sm5438210wmf.37.2018.07.07.09.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 09:24:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v3 4/4] builtin/rebase: support running "git rebase <upstream>"
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180706120815.17851-1-predatoramigo@gmail.com>
        <20180706120815.17851-5-predatoramigo@gmail.com>
        <CAP8UFD3_+0EDSzcrx9f70HBpWKvr94re5ZimuXDhfTZzJpfCvQ@mail.gmail.com>
Date:   Sat, 07 Jul 2018 09:24:05 -0700
In-Reply-To: <CAP8UFD3_+0EDSzcrx9f70HBpWKvr94re5ZimuXDhfTZzJpfCvQ@mail.gmail.com>
        (Christian Couder's message of "Sat, 7 Jul 2018 08:45:03 +0200")
Message-ID: <xmqqbmbjggka.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> +       default:
>> +               BUG("Unhandled rebase type %d", opts->type);
>> +               break;
>
> Nit: I think the "break;" line could be removed as the BUG() should always exit.
>
> A quick grep shows that there are other places where there is a
> "break;" line after a BUG() though. Maybe one of the #leftoverbits
> could be about removing those "break;" lines.

I do not see the above as nit, though.  "could" is often quite a
different thing from "should", and in this case (and all the other
cases you incorrectly mark with %leftoverbits) removal of these
lines does not improve readability.  In fact, if there were another
case arm after this one, having "break" there would help those who
scan the code, as the person who wants to ensure what that next case
arm does is correct is given a strong hint by "break;" immediately
before it that nothing in the previous case arm matters and does not
have to even be looked at.  By removing it you force such a reader
to notice BUG() and reason that it does not matter because it does
not return control to us (hence no fallthru).

