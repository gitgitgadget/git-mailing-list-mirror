Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08D62036B
	for <e@80x24.org>; Tue, 10 Oct 2017 12:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbdJJMQb (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 08:16:31 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:53690 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbdJJMQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 08:16:30 -0400
Received: by mail-qt0-f169.google.com with SMTP id n61so22453860qte.10
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lQMFtJRCArwp3wzx3Cjb6oQ0UqbfIZ6ZBRWH4m+nfrg=;
        b=mtua/+YVMMggtJ+5WLrJZ1m7bYjjM9iaZ5BV5xfnxY4r0HwKp1ysjYKTY54kCpdnAc
         ytOVm3afyx1ohw3jWCYlM4/1TXVht5Fp/A1aR+UIXAfHg7uMSHaYUlkEeqSpf1ymXlKF
         L8J+DXOaH/BHXiMsv8xqGMiMuegh0u9BE6UiVRX0ly1gr8B1c1n8+RnCRAu4Jua2eneL
         /YSLyUzyVBUGO1PFiYZfmy5OaNffPqxDBdA+ixE0wc3h+3HJ7q71b2dAMk97B1ByYfKx
         cDZBFHcF64Wj3yP3nf5t7a8W0Pw14WrH5A9eBjrhdStdqCQu5ATz1/BKxQzK2agKINh0
         D2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lQMFtJRCArwp3wzx3Cjb6oQ0UqbfIZ6ZBRWH4m+nfrg=;
        b=aJpJLopyjh6ERrRmCp4vuoYzS/zeE2nZ5hiJW92zXfrvj9X+gz8JXMZL93Z/+fXZuq
         92K6fSNcZ1x79S5RLz/8ixaTqW5lBZF0HYpszBUuAuK6qd0ybI62An5mHYgJnFK4v39Q
         iYmY5P/a8fOBFy0a0kPZqp6rW5YLfJMH9J5Qq77twtulS7HFDoMMb/njf4LxRMJzI0oz
         A14IKGKNkqEJNXcvFjSdD19cRlXiZRgFziQImVlqYKhEj1j1G0V1fLF7oERiJa6KDJgw
         KiRqfhN2QQXYedziPxXDAs+Ea/MQKi4XIY/X2PeHinAC1gVOW89zdXZ/iaKH5VbqzxUP
         iQPw==
X-Gm-Message-State: AMCzsaU6RDNObNqeb04W1VYDTPpGq2osv7vddidPnMYUbN9ghs2Vle8b
        UNq39DFmER73WcrFuM6twMY=
X-Google-Smtp-Source: AOwi7QD/+CoHfH2gNlK0X3BCg2ehdFujiIteP40TGwKQdEHP2sYwTMoKndHboYFuJCCYj3AMicrCkg==
X-Received: by 10.200.52.212 with SMTP id x20mr19376503qtb.90.1507637789631;
        Tue, 10 Oct 2017 05:16:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id x65sm6167815qke.60.2017.10.10.05.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 05:16:28 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] sha1_name: minimize OID comparisons during
 disambiguation
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
References: <20171008184942.69444-1-dstolee@microsoft.com>
 <20171008184942.69444-5-dstolee@microsoft.com>
 <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <338aab6a-1181-d740-1bf2-2ac86749a6b2@gmail.com>
Date:   Tue, 10 Oct 2017 08:16:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2017 9:49 AM, Jeff King wrote:
> On Sun, Oct 08, 2017 at 02:49:42PM -0400, Derrick Stolee wrote:
>
>> @@ -505,6 +506,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>>   	return 0;
>>   }
>>   
>> +static void find_abbrev_len_for_pack(struct packed_git *p,
>> +				     struct min_abbrev_data *mad)
>> +{
>> +	int match = 0;
>> +	uint32_t num, last, first = 0;
>> +	struct object_id oid;
>> +
>> +	open_pack_index(p);
>> +	num = p->num_objects;
>> +	last = num;
>> +	while (first < last) {
>> [...]
> Your cover letter lists:
>
>    * Silently skip packfiles that fail to open with open_pack_index()
>
> as a change from the previous version. But this looks the same as the
> last round. I think this _does_ end up skipping such packfiles because
> p->num_objects will be zero. Is it worth having a comment to that
> effect (or even just an early return) to make it clear that the
> situation is intentional?
>
> Although...
>
>> +	/*
>> +	 * first is now the position in the packfile where we would insert
>> +	 * mad->hash if it does not exist (or the position of mad->hash if
>> +	 * it does exist). Hence, we consider a maximum of three objects
>> +	 * nearby for the abbreviation length.
>> +	 */
>> +	mad->init_len = 0;
>> +	if (!match) {
>> +		nth_packed_object_oid(&oid, p, first);
>> +		extend_abbrev_len(&oid, mad);
> If we have zero objects in the pack, what would nth_packed_object_oid()
> be returning here?
>
> So I actually think we do want an early return, not just when
> open_packed_index() fails, but also when p->num_objects is zero.
>
> -Peff

Sorry about this. I caught this while I was writing my cover letter and 
amended my last commit to include the following:

     if (open_pack_index(p))
         return;

After I amended the commit, I forgot to 'format-patch' again. I can send 
a diff between the commits after review has calmed.

Thanks,
-Stolee
