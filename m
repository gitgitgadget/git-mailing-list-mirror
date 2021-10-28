Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1561C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998C360F38
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJ1Rfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJ1Rfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:35:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B855C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 10:33:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id np13so5240978pjb.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=OtMFUNE7ncOmgp1VhnjVdOOs8rxR9ELlYW9pvW2sn6c=;
        b=pPKlyxJQEuzv4PLk7CaTKl74TNiUcPaBF8rwLGNwstod0PrGbg5pWgSIz63IbGsWdn
         WhFJYybITVtlvwYRnVWvinyXxvkzm6zfWkpsbYrAFRJAYJOEh5wUr1VW1xuqlX7DBvQ0
         9lbP/xUVDOmZFFgTAQSCxJfMGesk5J8FzXN/SfYjZpXenOlFmRKseas3vbWxlAmSjAeb
         eyh/MqQh/6I89/EOCgGqH0p5KI2Ky5Ds++1Ktbg8X+Hc1nkEKRpG2zyv7mR996ETZMq+
         PPOY40u4c4Xdm8g/eNxeKXidCRu0Qpi6LFSpD2ns1s1dhyWSVPuHzRQlUEqE7SVgwTUz
         ZhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=OtMFUNE7ncOmgp1VhnjVdOOs8rxR9ELlYW9pvW2sn6c=;
        b=b9u5/MC3C4OMgqXZbSoz7swbVLpmYWauiAFqv1Q6TQHxNUX2cstgQ5nWOHIpaC7pGX
         ueiKCKfewH3ZGbXA5Ze7dIsKbZ319oQUyBdb+phpr1Q+fXGErn2zRnulLRxHtDXFtLmo
         XcVxcpVKeJ9qhiyiGb7fQ2luq0k/L1V0aFb1bJniqg2/coyOoCR/HFEnUx2f2BsEnTZE
         udqLexM4Du/+vqSUUCHra8JXzxVEtJqPyXEWR0jEQB2RyTEghe9eRR5FdXOA6rXkb4sY
         ymt/7VLcV2Q63e21unvN6D1DfRB5N/0cV/hZ8ri1F7EcnnkzyIqiLnQE2xdcLWXo5zHh
         ZWyQ==
X-Gm-Message-State: AOAM532WzhMr3PvkfZRBEiISctvehxbgaldqX0zRMNtcYK7TwZ6bWRdc
        C8kRIsfeaaVqQeRR1tyYzn9yNDEqFeU=
X-Google-Smtp-Source: ABdhPJzhZObdGic64RWH110j1EjbrGn01U5YmeB/NXVMDBYDntZsXeFEyx9nNQMdZzCGFGVz6Ag7gg==
X-Received: by 2002:a17:902:7c02:b0:140:a4a:4b3 with SMTP id x2-20020a1709027c0200b001400a4a04b3mr5167000pll.30.1635442395608;
        Thu, 28 Oct 2021 10:33:15 -0700 (PDT)
Received: from smtpclient.apple ([2601:602:9401:4360:392d:d25f:907a:49aa])
        by smtp.gmail.com with ESMTPSA id k20sm4659409pfc.83.2021.10.28.10.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:33:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] color: support "default" to restore fg/bg color
From:   Robert Estelle <robertestelle@gmail.com>
In-Reply-To: <xmqq4k91t834.fsf@gitster.g>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Date:   Thu, 28 Oct 2021 10:33:14 -0700
Message-Id: <881B4747-B0B5-459B-B673-06972275A8B8@gmail.com>
References: <xmqq4k91t834.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (19A404)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sure. I can update the commit message. Both the commit message and the doc u=
pdate already described that the default is terminal dependent and frequentl=
y not white on black, and the doc update gave transparent as an example. I e=
xpected that to be clear enough, but I can add more background.=20

> On Oct 28, 2021, at 9:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> =EF=BB=BFRobert Estelle <robertestelle@gmail.com> writes:
>=20
>> Those are good examples. Note that this applies to more cases than
>> those relying on transparency or patterns: color terms often have
>> defaults that are not identical to their ANSI palette. I suspect
>> *most* themes are probably this way, based on a quick sampling.
>> You can see a bunch of examples here:
>> https://github.com/mbadolato/iTerm2-Color-Schemes#screenshots in all
>> the themes where the background color in the "40m" column isn't the
>> same as the unset column before it. (All of Terminal.app's built-in
>> themes are that way; I know xterm defaults to black on white vs white
>> on black; and so on).
>=20
> I think you are wasting your time giving these to _us_ on the list
> who happen to already understand what the issue you are attempting
> to fix with these patches.  The suggestion was that you would help
> future readers of "git log" if you wrote even just one or a few of
> them in your proposed log message.  Those who will be digging the
> history, perhaps they want to fix something in near-by code, may not
> be aware of this discussion but the log message is a good place to
> leave a note for them.
>=20
> Thanks.
