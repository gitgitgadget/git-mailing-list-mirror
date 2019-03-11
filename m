Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CF020248
	for <e@80x24.org>; Mon, 11 Mar 2019 06:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCKGUJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 02:20:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54350 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKGUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 02:20:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so3092188wmj.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wPLWJLb7U3KDXXdyeTYwRJLf2Kj++hz06A4m42wmHa4=;
        b=QPMQ/ud+IQHWI0g5uGVetWFor/mdQ2rG706iDkWww6+Tt3OTUljtvSIU/7lGF0ZEQb
         cCVRf+9pBdN0IcusuLkcjnYZq+26KCQ0pMDsw+R5rrq3L4pikZDqzP2N3zSD3GdW5gIC
         NH2do3dNR0eJPnW7FRPsMeU+CwZXM2R/Mb6DbbVJNKQR4RO65u2Ff55gA7xMhhR6gRKY
         bavOduR9ilTEMLr+0A1+HfzaSGM0Cjq17W9cd/YtnTbiRUEDhUycoEKYIWXyWSMul8Lq
         Mkw56ug6VWfbtwGN25mBq/OBOo9RAkGTjM6EZOmeWOlQd+nMB/YmP6/pmzlHIWCyDAta
         PwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wPLWJLb7U3KDXXdyeTYwRJLf2Kj++hz06A4m42wmHa4=;
        b=bXTJPOjWEZcN6sn6Bwuc8glwRc3MIqfsuGDOkbAZON0XRX6bteS6AHT5HrrruhJoUA
         G1ERnNzG9/BrAaHkIGgKmLyXpv4uDPlJRI+Ztd8IhqyNk7n4bgzNgk7v30ccqxDULLnl
         8GzOyt13uQ0pHpz2b56b1rRt2bloFfoP+BYLR9+LFcXGtxiPwQnTWoSygbZZBHHa+4My
         hfly71vQRCLsyQ/o8E7rbPxe02Z146CKSQcg5jivAWe/9fBQqC1RKHS3L+IsB1TqwUIO
         9PsiRlvICBuqbfyqoLMEaimhxvk4UbGTOu5QgIcuWOJaN9IDngVtjPPm7CHAGoszNbpb
         yh6A==
X-Gm-Message-State: APjAAAXP2ibOY69waAcTd4BqOns1maiErlnhu09wT9Ak+BFP0PIvOSdw
        e8GsTTh7F42YKOQED+ao93U=
X-Google-Smtp-Source: APXvYqwVfa30KSJsB4fJgFSq2Joe6FaRSP5C2JTduccKoiJs82M7JhB7PAGxKAuc8zZSJCR/vx7iFw==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr16475301wmf.139.1552285206856;
        Sun, 10 Mar 2019 23:20:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u12sm4676837wrt.2.2019.03.10.23.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:20:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Yagamy Light <hi-angel@yandex.ru>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
References: <20190305120834.7284-1-pclouds@gmail.com>
        <20190308092834.12549-1-pclouds@gmail.com>
        <20190308092834.12549-2-pclouds@gmail.com>
        <CAPig+cQYDuKrRwf9GrGZUTnH=BgSyp8Rmh7ON1p+0qOrHxpe3Q@mail.gmail.com>
Date:   Mon, 11 Mar 2019 15:20:05 +0900
In-Reply-To: <CAPig+cQYDuKrRwf9GrGZUTnH=BgSyp8Rmh7ON1p+0qOrHxpe3Q@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 9 Mar 2019 21:02:02 -0500")
Message-ID: <xmqqbm2ikk4q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>                 case 2:
>> +                       if (last == '.') { /* Refname contains "..". */
>> +                               if (sanitized)
>> +                                       sanitized->len--; /* collapse ".." to single "." */
>
> I think this needs to be:
>
>     strbuf_setlen(sanitized, sanitized->len - 1);
>
> to ensure that NUL-terminator ends up in the correct place if this "."
> is the very last character in 'refname'. (Otherwise, the NUL will
> remain after the second ".", thus ".." won't be collapsed to "." at
> all.)

True.  Why doesn't it do the similar "replace with -" it does for
other unfortunate characters, though?

