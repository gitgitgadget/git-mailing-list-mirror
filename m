Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31BB1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 19:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933194AbeFUTt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 15:49:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34109 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbeFUTt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 15:49:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id d3-v6so3996569qto.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4A1/6SL+Fj5c01girqPK5Rk0h/ffzzopr4/e1XDjCbA=;
        b=ZxNXYblyFGJI8Rvlz9oslv+BaQLNdLGiL9tGb0ZuMTcX0TwNo6yvbI+jGqvfD8qsQd
         UAckmm54kYFDUP0aHzbeNsCjrAAJTLvBTHDY37LFK7y9bLIxm6qsze9Wuyoun0XnLoZq
         5q1/GVvgFS4akyGxFRAiiQmpIaXvYiVVfzAWXU7I65XDtUlcWXsqCVaSLeIHtAEwkkyN
         t2SMboelGbicv8QiG3N8QxNIPJf8tjxKEgUSKUipEjylCKeJvsXB+STem5XcpU5auTCq
         kD4hIe378npLN40ZZRU2Y2c3jJepM+eU4bPrvVzoAJC3T4sIECg1wqgwT/8nj8C4SbqZ
         3vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4A1/6SL+Fj5c01girqPK5Rk0h/ffzzopr4/e1XDjCbA=;
        b=V3okta+3InCPMlzgMtKhwxkhnJjW70LNp4Poj8H/ph9/3NOBvwDcNL+P0XG3oqhALr
         PR4zNiWy95jKB4XtyLxmPI9XU1QvFgIunSENZYICaTrszXPu5hVfco/7rNW/mkgfizf3
         MXoJ3W9WbYfecu/vGpb3kcvJfR5osOY9fRYeHqxIKRxTwlqkrxzA7rOIB+m+C09hxuTl
         BsPdMfGQeCHlOLonMIazxVd7BF93nXmU8vIEsOVb93mONT+/rwSrvT/a4Q4gLLcsLXlp
         MapbmISucX8lOwvg5pL43R6ufBWA64Ty9KXJsHXYlOYXrvk7Y6c5hCeaXpwbWuNH3FS+
         0vBw==
X-Gm-Message-State: APt69E2q5/e2WBzMQXwwXbqzODCecddhU83PUj1CmelqSLBQ8sx6J8yk
        EZpJ4hj8ubBLId73P3z54xE=
X-Google-Smtp-Source: ADUXVKJ3qNFoQRwl0CvIsc/q2YVx4oW+A35MycYJ2yZroFDMPHBQZ3i8bO2buL85qy51lHlikwRMBA==
X-Received: by 2002:ac8:2f99:: with SMTP id l25-v6mr23453409qta.166.1529610566043;
        Thu, 21 Jun 2018 12:49:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id 31-v6sm4855316qtq.80.2018.06.21.12.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 12:49:25 -0700 (PDT)
Subject: Re: [PATCH 13/23] midx: write object id fanout chunk
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-14-dstolee@microsoft.com>
 <CACsJy8DW8foQ8+KDdjf4g_3UNi5oSqJyHYo5d9j4cth_yBXDCA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8e7c491c-81d5-abf0-dae6-6d605afb1153@gmail.com>
Date:   Thu, 21 Jun 2018 15:49:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DW8foQ8+KDdjf4g_3UNi5oSqJyHYo5d9j4cth_yBXDCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2018 1:28 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>> @@ -117,9 +123,13 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>                  die("MIDX missing required pack lookup chunk");
>>          if (!m->chunk_pack_names)
>>                  die("MIDX missing required pack-name chunk");
>> +       if (!m->chunk_oid_fanout)
>> +               die("MIDX missing required OID fanout chunk");
> _()
>
>> @@ -501,9 +540,13 @@ int write_midx_file(const char *object_dir)
>>          chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_packs * sizeof(uint32_t);
>>
>>          cur_chunk++;
>> -       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
>> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
> Err.. mistake?

Not a mistake, just a side-effect of inserting the fanout before the lookup.

The commits are in this order because we need to construct the list 
before we build the fanout, but it makes sense to have the smaller 
fanout chunk before the lookup chunk.

>
>>          chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
>>
>> +       cur_chunk++;
>> +       chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
> Same here.
>
>> +       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
>> +
>>          cur_chunk++;
>>          chunk_ids[cur_chunk] = 0;
>>          chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + nr_entries * MIDX_HASH_LEN;
>>

