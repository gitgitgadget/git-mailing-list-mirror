Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1893220248
	for <e@80x24.org>; Mon, 11 Mar 2019 06:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCKGoT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 02:44:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52636 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfCKGoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 02:44:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id f65so3123295wma.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 23:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UzFxL4Cj7ivbSlo9XDmNWLopSGvNg7iAAwTHJGnFQlw=;
        b=LhJg+8c03DF5+0cAgftySomqtErucqQ+TXH498pvGEo4wwM9i1vPzM+T04X5SU7I5g
         TDp88nRoxWXX/M3PLLDTWeV/r1pmylCUUbz5i2biz7vHKxCM0J3MjWhsGBkldL9wSTk9
         g9NSJblyDXoHxohXdAk6O8X0/js10Q1wzYr50opxj5cP9txFgAEIaJ9165brrkTZ8GJS
         S3asbLhVrkVaWcQR8u21ZZcFdfpp8uTI0ruDZaoIVlJRJsPDKb42pUWZxES/NQEoeYnd
         tSDtcRl124aedv1OduwgCUjH+iTWIFpavDe2891abacs+Lj5ARvE/ZQgJnA9iB9bMXKq
         w9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UzFxL4Cj7ivbSlo9XDmNWLopSGvNg7iAAwTHJGnFQlw=;
        b=KkieDM6XRr5kgy6w5/1touO5Nj/gYpo3YTCA9GVGEEjBvFe3EH0Glv/UlMEyK5PN/a
         6IS5us6FskXv1Hmf97nF6JMbCISmteMCr5s+uryzPiy1lAkFpDH4f/X1MRgBdUqbkSxV
         j4r9+VBR2PM2uWR0Y7CufEDv4yYBjj/UL0Dl1hidVavw68nF0BhBr4PFwTJHPW1Ankae
         Cq8srfL5hbAHOg9liZm9/VHOodHI9um085niTnqu6y6sfP59asLdkpFLXe/QzmWzDwFD
         SSjQibsNuydUd+RwDhUe9ydBYRR1DWsc3UZeQpbWLkefRbbIY9/A/ewdzIHsXdtXVnQw
         SC1g==
X-Gm-Message-State: APjAAAWNSo0/J3/LQGHIVXR7pq7m1QHflintLkG5+9VoSXiC59t2aSeO
        m6aD90YiNtA4L1/tZq00U26oyYnPumg=
X-Google-Smtp-Source: APXvYqxgTMno+XtROqLTBbjvRcxr0DblYeGFz9MVHnVG95E2ltS/q8qEeAUsh4yFPqpkJpTTDO2a0g==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr17083055wmf.80.1552286656790;
        Sun, 10 Mar 2019 23:44:16 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b18sm4907715wro.80.2019.03.10.23.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:44:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 0/8] Fix scissors bug during conflict
References: <cover.1548219737.git.liu.denton@gmail.com>
        <cover.1552275703.git.liu.denton@gmail.com>
Date:   Mon, 11 Mar 2019 15:44:15 +0900
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sun, 10 Mar 2019 20:42:27 -0700")
Message-ID: <xmqqpnqxkj0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This is a complete replacement for dl/merge-cleanup-scissors-fix.

Thanks; will take a look and requeue.
