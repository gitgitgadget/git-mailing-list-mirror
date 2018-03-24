Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10DB41FAE2
	for <e@80x24.org>; Sat, 24 Mar 2018 12:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCXMNQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 08:13:16 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37824 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXMNP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 08:13:15 -0400
Received: by mail-wr0-f170.google.com with SMTP id l49so5414051wrl.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=X8xUhg5/54Xyz7oKCBevcfidVhhY+nGc1uEjwevcdrc=;
        b=oYcz7QAMyzrcyivbgYYvujkj6CW6osK1UsQoOmaVQ2mNn6v+Bi+Gsfs8vgldoEJNz+
         kEnGD+nES61wjKHkGN+Fed/00GG4QSV9GCmzUDVJ61crkPnrOdMQZXGbN6gezyupjqvi
         utuxREOdKKoZhIqDuin/qfdhcYhzQ/EmQYKMiYHBDA+3ocam2NqHWg7sa2bZ+hkmkypl
         +Dnh4lH2G4osk0VIn5HBVXJeMs0wj6BqZxdrx4xZK39r7fxMKUO1FTb8004PD+yowFoN
         gI/ngiDJowus0mrm5cAiQroeNjNjdzEMt3z4DsxIIcR+ucBKVnc0/m3r22emhLlM0gRf
         6QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=X8xUhg5/54Xyz7oKCBevcfidVhhY+nGc1uEjwevcdrc=;
        b=ndqY0YW09FETg981YNdKKU9DCKFm7hj/JbKwF3n/DvuceAH1ybusQvEDxUD/ZuxbTE
         laBLenXBBKHMAxgIhE5re6lEQdUzoccbVepzaArfoo9Fht0jHjSZI96EDaaVkKKzshH/
         ImCYEOQ9PpKHGNtgeM/uaNDuh2+g+++HLjpLHY7qkZPXjC85ByoZsboHGXauRMkEQcRN
         MZNVfgjkiy1E9ssta3e2oYlkFlydJEitOBTOLLMJHAXRLdc2rXFWTSp81zVeLE3tjQWG
         YQ0HdVCEt9mrgd9y3+Xj9dhC3ihdKcghXjq6LktnGmDIArzVLEsJ7Ztoo3NXrlgDuS0c
         nz+w==
X-Gm-Message-State: AElRT7EmR57cqOxp1c6g46nOIuo33rkhZZX7rMm+9avGNsDGYv3NfONh
        yqjQSgN4wyWiLUXAXAsNMoY=
X-Google-Smtp-Source: AG47ELstYKbycJao1Nre3PhJkFCv3P/UcsgDD21lSH71aFrbhf8RRznjqi54WrLHXxowbevaaJhp2w==
X-Received: by 10.223.227.18 with SMTP id b18mr4432490wrj.247.1521893594603;
        Sat, 24 Mar 2018 05:13:14 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 95sm11708854wrb.47.2018.03.24.05.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 05:13:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct object_entry
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com> <20180324063353.24722-7-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180324063353.24722-7-pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 13:13:12 +0100
Message-ID: <87d0zty8mf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 24 2018, Nguyễn Thái Ngọc Duy wrote:

> Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
> pack. Use an index instead since the number of packs should be
> relatively small.
>
> This limits the number of packs we can handle to 1k. Since we can't be
> sure people can never run into the situation where they have more than
> 1k pack files. Provide a fall back route for it.
>
> If we find out they have too many packs, the new in_pack_by_idx[]
> array (which has at most 1k elements) will not be used. Instead we
> allocate in_pack[] array that holds nr_objects elements. This is
> similar to how the optional in_pack_pos field is handled.
>
> The new simple test is just to make sure the too-many-packs code path
> is at least executed. The true test is running
>
>     make test GIT_TEST_FULL_IN_PACK_ARRAY=1

Aside from the tiny nit in 87efk9yfm2.fsf@evledraar.gmail.com this looks
good to me.

I've tested this with the same method noted in
87vadpxv27.fsf@evledraar.gmail.com against the version before it on
similar test data, and got:

 * Reduction in user time by 0.42%
 * Reduction in system time by 3.17%
 * Reduction in RSS by 0.003209%
 * Reduction in page faults by 0% & 0.006539% (time(1) reports two different numbers)
 * Reduction in the I of I/O by 99.504132% (note: from 4840 bytes to 24 bytes, so some fluke...)
 * Reduction in the O of I/O by 0%

I.e. there's no notable change at all, but I thought it would be useful
to re-run this for context.
