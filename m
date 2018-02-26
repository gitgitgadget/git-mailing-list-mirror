Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3161F404
	for <e@80x24.org>; Mon, 26 Feb 2018 14:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeBZOGb (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 09:06:31 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32921 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeBZOG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 09:06:29 -0500
Received: by mail-qk0-f178.google.com with SMTP id f25so19142791qkm.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nMr9BfSp8DO1pOPBPIc+ICv4/1o5xj9kevM/lXmPa5E=;
        b=GlmsFNYupb0G23jqEvnrUo9eKGVxWKf75BdHPkhUs7tuD6n9HkdPquxjqJ5e/PgIL0
         MQjp2atyy7ILR+qo6q5zh/TFKVzkkTdc/Obzq6OokHsGXZhXJz01WDwn1e/1kGmT2lCN
         4cSh8I1KfXQLFDdKE+ARDpKoku3iUF3rrGVXHCou6YBmzBrUhjxOXfQBdv2g8By3H8gf
         +BAVyhqOh1VvB7kLBVnfBRQrEo1/6DEXRHqy4ARrh2GJAzZoQRVNpJHrMPpGqc0YlEMX
         dowzPM+xNplwLJOOoanb+VYlj792cx9wGRt22Ov8vU9KzMsoSpICeHd6qKtfMyl33Iyt
         3VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nMr9BfSp8DO1pOPBPIc+ICv4/1o5xj9kevM/lXmPa5E=;
        b=Mjn94e2BeWrHMC3CGXDmZNEk5auMdBfKOeooRVogV5V9c4lXnfg56FvEEcNFGID90w
         VsXyC0P+NwQAyZ6oRJdREjKzSQHqMyU5vyMSTDAMYYNRkYxF3YzvIw3tv/hKBU6vc0nr
         6/EEdMNNxVEEO00bcKK8w7EVphp42JkY7xTw7qCXX/3098EDi4jYzakHVze6+7QxhzjC
         eGJuH0qT8reywvLeY1Wjjrx/+E4l6+7eWfwdYyXz2z4ROE5ZPRNjnCUyL+LpUZF+kiio
         CjlxO0mUf79RJtf/h9C9BGyTt+3H/VltZNlH1EVoXbLO0hCMHIYwkDQUE02XvJc0G7vS
         BmFA==
X-Gm-Message-State: APf1xPB5ghizcCHOrmqkvVc0g1EXbgqlg+9jKRya7rliE+yFV8i+0dVm
        PTz8TWgbspK9YF/GBOAJl0Q=
X-Google-Smtp-Source: AG47ELsoD7dMr2g52ry2zJGTl5EYVEkHqxc84G4g4bBtlVUIQ1pnE1VzG49RYp/UYqPXOFij8fOkFA==
X-Received: by 10.55.239.26 with SMTP id j26mr17278752qkk.315.1519653988976;
        Mon, 26 Feb 2018 06:06:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id x66sm4745133qkc.54.2018.02.26.06.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 06:06:28 -0800 (PST)
Subject: Re: Use of uninitialised value of size 8 in sha1_name.c
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, dstolee@microsoft.com
References: <CAP8UFD23z9YDukO=O+cK=o_0DLcxbkXWzp4rCA1kRXGTZ-TMcQ@mail.gmail.com>
 <20180226095311.GA14831@sigill.intra.peff.net>
 <CAP8UFD01wkpNuXSHxQTETi3+tWBM0E=iYXQeT2r7tGs=2Yq2EA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0a85ea3b-3f64-f67d-b4d5-a761cbc4c6db@gmail.com>
Date:   Mon, 26 Feb 2018 09:06:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD01wkpNuXSHxQTETi3+tWBM0E=iYXQeT2r7tGs=2Yq2EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/2018 5:23 AM, Christian Couder wrote:
> On Mon, Feb 26, 2018 at 10:53 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 26, 2018 at 10:04:22AM +0100, Christian Couder wrote:
>>
>>> ==21455== Use of uninitialised value of size 8
>>> ==21455==    at 0x2D2A73: get_hex_char_from_oid (sha1_name.c:492)
>>> ==21455==    by 0x2D2AFE: extend_abbrev_len (sha1_name.c:502)
>>> ==21455==    by 0x2D2C3D: find_abbrev_len_for_pack (sha1_name.c:551)
>>> ==21455==    by 0x2D2CFF: find_abbrev_len_packed (sha1_name.c:569)
>>> ==21455==    by 0x2D2E12: find_unique_abbrev_r (sha1_name.c:608)
>>> ==21455==    by 0x2DCB66: strbuf_add_unique_abbrev (strbuf.c:877)
>>> ==21455==    by 0x14F7CE: update_local_ref (fetch.c:700)
>>> ==21455==    by 0x1500CF: store_updated_refs (fetch.c:871)
>>> ==21455==    by 0x15035B: fetch_refs (fetch.c:932)
>>> ==21455==    by 0x150CF8: do_fetch (fetch.c:1146)
>>> ==21455==    by 0x1515AB: fetch_one (fetch.c:1370)
>>> ==21455==    by 0x151A1D: cmd_fetch (fetch.c:1457)
>>> ==21455==  Uninitialised value was created by a stack allocation
>>> ==21455==    at 0x2D2B2E: find_abbrev_len_for_pack (sha1_name.c:513)
>>> ==21455==
>>>
>>> A quick git blame seems to point to 0e87b85683 (sha1_name: minimize
>>> OID comparisons during disambiguation, 2017-10-12).
>>>
>>> It is difficult to tell for sure though as t5616-partial-clone.sh was
>>> added after that commit.
>> I think that commit is to blame, though the error isn't exactly where
>> that stack trace puts it. Try this:
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 611c7d24dd..6f7f36436f 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -547,7 +547,10 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>>           */
>>          mad->init_len = 0;
>>          if (!match) {
>> -               nth_packed_object_oid(&oid, p, first);
>> +               warning("p->num_objects = %u, first = %u",
>> +                       p->num_objects, first);
>> +               if (!nth_packed_object_oid(&oid, p, first))
>> +                       die("oops!");
>>                  extend_abbrev_len(&oid, mad);
>>          } else if (first < num - 1) {
>>                  nth_packed_object_oid(&oid, p, first + 1);
>>
>> I get failures all over the test suite, like this:
>>
>>    warning: p->num_objects = 4, first = 3
>>    warning: p->num_objects = 8, first = 6
>>    warning: p->num_objects = 10, first = 0
>>    warning: p->num_objects = 4, first = 0
>>    warning: p->num_objects = 8, first = 0
>>    warning: p->num_objects = 10, first = 10
>>    fatal: oops!
> Yeah, I tried to t5601-clone.sh with --valgrind and I also get one
> error (the same "Uninitialised value" error actually).

Thanks for finding this. Sorry for the bug.

>> Any time the abbreviated hex would go after the last object in the pack,
>> then first==p->num_objects, and nth_packed_object_oid() will fail. That
>> leaves uninitialized data in "oid", which is what valgrind complains
>> about when we examine it in extend_abbrev_len().
>>
>> Most of the time the code behaves correctly anyway, because the
>> uninitialized bytes are unlikely to match up with our hex and extend the
>> length. Probably we just need to detect that case and skip the call to
>> extend_abbrev_len() altogether.
> Yeah, something like:
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..a041d8d24f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -547,15 +547,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>           */
>          mad->init_len = 0;
>          if (!match) {
> -               nth_packed_object_oid(&oid, p, first);
> -               extend_abbrev_len(&oid, mad);
> +               if (nth_packed_object_oid(&oid, p, first))
> +                       extend_abbrev_len(&oid, mad);
>          } else if (first < num - 1) {
> -               nth_packed_object_oid(&oid, p, first + 1);
> -               extend_abbrev_len(&oid, mad);
> +               if (nth_packed_object_oid(&oid, p, first + 1))
> +                       extend_abbrev_len(&oid, mad);
>          }
>          if (first > 0) {
> -               nth_packed_object_oid(&oid, p, first - 1);
> -               extend_abbrev_len(&oid, mad);
> +               if (nth_packed_object_oid(&oid, p, first - 1))
> +                       extend_abbrev_len(&oid, mad);
>          }
>          mad->init_len = mad->cur_len;
>   }
>
> seems to prevent valgrind from complaining when running t5616-partial-clone.sh.

This seems like the safest fix, but also we could use our values of 
"match", "first" and "num" to safely call nth_packed_object_oid(). 
However, since nth_packed_object_oid() checks the bounds, don't 
duplicate work and just use the return value.

I would reformat your patch slightly, but that's just preference:

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d2..97b632c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -546,17 +546,14 @@ static void find_abbrev_len_for_pack(struct 
packed_git *p,
          * nearby for the abbreviation length.
          */
         mad->init_len = 0;
-       if (!match) {
-               nth_packed_object_oid(&oid, p, first);
+       if (!match && nth_packed_object_oid(&oid, p, first))
                 extend_abbrev_len(&oid, mad);
-       } else if (first < num - 1) {
-               nth_packed_object_oid(&oid, p, first + 1);
+       else if (first < num - 1 &&
+                nth_packed_object_oid(&oid, p, first + 1))
                 extend_abbrev_len(&oid, mad);
-       }
-       if (first > 0) {
-               nth_packed_object_oid(&oid, p, first - 1);
+       if (first > 0 && nth_packed_object_oid(&oid, p, first - 1))
                 extend_abbrev_len(&oid, mad);
-       }
+
         mad->init_len = mad->cur_len;
  }

Christian: do you want to submit the patch, or should I put one together?

Thanks,
-Stolee

