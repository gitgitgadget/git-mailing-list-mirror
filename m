Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88E22141A
	for <e@80x24.org>; Tue, 15 Jan 2019 19:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfAOTdA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:33:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36587 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbfAOTc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:32:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so4467688wmc.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cczqxxbkkVJ6Qp92QkWFlzCdgyin8cpfhRq+IKCQSVg=;
        b=Mjzn1GYosSP0rRwjDYrIaLgwyHvkZklVtgAAFVceS4f9nPRmRzOsxIcUdC+oBYVsuj
         yW4WobD99Q30+bsFO3SDESNGbo59hAm5+/6yNTjlX4IDl/1A8GXqgsukS1fnglE6T68s
         BSatWh6J9oG/3uZoDYA5XO2VEz60BBJXmSBUqNnmskSwJa1YCTadvlPgazYYAnu6BxlV
         UACcXZt9gqgUja8/xV73m+QMr6SGV+1Cw9jqMOe6M3VLL+6+lx1ad9Ql22asNLsMPDPd
         9s9jEhnLDhUBbAKgdee49g3SNcWD5/B1RxH0L0SHWxsUYBand9mD1TNuL8WOmhB+tVV6
         my0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cczqxxbkkVJ6Qp92QkWFlzCdgyin8cpfhRq+IKCQSVg=;
        b=qlmXc+i7hliFWvQv+gKWUx5L2CyK6R4sZQts+c0JxHm/h6RkKDUSLjYOOu1XstallO
         L5LXT/W8A5AYQFilA6MFyGsQJdnjAZ9cni6keofwpuqoLiHqUFJT/s2yhJu3XPKVHqDA
         Jdn22WrDC30ZVqHA7X5vSdwZiGGmx/QpZTQBm48adYZNcpd7VwIGCy6puJZId/dz7Zlp
         LV/edP7s2H+oitMXwU/ZtLoU0sHKhLfcxgRsh4vHojqjAjIs0c6/PHrSQyBciHq+jIMI
         bsteWpUOuCfMnGmuNqlEp3P0pjT0OnnFiFoZ3VsRq2mVCFE/5kymlDoWHFT+q12doGPl
         JBVQ==
X-Gm-Message-State: AJcUukdPDbxqb1n57jJRTFxLdmwCOTCMw6YT6dar+IYUvwHr1ZNSh2eN
        DaOtZhmY2WDN+GapGBwZZJY=
X-Google-Smtp-Source: ALg8bN66wIQCo+oYTJRRXj6xnpZ+w8lsgwcOrb8W5hBL37zN2H7o8wUyXRzRFQ8233GrpJvA8fa4aw==
X-Received: by 2002:a1c:16c5:: with SMTP id 188mr4686408wmw.69.1547580777596;
        Tue, 15 Jan 2019 11:32:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m193sm35282000wmb.26.2019.01.15.11.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:32:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] getenv() timing fixes
References: <20190111221414.GA31335@sigill.intra.peff.net>
        <87va2u3yeu.fsf@evledraar.gmail.com>
        <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
        <20190115191359.GC4886@sigill.intra.peff.net>
Date:   Tue, 15 Jan 2019 11:32:56 -0800
In-Reply-To: <20190115191359.GC4886@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 15 Jan 2019 14:13:59 -0500")
Message-ID: <xmqqy37lra1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jan 12, 2019 at 10:51:42AM -0800, Stefan Beller wrote:
>
>> > I wonder, and not as "you should do this" feedback on this series, just
>> 
>> There is a getenv_safe() in environment.c, but I guess a xgetenv() that
>> takes the same parameters as getenv() is better for ease of use.
>
> Yes, but it punts on the memory ownership by stuffing everything into an
> argv_array. That saves a few lines if you're going to ask for five
> variables, but for a single variable it's no better than:
>
>   char *foo = getenv_safe("FOO");

You meant xstrdup_or_null(getenv("FOO")) here?  And did Stefan mean

	#define xgetenv(e) xstrdup_or_null(getenv(e))

?

>   ...use foo...
>
>   free(foo);
