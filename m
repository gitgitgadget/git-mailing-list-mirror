Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAAE1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeFUUDg (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:03:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42292 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754067AbeFUUDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:03:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id y31-v6so4005402qty.9
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YLHf8SCBQr8egysjvN6H+8bSsubPqsnxbMzNGIfpKQQ=;
        b=ihpe9ou9bz+/iWoBqSAMLwPW+eWSVjJojTHn/waEwirHxWxNHgp7IcxjMLJ9A58YSn
         9bFaYj89RNzfkkjPbz52kDZz/ZEaDmhAMyReQ1d5vSTUlbdj3NVm0KqxI6ZZiwWBABZ0
         oT7IvSLv7HxB/I7+encHmVStTv3upj2M1OiNK0CbnB+Z61yEzR8oMu/MHvhLTAPWjOIf
         AX0gc7jnJv/D2brRnQYUNYPtCecBLvUe0qnCZjmnSjfblU1qSuysFTQThythKkk71j8C
         6o1rjoizf2bBovn4g/0cYTzb9SMs5poCubVYh2+x6a1RX6Ae7gWsx5yUUqFOW/zsDCJ0
         TOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YLHf8SCBQr8egysjvN6H+8bSsubPqsnxbMzNGIfpKQQ=;
        b=MgPa5P2R9uR3aRJaKda3uctwmd56jW7NJjqMfoknCNtM5HGPmEXW3xN2GbFEialbOx
         wT739IY3NUBBf2/zKsRW7LTFbw0HpQDvBDraKSHxt98FNnTw3FoUEu4hqKzNdWXZB0Ow
         HisSZ+CsQfiPxBeydjeFaGRKh0RTlI4oVxH1FEjQHE/QJpQNB/K18u/pRIOMUtfs1Se+
         tFOduMkrKQVrDV3d4Hy05fRMSsEk6j7x1yIfWW6DBGC08PEdge+YcD0t+F8LsIuzSLx4
         hq76G49n1QFrzdorwWnVXNDycNwEZ7HaIrIGmIqYyWWFHXIV5RTioJbGsh6vGLN/i6yM
         b1rg==
X-Gm-Message-State: APt69E19A922VwU4ipKFwef4jrpwieL9ntXc/9sPxRNxOEPMb9+o6VR2
        2tbSjgRZogHZoZrHWeU7d9E=
X-Google-Smtp-Source: ADUXVKJkbOxsnU2wJKi2NlEhUkiBzShsE0RBEMU+O5g/trMl0v3Plnpb18GFxuTWMX1RyUNpn17NGw==
X-Received: by 2002:ac8:683:: with SMTP id f3-v6mr25209881qth.104.1529611415306;
        Thu, 21 Jun 2018 13:03:35 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id m2-v6sm2792353qtc.77.2018.06.21.13.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 13:03:34 -0700 (PDT)
Subject: Re: [PATCH 17/23] midx: read objects from multi-pack-index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-18-dstolee@microsoft.com>
 <CACsJy8CqoKWgd=ekxozaKzRjrU3NN9KUxrspk_iP+zxBVcV5pA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9d875e2-452d-6492-fd25-9d114af39a25@gmail.com>
Date:   Thu, 21 Jun 2018 16:03:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CqoKWgd=ekxozaKzRjrU3NN9KUxrspk_iP+zxBVcV5pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2018 1:56 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 6:55 PM Derrick Stolee <stolee@gmail.com> wrote:
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   midx.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>   midx.h         |  2 ++
>>   object-store.h |  1 +
>>   packfile.c     |  8 ++++-
>>   4 files changed, 104 insertions(+), 3 deletions(-)
>>
>> diff --git a/midx.c b/midx.c
>> index 5e9290ca8f..6eca8f1b12 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -3,6 +3,7 @@
>>   #include "dir.h"
>>   #include "csum-file.h"
>>   #include "lockfile.h"
>> +#include "sha1-lookup.h"
>>   #include "object-store.h"
>>   #include "packfile.h"
>>   #include "midx.h"
>> @@ -64,7 +65,7 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>
>>          m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
>>          strcpy(m->object_dir, object_dir);
>> -       m->data = midx_map;
>> +       m->data = (const unsigned char*)midx_map;
> Hmm? Why is this typecast only needed now? Or is it not really needed at all?
>
>>          m->signature = get_be32(m->data);
>>          if (m->signature != MIDX_SIGNATURE) {
>> @@ -145,7 +146,9 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>
>>          m->num_objects = ntohl(m->chunk_oid_fanout[255]);
>>
>> -       m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
>> +       m->packs = xcalloc(m->num_packs, sizeof(*m->packs));
>> +
>> +       ALLOC_ARRAY(m->pack_names, m->num_packs);
> Please make this ALLOC_ARRAY change in the patch that adds
> xcalloc(m->num_packs).
>
>>          for (i = 0; i < m->num_packs; i++) {
>>                  if (i) {
>>                          if (ntohl(m->chunk_pack_lookup[i]) <= ntohl(m->chunk_pack_lookup[i - 1])) {
>> @@ -175,6 +178,95 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>          exit(1);
>>   }
>>
>> +static int prepare_midx_pack(struct midxed_git *m, uint32_t pack_int_id)
>> +{
>> +       struct strbuf pack_name = STRBUF_INIT;
>> +
>> +       if (pack_int_id >= m->num_packs)
>> +               BUG("bad pack-int-id");
>> +
>> +       if (m->packs[pack_int_id])
>> +               return 0;
>> +
>> +       strbuf_addstr(&pack_name, m->object_dir);
>> +       strbuf_addstr(&pack_name, "/pack/");
>> +       strbuf_addstr(&pack_name, m->pack_names[pack_int_id]);
> Just use strbuf_addf()
>
>> +
>> +       m->packs[pack_int_id] = add_packed_git(pack_name.buf, pack_name.len, 1);
>> +       strbuf_release(&pack_name);
>> +       return !m->packs[pack_int_id];
> This is a weird return value convention. Normally we go zero/negative
> or non-zero/zero for success/failure.

We are inconsistent.

* open_pack_index() returns non-zero on error. (This was my reference 
point.)
* bsearch_pack() and find_pack_entry() return non-zero when an entry is 
found.

Since the use is "if (error) die()", similar to open_pack_index(), I'll 
keep the current behavior. To switch would require using 
"!!m->packs[pack_int_id]" here and "if (!prepare_midx_pack()) die()" in 
the consumer.

Thanks,
-Stolee
