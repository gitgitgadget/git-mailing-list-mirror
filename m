Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10931F406
	for <e@80x24.org>; Wed, 17 Jan 2018 21:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeAQVoW (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 16:44:22 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33818 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeAQVoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 16:44:21 -0500
Received: by mail-io0-f194.google.com with SMTP id c17so22548357iod.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 13:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8W7AHX2YfW815DsVUqiwSoZdwcxgpOeKAI/mdJASJZs=;
        b=QWrpVnPBbLL6x8lSviLg13jjISaxRjIQ+rACXwn0nUNIEx7s28YFj1bO5rJYZTH7ur
         FhB/VG8GpyeyjPsXpjreGWWmENEmOvN8AsEzJOvttkPUCW4Xwas2EXbWogpb+nKUgz+4
         +pS0RuE1EhcKvdh0sHdBTs0eYuOYaySK5HZ7rmYdmEdYKqkJw3eTwlHjCDwcg5/af9lS
         YDFjlYcrFzEJb6NH2bjAgcnpG3Wz336fayuvEN/2M3ZyQhQ4HbI/JBg2QGJ4fZBLWDpx
         6jSZgMPEqAJ+zmmPODGPhszLM6GqSiNNtyvENDWr3nkSCtjrPHQur40GKv3FaQhuQkv2
         s2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8W7AHX2YfW815DsVUqiwSoZdwcxgpOeKAI/mdJASJZs=;
        b=fHu8jFR07bSyiMQNVNbM3aoN9oAj36QLGAnsNtDciCN57oDR00jWB+30Lf/NNwcbbY
         dvKsk62fakcarOM48CM+W3M6MVo3TwWWe/fureJUgRnEcd+9tZWfIMb46cZzuXsdUNZz
         RqUAMCxf3UMIYtLMM/fXF4popPWgDYNKjyxRI4ENUirbzABzofP2Cm1QRv0MPHyFrG2R
         4rv/2rIuhslS9kOX1iorMy5qfuhqEvVnRCS5WAQLpTiYzbsZ9QwhN4DHf+6AgqibPx4z
         +OqJIvBF7G0cU5SaSGNwtmLSt2F5o55UwzTil122EMkV/qmxP04uGZB3N6KqtChXYv4I
         OBiA==
X-Gm-Message-State: AKwxytf43kv9oNReG6K6RvZq0CjbT2nVQm1VcoADXWMwl30xnbElftkL
        8aBuScnNcSSyiFKQGoDPCXRcr6Wwl5P8MnABFxI=
X-Google-Smtp-Source: ACJfBovB/djGyi+R/VV7T09toNrCCW7QLcL6cXIBdrQfMxKTAWzheC+275uIDR3oOtM50i46SP3nPjTzRt+QqfBY9+g=
X-Received: by 10.107.200.11 with SMTP id y11mr7438454iof.116.1516225461064;
 Wed, 17 Jan 2018 13:44:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Wed, 17 Jan 2018 13:44:20 -0800 (PST)
In-Reply-To: <3cbace45-61df-3074-a48c-66c68c96d542@jeffhostetler.com>
References: <20180117175455.9316-1-chriscool@tuxfamily.org>
 <20180117175455.9316-2-chriscool@tuxfamily.org> <3cbace45-61df-3074-a48c-66c68c96d542@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 Jan 2018 22:44:20 +0100
Message-ID: <CAP8UFD16OLcmATtr8wg7KcnyUJJLYv5+8n+ygSZEOUbHMTgopQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sha1_file: improve sha1_file_name() perfs
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 9:37 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/17/2018 12:54 PM, Christian Couder wrote:
>>
>> As sha1_file_name() could be performance sensitive, let's
>> try to make it faster by seeding the initial buffer size
>> to avoid any need to realloc and by using strbuf_addstr()
>> and strbuf_addc() instead of strbuf_addf().
>>
>> Helped-by: Derrick Stolee <stolee@gmail.com>
>> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>   sha1_file.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index f66c21b2da..1a94716962 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -323,8 +323,14 @@ static void fill_sha1_path(struct strbuf *buf, const
>> unsigned char *sha1)
>>     void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
>>   {
>> -       strbuf_addf(buf, "%s/", get_object_directory());
>> +       const char *obj_dir = get_object_directory();
>> +       size_t extra = strlen(obj_dir) + 1 + GIT_MAX_HEXSZ;
>
> Very minor nit.  Should this be "+3" rather than "+1"?
> One for the slash after obj_dir, one for the slash between
> "xx/y[38]", and one for the trailing NUL.

I think the trailing NUL is handled by strbuf_grow(), but I forgot
about the / between "xx/y[38]", so I think it should be "+2" .

Anyway I agree with Junio that using strbuf_grow() is not really needed.

>>   +     if (extra > strbuf_avail(buf))
>> +               strbuf_grow(buf, extra);
>> +
>> +       strbuf_addstr(buf, obj_dir);
>> +       strbuf_addch(buf, '/');
>>         fill_sha1_path(buf, sha1);
>>   }
