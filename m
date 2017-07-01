Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA3C20209
	for <e@80x24.org>; Sat,  1 Jul 2017 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdGAUd0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 16:33:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36132 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdGAUdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 16:33:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so21127091pfk.3
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gdgcMb2hI+erWxHoZBXZtAOfodGa8OqzeAfcbHe9n1Y=;
        b=OkcLfBVCx0RaD9HYSLCgKTINUyQznQXO20YXN5BTQtCOJoqp79HADxwU4qJzrgOFDn
         jiu9wqXLQQa/sWNcU8fgmP2h9U5Tl/ihvElxVBB7bAxLIkj4rPPfj30q4QNMzZ/KbFDC
         i3dq7DqGTg+ogkQSoaF9Rj836f0VPvqXFi7Xj1CZKhFrhNS9DEKMw8Yuo79D9ynBFRav
         VFjbL5omLdl7cONWJY/aaRqz3IIH6YW0qMP9evvHuMJWmheZXHvODcfUagL938d88DJo
         4LB6OAsOZrCi9UGbytEK2nYzL5pyaaxzscvsWA/5mwo5mmNUTJ5wtqJHCP4qDquZUL5b
         VtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gdgcMb2hI+erWxHoZBXZtAOfodGa8OqzeAfcbHe9n1Y=;
        b=LYpzmkGLErDZEyyQZZutxjGNyq97TVToLj/pqCt9za/raBE5ZSzA/CbJRNorlA2Gyz
         DEqnWIgcVBmrQtKwFfvW06BA6ZCNH6M0rMrR4aARUnJGPPOoiUOMSvupSEDW043lt9iM
         xHHn/LVWHLU/uVqoqlf9CpxWjoAszGPztTm1Yfw0s6MoTJ039W9nEdLYO02z3xpnu2RI
         xlkM8U/G+kv6YZtlkHieJ+uFLZJOhj1FnOMMVYm9BACSzJwzXdUeiXWKgSudO7Pqx8Gg
         ibHMoAo7ZE51SFaht5L/xm5FWGeVNlONtqOHTz5L7ZbGX9c8+1ogfT1fbLvsr6rSrS/k
         9HWQ==
X-Gm-Message-State: AIVw111VZQzPvjsuVlZJ91PFAq01Mgza1yUBVIKpiJGW1PZ638EBd64H
        RYhOaI7E02V7qA==
X-Received: by 10.84.217.220 with SMTP id d28mr2344779plj.218.1498941204430;
        Sat, 01 Jul 2017 13:33:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id d1sm27178763pfj.51.2017.07.01.13.33.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 13:33:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
        <4be750af-b093-6644-7f0e-82983327766a@gmail.com>
        <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
Date:   Sat, 01 Jul 2017 13:33:23 -0700
In-Reply-To: <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
        (Christian Couder's message of "Sat, 1 Jul 2017 21:41:02 +0200")
Message-ID: <xmqqtw2vnbho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I think it would be good to ensure the
>> interface is robust and performant enough to actually replace the current
>> object store interface (even if we don't actually do that just yet).
>
> I agree that it should be robust and performant, but I don't think it
> needs to be as performant in all cases as the current object store
> right now.

That sounds like starting from a defeatest position.  Is there a
reason why you think using an external interface could never perform
well enough to be usable in everyday work?
