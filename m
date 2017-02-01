Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBE420A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbdBAX2x (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:28:53 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36431 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdBAX2v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:28:51 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so35495975pgf.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 15:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Oy5c9qvycGdFo06nT9Kui5OVPosZ+bVrHUh9Twylr+o=;
        b=SL4TkG6LDVXykWJXja2dhft2oOKofHT3o8Kcy7JdembWbaiVfb4PX76DtOJWyL3DLV
         5cUrARjL+AluVRmEla2OYRYMyBzX734cetMesuDHRzJfIqA+35w31rDXVG3+z1LM2Om9
         4TRi62JSWguC5KYJ3DVDcSEy/rT82Gmj+OyuuAiUwPT3ozTivT5Lj4b7ZzDG5jsvfATP
         j2VnZwYkv/p1S+pqOqL+wGnanebpP4KmSLxtA9FXuu7seVkRW6T5YGy00p8Vxgi2zbOc
         YQb+RKR4AstNMoc+yjRCfrF41X2oDbXi62N6Of2zQhmBySSBk7+9oBy0T7dFEpZYkEpB
         aP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Oy5c9qvycGdFo06nT9Kui5OVPosZ+bVrHUh9Twylr+o=;
        b=DorffAS+4WeK0uxLoRqwqdjGZYQyOlp8Tv+ycR3AEj6x1UQKMfciJ0yjNHG78Z8weq
         kmHvZM/ZMvigxXDMgT3uq7Etx4ahvUK/myMFseaum+nPcG+3wjgyTVIlqKH27SZwIEBZ
         ag9ImeGP+/7dTZXu8OWsGLaiqylrh7rHIwVhABHBKYfKi8uHgVMR3oQygWKy5b6WWeU3
         P0qVtvRuCF95ZrVb32Y/dFf7B70L4UNI1vRjMMwYvPseQFrIGvv77BqBi6Y8ECVZASFN
         Nlq2sEJ33S3YmjP5zUnYwuB+EVFCftpGyjIoMbkhcOtzOsR1tlg0KriWI1PJn2CyPuhz
         68uA==
X-Gm-Message-State: AIkVDXL+TTOmGZs8Cw97A88M9wtg9eYid2PqU9MqzffZk9zIO0/6vctEYtnslXsjzb7dRA==
X-Received: by 10.84.210.107 with SMTP id z98mr8063833plh.171.1485991730798;
        Wed, 01 Feb 2017 15:28:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id w76sm52349866pfd.74.2017.02.01.15.28.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 15:28:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: make "CONFLICT (rename/delete)" message show both paths
References: <1485636764.2482.2.camel@mattmccutchen.net>
        <xmqqvaswrv5q.fsf@gitster.mtv.corp.google.com>
        <xmqqh94dockc.fsf@gitster.mtv.corp.google.com>
        <1485991441.28767.2.camel@mattmccutchen.net>
Date:   Wed, 01 Feb 2017 15:28:49 -0800
In-Reply-To: <1485991441.28767.2.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Wed, 01 Feb 2017 18:24:01 -0500")
Message-ID: <xmqqa8a5mqxa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> On Wed, 2017-02-01 at 12:56 -0800, Junio C Hamano wrote:
>
>> Let me make sure if I understood your changes correctly:
>>  ...
>> So the condition to guard the call to update_file() also looks
>> correct to me.
>
> All of the above matches my understanding.  Would it have saved you
> time if I had included some of this explanation in the patch "cover
> letter"?

The fact that I arrived at the same understanding by reading the
change without peeking at such a cheat-sheet gives me more peace of
mind ;-)

Thanks.
