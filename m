Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579FF1F428
	for <e@80x24.org>; Sat,  8 Sep 2018 14:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeIHTma (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 15:42:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42397 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHTma (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 15:42:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so19328669qto.9
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=21NnhtXiCCesIk5mi1Wvt6jyAFj/U4v0rtzyrWK7cq8=;
        b=ms0VhGfX02Y/A37dfRcfZl6fqH79R8TP+DAJRcCuz4CGF2JG5t35jTk9vKjuupzyf6
         GwUbGMwXj3Y5LfXsijwkq/3Pwe0iu1bl1rCk88Y+eVEKos3xu2nMMb10bIvit3euSTC+
         LM/DnZwm6Rg61n3iHGhkal+dcN8BJhBa0oQZIxyUcQRsw5tI6kKjp213OogECHRVYfA9
         taRGHCwLoENbJ0UuF79S+lsYgbFtE6wTDIfQVgUGm/uEwmzcSRHk84Rxd7bxNLg6Hr5/
         p7Vz46vjlvK7GFvvZ4snVv0sAtMZNY9ZJYZaMzqKb3qoIc8rijjlr+64FOqgz6hFjqZg
         f/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=21NnhtXiCCesIk5mi1Wvt6jyAFj/U4v0rtzyrWK7cq8=;
        b=eYqXMvtNw3+IoccjlHjbAY8RPaMEnpEU/um4CivR8ql0QnKqUdaoxneDgChmEcYsDP
         yhwQyaF1AEQLOVOwXPCP+B4Irm/9m2EF3vA4tnL0qHSe6s47xQ7u9vN3BHZYF0VDs0gH
         xZ9d6H+xGiv/9/F1XhfmTycvLMbvmMSCzzuA/cS1xrolosyLqQFkJKr0LmwED8Xritmn
         vn2QP3lppJfAhvNW+5rXoEvIhW/x1B6enmpNssX8quAhcQQykhcZcO+3BieX50q2FXR6
         bhOvnyrVoT0ECH+oKfeXBJ6SQmSE+wj3+Gm7/OCjNdxScLXZw3u2SW2zklI2PEgOZMQK
         9oyw==
X-Gm-Message-State: APzg51CyjSvrCfbeVNwEPtAT1LcvbTcS18vdtTuDjVZZ/aVeVO8yW3wr
        QX3Bwco9tVtdhG5uz/a8TUQ=
X-Google-Smtp-Source: ANB0VdajOqdpE09GLscv1SLHnlYEjfZJtEyGTSid1JWaNAKxMOVBIkixfkx1MoNYPuM31UlW1rWUAg==
X-Received: by 2002:ac8:1749:: with SMTP id u9-v6mr10129776qtk.31.1536418585288;
        Sat, 08 Sep 2018 07:56:25 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e29-v6sm7618600qte.47.2018.09.08.07.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 07:56:24 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] read-cache: load cache extensions on a worker
 thread
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
 <20180906210227.54368-4-benpeart@microsoft.com>
 <xmqqbm99vwsy.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <447feebe-c99a-dc53-21ae-d33541baf30d@gmail.com>
Date:   Sat, 8 Sep 2018 10:56:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm99vwsy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/7/2018 5:10 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> +struct load_index_extensions
>> +{
>> +#ifndef NO_PTHREADS
>> +	pthread_t pthread;
>> +#endif
>> +	struct index_state *istate;
>> +	void *mmap;
>> +	size_t mmap_size;
>> +	unsigned long src_offset;
> 
> If the file format only allows uint32_t on any platform, perhaps
> this is better specified as uint32_t?  Or if this is offset into
> a mmap'ed region of memory, size_t may be more appropriate.
> 
> Same comment applies to "extension_offset" we see below (which in
> turn means the returned type of read_eoie_extension() function may
> want to match).
> 
>> + };
> 
> Space before '}'??
> 
>> +
>> +static void *load_index_extensions(void *_data)
>> +{
>> +	struct load_index_extensions *p = _data;
> 
> Perhaps we are being superstitious, but I think our code try to
> avoid leading underscore when able, i.e.
> 
> 	load_index_extensions(void *data_)
> 	{
> 		struct load_index_extensions *p = data;

That's what I get for copying code from elsewhere in the source. :-)

static void *preload_thread(void *_data)
{
	int nr;
	struct thread_data *p = _data;

since there isn't any need for the underscore at all, I'll just make it:

static void *load_index_extensions(void *data)
{
	struct load_index_extensions *p = data;

> 
>> +	unsigned long src_offset = p->src_offset;
>> +
>> +	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
>> +		/* After an array of active_nr index entries,
>> +		 * there can be arbitrary number of extended
>> +		 * sections, each of which is prefixed with
>> +		 * extension name (4-byte) and section length
>> +		 * in 4-byte network byte order.
>> +		 */
>> +		uint32_t extsize;
>> +		memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
>> +		extsize = ntohl(extsize);
> 
> The same "ntohl(), not get_be32()?" question as the one for the
> previous step applies here, too.  I think the answer is "the
> original was written that way" and that is acceptable, but once this
> series lands, we may want to review the whole file and see if it is
> worth making them consistent with a separate clean-up patch.
> 

Makes sense, I'll add a cleanup patch to fix the inconsistency and have 
them use get_be32().

> I think mmap() and munmap() are the only places that wants p->mmap
> and mmap parameters passed around in various callchains to be of
> type "void *"---I wonder if it is simpler to use "const char *"
> throughout and only cast it to "void *" when necessary (I suspect
> that there is nowhere we need to cast to or from "void *" explicitly
> if we did so---assignment and argument passing would give us an
> appropriate cast for free)?

Sure, I'll add minimizing the casting to the clean up patch.

> 
>> +		if (read_index_extension(p->istate,
>> +			(const char *)p->mmap + src_offset,
>> +			(char *)p->mmap + src_offset + 8,
>> +			extsize) < 0) {
>> +			munmap(p->mmap, p->mmap_size);
>> +			die("index file corrupt");
>> +		}
>> +	...
>> @@ -1907,6 +1951,11 @@ ...
>> ...
>> +	p.mmap = mmap;
>> +	p.mmap_size = mmap_size;
>> +
>> +#ifndef NO_PTHREADS
>> +	nr_threads = git_config_get_index_threads();
>> +	if (!nr_threads)
>> +		nr_threads = online_cpus();
>> +
>> +	if (nr_threads >= 2) {
>> +		extension_offset = read_eoie_extension(mmap, mmap_size);
>> +		if (extension_offset) {
>> +			/* create a thread to load the index extensions */
>> +			p.src_offset = extension_offset;
>> +			if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
>> +				die(_("unable to create load_index_extensions_thread"));
>> +		}
>> +	}
>> +#endif
> 
> Makes sense.
> 
