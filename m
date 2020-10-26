Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611BC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8878A22265
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782136AbgJZOwt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 26 Oct 2020 10:52:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35162 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781973AbgJZOwt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 10:52:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id w25so9683195edx.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 07:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXbq/X3yujdBVOb3G4r71V3qdf37n+mOFpErGn572ig=;
        b=onCyHg5E8Jf9mxzSVrV4DhjMdlq7GwzzrqiH0ok+x6UxmuoJiz1ZlFKp+RxWR+qa7y
         ck6wcgMUqwkbFdKjnj3zbu+KL6LrsA/PR3s40dNMGeQ4A7o1KpDtAH19bCxndA7KNP09
         FRfn+2VXycQUu9nLjHj/NB8uee0UPfYg7PSmcW2a9Z15Hwvu4pdKjRGNMmVWhGwo54Kg
         A5bKKK/CFCSxUfci1HMoIeHlROoYqtTzptwZhd9SHXTQYYyUTidFcPJbSxsd4FFThfbf
         N3VGhAXsPsiFXrsr/VEO25OXLusjsIQXstmrphQ/7f+BAqChw0/gMopnpamM3xXEX5LH
         TZWA==
X-Gm-Message-State: AOAM533DU+EoasgjE9xuVhPFx2uPGg1Q152SodKA7yFw4dMM+SxmBKTa
        k9mI9B8BIV0QITsO8m9acxUOz323ddKzniPaoMI=
X-Google-Smtp-Source: ABdhPJzc9zbbWrzR7jN+XRdfzJukQjGsB3/hDezgVT/9dDZPkE2vUSrdZowQipbk0cXlinUXSb7ytFC2k9WsmIJLYws=
X-Received: by 2002:aa7:c746:: with SMTP id c6mr15968913eds.221.1603723966975;
 Mon, 26 Oct 2020 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201026144825.26537-1-avarab@gmail.com>
In-Reply-To: <20201026144825.26537-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Oct 2020 10:52:36 -0400
Message-ID: <CAPig+cRvCPaUxoCojiHvwte4Ty9iRmOaYGrcKs7WHXQN=bid6g@mail.gmail.com>
Subject: Re: [PATCH] remote: add meaningful exit code on missing/existing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 10:48 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change the exit code for the likes of "git remote add/rename" to exit
> with 2 if the remote in question doesn't exist, and 3 if it
> does. Before we'd just die() and exit with the general 128 exit code.
> [...]
> So e.g. if a sleep() is added right after the remote_is_configured()
> check in add() we'll clobber rermote.NAME.url, and add

s/rermote/remote/

> another (usually duplicate) remote.NAME.fetch entry (and other values,
> depending on invocation).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
