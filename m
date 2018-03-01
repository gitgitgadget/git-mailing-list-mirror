Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E621F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033715AbeCASFZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:05:25 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40396 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033627AbeCASFY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:05:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id t6so13898494wmt.5
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JSEghgAibdnABGEfxfDXcFPuJmwmWTKyUpdt47H4SHM=;
        b=cBVEv+tQBTFFNEvALpc+/Adpva4YElOgUcoHb4f2jWEWbIToHpBmwlzmeFdj17TDcS
         W4R2L050kEfjhKfCjOP25GUwsDT3OsJ5IFmaLt6u5RY0W2asDnrFr4gB+Zhcr+7tBDx3
         e6L1rlpiGLTw97Uu9nymjJ/rJ1h791v25BbQYvSNBC2/IlkJ+BbAedI0y2Z7ll3bImsW
         Ds+ub1yVN5f7/b5uV/intTUMbhJElb2Kei/rTTJTjufzHCXkhQ7oSlYHdDofXsAo1FnT
         sR6BBnY/IHiS3rMvqV947lTj+QQk/jGXRIjWmEFQ0TdUaNY5W2YRXGFGsa3vTqd4N1m9
         okRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JSEghgAibdnABGEfxfDXcFPuJmwmWTKyUpdt47H4SHM=;
        b=ngYXR65RJbRgIOe5OI3awMfgg79zuSKw6ARFkjYEYFTOIqGuq4YXAvc40aiTIgDdde
         xAUivJmLmc6zpFj89hR1t9nQYUJyHxSBpFHgGHgeVfHkecah2zmypWNazjoBf7z9OplP
         pRGEfWt4pYlinIoKdEJJv5ZMX0YSDt+JtNKLGvVV2vR1BZRSYW7dVhOCxm5HQkO2U52T
         hF9tp49jyAWG19efaNyAGJPXTSPxsFh+0/UKvRf4INAQJX5p+t87So0mYvt20R6xH5WV
         SO82lvlKXsAJeNp2Tar1vpS+I9N6YepiqO0+2ZtG0IXek3qPcUFqu0kDTjcW1UL+SXRx
         X86g==
X-Gm-Message-State: AElRT7GsGYOoVUpn3Cf5JMPlYEeBhNT+Vzx35apjSGokf7THl6M31j1o
        eDOba3Gm7Fdozenfmi5JnGg=
X-Google-Smtp-Source: AG47ELtEmjGEl8XDQo17B2ULMdzWgdhxrAGrdqzEvyvxwN6TOnDII/zyODzMEakeWF2pe7OoshQF8A==
X-Received: by 10.28.11.147 with SMTP id 141mr2388216wml.138.1519927522613;
        Thu, 01 Mar 2018 10:05:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y6sm4066112wmy.14.2018.03.01.10.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:05:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 07/11] pack-objects: move in_pack out of struct object_entry
References: <20180228092722.GA25627@ash>
        <20180301091052.32267-1-pclouds@gmail.com>
        <20180301091052.32267-8-pclouds@gmail.com>
Date:   Thu, 01 Mar 2018 10:05:21 -0800
In-Reply-To: <20180301091052.32267-8-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 1 Mar 2018 16:10:48 +0700")
Message-ID: <xmqqzi3rhdsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
> pack. Use an index isntead since the number of packs should be
> relatively small.
>
> This limits the number of packs we can handle to 256 (still
> unreasonably high for a repo to work well). If you have more than 256
> packs, you'll need an older version of Git to repack first.

I can tell without looking at the rest of the thread that people had
reasonable objection against this stance ;-)  This will not fly well.
