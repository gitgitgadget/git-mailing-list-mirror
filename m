Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68FC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjDAR4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDAR4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 13:56:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AD21C1F7
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 10:56:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n14so8526008plc.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680371771;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai4T/y1pgL+jcJKCtuNwH0A3xceH72RSbm78aHdtWVM=;
        b=HKdIi9Hyas5iO3c734IPMu4xYMTx6KWVtK8G0qSk+Qq6vEsEzuxb3HZR8UiIaT4n1j
         GUSGGj4DUqMxThurQGHGEv2wfEZdBYNKSWv7LAFhLs/tzGxTXjfGElagN//BuEeptpnr
         ZooMSQC3NYlpGQYylP1zCMO2CdVLMUzp8Ijn3KY07xw730MlITSHx6drLLshVQs+3Sym
         I0ypp+1koTV83ebg6wjMd5WBkDYOyqFkxJ4wMRVnca75/Dck3e6ExBUtIcW/XAYd8+qH
         1kduse4egKpYKZ5oa7unmMBZVrcu1fUaD7PTZ3bIR3j/LupIiOoYPFo11iVRBrMFOGXH
         dhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680371771;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ai4T/y1pgL+jcJKCtuNwH0A3xceH72RSbm78aHdtWVM=;
        b=gOHxfmE5Dcep04anp9mD2KPGK96qzcxYxilT+ENgtWooP8TgPxevhmER3rMCNDfzJG
         7terpeXsx5QEjUckRKzAqaNQJ2VGy+wRXs0LFMKlHEuCuwHQBCtLCqzLqHEvR0czTksZ
         WzFrFH+F7FYmhaz1HD8u6fV/OkzQmeOXQL3i6Vb5fYEOuDD8G/OWBZfUW9QVbsTan/Hx
         CowzYn5vRkO5TANf82R657Qsar+wHyIp873Q5JOAFqxA4zkazn8Xk/+vleOPf3AIMI/c
         Vh/k4iEyDaJyl4mApWNzP6LRP0PDCFm9biU0ALNyvF3YLlnkD6SL5psgrDrqZU9APSA4
         Mc3w==
X-Gm-Message-State: AAQBX9f/Ra0Oqrul0OnS/n23OA5TK7YGC1k8NqIAnOBlBgnqwfg6147A
        cQHePWDsEs7TwD9ntM4d5hrbAJZpvxQ=
X-Google-Smtp-Source: AKy350a3/2N02s0Zws9fDHEtUKBogk4XAEozBMs1DMW9YO3BFmPa/1xeio2si70Z8Ve/mC4NlJltcw==
X-Received: by 2002:a17:90a:4fc2:b0:23d:4242:a7a5 with SMTP id q60-20020a17090a4fc200b0023d4242a7a5mr35929720pjh.47.1680371771118;
        Sat, 01 Apr 2023 10:56:11 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a2e8a00b0023d1976cd34sm3485893pjd.17.2023.04.01.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 10:56:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Gardner <four712@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: macOS git grep change in required character classes
References: <CA+MNPvgceR3s30LaCS716NGw+8S47CQZTqFno=vE2XAuiBA7Kw@mail.gmail.com>
        <xmqqa5zrbmap.fsf@gitster.g>
        <CA+MNPvg9JX8S2fOcH9NEq=d04BcCgbf5Qwc070WWwjXpUsd3Sw@mail.gmail.com>
Date:   Sat, 01 Apr 2023 10:56:10 -0700
In-Reply-To: <CA+MNPvg9JX8S2fOcH9NEq=d04BcCgbf5Qwc070WWwjXpUsd3Sw@mail.gmail.com>
        (Matt Gardner's message of "Sat, 1 Apr 2023 13:17:03 -0400")
Message-ID: <xmqq355jbi6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Gardner <four712@gmail.com> writes:

> Even though the grep that ships with macOS is GNU compatible?
>
> $ which grep
> /usr/bin/grep
> $ grep -V
> grep (BSD grep) 2.5.1-FreeBSD
> $ grep -E \\btest\\b test.pl
> sub test { return; }

It seems that use of REG_ENHANCED bit (which gives some GNUism
enhancement to regex engine of BSD origin) is inconsistent even
among tools shipped by Apple,

cf. https://lore.kernel.org/git/4e03ea47-b0aa-d69e-6c54-fcbadb3b0641@web.de/

which may even contribute to the confusion.

I think we recently (of course this is after we stopped doing
NO_REGEX and switched to macOS native regex library) started using
the ENHANCED bit only for BRE and we do not use ENHANCED bit for
ERE, and the cited thread (which has "pcre" on the subject, but it
turns out that the symptom had nothing to do with pcre) discussed
possible use of the same enhanced bit for ERE by us.
