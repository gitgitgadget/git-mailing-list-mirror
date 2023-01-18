Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C0C46467
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 18:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjARSzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARSy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 13:54:56 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33A15957F
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674068083; bh=MWAaeG7PtGuNMuXRFzx4bEUtVqyjCK6mrmneZvP2pOc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=I6ZlE50lW1x71kZe33gEQq4Jo0h0B6nGoZ9RZcweHqBTSduqOiu293/WWOPmG+FPW
         ZLM1yBGvgNKTPgDeoQQarSqzPxYbRQUnWtVcwAknIfP1z4Qe6Q37mMqKFwkty51RRI
         Yjbeis23r7/QchEI45QBIJDXQKxqEYHXjGgFXJ9cv+hLY1GAOmLRMUknlRWIH9UUdS
         ThxCH2r2t9uGRg2o8H52dTYxn35vt9acsTcAmYnaZyveK4epD7H/EXB2PpGIm/2eiZ
         SpfN3KxbjyQLe0B6Ye4e+jlSd3oWOTfHVEn2R09AO1lKTVZ62XRzGzBI2WfFw0RE7L
         A9Iw0hcKxCnrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuF8z-1oQgBz43iv-00uZtZ; Wed, 18
 Jan 2023 19:54:43 +0100
Message-ID: <d30e2fb2-e9dc-20e0-0761-3b585a053586@web.de>
Date:   Wed, 18 Jan 2023 19:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 15/19] object-file.c: release the "tag" in check_tag()
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-15.19-66c24afb893-20230117T151202Z-avarab@gmail.com>
 <7e571cdd-c0fa-7519-848c-b0bc4613abab@web.de>
 <Y8gqJESD/wbEHZYb@coredump.intra.peff.net>
 <fd883d86-0c85-6c72-a331-2e8b2064befe@web.de>
 <Y8g84mABtIiHmxTI@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y8g84mABtIiHmxTI@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uezKLNxk+iz2arqhMhJvASxWhCGfNixvQyMNJr2Cd3YnA4lrrsl
 RMRK15IKzAfIhwfU/Gn3KiT8K80JlAwjZaXVQhFcy3lQZymEb5StwN+y12C4fTJj5SUh0i4
 9W0969w1QPN0vnBjEc+O9f264wxdw6TjR3MqLNOrELrVi2TGkLqQz28QgmYg1cjjHe2nAOp
 5KMw0P4R/BFD2QTxXScnw==
UI-OutboundReport: notjunk:1;M01:P0:mdkQfxzIbCU=;SRplG5vSCGPfVEW45mDgz3PmcXc
 yMRO98kcSD/t/XT/JxPpVJVfu+5ol9x7pjm0gQY4O4soBcWAIACf9SJylzsdojrsAr6jQ6wgU
 qci/0fMoCIdM3Ue4q6YDajhhgE7yxlOjwXmcb5+1WJXQc97iax5/xHaMFIYks4jpnkfq3mUBa
 T8/WhhtbqL+UFsHSHJ7ufkEnveswHlYv1SWjf4ARyryq6etBHNzudnqHclRIjPe5zEJZDF+9m
 s+fvYLFMGLRFJ3LpILt2VXIFUWIwO9yomBFuIkVqdnjv+pTthut3wn+JaWrIN2ZdlWv+689H6
 X9Ih4xWyIG53n135ZrvwXmFPIZ0Bk/xyyWGXkhnvCAz0wu5mmPC7LoUejCzIl5b6iro/DrD7I
 2B9auA5tPEPIAk1cgwI0gsdzIB4Mca+Uk2kUYNR2on2OQdTwLwL68M6WZLBcgC2C1Lm0y7ESV
 LvnyAprE1SsyBmAmVc0BbmK/4hG7ZTYs6u0+fDBcSuHX3VnVQSXpH+YLk5L80UiB4Eq00Wtex
 HbZ24VgbQL9mBZJXHamE/YM+p9bVIq41+9vmDzjVD1Y/82EuTt0vKQXVyNV7VkSPU3QrdFCpq
 6UrOzplDvGL0pJog5ikd0a+t4CBNlvwfEw/3kq/ZOuB9U2rt4RYEkmZGh5/xaNmJS8r21KJC5
 lVSdYtyVt8Alo3RtIXNtJk7RiLIEYoDz1ryq6KVl5PfzXozMOAgT11DomIpDwu6d07fOj0Gf5
 m4Y5Vcm4Q/KmJ204aTYf8LIF9A/WCIqCzlEmPwJ382b/afZptj0ILVM/405wH1H1PRLoVPvXs
 Y+9oXY+u94Ium/0tNR2895C1AuMQ8Maa6fk15G7cJVYATRvs34Ptci7F07IKUwPdhswGG+b5z
 C5HHcsDvEVYmqM1WQo41wtRA8XVK/T3Umqh2CV4KJ4DJHrT2bM9BjpvH25ZH8ncdK8cSFAFKm
 ZoP++g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.23 um 19:39 schrieb Jeff King:
> On Wed, Jan 18, 2023 at 07:05:32PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>>   2. The point of this code is to find malformed input to hash-object.
>>>      We're probably better off feeding the buffer to fsck_commit(), et=
c.
>>>      It does more thorough checks, and these days it does not need an
>>>      object struct at all.
>>
>> I like the second one, as long as it won't check too much.  c879daa237
>> (Make hash-object more robust against malformed objects, 2011-02-05) ad=
ded
>> the checks that are now in object-file.c and intended to only validate =
the
>> internal structure of objects, not relations between.  It gave the exam=
ple
>> to allow adding a commit before its tree, which should be allowed.  And
>> IIUC fsck_object() fits that bill.
>
> Yes, I think it will do what the right thing here. And having just
> written up a quick series, the only tests which needed changes were ones
> with syntactic problems. :)
>
> I'll send it out in a few minutes.

Great! :)

>>> Either of which would naturally fix the leak for tags. I'm not sure
>>> there actually is a leak for commits, as commit structs don't store an=
y
>>> strings themselves.
>>
>> parse_commit_buffer() allocates the list of parents.
>
> Yes, but it does so with lookup_commit(), so the resulting commit
> objects are themselves reachable from the usual obj_hash, and thus not
> leaked.

The commit_list structures are leaked, no?

>
>> Hmm, and it looks them up.  Doesn't this violate the goal to allow
>> dangling references?
>
> No, because lookup_commit() is just about creating an in-process struct.
> It doesn't look at the object database at all (though it would complain
> if we had seen the same oid in-process as another type).

Ah, good.

Ren=C3=A9
