Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD3B2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdJCRFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 13:05:46 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44212 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCRFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 13:05:45 -0400
Received: by mail-qt0-f175.google.com with SMTP id v28so5362000qtv.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ycqPG55bKz4w9QvCaHW9YDssz0VAxWXcMC4Jmb4Ea0w=;
        b=GKhqbScLnh3oFFSKPwuDIr2l7FkHbLmCsYoB5da8yGp+TozpyH3tLQINpvvrdsALK/
         6mochkLZ9HU6BcBLtqvZ3TSlgRA6wKrij+kPeozqmcZGhFOr1lQOAHin4kVvT9cdmkre
         dotuRfdcm1ApUFok9J5InBJG9k15T2e2mIZQ5jR9yv8LDpOQQ+4O+A8FrRyImkPSvak6
         P5O7BeyEQz1UrH0nlMaqNJkUATa/92ZZwduh0hGbCsvtIOqEW7PYFfbJDd5dibtxtWmF
         j6Fy+v2NMP2FaK/RYwC0A6bMaq/9KcVzYcz4yq5u4ZrlVBJSPWyYVurqxKq5HDT/05N8
         RkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ycqPG55bKz4w9QvCaHW9YDssz0VAxWXcMC4Jmb4Ea0w=;
        b=fkjDTkrG1vgmoQApAyedUiyZ2xhgdGaZDk03ZzfmsfB4SCOB+klw7ktT6YGYQnDM5K
         hk+7rn25Waub38JDYcXKnXwwGsk78QT0SHuCqW4CBsKwomNFHnHxMd8yxDI0iEgp5UeE
         ZkdNbQ/xbG/HYQGecscTcWNQzG+SIc1LEQbtHOpuUmt5bOHMZg8IdmtHS4IJy/olafQ5
         wu8p6wQzjiruUN1yTylOKsQlcVIYAj8rw8TelQK5YL34T9GIDEI29YnvICyVB/fFdQ27
         rZf2IGrCnzXgJbWJtWv1NybSW/2PgqMuZR129HSm/5c/rcb9dSUi5DviIw1nyh/TxtAQ
         HCQQ==
X-Gm-Message-State: AMCzsaXV7m7IIVVOCN+Aw5XcZAt9Glg9v7gJrxl39L1fUdBH7iqPRjKs
        ArQzaNNUWlR/h08wOVjnlHw=
X-Google-Smtp-Source: AOwi7QACksFRimB4S4v8xnBdxiqsR76o+glUo5OtNfS1XW3t0nVuMIj1++AirCqXLR2V6faq7UGvfA==
X-Received: by 10.237.63.85 with SMTP id q21mr3559908qtf.30.1507050344444;
        Tue, 03 Oct 2017 10:05:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id c64sm8508355qkd.70.2017.10.03.10.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 10:05:43 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] sha1_name: Minimize OID comparisons during
 disambiguation
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-6-dstolee@microsoft.com>
 <CAGZ79kZz0EPUo=FpndxQMztQ=x-_c_CbvRB2NDmTLQXWapDBqQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ddd2da9-2846-a4c8-f80a-55eb61e5925d@gmail.com>
Date:   Tue, 3 Oct 2017 13:05:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZz0EPUo=FpndxQMztQ=x-_c_CbvRB2NDmTLQXWapDBqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/2017 11:55 AM, Stefan Beller wrote:
>> @@ -505,6 +506,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>>          return 0;
>>   }
>>
>> +static void find_abbrev_len_for_pack(struct packed_git *p,
>> +                                    struct min_abbrev_data *mad)
>> +{
>> +       int match = 0;
>> +       uint32_t num, last, first = 0;
>> +       struct object_id oid;
>> +
>> +       open_pack_index(p);
> coverity complained here with
>      Calling "open_pack_index" without checking return value
>      (as is done elsewhere 13 out of 15 times).
Good catch! This same line is repeated in unique_in_pack() in this same 
file, so if this is worth fixing then we should probably fix it there, too.
> I think the easiest way out is just a
>
>      if (open_pack_index(p))
>          die(_("Cannot open existing pack idx file for '%s'"), p);
>
> or is there another good approach?
You probably intended to have p->pack_name in the die();

Using `cat *.c | grep -A 2 "if (open_pack_index("` and `cat */*.c | grep 
-A 2 "if (open_pack_index("` I see a few places that return error codes 
or quietly fail. The cases that use die() are inside builtin/ so I don't 
think die() is the right choice here.

Since find_abbrev_len_for_pack() is intended to extend the abbreviation 
length when necessary, I think a silent return is best here:

     if (open_pack_index(p))
         return;

Thanks,
-Stolee
