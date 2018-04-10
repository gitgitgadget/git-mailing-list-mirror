Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58CC1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 03:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDJDVW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 23:21:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35122 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeDJDVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 23:21:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id r82so20517446wme.0
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VHY0Jv9POmhPZny2vuqJh/eLLAjuB5819x+52k4XFO8=;
        b=La5BXunMbG8Z0hs30uL9w7N8b/tkYjLrSllu1jwjjMzuMogUHC3TBOB9Nng3PWkPhU
         H7JP2An8cjYUT95cr3dv72YWAlvdm7Pm10rNfhO+/3KAiNyijoYKp1qPMvshje5kGqrb
         OLvIyv+W8QXdwW7JufQ9Js32WcXBi7EveV+bHhE8tg1NTiZQM+yftMXwuCLaCGkyvzgB
         Z7u8HFv+JX39/aGVwjSBrOc/CHcbPznB/UxIK4mWf8TKVo2UhZxGe43h7AnRGfpGU+CA
         UOR+3IEDgsIHuzqn8k4gNePahOsBP3MFLQGA2d1Hg2vZzsH8TfTnQLxkoV8Wk5Upzw9+
         iR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VHY0Jv9POmhPZny2vuqJh/eLLAjuB5819x+52k4XFO8=;
        b=SJs9aSOW5nJ0B7GcLd8odD4ILCuk+sUd8tiXPsv/VxD31Y04cm/msYeRftdE+d2dMu
         ER1q6e8e2cSzL332XllfVwBu5ZLhTi+LQYkKFgFG6e8wPFSrgqSNlydaYecnhQm33i/J
         rApiDDv9ijHjPYiLI8Jthn4cBzdFiBBXU4ou3Ww32AGhuI9F5vZiYbPNhh62J2UPxsv0
         cMm1JoP5jUfZo0SDjPZvYh+/OUYuWphKVKUlTS8kf2WY+6v+ak81E863mvHLrNTwXY/a
         paYw6UAC3cRTwvVD1XtH9R19HvmMsJkuaNBhzodBSSfFZbb+1tDIlGBEJT42Ilf+AXho
         y4eQ==
X-Gm-Message-State: ALQs6tDYY1ljQFHfV03IMefVyOeX3lA2EXWBU3s/8A9XSpOX8jKD8cAh
        lRCyVmWgNnC2R8JWDo/ag4I=
X-Google-Smtp-Source: AIpwx4+MabpfPwS4aCgtG89jyi5IL6ysOdpG7JSSpKERgbP62ZSDpSkC1hvZazQxIoGo9kkH4PN0eQ==
X-Received: by 10.28.156.4 with SMTP id f4mr267361wme.79.1523330480584;
        Mon, 09 Apr 2018 20:21:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y100sm22028718wmh.2.2018.04.09.20.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 20:21:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 05/16] replace-object: eliminate replace objects prepared flag
References: <20180406232136.253950-1-sbeller@google.com>
        <20180409224533.17764-1-sbeller@google.com>
        <20180409224533.17764-6-sbeller@google.com>
Date:   Tue, 10 Apr 2018 12:21:19 +0900
In-Reply-To: <20180409224533.17764-6-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Apr 2018 15:45:22 -0700")
Message-ID: <xmqqzi2b3fww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> By making the oidmap a pointer, we eliminate the need for
> the global boolean variable 'replace_object_prepared'.

That is not quite a justification for this change, as making it a
pointer (and paying for the malloc(3) overhead) is not the only way
to remove the variable (i.e. the "has this been initialized?" bit
can be moved to "struct raw_object_store").

One possible advantage of this approach, I guess, is that we would
more quickly catch code that tries to access replace-map without
initializing it.

