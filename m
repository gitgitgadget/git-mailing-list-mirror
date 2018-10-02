Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0322F1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeJBVow (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:44:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43037 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeJBVov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:44:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id v18-v6so1298988qka.10
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oxzef9rqY/2ZArIg7j/10JYbd6sW+gH70nt3TnxValA=;
        b=O/iXyqvSA1UWqZ/7Yvk9/+IVCBNb55JOJrEU1yeu7X0gYmOHcVd65zeTtkSU7sRHGe
         UFqj2GXKkVZ2NZkZZv/ncQHV+OFVmj7hkaQNF2GLAD0J0/Od7Z6nQeTry3Iq5xctHlU1
         mN+3LUt8bNJ/34WVYSHau2CkMFbcuij4nRz7pNi3QHcI9ksUNsqOp4/sER7HKqvQ9BPr
         lQt6wGP4pYdS/3e5o+gcdUY/GITfcKvF9/lyGqwu5ueiU6QbWVYjsjSBT/tV0tb9eY5d
         NhVRitStO6q7OAU2fZ0kaCqUZo/KP4v+Lht8sAt+XGAOEps3jrJcdOHvnVNyxzFGAbgn
         iQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oxzef9rqY/2ZArIg7j/10JYbd6sW+gH70nt3TnxValA=;
        b=Y5SMEs9/wYxkdXzR6IOmJQQcmAddoGwAn6ZZdh+gLgNbD5/16HyWSnyga1MA+p5Tgo
         59uL2PTUi5oD4vIl3Osyo4p0dZhOdeMijK5UOQFF3HMEZTaUOIp0YxtuPGIcOpJFkMC/
         y8O6JzWz29xDX2XjwVTC8Ld9omihUGwGq9AL7U1sTdHEeyIxasLHe3gG+7SzGD2SS9gl
         Ylqm7Y52+glkg37agYIdin2QGg66kORewwzaVm3GlNwePkuxES1zmRpuAJXtyDbF+QCM
         mZcDqj60juIOUplbLOQJb8Ep+jI/GOyeT+LE/emHHcKURQsFm0vO2NMJLHgxgkXf8N26
         obWA==
X-Gm-Message-State: ABuFfoix3hERlchtcMfDwJ1uv54k9fBb3IrWcZRjIQ2VjyU/GIgsdlOK
        iYwbztx/BOAx1/fIh6aoEsE=
X-Google-Smtp-Source: ACcGV60rpCuTsR47ygR1J+A7Ku8cmOpS/c8d+o8wRBUuM5UDxx7vnToNVpKKwJImc3kTPk8U5wPjNA==
X-Received: by 2002:a37:c603:: with SMTP id b3-v6mr12320966qkj.176.1538492461406;
        Tue, 02 Oct 2018 08:01:01 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 7-v6sm8714118qkv.56.2018.10.02.08.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:01:00 -0700 (PDT)
Subject: Re: [PATCH v7 5/7] read-cache: load cache extensions on a worker
 thread
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
 <20181001134556.33232-6-peartben@gmail.com>
 <CACsJy8A2+P6RM5OOhke=Ptc2iPB81fGu0BF-Ven9am_UEThB8A@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8fed4b13-71f3-4657-8058-39400009b32a@gmail.com>
Date:   Tue, 2 Oct 2018 11:00:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8A2+P6RM5OOhke=Ptc2iPB81fGu0BF-Ven9am_UEThB8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/2018 11:50 AM, Duy Nguyen wrote:
> On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
>> @@ -1890,6 +1891,46 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>>   static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
>>   static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
>>
>> +struct load_index_extensions
>> +{
>> +#ifndef NO_PTHREADS
>> +       pthread_t pthread;
>> +#endif
>> +       struct index_state *istate;
>> +       const char *mmap;
>> +       size_t mmap_size;
>> +       unsigned long src_offset;
>> +};
>> +
>> +static void *load_index_extensions(void *_data)
>> +{
>> +       struct load_index_extensions *p = _data;
>> +       unsigned long src_offset = p->src_offset;
>> +
>> +       while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
>> +               /* After an array of active_nr index entries,
>> +                * there can be arbitrary number of extended
>> +                * sections, each of which is prefixed with
>> +                * extension name (4-byte) and section length
>> +                * in 4-byte network byte order.
>> +                */
>> +               uint32_t extsize;
>> +               memcpy(&extsize, p->mmap + src_offset + 4, 4);
>> +               extsize = ntohl(extsize);
> 
> This could be get_be32() so that the next person will not need to do
> another cleanup patch.
> 

Good point, it was existing code so I focused on doing the minimal 
change possible but I can clean it up since I'm touching it already.

>> +               if (read_index_extension(p->istate,
>> +                       p->mmap + src_offset,
>> +                       p->mmap + src_offset + 8,
>> +                       extsize) < 0) {
> 
> This alignment is misleading because the conditions are aligned with
> the code block below. If you can't align it with the '(', then just
> add another tab.
> 

Ditto. I'll make it:

		uint32_t extsize = get_be32(p->mmap + src_offset + 4);
		if (read_index_extension(p->istate,
					 p->mmap + src_offset,
					 p->mmap + src_offset + 8,
					 extsize) < 0) {
			munmap((void *)p->mmap, p->mmap_size);
			die(_("index file corrupt"));
		}


>> +                       munmap((void *)p->mmap, p->mmap_size);
> 
> This made me pause for a bit since we should not need to cast back to
> void *. It turns out you need this because mmap pointer is const. But
> you don't even need to munmap here. We're dying, the OS will clean
> everything up.
> 

I had the same thought about "we're about to die so why bother calling 
munmap() here" but I decided rather than change it, I'd follow the 
existing pattern just in case there was some platform/bug that required 
it.  I apparently doesn't cause harm as it's been that way a long time.

>> +                       die(_("index file corrupt"));
>> +               }
>> +               src_offset += 8;
>> +               src_offset += extsize;
>> +       }
>> +
>> +       return NULL;
>> +}
