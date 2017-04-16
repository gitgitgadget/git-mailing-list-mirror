Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8D81FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 05:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbdDPFt4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 01:49:56 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55716 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdDPFtz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 01:49:55 -0400
X-AuditID: 12074413-f4fff700000077e1-7a-58f305ff1f6c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BD.47.30689.FF503F85; Sun, 16 Apr 2017 01:49:54 -0400 (EDT)
Received: from [192.168.69.190] (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G5nlFt023707
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 01:49:49 -0400
Subject: Re: [PATCH v2 11/20] refs: record the ref_store in ref_cache, not
 ref_dir
To:     Duy Nguyen <pclouds@gmail.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <7e63849fdb197cd66b229a28408845908fa844a7.1490966385.git.mhagger@alum.mit.edu>
 <CACsJy8BM1nHhbKo9ioAP2OC2UU-RMWhmJ5OsYZwWYqek++DA0Q@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c057d1f5-e8c6-3c08-2b18-e5cf73f74e57@alum.mit.edu>
Date:   Sun, 16 Apr 2017 07:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BM1nHhbKo9ioAP2OC2UU-RMWhmJ5OsYZwWYqek++DA0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1GVi+xxhsO6wmMXaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujOalSxkLNnFVbJuwgrGB8TV7FyMnh4SAicTyvnesXYxcHEIC
        O5gkZh5ZzQzhnGOSWHH0NDNIlbBAiMSHwzdZQGwRASWJNx3bwOJCAucZJdYt5wBpYBaYyCRx
        4stDJpAEm4CuxKKeZjCbV8BeYuWcP2DrWARUJf6cugIWFwUaOmfhA0aIGkGJkzOfgC3gFAiU
        OP78HtgCZgF1iT/zLkHZ8hLb385hnsDIPwtJyywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxb
        nJyYl5dapGuul5tZopeaUrqJERLowjsYd52UO8QowMGoxMNr4f8pQog1say4MvcQoyQHk5Io
        r8x/oBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3mSWzxFCvCmJlVWpRfkwKWkOFiVxXrUl6n5C
        AumJJanZqakFqUUwWRkODiUJXhdWoEbBotT01Iq0zJwShDQTByfIcB6g4cYgNbzFBYm5xZnp
        EPlTjIpS4rzmIFsFQBIZpXlwvbBE9IpRHOgVYV5HkCoeYBKD634FNJgJaDDD5A8gg0sSEVJS
        DYxbueduL5e/winfLsG3Q7lYVtcsYqOwoLUAE0PbhNIXT+IzDL9dUmCYwF7TcpNv76xsI0uf
        /RzfX7zOkQx416T4IDPHPuOwUGDdVrHnHO4OB9j2fpk1LSD9SIda7rvyj0Z7+Lxu3pb5tOpz
        bK1yfqjz7NOHa0RWbjvMvMoz8+IhofnuMq8vmymxFGckGmoxFxUnAgBpZB3SHwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2017 01:38 PM, Duy Nguyen wrote:
> On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Instead of keeping a pointer to the ref_store in every ref_dir entry,
>> store it once in `struct ref_cache`, and change `struct ref_dir` to
>> include a pointer to its containing `ref_cache` instead. This makes it
>> easier to add to the information that is accessible from a `ref_dir`
>> without increasing the size of every `ref_dir` instance.
> ...
>> @@ -526,7 +526,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
>>                  * lazily):
>>                  */
>>                 add_entry_to_dir(get_ref_dir(refs->loose->root),
>> -                                create_dir_entry(refs, "refs/", 5, 1));
>> +                                create_dir_entry(refs->loose, "refs/", 5, 1));
> 
> The commit message mentions nothing about this change. Is it intended?

The old `create_dir_entry()` took a `files_ref_store` as its first
parameter, because that is what needed to be stored into the old
`dir_entry` struct. The new version takes a `ref_cache`, because that is
what the new `dir_entry` struct requires. This hunk is a logical
consequence of that change.

I'll improve the commit message to explain this better.

Thanks,
Michael

