Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77301F424
	for <e@80x24.org>; Wed,  9 May 2018 17:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965754AbeEIRSi (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:18:38 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36379 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965240AbeEIRSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:18:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id v2-v6so32187352oif.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f0d/xpaP4/nJJXaL5+NKXw4pnF8OyEplzpiQAgqbQTc=;
        b=AUHPBLDZmt3ngbq+w5OK03skKpcIydmMEuxHct00Ap/mK8LFmVKw14LThaCs1VUmNc
         REcRkuBZ/VvOfJzM0WAnvWSfUDvQ4Vth9PtU/vddlokAHu7TSzjaCOPaiVkgZENCelhC
         3r15D+Z+5h6idz/w5j6y16nf+X081CUpf8F5qDwvxdsFNIZwrR4nj2OznvrVh3MIrjss
         n6fd4LGobW/NZ0ZQ+oRDaLuoHgkflR1UDJ+0AUrwzIOdgtmogXWUqyfmaceWjlMQTsLp
         EmrffmGSwU0BUzqDHqtow1lwTRA9GiQHLEaJUlLYQIw5w4aNiP8k9DQYkdny0+Y1xcSE
         N4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f0d/xpaP4/nJJXaL5+NKXw4pnF8OyEplzpiQAgqbQTc=;
        b=VK7pIgYkqrc5qmJARjaKqXoUnUQiDroXHckaNh1xaM9iSJVH451yIBwBf4+Bo+J6jd
         +VZY27IOWDF3x7Hlvy6wlEhcMQUd87PCKh79+pYqz6DpCgBx9kuG+iQZF380MpJmwjAU
         zvU5S/tlf3cCwyEE6vRjMHICf7UOMDCiQngmM6C9NQzLgd5dnqluvOedy3XJVlJFJwfY
         TJhpO5TZYJFN+Y5wl1b0CF9eY/wxDX/Eu+LX9plPkVV2RNsY1FcHmzrIJGR61fqENrG2
         QoiUrrH+ZybMXGRuuDImY1ov7TX33IoshINtoQsNfROjTQ+D7T70JSUsg0cozNuGkUYK
         pqKg==
X-Gm-Message-State: ALQs6tCQBJXuG5USeh04e+TA7gQOeaoyWQ4czah7FPGB27g03Z0nCeDW
        1k4ymz1+txgHS1B7kYfy1ljR3WuCsw8sUDxeulk=
X-Google-Smtp-Source: AB8JxZrv1mYw7CsZcS+/hwuxyKn2QJltEKdSUiJdLa/21jGVK3jeRaBdyEjDU1e3akQwjaWKpEDkzpWerpPCLOXlpYA=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr30676681oix.281.1525886317349;
 Wed, 09 May 2018 10:18:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 10:18:06 -0700 (PDT)
In-Reply-To: <20180508130431.287a9f273a847c375b3b1e2b@google.com>
References: <20180507225916.155236-1-sbeller@google.com> <20180508193736.14883-1-sbeller@google.com>
 <20180508193736.14883-14-sbeller@google.com> <20180508130431.287a9f273a847c375b3b1e2b@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 19:18:06 +0200
Message-ID: <CACsJy8C7N2W821H8YR8VaKdCSOSCDtQi_YT7z8hHNDO-VxJmEA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 10:04 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue,  8 May 2018 12:37:36 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> +void clear_alloc_state(struct alloc_state *s)
>> +{
>> +     while (s->slab_nr > 0) {
>> +             s->slab_nr--;
>> +             free(s->slabs[s->slab_nr]);
>> +     }
>
> I should have caught this earlier, but you need to free s->slabs itself
> too.

And nobody frees 's' either. I'm not saying cler_alloc_state() should,
but somebody should. When I tried repo_clear(the_repository) with
gitster/sb/object-store-alloc I got this

==13250== 944 (32 direct, 912 indirect) bytes in 1 blocks are
definitely lost in loss record 62 of 88
==13250==    at 0x4C2CF25: calloc (vg_replace_malloc.c:718)
==13250==    by 0x1AB7A8: xcalloc (wrapper.c:160)
==13250==    by 0x1BF666: allocate_alloc_state (alloc.c:41)
==13250==    by 0x140090: parsed_object_pool_new (object.c:462)
==13250==    by 0x16CCF4: initialize_the_repository (repository.c:18)
==13250==    by 0x110BD0: main (common-main.c:37)

If you want to reproduce, this is what I used to test this with.

https://gist.github.com/pclouds/86a2df6c28043f1b6fa3d4e72e7a1276
-- 
Duy
