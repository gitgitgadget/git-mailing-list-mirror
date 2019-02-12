Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C95211B5
	for <e@80x24.org>; Tue, 12 Feb 2019 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfBLLIE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 06:08:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41866 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfBLLIE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 06:08:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so2171473wrs.8
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QUb/crCePr7u4sD11XzO2lekrUEel108Y8rGsr30XJo=;
        b=Eaf+Ks9sWKVxyAD+0svy79iiViCuOv3gjQOQ7IiM88Lt3mkdw8hoxorksoejpwUyyR
         doOrztnTUufdQvggV087lW99tUZ4KRhMD3+1oKxlPhDjRLHuQ64L4EN3TXk2YSERJ5N3
         nu7VPtU8+5oxmSoxpeOKZD1GKTQriu0ZdaAjYqrWV+radTuG2nLIdolnM16r0QtHc9jT
         Q4wJza7yzOhv5G4cecGUrgWn0ROezjfggzutDKEuWg3cR+1g1bJ/ACzNTTsr5uW2L2i/
         taIMz9ltg/jW3FslLp5XihDG3tky4omdB0jBfUrIwY0AYCFwhZHC6C097CFByi1W1c4c
         8MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QUb/crCePr7u4sD11XzO2lekrUEel108Y8rGsr30XJo=;
        b=PIabgDJkJhEjsMBe1yX+BgtGZBd07VZHardwix4Kgt2Nn4VjhrI7KWoVM/wPv+FE/9
         IGML3wKt6Gv5BvtGxwYnAqNQ0UPktnAc35dkW4DH51sewMO8ZySKfnUyTBfpm/KVzDGM
         O7XrsAZe3jaAdCbZbKS2tqBrMUKKt6l8n1Y5zLEBfFz6elkHfKTEabto4zZW0ounbrnt
         f+8wehxuJIr9dIHyoHK5/g+C8ASiyJeaoWTqsBzUoY+C46NSw09MtDyw1abcbSWgCM19
         JoakVlAc/0P1YcU7SakgVnCKt/Uv3uBSqS8RnMMOVj0VWdgjg2VY8+GeBRz9lWQ0dBw9
         ggEQ==
X-Gm-Message-State: AHQUAuY0f60WwHERT2d2f9LBOZ1G6sRl09yJMffQz/u/KTTFzJ3hfrQ+
        PDfDiBcjeWY93ztZ5/xawMI=
X-Google-Smtp-Source: AHgI3IZvVOSp45h9cfppEA7xN+sUlNGw9ZKGcb7R85c7DXF4hWDg9Aznt05UQp9eWGibX940lKGZAw==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr2253422wrr.93.1549969682186;
        Tue, 12 Feb 2019 03:08:02 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id x3sm18172507wrd.19.2019.02.12.03.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 03:08:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 28/31] dir: make untracked cache extension hash size independent
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-29-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212012256.1005924-29-sandals@crustytoothpaste.net>
Date:   Tue, 12 Feb 2019 12:08:01 +0100
Message-ID: <87y36ljmcu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, brian m. carlson wrote:

> Instead of using a struct with a flex array member to read and write the
> untracked cache extension, use a shorter, fixed-length struct and add
> the name and hash data explicitly.
> [...]
>  	struct stat_data info_exclude_stat;
>  	struct stat_data excludes_file_stat;
>  	uint32_t dir_flags;
> -	unsigned char info_exclude_sha1[20];
> -	unsigned char excludes_file_sha1[20];
> -	char exclude_per_dir[FLEX_ARRAY];
>  };

Both this & the follow-up 29/31 look scary since this is an on-disk
structure and this patch & the next one rather than implementing some
transition, just changes the structs & code we use to read & write to
use the current hash size.

So what are we going to do when the "current" size is SHA-256 and our
on-disk cache is SHA-1? It seems like with this we'd at best (I haven't
tested) throw away the SHA-1 UC data, and at worst introduce some silent
persistent read failure.

In any case that seems like something we should have tests for with an
on-disk format, i.e. write in one hash, see what happens when we read in
another, and perhaps instead of not understanding SHA-1 hashes in
SHA-256 mode we'd read the SHA-1 and consult the SHA-1<->SHA-256 lookup
table we're going to be eventually maintaining on the side?
