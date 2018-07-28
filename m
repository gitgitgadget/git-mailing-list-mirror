Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BDF1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 01:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbeG1DC3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 23:02:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389016AbeG1DC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 23:02:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so6725808wrt.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2SKpHDDJwa7vAQ3vIxRZsNDA99XYBOxMNZzxVHgOEtM=;
        b=KJAuPbd2CNtCMjKfwRraJX2b7HCltas6lJKQb40qOSfFndjYXAuQWNC9LiVLl8tE9j
         5ytI51ysam2Qg6c6AVlpq/CF8iieKLpkC9nVHAy0r6YoVRrDalQV5v949c2dXIUtxFQF
         Lfp8iWBuD7PpDFUR+shAxzi8BjSEJEGf5ZZ7I/QoptxknDh05H7IoR2deZDjRh559XQL
         euLxk5o5S3JVxTaBsUwOh15m2qZrR/WX10PmNF6qEbtSkbt/aruiruAj9BvCxvbeLlGg
         /pRiB8ICLh590T37zZIL0n/AIKgExmAqD99TA2DZhg7Q4Cj7ZEWYe7ZmW86pX4RnhAQi
         QwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2SKpHDDJwa7vAQ3vIxRZsNDA99XYBOxMNZzxVHgOEtM=;
        b=F+q1thrEOtfAqloEX3usTTwG3w5YEhR0XpPf4ZUO+zK31c505vLKmTHFVRDnvJ1d6Q
         CSlRVLLp3VWeIo2aPsUQoiBneEltoSRqMB4/dRSDqRqJ8Vq9/zx0Q79ByCHaXWvIk9s4
         n14tv1vqva1juxCVQHOV4koDfGeddIqUYjzbdRTj+VOcmI/29fa1n3haqzqKjSQH699F
         ydw48E8InttiTvfuxdrwwfJw2PjjwEniRPo8CzQCb5OwYj7MUA4rYj1Cprp6aBWdjg74
         Gm+Jf+OPscXoIPkfJpOeEPAoB3rJJp7gv51TXJnisS4wVrk+KcmW5Bh0aQ50tk9Tb3Ai
         uRjA==
X-Gm-Message-State: AOUpUlGErP5nLyBoEI0jOm2R6CCKt4sAbn7hIZ/gsdSsETy0AI9AyPLI
        vImrAimP+86UbtA7Bb4gYCU=
X-Google-Smtp-Source: AAOMgpfA9gv0BpYuWv2udNV4igWeWueFSZU3fhUzhDJqIUj4QjqVA4tYTalqyaIFulffDrdn/Sa1lQ==
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr7047513wrr.105.1532741877932;
        Fri, 27 Jul 2018 18:37:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h14-v6sm4290550wro.15.2018.07.27.18.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 18:37:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@google.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
        <20180727233606.179965-1-sbeller@google.com>
Date:   Fri, 27 Jul 2018 18:37:56 -0700
In-Reply-To: <20180727233606.179965-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 27 Jul 2018 16:36:06 -0700")
Message-ID: <xmqqh8kkjg23.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I really appreciate the work by DScho (and Peff as I recall him as an active
> reviewer there) on 4f4d0b42bae (Merge branch 'js/empty-config-section-fix',
> 2018-05-08), as the corner cases are all correct, modulo the one line fix
> in this patch.

Amen to the early part of that ;--) Even though it was merely
cosmetic, and did not affect correctness, that longstandng bug was
very annoying bug to a lot of people.  I too am very happy to see it
disappear.

I would still hold the judgment on "all except only this one"
myself.  That's a bit too early in my mind.
