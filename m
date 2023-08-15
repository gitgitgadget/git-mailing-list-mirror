Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C4C41513
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjHOS3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbjHOS2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 14:28:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42043DF
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 11:28:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-319559fd67dso4268250f8f.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692124130; x=1692728930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9Nyff7h4tHaw7loeuWllwSvKJUpYoMt9d1Mz9bZZNc=;
        b=bc9RlUen6mTHfToNtHCQZyaNNryEArUid6LCKyTCWp7t6fH2wpoKhUY+KiTx4Nr8hG
         bugWUAoymlfgnD8ecYyw9dSKMkBGqshRTQ2WrMGpSGmHYiTG93/Nl+fUhjeRDYzMqD+L
         /6rx79sHkjf4ksy5WaD4jL/928gYo/h1CJbC7KF1HPrUY9FEQQQbCbDMh2KJFN4dzsZR
         qIEGiBXvzPFkv+KZatdyliO3oYT0uxx23lj9eJ0JRyKB+PWh1bNN9llZB65+leO41Oz+
         NMMG3fQZNRC/hr03zH1L1VbdQmxmpBC+nzV6N5vciDayJlj3zEFUgI9O1Hbd2XCy5lF1
         YuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124130; x=1692728930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Nyff7h4tHaw7loeuWllwSvKJUpYoMt9d1Mz9bZZNc=;
        b=EyYCf3cX4uTEhtaZu1KNBjBZDeiV5Phf3S47uq5wSB0fG1I/Yqs82NiNVphyM14vxE
         QuYXKaQLQn4VKxKaZWBcJ6akXRax3BFsv/Y2ixlJyiZ2MHtHyTnkogsVVrM8m4Hya8JJ
         JnpiHO1o1+xVoPJ6EqYcBjuxmQ4/BX+vWuZzh3/5o5noVDIXff06E9EITWfQ9BR6Vqng
         mSD/AZf/jXzkC0yUxOYFNZuf7yIGVkiOvlr8EZIZGyqtDfcjH0zurzNSjQewOmDz3JgH
         ikXfrQ6sGG7TvrKL3eV0/7RKUo2J81jHQVZ0a4pMwktXBg7PP2LkKBsKJpQIvzJOgVEf
         Au7Q==
X-Gm-Message-State: AOJu0YwX2eeFf4gfJSN6fRt5rlhDjDF/ruOhusn683RRoZ1BekdiDY/y
        dExoWOJNQVipSterisNQxHo=
X-Google-Smtp-Source: AGHT+IHth2Fsc/0qKNIhjcErtqhxJjIoqoOzBvw32CZopyIjHu+6+iGJ8k5xoTGT7TW1zWbFJv2Ieg==
X-Received: by 2002:adf:fd10:0:b0:314:2132:a277 with SMTP id e16-20020adffd10000000b003142132a277mr12211454wrr.9.1692124129453;
        Tue, 15 Aug 2023 11:28:49 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm18567163wrp.93.2023.08.15.11.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 11:28:49 -0700 (PDT)
Message-ID: <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
Date:   Tue, 15 Aug 2023 19:28:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20230715103758.3862-1-andy.koppe@gmail.com>
 <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
 <xmqq7cpwjhr1.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqq7cpwjhr1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/08/2023 19:13, Junio C Hamano wrote:
> If there is 'main' that is different from 'master', that sounds like
> a problem to me.  This project predates the newer convention that
> allows the primary branch to be named 'main', but many new folks of
> course expect to see 'main', so while my primary working areas all
> call the primary branch 'master', it is pushed out to both names.
> 
> Or at least I thought I arranged that to happen.

See [1], where main currently is at v2.41.0.

Regards,
Andy

[1] https://github.com/git/git/tree/main
