Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570811F424
	for <e@80x24.org>; Sun, 21 Jan 2018 04:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeAUEjM (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 23:39:12 -0500
Received: from mout.web.de ([217.72.192.78]:52828 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeAUEjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 23:39:11 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZvgf-1f53hA3L1p-00lk1P; Sun, 21
 Jan 2018 05:39:01 +0100
Subject: Re: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
To:     Gargi Sharma <gs051095@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
References: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
 <20180120010228.hhyvirqp44taf3cz@dcvr.yhbt.net>
 <CAOCi2DGKkLnY_=-7pMr9VyP7TVsj0b8w-msdNn9ZtXKK8g7u9g@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <75c9bdc5-1c81-1e03-e865-5e74014bd590@web.de>
Date:   Sun, 21 Jan 2018 05:38:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAOCi2DGKkLnY_=-7pMr9VyP7TVsj0b8w-msdNn9ZtXKK8g7u9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:jeIt8hY7gb+YDjFgA6pmTi7lu60N1+tkX73PgaYXB5M2ciDyEFD
 SR4pwYduLyVUGD3Lc9V8Sz0R7wq9c2VQwAGC9l2aKH9K8sU6f/lr5bSSbUTyHzIhuF3GE62
 SN9SsT5Uefgqf9esvvDaQFBA8zWv4IhXLZ7Jw1CFzqgCjKT9SLXEX7JRTp1BqNfvVF7ef8i
 sYp6ujKv2xNvf9DdONgbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L5QpKtMhhlI=:wrrOuJOuOZ1MmMDxpmR4sR
 I1G4BOQQgLMJaPdT5LYfYA10MoTxWG9RPmElfA1It3cyXDtQP9gTwQAlStN1V42iMDT1QbdZs
 rGL9c1s3Q6Jn6iqmEvQ8AwtoCTQSSKwIkDpSf7OUl9/KGB0qvO+rdBGl1DNaCRTwI9WYZPCE5
 ORnn1tZOUmH3U3peuQow3pg8YD5p+Mb2oJOw7tzV6ChIp74nE4ybgeRcQXj+qqhfPFcppqJ89
 VFhY+wUymVzPvWuPpI4lwiYre7iWSmqJq5EHHDOlFfvTh5XCbAU2OX92pFcTPrn6zJXIkfH+j
 DALDPn/ur4wNyFe6ScsJ2mwa5zHgW7/zrtCeomVYJA3mjLFNmlvXs8aOOmQ0MDdbtxQzoYUyW
 CoopSkpHEjHTYM4bJss/blV3NF4igBGEy0NsrIe35cDnRC59v4hNbyM8o7ry6nvCnCEoVO/PP
 Jmxxbxfo7vyUHU6fjgur8+MFIPI/L6oFaf1pzIaCBw8nxLRRjeInMU7GWxSO2FGth7ZCcToLV
 2zyIah2RKHuWtsHmIEA9T2Qm3WZO+2X6Gv5YJSkY1nT7LNrn7eLcIFpyZWGoeX6aJF6BqCIHk
 TFIKLLOHQN4voT/qAHDPPMQXpTz8lzmsosFcYi0rSg6cNGyeWaAeoih+/qVN56UERZ+QbWySf
 fqhVLdE/F70Uzr2bxfBzDmUOfg/VYB6hVU8HQ7vj2X+UmfgROIirwRtQMrsDANpzmNoCh5SVM
 8OeKbxBt2QZS2arjd7QGdOPaIdkhNNei+cIVv7cf8UqDYzcPPWx9vjSIookWfiGFwP3I8oF8C
 0UhX8qpLSvtLrXVNWPqzROahMF3eSMl+Sccy7kCXgITix7yASM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.01.2018 um 23:24 schrieb Gargi Sharma:
> On Sat, Jan 20, 2018 at 1:02 AM, Eric Wong <e@80x24.org> wrote:
>> Gargi Sharma <gs051095@gmail.com> wrote:
>>> --- a/list.h
>>> +++ b/list.h
>>> @@ -93,6 +93,13 @@ static inline void list_move(struct list_head *elem, struct list_head *head)
>>>        list_add(elem, head);
>>>   }
>>>
>>> +/* Move to the front of the list. */
>>> +static inline void list_move_to_front(struct list_head *elem, struct list_head *head)
>>> +{
>>> +     list_del(elem);
>>> +     list_add(elem, head);
>>> +}
>>> +
>>
>> Since we already have list_move and it does the same thing,
>> I don't think we need a new function, here.
>>
>> Hackers coming from other projects (glibc/urcu/Linux kernel)
>> might appreciate having fewer differences from what they're used
>> to.
> 
> I think the idea behind this function was that it is already being used in two
> places in the code and might be used in other places in the future. I agree
> with your stance, but a list_move_to_front is pretty self explanatory and not
> too different, so it should be alright.

Not sure I understand the point about the function being already used as
an argument for adding it, but if there is already one which has the
exact sane behavior (list_move() in this case) then that should be used
instead of adding a duplicate.

René

