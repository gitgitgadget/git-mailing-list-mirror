Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BB91F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeIJVs7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:48:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35631 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJVs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:48:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so22278806wmc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=u+go1WJ3J6W5ELRmA77uZStRhI4bUMNb94wWfE5sHIo=;
        b=ozapJmoRTfuXXKcuE9l/zSuanfKv1WcDm0l/mgu2I+QRbQA5MerU4dPeHbteWbsire
         8s94XNgZb+hGQCehrjiKTVXmfZaIT5Ma+94NhEqZ0fSJSaPWKQJ0Vc31GyGGDfyvoabB
         60b7m0fmwaE1TbeIdKIOSFLwzAmlfumCevaekVbCLTiSzDViymsUSsfUtB4wT7QM1ueD
         Q+ZSFqlJdVNJnAMK5xWPqyPRDTnqbmvO+yQllxFx6I4kIsjaLh/71cUSDgOE2yjLwsEi
         LgJx5fYdJAKIfTZpdMSBrD0iNq6waOHSyytns/GcinT4sVey+ZURalqJ1bJHaT2EmdJq
         aWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=u+go1WJ3J6W5ELRmA77uZStRhI4bUMNb94wWfE5sHIo=;
        b=ZyVouV+hi+tSJ9vR/6XUVLRwPu4ErEdZYiCNCL8Hkvd7lpSJqKw/s1HjZvwcESrkls
         UUt04YFhJ8WPAvHl4sI1PQxTZgPozyhS2HeTxitdPkINYGzUfClN4mlXBJJjap6kXB+/
         lWl+PzkMBrVFK7NdldlgMHyGJNoxEfPYS8klz9AW6JrRhcpNwhsFH0Xk776/UEuKsEoZ
         Oc6RwIWjgHxGYfpTPE2cpftzXwdxi9nP2+nMUAIiKfRPkbLa2PblEMx4q+l6EFuHHT6V
         60aq01kiiBxbylAN2rtlqBxMHZjFbAZSnqEFOlzqmd/7DoXbmZqijBi/PW+4jN6MpXhO
         aRig==
X-Gm-Message-State: APzg51Ddy/O2YQEHZdaQiwLh67Gm6YjpnCEyHpUmjY8j+JFEO5nJF0JD
        ppnehT7RjqQ7gOjDAWk4WL0=
X-Google-Smtp-Source: ANB0VdaYqCUIrIQaE54kW2XcbahOquTbsRkaIVMJIcmvLGmmfQ/wHjLEetKQhPtoCaszUYCNLxmdwA==
X-Received: by 2002:a1c:e141:: with SMTP id y62-v6mr1420315wmg.138.1536598437467;
        Mon, 10 Sep 2018 09:53:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z4-v6sm13730017wrt.89.2018.09.10.09.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:53:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] un-breaking pack-objects with bitmaps
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190701.GE30764@sigill.intra.peff.net>
        <8736uud0gq.fsf@evledraar.gmail.com>
        <20180831225558.GA22917@sigill.intra.peff.net>
        <20180901074145.GA24023@sigill.intra.peff.net>
        <87d0toqyj6.fsf@evledraar.gmail.com>
Date:   Mon, 10 Sep 2018 09:53:56 -0700
In-Reply-To: <87d0toqyj6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 08 Sep 2018 08:43:57 +0200")
Message-ID: <xmqq1sa1uwd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I'm just reverting jk/pack-delta-reuse-with-bitmap out of next when
> building my own package of git, but I think this really should be fixed
> in that branch, either by merging the fix down or reverting the original
> series out of next, I think just merging the fix down makes sense, but
> have no strong opinion on it.

Either is fine.  I am not moving 'next' beyond what is necessary for
this release cycle during the pre-release freeze period, and because
I thought that Peff was in favor of squashing in the changes to the
original when the next cycle starts, I haven't bothered to merge the
fix there yet.
