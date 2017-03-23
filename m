Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75A020958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935056AbdCWPdU (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:33:20 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35884 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934412AbdCWPdS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:33:18 -0400
Received: by mail-ua0-f180.google.com with SMTP id x52so11191555uax.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f1O2WwnieI4Pqr7tQ9kGY5Dv0675MBKE1nMCwpd80Fs=;
        b=UX4/Vyno8r+1POXxXA7wh6XN5CYJurXqqD7Rf/RWt08jM4+SmQ/ttcmVNpegS+1ZW0
         uDFiZhw6aXVnLpAt66bpavbUNyLa6MnKefJ3QwyDp9z6gm58CF5QEY0d1RbezinPXoAz
         E0ahb/rztMS1AB+eaCOTvF7JqEoElePRKxHA6fLp8mCc31xdyVRwHFWW476w1hM8al0L
         tKz2kLNJ3SzrG3DvQSJW0La5qIPHeqEwkg0C5ufR3+ihfH+DnidVKdFuwIMkpXp4DWMV
         VuBAWC3Ss1ebnKMMeiWrftxaqAwMiLJlwWJAesumq6YKlzQkOchGqumYIepdVo0dEHxS
         wsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1O2WwnieI4Pqr7tQ9kGY5Dv0675MBKE1nMCwpd80Fs=;
        b=tnP2crO0RsWfd8MoL+9k1tPhB8l2obMzM/B/XhWJ4sDXyEu4Toiex0dfFxengGSGEN
         0qj2ZUhSSZm1fuas5OtpeUFTJMLZW5rgdjuxbe8WbRZ9Lvz5NmRDqQRVRv9xt5x4cxWF
         Q2hGLekS1wPcE2eALNc7z8TfWg+wbWfcxkCimQdg6BIdmekaHvF8fZtcda+df93Nj87c
         g81FuQKPosdfrBUZBTa/o+MaWq4Insbh+g+XmKX6qv3+cYBNajLUF/elgm6e5iG5aohO
         DnHh1x8MWOWYLpo6NuTkfLeLba326i1dSUUhbA7fT3o1Es/nPTJ7tOd7mrbmMdDED7Os
         OE+w==
X-Gm-Message-State: AFeK/H1Psv97Sn5a3hY3orHYnYcJGksFsosrlCxjV0MOiQJMwtIgcO2zgasfFrpYrw69pBgp8rVOxu/0DvJ4/g==
X-Received: by 10.176.80.197 with SMTP id d5mr1234887uaa.39.1490283197362;
 Thu, 23 Mar 2017 08:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.150 with HTTP; Thu, 23 Mar 2017 08:33:17 -0700 (PDT)
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 23 Mar 2017 16:33:17 +0100
Message-ID: <CAM0VKj=DgyctKB+m8qh=VG7fDJDf-d-95twqiZD0R1zXgSDJKg@mail.gmail.com>
Subject: Re: [PATCHv2 00/14] completion: speed up refs completion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 4:29 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> This series is the updated version of 'sg/completion-refs-speedup'.

Forgot to mention that v1 can be found here:
http://public-inbox.org/git/20170203025405.8242-1-szeder.dev@gmail.com/T/

G=C3=A1bor
