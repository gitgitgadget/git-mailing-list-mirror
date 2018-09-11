Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3B61F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeIKXQ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:16:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33431 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeIKXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:16:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id r1-v6so8462941wmh.0
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EGBPhgQTOibgxUejBzAGeJfsaTq45ckHQE+esSZysSw=;
        b=Dmq4LLbZsTrMTyt6p1WM88JWkEfgCYgX5Y/nUl37wtLksyfNfG22vTphsbDtiLy2eh
         /PKMo5dY0lj1mvkN9S/gN3Pn+BDmEpoWDgYZiAAkk9n8p7TwQCvFJjWiho0AaeUKLRhH
         x5GTIW1japMI23O4D2vzVDNfvcCau3EysnzPNDERroT7LUJ8UA2rDJ9eYCx4Q7lxfwr7
         R0syV+36LKsnD/VNu4uqldhwFRG+aFwz6iIXUe3Dp1sD0/veM2Mqg2QIPzXAZgovJ0NS
         wSTQ+9tmzdCGgE7jq+TfL7WTUtNkD2HVjxPVnDTsPuzzoM4642jETaOXxD1XTD6t9i8c
         sQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EGBPhgQTOibgxUejBzAGeJfsaTq45ckHQE+esSZysSw=;
        b=b13us2wy3VcBVtJj0Q2SjGKx6iwgqVcH8RA/Mkp0e3Y9M0ATuiKlqKbjCV6fDERMTK
         KwRRANhj//kdjAC85qEyif/LWZb6T0/AKF6MCLuvqoa+qcUF3yoAz9lDVTqgcwyqMlho
         SE2WDeHmjvTLu9X6HkdEsdRWq+GF4UYEeJwgpTW92fB78kz/rK+EM/JvlANAjePFB2eM
         1F3/C8BdFBh2/JNiNJIM2hS9VUZVkJU5EL1J2akljy5QS6XUnhUWpiRoBMAJmyF876zL
         7PZm3dJncuFaMQ8vH1oFpnEcgjHwFi+i0EvJtxxbYHAeBqXPDaUVXiLoENJT/gE6QArm
         9zfw==
X-Gm-Message-State: APzg51Bh9bYHfA0Wl9NhKivhnFTXb6ZHgKpjkkNc3c8uKFWVJLn71Nrn
        D3w5iVmguSi6eKCDfQ76CUpejy4/
X-Google-Smtp-Source: ANB0VdaXO6bak2nqqHmE4TwNxKf0lPMksgXEH4YiKXfL/7pBZOEfg4vzvOyyfrLpV1NQOFt8RmfCbw==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr2091339wmd.92.1536689784806;
        Tue, 11 Sep 2018 11:16:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w15-v6sm26209066wrs.8.2018.09.11.11.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:16:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
References: <20180904135258.31300-1-phillip.wood@talktalk.net>
        <CAGZ79kaBBzG6-QKruCeybN_do735h9tAXHZ7Rjx_YXeh85ax6A@mail.gmail.com>
        <b78b467c-6cae-2e2e-533c-48a4552539f5@talktalk.net>
        <5cff63d6-d9ec-d28f-d34a-e610ac19dbcb@talktalk.net>
        <CAGZ79kb53jNAJagQ+nG0hoJiozKkR6Aw=oRLZj5xvjFY5Hx=Sg@mail.gmail.com>
Date:   Tue, 11 Sep 2018 11:16:23 -0700
In-Reply-To: <CAGZ79kb53jNAJagQ+nG0hoJiozKkR6Aw=oRLZj5xvjFY5Hx=Sg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Sep 2018 10:48:05 -0700")
Message-ID: <xmqqftyfq4qw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  [...] So this should be sufficient.
>
> Yup.
> Thanks for keeping track of this patch, as I lost track of it.
>
> thanks,
> Stefan

So does the above exchange mean that
<20180904135258.31300-1-phillip.wood@talktalk.net> is ready to go
with your Acked-by?
