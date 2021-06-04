Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A7BC47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E2961402
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDCK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:10:28 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41562 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDCK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 22:10:27 -0400
Received: by mail-ot1-f52.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so7701308oth.8
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AMSOgFUC2uB5t47c6gbNjVRpTmvNHO0j9q0CzxVhB/0=;
        b=Kh94y+OxXTFq36mS+YXK2bfASi4x+3CuGrfdfWN0YgQo6S6vRNRcZaNn6ZGLKNyE0c
         tF1Od0rNcYsyNXo6Xbu9MQnwOI82Oe4anqlq9Qfw7dCMcT8LiCKLCgS9gZCfQR8hcGUg
         Al4q/y6BUgTPEEVu7aWIAmjJ7ai7v/6B+Ps915Kd7RjVN+YTiI03tf9uouGGRKkzDbD8
         Vl+ypJ5LlyiHBmF0YxMxRBFsyM/VSFhiIe3vxcmMISXcdixxokU3WgbohalzY6JIWBfM
         uovGrr91zi3BGTzAyR+S/acFcg8lEIw2WPDfEZYBiGVoTF22/e16Y9L7psYQRjHOvdGo
         6KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AMSOgFUC2uB5t47c6gbNjVRpTmvNHO0j9q0CzxVhB/0=;
        b=T7XM3SEl7V4sVBRuUWqniqI8v3pHLh9n+iesTvF3aOAKBScqwW4aoTIvRkQFV87ZMx
         bESakMEeLrwKxJ6PvuAZuIcI84caGlbATPH+pbLIA2JZ3pkmNltRrBAd2OwrCCKbubDg
         O6JQ6VkZdcJ3C5nGxuJD9zZNJRMVMTKaPwddiNHBroX9sJHhTsgk48c1bn25zeNDG2Lp
         mk1lhYdirSYNkuxgTfDsrH7UitfzY8ZwOG5AKgTcBD3fZlvT9ntSQNIInwBgU9EoNGaf
         EYp2E9Chw3EMsWr6h5IiWqsCGXwJV4G0Gzm5PlJIIiV2AYuBV4ik4ZiTrOxgYjDPsZKF
         yRyQ==
X-Gm-Message-State: AOAM5308wgWuAlrtFs0O7PtSEvUTB40DjEsI4g5XQSVnw4AhQqwZMZNJ
        agjNNUF9q/2HP/UGPm5VVos=
X-Google-Smtp-Source: ABdhPJzfszddADCULlowUYu2BWNHIUaNlrIXhZKT2/PCG2FwqINq8v29lPaR71F6Psoc5+YLe7TOEw==
X-Received: by 2002:a9d:7a49:: with SMTP id z9mr1791707otm.13.1622772446059;
        Thu, 03 Jun 2021 19:07:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q6sm156062oot.40.2021.06.03.19.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 19:07:25 -0700 (PDT)
Date:   Thu, 03 Jun 2021 21:07:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
In-Reply-To: <YLmGxcQ3s2gBbfe0@danh.dev>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-03 20:11:45-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > All you need to enable 2fa is demonstrate that you can *use* 2fa... S=
o
> > you need an OTP client.
> =

> In the past, when I tried to enable 2FA, Google always asks for my
> Phone Number because of *security* and *safety* reason.
> =

> I tried to create a new Google account to double check my memory,
> Google now requires a phone number in order to *create* new Google
> accounts.

Presumably if you don't have a Google account, then don't have a
gmail.com address, and you can't use Gmail.

So why would this thread interest you?

-- =

Felipe Contreras=
