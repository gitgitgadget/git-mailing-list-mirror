Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6F72047F
	for <e@80x24.org>; Thu, 21 Sep 2017 07:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdIUHmk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 03:42:40 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53166 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751485AbdIUHmj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 03:42:39 -0400
X-AuditID: 12074414-0ebff70000006ddf-a3-59c36d6e5498
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 89.6A.28127.E6D63C95; Thu, 21 Sep 2017 03:42:38 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCB74.dip0.t-ipconnect.de [87.188.203.116])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8L7gZb5021372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 21 Sep 2017 03:42:36 -0400
Subject: Re: [PATCH v2 02/21] prefix_ref_iterator: break when we leave the
 prefix
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505799700.git.mhagger@alum.mit.edu>
 <CAGZ79kbwCAidGR3cgukdjckZVYwj+qbOikqN-e934uP1yk9Cuw@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <32b3d338-6781-a600-2c7e-65dc2818aab5@alum.mit.edu>
Date:   Thu, 21 Sep 2017 09:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbwCAidGR3cgukdjckZVYwj+qbOikqN-e934uP1yk9Cuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqJuXezjS4PJdY4u1z+4wWTxff4Ld
        outKN5NFQ+8VZov+5V1sFt1T3jJa/GjpYbbYvLmdxYHDY+esu+weHz7GeSzYVOrxrHcPo8fF
        S8oenzfJBbBFcdmkpOZklqUW6dslcGXsnDqbpWA3e8W6q8tYGhivsHYxcnJICJhINB/vZe5i
        5OIQEtjBJDFj5j4o5wKTxOLeycwgVcICwRLNb7awg9giAmoSM1fNZgMpYhboZJZ41n2LBSQh
        JHCeUeLtTVsQm01AV2JRTzMTiM0rYC9x9+prsBoWAVWJvUd+gQ0VFYiQ6Ht7mR2iRlDi5Mwn
        YDWcAoESr+buZwOxmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGgVlI2mchaZmFpGUWkpYF
        jCyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUIiRGQH45GTcocYBTgYlXh4
        J5gcjhRiTSwrrsw9xCjJwaQkyjspEyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDcjCCjHm5JY
        WZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBm5AD1ChYlJqeWpGWmVOCkGbi
        4AQZzgM0XDQbZHhxQWJucWY6RP4Uoy7HjYfX/zAJseTl56VKifOmgQwSACnKKM2DmwNLbK8Y
        xYHeEublA6niASZFuEmvgJYwAS3J3nAAZElJIkJKqoFR0dFEQUIrtaC3zt+VL7GmLIaLY8oX
        83Orn516m565ekH2W48jkhd6Hq259JMjNTElMqV08dIjeYuX3dssPcmBa9o81x9BUU1ljwL+
        TfCT8Nh6hO3yR+No9w///p1JlF9hIq/8Tajn/Y/LjpFmIXdeXM5+vXbZk8tdDHm3p5r+/vcr
        edbE9qSLSizFGYmGWsxFxYkASZgKWkcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20/2017 10:25 PM, Stefan Beller wrote:
> On Mon, Sep 18, 2017 at 11:22 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> +/* Return -1, 0, 1 if refname is before, inside, or after the prefix. */
>> +static int compare_prefix(const char *refname, const char *prefix)
>> +{
>> +       while (*prefix) {
>> +               if (*refname != *prefix)
>> +                       return ((unsigned char)*refname < (unsigned char)*prefix) ? -1 : +1;
> 
> This looks interesting.
> 
> We get a signed char* , cast it to unsigned char* and then
> compare byte by byte.

Not quite. We get a `char *` of unknown signedness (it's
implementation-dependent), dereference it into a `char`, then cast that
value to `unsigned char`. What you described would be

    *(const unsigned char *)refname < *(const unsigned char *)prefix

But I assume that these two variants would result in identical assembly
code.

> [...]

Michael
