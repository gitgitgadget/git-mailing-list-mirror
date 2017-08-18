Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA30A208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdHRTEF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:04:05 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34156 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdHRTEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:04:04 -0400
Received: by mail-yw0-f178.google.com with SMTP id s143so64176036ywg.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j70KqaqyZuUY4MEbCDDKH50Sxjdz0K9ZgEg55zjFu4g=;
        b=ZYx88XkkAq3LNoQzcIRuOubVcohQ3yN9dz9gFs1IUfSQimnAD1v2gVIXn+5UYWX+Lh
         SlYsGy5tlFUcOYUMsKSMNX4vfQ70IJfEUqvqpAl9HPlp833I7BRoIvQ0FPB+JA2mauwm
         ejBes9RJC0CotKz1om/Cx1EjvU4GAgb3W9V7w1l14mKtj6H/N1VEf1L8Co/mb8Cd/f5i
         4FI9IxJG/pW+zEy7JAKDhtHoQ5JZdmpx8rPmEFlNu+xIT0c7thUKG5UWoPMxnpd8LtHI
         0YiJcN1H2nfdSpNPMHfkLowN8powms4p7clJkz0Q2dLQKgMd/sDD0iClsin8dGHgGMPC
         DlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j70KqaqyZuUY4MEbCDDKH50Sxjdz0K9ZgEg55zjFu4g=;
        b=VcDqaBmlxwovNP8TuGLVxeEqy5up+EFYFdB8U25V9OWn9O7mp0Gc5a/YuX1JCKj16k
         ZEIQ/0h2N/2pLoQNQcAvLzgDaA0UIoli4Fi0GMPm3Byp35BhoJ7G2lGzIY7lemxDBMV3
         o0NN7Gopwk+hSBzOxVCrbsdA6b1fMwQ7aUGneOnq3YtaO40K49VvqXKeJLyxWork/UFH
         vUzJ0oBEQZ+aoA6jT5BRAjPNAdnw/Wm2taZvGqseeML6yq+5fLbFNtKuLy6YE3oMQ4Oz
         i6Ahj3ymNOy58jyhMVOKexe7Ms+XEO07IweUjmglP7/GStsuRLe3E+rBi1Rmvj6r2kIW
         Sp/w==
X-Gm-Message-State: AHYfb5jSqGzCcPEGfidVLHGDn3RVCDlj3kpA5j9Bp8hSQvMXFeIWv6yO
        ex20TudMVrANFwfwDwYJdBWouarI8LIM4yM=
X-Received: by 10.13.212.3 with SMTP id w3mr7986434ywd.4.1503083043822; Fri,
 18 Aug 2017 12:04:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Fri, 18 Aug 2017 12:04:03 -0700 (PDT)
In-Reply-To: <20170818160603.GA69414@book.hvoigt.net>
References: <20170817103413.GA52233@book.hvoigt.net> <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
 <20170818160603.GA69414@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Aug 2017 12:04:03 -0700
Message-ID: <CAGZ79kYNLo_3PfLTOE5wusTs6wgFXZLVH+qNZ-ovxGguhinHLg@mail.gmail.com>
Subject: Re: [PATCH] add test for bug in git-mv with nested submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I just copied the shortcut that they were adding themselfes as submodule
> in 'setup submodule'. The whole setup of submodules in this test is like
> this. This way we already had a nested submodule structure which I could
> just add.
>
> I agree that this is unrealistic so I can change that in the test I am
> adding. But from what I have seen, this shortcut is taken in quite some
> places when dealing with submodules.

Please do not make it worse.
Once upon a time (late '16 IIRC) I had a series floating on the
list removing all occurrences, but there were issues with the
series and it did not land.
