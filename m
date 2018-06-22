Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4DA1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934169AbeFVSov (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 14:44:51 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41327 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934096AbeFVSou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 14:44:50 -0400
Received: by mail-qt0-f194.google.com with SMTP id y20-v6so6807429qto.8
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gOCxnHd4TE3CzdsJPfnMB418g6jjlHfxul3A620F+7w=;
        b=spORsy2t4ikIooZZ7UgW5Tg+RCkj/gHiLBnCMHv03wCYJRSrXh9TyTczj8d7tEfFZW
         ZD/2yOW7vsaDXBPMM2hPIdp7PRng4GkAoiO62MFp9T+Nw8WiG9lS9DE1rX/8IwNi5A3U
         tNl8FCoBn9Mh39u3enBosoUuweXlu2fxasTprzhjvT7ph67kXp4zKXp97evSIITm3OPk
         YIsRUqhlGy5PZBIKkVUH2/Onx2njFswIdgD5nGiyHlxSmBr0rG+F37jItD1JO6DlcX0n
         l5zdzKcVw3QCl9OfHSyamFGiF9YEn6i4eyAUEcLYLVkIJqHlM2hmormHgtcuAtppoTGK
         yg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gOCxnHd4TE3CzdsJPfnMB418g6jjlHfxul3A620F+7w=;
        b=F+Qn4dMkpj3f5OY+h7X/k1rWmZoHYJVi/RAmdw1Jv0ESv9egK/JzwYZ1yTBmxYKy21
         ca2oLjHMOCL0rBk286SemhPZeEuvPQAyJ7jIS5e/ds6DAcGWtrCP6Mc+HgCJcy3rtWXB
         0gNMVio+NTakjNbMVidvxjMdECuwIPC/s4JrD9IC4Y33A4nR2kisxUCDEzOOybZLghVI
         JkoBWemqn4b4qETdUx0SpuijlXoBmjLKbxxTxohkDGfVEr5pEfcFVaBepEl31vtULjKA
         IxMUGC74jREOBkcdy3U3IEoXCM6aBkK7WsEac14KMhy5iYXiaXenfJ7IvjEPXnPSvBkf
         7Y1w==
X-Gm-Message-State: APt69E2vmMDz5bOXe1blC+jCBgeYzNIRvL8QFTOTT46BSQQIAd6Qb3kl
        VrOUIkLZd7YKagrS6bq8cBE=
X-Google-Smtp-Source: ADUXVKJBcGJSFt3kib3DCOP6N6yZDRnZgF9vuJf393xlz9G3MK7bS4Yyw7MOqbETSonNEmGrijQAaA==
X-Received: by 2002:aed:2798:: with SMTP id a24-v6mr2561656qtd.40.1529693089498;
        Fri, 22 Jun 2018 11:44:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id c62-v6sm5560022qke.64.2018.06.22.11.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:44:48 -0700 (PDT)
Subject: Re: [PATCH 23/23] midx: clear midx on repack
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-24-dstolee@microsoft.com>
 <CACsJy8BHgqqrDNvU_oy0+_QmDW-wt-jBvWT9oJ9H1pA_tmuVFg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9aa18ceb-672b-31e5-ebfc-0e369ef9bc80@gmail.com>
Date:   Fri, 22 Jun 2018 14:44:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BHgqqrDNvU_oy0+_QmDW-wt-jBvWT9oJ9H1pA_tmuVFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2018 2:13 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:07 PM Derrick Stolee <stolee@gmail.com> wrote:
>> If a 'git repack' command replaces existing packfiles, then we must
>> clear the existing multi-pack-index before moving the packfiles it
>> references.
> I think there are other places where we add or remove pack files and
> need to reprepare_packed_git(). Any midx invalidation should be part
> of that as well.

The other places where we call reprepare_packed_git() are for when we 
may have added a packfile, such as in fetch-pack.c, or sha1_file.c. The 
other candidate to consider is 'git gc', but the packfile deletion is 
handled by a call to 'git repack'.

>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   builtin/repack.c | 8 ++++++++
>>   midx.c           | 8 ++++++++
>>   midx.h           | 1 +
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index 6c636e159e..66a7d8e8ea 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -8,6 +8,7 @@
>>   #include "strbuf.h"
>>   #include "string-list.h"
>>   #include "argv-array.h"
>> +#include "midx.h"
>>
>>   static int delta_base_offset = 1;
>>   static int pack_kept_objects = -1;
>> @@ -174,6 +175,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>          int no_update_server_info = 0;
>>          int quiet = 0;
>>          int local = 0;
>> +       int midx_cleared = 0;
>>
>>          struct option builtin_repack_options[] = {
>>                  OPT_BIT('a', NULL, &pack_everything,
>> @@ -340,6 +342,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>                                  continue;
>>                          }
>>
>> +                       if (!midx_cleared) {
>> +                               /* if we move a packfile, it will invalidated the midx */
> What about removing packs, which also happens in repack? If the
> removed pack is part of midx, then midx becomes invalid as well.
>
>> +                               clear_midx_file(get_object_directory());
>> +                               midx_cleared = 1;
>> +                       }
>> +
>>                          fname_old = mkpathdup("%s/old-%s%s", packdir,
>>                                                  item->string, exts[ext].name);
>>                          if (file_exists(fname_old))
>> diff --git a/midx.c b/midx.c
>> index e46f392fa4..1043c01fa7 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -913,3 +913,11 @@ int write_midx_file(const char *object_dir)
>>          FREE_AND_NULL(pack_names);
>>          return 0;
>>   }
>> +
>> +void clear_midx_file(const char *object_dir)
> delete_ may be more obvious than clear_
>
>> +{
>> +       char *midx = get_midx_filename(object_dir);
>> +
>> +       if (remove_path(midx))
>> +               die(_("failed to clear multi-pack-index at %s"), midx);
> die_errno()
>
>> +}
>> diff --git a/midx.h b/midx.h
>> index 6996b5ff6b..46f9f44c94 100644
>> --- a/midx.h
>> +++ b/midx.h
>> @@ -18,5 +18,6 @@ int midx_contains_pack(struct midxed_git *m, const char *idx_name);
>>   int prepare_midxed_git_one(struct repository *r, const char *object_dir);
>>
>>   int write_midx_file(const char *object_dir);
>> +void clear_midx_file(const char *object_dir);
>>
>>   #endif
>> --
>> 2.18.0.rc1
>>
>

