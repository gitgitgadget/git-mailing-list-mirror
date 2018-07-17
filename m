Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B9E1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 22:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeGQWwi (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:52:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34805 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGQWwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:52:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so2690159wrt.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AWxZNLeNhkg1IhU1stAD18odQOFjWJojpvL+BajaqbE=;
        b=IzOHC4aQ3VSsciw3UbCwqRwZirV2XI3lYASLSKy49LQMWUvQgp6l53FMQTilDo+j0x
         LBRqG26yVWqFxbCtSMj6wmZqxUYyOlOXCRxaP2ij97JLObL0+oXWd5VnDi3YJWxqHAcR
         ZqIPw7QBEzAFMEZlCezVSRXsA3vEDDQDAsgToljt5CaJhdj+izWcu9PSztnTyaJoObuP
         nd5kCOzdtDNKcmUnM7k4SF/oBJFwn0afWBWV6q7cTOYK2CEUmbFzxDZ9oRlv3bIpxpxz
         pDIn+MGtxyA9F4c/1kgoP4n+08/6E9MYUzTDmM8F3zD9GsRqdGtrNfwzGwv1VAxCd/is
         RWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AWxZNLeNhkg1IhU1stAD18odQOFjWJojpvL+BajaqbE=;
        b=QlqBbzgI4+21cN53A7h9UneUEbdDkJmT0z7Vf+YZmxwT15z5iKbbrSzoqLuNo85v4Z
         RUI3hRaod4A6MPm/qydTzLGV8Lc8hUBWx6V7iHK2WcN6Szht5z5yw9XF5x3XDKQvdnCk
         WYk4hwbwm3L04WfnvJZGPkEWzjax6MgXD50IPdposgzK12GZH954C4vOoys3uivdeMyy
         yPwlZuErQAE9awZvo8eQl6q0uARkRtC+v09pmvorvYk+ZibvmgsqFfIzIb5TiFflQiXu
         cmBGV/a3yZLsb46fnkkx7BEIwZL4wQRdAWNcn333BbJvPLEK72cGsy9jiXvvbTb4N/4S
         tL5A==
X-Gm-Message-State: AOUpUlHGvQqgG8qLqjofk+BUUch+sWaNPb5Vws6gyQr0oaM/aiyUbHGY
        V3CJR63J7N3h9qEZkvHNax4=
X-Google-Smtp-Source: AAOMgpee8R4F1DOyfUNE76Xkyv9M1QFugw2uKe6y5HWAb7Y8lpcd/rAugRqcql4zdGlu6vAKb0Rj5g==
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr2546857wrj.166.1531865873003;
        Tue, 17 Jul 2018 15:17:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y13-v6sm3140471wrg.5.2018.07.17.15.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 15:17:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] ref-filter: use oid_object_info() to get object
References: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
        <0102016493ab542d-ea2a3e8c-d6a0-44ca-8fc6-f940fe7e84cd-000000@eu-west-1.amazonses.com>
        <xmqqr2k2sy02.fsf@gitster-ct.c.googlers.com>
        <CAL21BmnDqv9yib5Vqh4q7zj1hd_bmhO+xnDVJBi-zM0Cqtsevw@mail.gmail.com>
Date:   Tue, 17 Jul 2018 15:17:51 -0700
In-Reply-To: <CAL21BmnDqv9yib5Vqh4q7zj1hd_bmhO+xnDVJBi-zM0Cqtsevw@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Tue, 17 Jul
 2018 10:44:33
        +0300")
Message-ID: <xmqqtvoxld68.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Оля Тележная  <olyatelezhnaya@gmail.com> writes:

>> Hmph, doesn't this belong to the previous step?  In other words,
>> isn't the result of applying 1-3/4 has a bug that can leave eaten
>> uninitialized (and base decision to free(buf) later on it), and
>> isn't this change a fix for it?
>
> Oh. I was thinking that it was new bug created by me. Now I see that
> previously we had the same problem.

The original said something like:

	int eaten;
	void *buf = get_obj(..., &eaten);
	...
	if (!eaten)
		free(buf);

and get_obj() left eaten untouched when it returned NULL.  As a
random uninitialized cruft in eaten that happened to be "true" would
just cause free(NULL) on many archs, there was no practical problem
in such a code, but it is undefined behaviour nevertheless.

And the previous step made it a bit more alarming ;-)

