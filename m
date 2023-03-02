Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5AEC6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCBT5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCBT4w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 14:56:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B347410
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 11:56:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so105605pja.5
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 11:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K9tjMOnoYESqPLkDtDYaDiQqt1UlNzqF+CIY/aMP08=;
        b=XVcA8S1KFdF8GCftl2oMTkPiKSv2Dvz8qrQME6MVcBkrLBHySDk0GEKe2jWIKegAYh
         S8g9k1Ewr+d+Lpj8ZDkBqZRNL20ak/EtueVpyirhmk2XeXJTIhuoYg1g9FoVqNPttHuU
         smdVDneEMyBXdJUflLgzUoSfuOlauFYF807qDFyqzilFozaXQeHtFPxuSS70qFtq2tzJ
         gRYG8vGZjL90m94acy9sHnZVisS+uUa3cxRjEvIznMNs+OjfQ3QlL7wfBB8AGVEEauiz
         iGRKz11M2XsoipyallsNAYhvkppLD878Vswp5FwsmyqYOT4l6cJNG9BThlaX0NnsyJ3S
         O/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6K9tjMOnoYESqPLkDtDYaDiQqt1UlNzqF+CIY/aMP08=;
        b=5Fxq5jyidDRTl4JQwYxhM9WjUs5MkBXx8yuemRJ+uFFRzm2nNeWvot0ogBZjfnWtYJ
         Ugz6XAFASWZbh/XLqKhb+VbPLoGPb6M0J/hzM5A3LkSjyZYU8eov6IecxArUnA6Cz+3p
         tL7sPw8my8iRFSSUKbcN6a6ERc1dFJ7QwpEKcmeNuSglvMobQfNoj7fpUcMKGNVcKrkx
         ydrdgqaHX1Z1DftoQkjTpkdwGNPLp8WEykH4PRq21ma97rhSTrqdvZn5o/4EQJmsdAsi
         4ZB+OMKFi4WEwVEQ9ManrFbdsWK2U1oopN/EjpfRGMPJCmfGXjVJssyL5zvvyGNzCR1V
         YatQ==
X-Gm-Message-State: AO0yUKULk9SZm/zhMX0MUFiru2Jh6BXEO8NKGhtztgxAE6YDMvBi8eXJ
        QY3bN4r7GQ4SD4HMb4P3XHoXcXMEwIw=
X-Google-Smtp-Source: AK7set8xKTsnF0ZTiXiURwVUDWIZR9UHUTbATVBkA6w7grFmLICLiHjwCvAjGiJ/qQvDWKl7XewNvw==
X-Received: by 2002:a17:903:2350:b0:19b:22c2:26a1 with SMTP id c16-20020a170903235000b0019b22c226a1mr13693756plh.9.1677787011335;
        Thu, 02 Mar 2023 11:56:51 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b0017f5ad327casm85894plj.103.2023.03.02.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:56:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git List'" <git@vger.kernel.org>
Subject: Re: [Failure] Re: git 2.40.0-rc1
References: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com>
        <xmqqh6v3j8n1.fsf@gitster.g>
Date:   Thu, 02 Mar 2023 11:56:50 -0800
In-Reply-To: <xmqqh6v3j8n1.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        02 Mar 2023 10:44:18 -0800")
Message-ID: <xmqq7cvzj5a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> <rsbecker@nexbridge.com> writes:
>
>> Git 2.40.0-rc2 was a regression from rc1. The following new tests failed:
>>
>> t3206 - virtually all subtests failed. An example of this failure is a
>> results comparison in subtest 1 (seemingly relating to abbreviation):
>> + test_cmp expect actual
>> --- expect      2023-03-02 16:39:23 +0000
>> +++ actual      2023-03-02 16:39:23 +0000
>> @@ -1,4 +1,4 @@
>> -1:  4de457d = 1:  35b9b25 s/5/A/
>> -2:  fccce22 = 2:  de345ab s/4/A/
>> -3:  147e64e = 3:  9af6654 s/11/B/
>> -4:  a63e992 = 4:  2901f77 s/12/B/
>> +1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:
>> 35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
>
> Are any big endian machines involved?

Sorry, "big endian machines" -> "machines whose char is unsigned".

>
> cf. https://lore.kernel.org/git/Y%2F+paI8WGSmEbv%2Fw@pobox.com/
