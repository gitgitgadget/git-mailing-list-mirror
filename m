Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865572036B
	for <e@80x24.org>; Mon,  2 Oct 2017 14:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdJBOwo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:52:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36924 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdJBOwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:52:42 -0400
Received: by mail-qk0-f194.google.com with SMTP id a12so1326713qka.4
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vNaqhz0THYMQIBdiCrzDIVemaFpXYj4l+jd+yTwgxfc=;
        b=FOKF4ckRAkECs8xmh1od4tSPzrVR4uBEVMpcPRtj0UjAKNBJcmuRDstQyfKXF/wlvu
         355XgBg/Fz+us1uJwW42Oc5cdHa3PU9TSSIMEmrcDNzyv1fFzKD8z8plpOl7vmf0oz+O
         3QZTe67IPlVUl+u7bLSZRzVUYnCXgQBlDdmEe9ensFtxFs+qoMBjC0yHQYUxACDjvksQ
         DZCSgaasrJ+OFRpGoO4X4AojaLWuVD6q9Q6rHSWeshFETd3VLXS/2YK0DCIyLDovRcmc
         zbpSFmN4oxbNOGAdPL7GrkxBQENlILyZ1QRvZ9k6bKyu5SLouzlYoNYxJ+Jg2D6g6GMr
         6oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vNaqhz0THYMQIBdiCrzDIVemaFpXYj4l+jd+yTwgxfc=;
        b=aabsIRMIz03Hm5PimaWJ7v9gXDG4SKAIaavpxWLh7WWMDueNZ5Wo2veOtaq+1OUgMO
         tDs+QpvlzZmxBxwgeaS5WQP+NS5H/mGegbRvyKRSNYKEAxlkY0ZK/ozQn3A/lBsmuwWg
         xBqowKnmihwBoB93oRqAv4tf9//ybEayyUlUhQeCoHeaoMzLhkNehrbT/auO9EzUeKYg
         uaiXRoJhy15gpCwsScRGOkaXbjv8sj0LXeeGlYrd1JXuaGMgyXxwmU7VFKKh/LrrmQKT
         r0oYA2grtXdFWpSDmAHVGCxXECIReg3r3J+ynoGxoamYJmtbJ2kQjFqZ/bYiqWvK39Og
         yhkw==
X-Gm-Message-State: AMCzsaV8RZw3jkB6VJX1Cp2MrKS78soCBV5W4Ckj0KgxNIdeicn+Ai8T
        aQ5+OpISCUr8XIk5KWM8CjRxx5G9
X-Google-Smtp-Source: AOwi7QCTAKtiyLFArwQfuMXHigR2FKE92bnJm18zJW4hGCU8S4SNiS7nuAhMhU5KjaJv3d7l9uX26g==
X-Received: by 10.55.195.25 with SMTP id a25mr11232976qkj.325.1506955960706;
        Mon, 02 Oct 2017 07:52:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id m66sm6810369qkf.23.2017.10.02.07.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 07:52:39 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] sha1_name: Parse less while finding common prefix
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-5-dstolee@microsoft.com>
 <CAGZ79kaBGtgBv2OryCO+oc-0nvSyi0vXA2jsLS2=5Xweea1SNg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f255961b-754e-5cf1-7641-1951548db362@gmail.com>
Date:   Mon, 2 Oct 2017 10:52:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaBGtgBv2OryCO+oc-0nvSyi0vXA2jsLS2=5Xweea1SNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My v3 patch is incoming, but I wanted to respond directly to this message.

