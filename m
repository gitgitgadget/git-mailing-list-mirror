Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809E1201CF
	for <e@80x24.org>; Wed, 17 May 2017 07:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbdEQHJs (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 03:09:48 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36258 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdEQHJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 03:09:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so2807561pfg.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CK8/e1unDrH+FqzAWUxTrv3kWuH39tWgqfur/V6XMcg=;
        b=Zkvm0/1B3cnnoval3gCvoSMKZzTZOlFBzYFpMT8ZDcybNeA/BzkDfo7YSL+WvhA2AN
         1Zo7eaOTlFl/m2MgO6eS8JRtGH3sgDF5e46QKHcBdhawqYiHkXvTghStixduXGZYHy6Y
         TJA2A6BkHFoCp4dqzFXGnBb26ZnpseXU0KEMCovbL0BRqKqEVhldp9ZWsEAKZvhyeOi0
         Zhfl+oo2wg6JZdDEuUkc6Izp5fZX8ACVr2dkO+m9wH4RKUlmLEi1rqqiWCKLm198AFTP
         zx0IgU6/Eciukka0PqIGPE1HLdfI5QPh8ZS8iuNd3d5iFqAmERQTHQ+GSder55O9t7Z/
         vLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CK8/e1unDrH+FqzAWUxTrv3kWuH39tWgqfur/V6XMcg=;
        b=L9ITNVGik+jgboYBPE0Q52Sw371NIt4CJCGi/XreJv8LTf2j7asMei9RPRUCKwlBKc
         t5LJSZmJqtnGl6qJzQ7o/sbgqCjfCZNSqzdMrfuqARkGZNQoS0GbBRbX5VYdPwayzbjQ
         pdBkTqYGPSdl2+EBEe/PXgyRK/YlD1pn9geUUz/Vq4bKTZFDH2qk7kM0MteJaoCwihEL
         rfCVrE5gPLDwH/G8N4ZwzfJk/B5hy43lnip/R+o55q3wmXE+RVRnCsQbQdrdwnu2P0AH
         LQ81ojgeRmWMv0sRDW6vZTe6ZN5PLYEvSmZK1gOQKW3Ozo+FokD104zj1hJ3yAGxTmOY
         fN2w==
X-Gm-Message-State: AODbwcBsf20P3XRKW1ajtM9D2Yye+vv1FyKosQ9E89mV0YX6w60bI9WL
        o5nFn+KxUoWBYw==
X-Received: by 10.84.138.193 with SMTP id 59mr2554664plp.184.1495004986546;
        Wed, 17 May 2017 00:09:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id x80sm2133106pff.105.2017.05.17.00.09.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 00:09:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] sha1dc: fix issues with a big endian platform
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
        <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>
        <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
        <CAKKM46vwM9pxyMxTc4jA0z_8vGKdDGCGg9ziKkFAsqr5ULYJxA@mail.gmail.com>
        <007001d2cd88$2b916180$82b42480$@marc-stevens.nl>
        <CAKKM46sS_5bVe5a6wNN7SdVoGvwmVxnLAZTxJ+tSftXfZKeGWg@mail.gmail.com>
        <xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>
        <CACBZZX6cCjorisOn9qyrDH9L_MtKAsLLW=q1_htuaJ+E0QK9rg@mail.gmail.com>
Date:   Wed, 17 May 2017 16:09:45 +0900
In-Reply-To: <CACBZZX6cCjorisOn9qyrDH9L_MtKAsLLW=q1_htuaJ+E0QK9rg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 17 May
 2017 08:30:12
        +0200")
Message-ID: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, May 17, 2017 at 7:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> From: Marc Stevens <marc@marc-stevens.nl>
>>
>> Some big-endian platforms define _BIG_ENDIAN, which the test at the
>> beginning of file has missed.  Also, when the input is not aligned,
>> some platforms trigger SIGBUS.
>>
>> This change corresponds to 33a694a9 ("Fix issues with a big endian
>> platform", 2017-05-15) in the history of the upstream repository
>> https://github.com/cr-marcstevens/sha1collisiondetection
>
> Then why not just update sha1dc from upstream instead of
> cherry-picking one patch from them?

See the original message upthread.  I did the cherry-pick simply
because that was what Marc instructed the patch recipient to do ;-).

