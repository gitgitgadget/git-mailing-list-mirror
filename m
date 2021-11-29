Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16455C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhK2Wck (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhK2Wc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:32:26 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC8C07CA12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:18:25 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s139so37314712oie.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wYfXtjnAvWRdgI7ariPSo+C0H3jk+W3GpWdpW4qRk4g=;
        b=aw2Y0MUIpokk2Ut50eWneq2jLzhKV7dppWBSDvuf/vTFIX7NbPLsv7FGObe36xXu4L
         AUa2zHNhXGjI1tJY91oiGOP5m9Sto6mtOrYNlWShStMaMxw6nbb1tctdeSZJAh1FS7Lo
         Ot5EK+b5Y5RYTrlRk5ukdRbj7dQzJfvVVKOc9Id6TtBL+FXsS/kzitoW9MQ1rUPHfe/J
         VtG4cFHBUZwhssaAPrweVacUR1ilUXuicL+yWqR4R2s1DTX9rMGhyfY0jH8mckP6aMs8
         XaQ7Oxdy1u42nOTylv1itlnBnH6+y6fcZYRXHuEsZNR9OU5PFJqItUjs8mQge2/xRQnk
         uh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wYfXtjnAvWRdgI7ariPSo+C0H3jk+W3GpWdpW4qRk4g=;
        b=a5eYrkeCxVKJsMkrnOQp7FDI7+X0QM6x++FgwwK1W5XO9yGZtvwnlhyZvPktkergcu
         Hr39ysBxr8lsZBfmgq3SzYuUiTQZfQJ4A/6B50msN9/x/TuYXvJNH20Xya8W5CQNYETc
         MhCi5nXLJmqz3W4UrTCav+6hdsVu7mGHaxq4VOXundVga+1LR+7bLWKVnCoqrLsUpJWs
         muzkHI5uUSJ7GpAMClukgGlHgLTrP30qSyjz80XApbHj+OviFVTGmYr902c1lYVvUUGI
         3ul7Lz4LOk/3sAyGXeMaHQ8qo+ns5pewX3hZM16e3bBzVvhePrL5So12PeoOZCvqptkq
         cIuw==
X-Gm-Message-State: AOAM532/PPeHOZ7HW26qr4/WY5M6pmVRHoU7fliN4bi21tfcJZQMAIV+
        C2uw1cpC/UbuMRO/6/g8Yic=
X-Google-Smtp-Source: ABdhPJyuK/IBBjArsJO1SI9jxuJaeynlT6A0phcW7cEvx5dlbgeEg46f0fZZM+LPe8z8hhoAAgIcfw==
X-Received: by 2002:a05:6808:1a01:: with SMTP id bk1mr786271oib.46.1638224304660;
        Mon, 29 Nov 2021 14:18:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8ceb:ba7b:c887:bd90? ([2600:1700:e72:80a0:8ceb:ba7b:c887:bd90])
        by smtp.gmail.com with ESMTPSA id x17sm2467025oot.30.2021.11.29.14.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 14:18:24 -0800 (PST)
Message-ID: <2271576b-79d3-7983-d3df-5548e0a12e85@gmail.com>
Date:   Mon, 29 Nov 2021 17:18:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/5] object-file.c: handle undetermined oid in
 write_loose_object()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-3-chiyutianyi@gmail.com>
 <47b3e2ad-4fa1-040a-24c1-6da0445bd1a5@gmail.com> <xmqqsfve669w.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqsfve669w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 3:44 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> My first reaction is to not write into .git/objects/ directly, but
>> instead make a .git/objects/tmp/ directory and write within that
>> directory. The idea is to prevent leaving stale files in the
>> .git/objects/ directory if the process terminates strangely (say,
>> a power outage or segfault).
> 
> Even if we know the name of the object we are writing beforehand, I
> do not think it is a good idea to open-write-close the final object
> file.  The approach we already use everywhere is to write into a
> tmpfile/lockfile and rename it to the final name 
> 
> object-file.c::write_loose_object() uses create_tmpfile() to prepare
> a temporary file whose name begins with "tmp_obj_", so that "gc" can
> recognize stale ones and remove them.

The only difference is that the tmp_obj_* file would go into the
loose object directory corresponding to the first two hex characters
of the OID, but that no longer happens now.
 
>> If this was an interesting idea to pursue, it does leave a question:
>> should we clean up the tmp/ directory when it is empty? That would
>> require adding a check in finalize_object_file() that is probably
>> best left unchecked (the lstat() would add a cost per loose object
>> write that is probably too costly). I would rather leave an empty
>> tmp/ directory than add that cost per loose object write.
> 
> I am not sure why we want a new tmp/ directory.

I'm just thinking of a case where this fails repeatedly I would
rather have those failed tmp_obj_* files isolated in their own
directory. It's an extremely minor point, so I'm fine to drop
the recommendation.

Thanks,
-Stolee
