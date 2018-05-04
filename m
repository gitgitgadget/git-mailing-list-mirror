Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF4C200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEDCiU (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:38:20 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:38331 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEDCiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:38:19 -0400
Received: by mail-wr0-f182.google.com with SMTP id 94-v6so18169911wrf.5
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+i/cYFVn6JSQVzsB1oAfrkX1MYwdm1xJyg20Gywrbrw=;
        b=N56KNPR+Ijv7CG2rGY1G4+uu1NfwQ2wXkcfNnBiwfvdNb5hLRCn9YMeTuk5TjwRytQ
         wCk6HAIXMZWIKT2hFob7Uou38JMkYC8xdxs9sIPwMCBABq5Hq/wGmPovbQ58Zi3xrRCt
         AV8tP8LQlznEaKIlKUG/1nwXtvSFe66x8m+HCrf5y8b/o0asxQkDwm6gZIp7B0YsEPHT
         4k/SmWYWY6Nj0v995XY2YiqpJO0s5APL9h+U8RqIekNt50iIrhcc/Qp78N2aTTCP2CgX
         ipmYnXM4piuUeOv7D5Kw94vkRbNiVfQh+DXubBrHYA1p9zOLIk7oj0axZYRvfWQvgFdk
         a1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+i/cYFVn6JSQVzsB1oAfrkX1MYwdm1xJyg20Gywrbrw=;
        b=ktmGe1A5H3FXjuK297pDhIVKTN9zVb2E3ngY095KC4+zYNTkFK3VxU65HMij1qctyV
         r1cAlO+5ii4HJPOyKct9T1zuIdiFDFeqe9YtWj6/0R8v4NspGFegsZg8nyNEBMyMRggp
         cMnrB7FSFrNqf27TRyXULbbEfinF+k7fFQY3PV57VC0jACOP3TJRlk1OJieS6oAQ+DqG
         k9IaFffkxK68367GO6AjG4nG3IYT9/Tow6kjjC8gMGD/NRZnsY8Va7vMd7GK2vck5gu5
         LoeWuEFTcVeJWAKBLh/k9Q3HB1ptyZgKRr+3fy0Z5bmXuY7n4b/Qmfx9zyv+597WitKp
         iRMQ==
X-Gm-Message-State: ALQs6tCd/85LiW4PDunVM/4vpKp3mC3yB3vM5xmJjpYC3hg8pS7SdCio
        Rw9r3Do8yNDdAUndJUzgvz0=
X-Google-Smtp-Source: AB8JxZpdd17HamtfxtJaWZsPVTUO3hQ5iHL5pR/cr+oJWQKMtZlC0u5ULKSJvDnIX+I2v1vDWQd2Mg==
X-Received: by 2002:adf:d10f:: with SMTP id a15-v6mr21102368wri.165.1525401498331;
        Thu, 03 May 2018 19:38:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u35-v6sm16083046wrc.29.2018.05.03.19.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 19:38:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Shin Kojima <shin@kojima.org>, git@vger.kernel.org
Subject: Re: [PATCH] gitweb: Measure offsets against UTF-8 flagged string
References: <20180501064015.59977-1-shin@kojima.org>
        <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com>
        <86k1skzzc4.fsf@gmail.com>
Date:   Fri, 04 May 2018 11:38:17 +0900
In-Reply-To: <86k1skzzc4.fsf@gmail.com> (Jakub Narebski's message of "Thu, 03
        May 2018 14:40:59 +0200")
Message-ID: <xmqqin84taau.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I think the problem is not with aligning, otherwise we would simply get
> bad aling, and not visible corruption.  The ACTUAL PROBLEM is most
> probably because of concatenating strings marked as UTF-8 and strings
> not marked as UTF-8.  Strange things happen then in Perl, unfortunetaly.

Sounds quite right---the patch needs to be retitled, if the bug is
not about "measuring offset", which I think is what fooled me when I
sent my response.