On 9/25/2017 7:42 PM, Stefan Beller wrote:
> On Mon, Sep 25, 2017 at 2:54 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
>> Create get_hex_char_from_oid() to parse oids one hex character at a
>> time. This prevents unnecessary copying of hex characters in
>> extend_abbrev_len() when finding the length of a common prefix.
>>
>> p0008.1: find_unique_abbrev() for existing objects
>> --------------------------------------------------
>>
>> For 10 repeated tests, each checking 100,000 known objects, we find the
>> following results when running in a Linux VM:
>>
>> |       | Pack  | Packed  | Loose  | Base   | New    |        |
>> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
>> |-------|-------|---------|--------|--------|--------|--------|
>> | Git   |     1 |  230078 |      0 | 0.08 s | 0.08 s |   0.0% |
>> | Git   |     5 |  230162 |      0 | 0.17 s | 0.16 s | - 5.9% |
>> | Git   |     4 |  154310 |  75852 | 0.14 s | 0.12 s | -14.3% |
>> | Linux |     1 | 5606645 |      0 | 0.50 s | 0.25 s | -50.0% |
>> | Linux |    24 | 5606645 |      0 | 2.41 s | 2.08 s | -13.7% |
>> | Linux |    23 | 5283204 | 323441 | 1.99 s | 1.69 s | -15.1% |
>> | VSTS  |     1 | 4355923 |      0 | 0.40 s | 0.22 s | -45.0% |
>> | VSTS  |    32 | 4355923 |      0 | 2.09 s | 1.99 s | - 4.8% |
>> | VSTS  |    31 | 4276829 |  79094 | 3.60 s | 3.20 s | -11.1% |
>>
>> For the Windows repo running in Windows Subsystem for Linux:
>>
>>      Pack Files: 50
>> Packed Objects: 22,385,898
>>   Loose Objects: 492
>>       Base Time: 4.61 s
>>        New Time: 4.61 s
>>           Rel %: 0.0%
>>
>> p0008.2: find_unique_abbrev() for missing objects
>> -------------------------------------------------
>>
>> For 10 repeated tests, each checking 100,000 missing objects, we find
>> the following results when running in a Linux VM:
>>
>> |       | Pack  | Packed  | Loose  | Base   | New    |        |
>> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
>> |-------|-------|---------|--------|--------|--------|--------|
>> | Git   |     1 |  230078 |      0 | 0.06 s | 0.05 s | -16.7% |
>> | Git   |     5 |  230162 |      0 | 0.14 s | 0.15 s | + 7.1% |
>> | Git   |     4 |  154310 |  75852 | 0.12 s | 0.12 s |   0.0% |
>> | Linux |     1 | 5606645 |      0 | 0.40 s | 0.17 s | -57.5% |
>> | Linux |    24 | 5606645 |      0 | 1.59 s | 1.30 s | -18.2% |
>> | Linux |    23 | 5283204 | 323441 | 1.23 s | 1.10 s | -10.6% |
>> | VSTS  |     1 | 4355923 |      0 | 0.25 s | 0.12 s | -52.0% |
>> | VSTS  |    32 | 4355923 |      0 | 1.45 s | 1.34 s | - 7.6% |
>> | VSTS  |    31 | 4276829 |  79094 | 1.59 s | 1.34 s | -15.7% |
>>
>> For the Windows repo running in Windows Subsystem for Linux:
>>
>>      Pack Files: 50
>> Packed Objects: 22,385,898
>>   Loose Objects: 492
>>       Base Time: 3.91 s
>>        New Time: 3.08 s
>>           Rel %: -21.1%
>>
> These number look pretty cool!
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> double signoff?

Oops! I'll be more careful with my format-patch in the future.

>
>> ---
>>   sha1_name.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index f2a1ebe49..bb47b6702 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -480,13 +480,22 @@ struct min_abbrev_data {
>>          char *hex;
>>   };
>>
>> +static inline char get_hex_char_from_oid(const struct object_id *oid, int i)
> 'i' is not very descriptive, maybe add a comment?
> (I realize it is just walking through the char*s one by one)
I renamed 'i' to 'pos' in my v3.

>
> Maybe this function (together with the change in the while below)
> could go into hex.c as "int progressively_cmp_oids" that returns
> the position at which the given oids differ?
>
>> +{
>> +       static const char hex[] = "0123456789abcdef";
>> +
>> +       if ((i & 1) == 0)
>> +               return hex[oid->hash[i >> 1] >> 4];
>> +       else
>> +               return hex[oid->hash[i >> 1] & 0xf];
>> +}
> sha1_to_hex_r has very similar code, though it iterates less
> and covers both cases in the loop body.
>
> That is the actual reason I propose moving this function
> (or a variant thereof) to hex.c as there we can share code.

You're right that sha1_to_hex_r is similar, in fact I based my work on 
it. There are a few reasons I didn't combine the two implementations:

* I wanted to be sure my patch was only touching the code for 
disambiguating short-shas. Modifying code in hex.c would touch many more 
code paths.

* I realize that the extra branch in my version is slower than the 
branchless loop body in sha1_to_hex_r, so either I would slow that 
method or make the method call more complicated by returning two chars 
at a time.

* I wanted to strongly hint that the method should be inlined, but I'm 
not sure how to guarantee that happens across a linker boundary without 
doing strange things in header files.

I'm happy to revisit this after my patch is complete, since I think 
there are interesting trade-offs to consider here. I'd prefer to keep 
this discussion separate from the focus on disambiguation.

Thanks,
-Stolee
