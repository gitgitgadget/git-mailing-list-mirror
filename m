Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01DD1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbcHCWBj (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:01:39 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36598 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828AbcHCWBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:01:37 -0400
Received: by mail-yw0-f193.google.com with SMTP id u134so17708903ywg.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:01:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aBvurxDSu7eXDNXlHE7XIJRLbRyJaMsCQkxfJNSTosk=;
        b=mL2sSMRdJER1srwPw7etPMxNKik6tsDWEKM6oQ0ZusIfmEQQdEtdQ2ppeBg4oFBgsQ
         ReyHvLrZPzJEmZV8IKpdBeUgRMP9z6Raoojz012fdkI3EMuO+4gi4pRJfnPkPVcA5fTe
         eV13RV193FgUxxXCQXo+A7A1qE5lLHo98hq+yAxwBv6OE2KAXbQbPFeo6hFN+EN2qV+d
         1nfcjLZ1zz5OpLhK1MVpZshxdhXwMGaoaCUwVhpFSkK9Paw3ELUyhUBswz6u6ds/yr3n
         AT7CcgELVXvJHfGMaamnznx88FbQGKmk6FzDCHeKDTBYsxiCrs0zjlAelUPB8O9UFP0l
         o/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aBvurxDSu7eXDNXlHE7XIJRLbRyJaMsCQkxfJNSTosk=;
        b=bRAtbZJ+AdD+DRXGKZS1DWbZ4XL39OvUYe2YFPUs1afsoQScjla58Rd9SxXVSbWSdF
         m6i+Y9ViFhN91TB3NZ1ntf7jE95MYdU5PxDk0BjSpgaxb0vtulH8ByuA0YJy5U5yddI1
         dRDNSIUr8k85RG0LS7aGhWHGEXQEJh5MGSYhLM3wlmjJa4QjacOsJrMoj3hF8ZbH2Qw2
         +2DnthsnleJCyaOjpyXwhGX+aW+9z/QkssWlsl+NyqhAT1arcQktsMcsna9DfBkShRPj
         8IftX20pnWEcqT9KH0/CKrqCxlHszYo5oVQSeMpw23Og7LFKxNNPe1+R5PyHvjnTdS9w
         /1Jg==
X-Gm-Message-State: AEkoouuGTv3lA9GJRrufdLZyMipPAH5m5bCjskr/7cxWHo0u034pIlFLTg46wodqAyB46h/46+bcbhjdD7r05w==
X-Received: by 10.129.106.139 with SMTP id f133mr56462109ywc.163.1470260627663;
 Wed, 03 Aug 2016 14:43:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 3 Aug 2016 14:43:27 -0700 (PDT)
In-Reply-To: <564CA3AD-EA8E-46D3-9564-BF468CAF32B0@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com>
 <xmqq8twd8uld.fsf@gitster.mtv.corp.google.com> <564CA3AD-EA8E-46D3-9564-BF468CAF32B0@gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 3 Aug 2016 14:43:27 -0700
X-Google-Sender-Auth: 6I7ffcRhzbn6GzGwQzzotXT5rtM
Message-ID: <CAPc5daWH1z3am2hV_U1dE5WA7R+xrOFxgrxV4CN-vhz6uHz8Hw@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 2:37 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>>
>> I think this was already pointed out in the previous review by Peff,
>> but a variable "ret" that says "0 is bad" somehow makes it hard to
>> follow the code.  Perhaps rename it to "int error", flip the meaning,
>> and if the caller wants this function to return non-zero on success
>> flip the polarity in the return statement itself, i.e. "return !errors",
>> may make it easier to follow?
>
> This follows the existing filter function. Please see Peff's later
> reply here:

Which I did before mentioning "pointed out in his review".

> That's why I kept it the way it is. If you prefer the "!errors" approach
> then I will change that.

I am not suggesting to change the RETURN VALUE from this function.
That is why I mentioned "return !errors" to flip the polarity at the end.
Inside the function, "ret" variable _forces_ the readers to think "this
function unlike the others signal an error with 0" constantly while
reading it, and one possible approach to reduce the mental burden
is to replace "ret" variable with "errors" variable, which is clear to
anybody that it would be non-zero when we saw error(s).

Oh, I am not suggesting to _count_ the number of errors by
mentioning a possible variable name "errors"; the only reason
why I mentioned that name is because "error" is already
taken, and "seen_error" is a bit too long.
