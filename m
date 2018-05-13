Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658F71F51A
	for <e@80x24.org>; Sun, 13 May 2018 23:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeEMXHK (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 19:07:10 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:57546 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeEMXHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 19:07:09 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id I04yfAf7J3fRRI04yfWWe9; Mon, 14 May 2018 00:07:08 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=YZWTGTZf c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=A6NoEq-eS5wqql1_UWMA:9 a=QEXdDO2ut3YA:10
Message-ID: <190EC44928954138B9E9E78BA2323639@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>,
        "Dannier Castro L" <danniercl@gmail.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Matthieu Moy" <Matthieu.Moy@imag.fr>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Brandon Williams" <bmwill@google.com>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com> <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com> <775fe020-be92-f65c-5a67-e83e6bf4777f@gmail.com>
Subject: Re: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
Date:   Mon, 14 May 2018 00:06:56 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180513-4, 13/05/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfKSf9eyUHyXzzxjjYlVvCkJnV6J/ZDLgBaT0MW3nnT2GnZI8Al7PIaICaSTdWnJfD3zd8PGd7OdBBYW84VK16/p+t78gdpjINXkhvEoxpaFFKuUObITo
 qKhGlq2mviycj9s9xpFqKRNKKqlTub6zR0tFv3c7oRzqwdBBiWdyrg0/65KqwyEd7U9o9tEibUcJLYr2ftFP41dly4KvSkxnXf7O1qUd5U2d0ur9HG6DRG78
 Gl9aZcb6o1h1TqcQWyCjXpS5R9D8RH8Uj7xvMbQ9BBT81C4A+OL8knEITkwLHBtpQgnDbElBtFkGzPhzIXuRVLJOSHl9PjhOQvj8YbBfMjc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Dannier Castro L" <danniercl@gmail.com>
> On 13/05/2018 00:03, Duy Nguyen wrote:
>
>> On Sun, May 13, 2018 at 4:23 AM, Dannier Castro L <danniercl@gmail.com>
>> wrote:
>>> For GIT new users, this complicated versatility of <checkout> could
>>> be very confused, also considering that actually the flag '--' is
>>> completely useless (added or not, there is not any difference for
>>> this command), when the same program messages promote the use of
>>> this flag.
>> I would like an option to revert back to current behavior. I'm not a
>> new user. I know what I'm doing. Please don't make me type more.
>>
>> And '--" is not completely useless. If you have <file> and <branch>
>> with the same name, you have to give "--" to to tell git what the
>> first argument means.
>
> Sure Duy, you're right, probably "completely useless" is not the correct
> definition, even according with the code I didn't find another useful
> case that is not file and branch with the same name. The program is able
> to know the type using only the name, turning "--" into an extra flag in
> most of cases.
>
> I think this solution could please you more: By default the configuration
> is the current, but the user has the chance to set this, for example:
>
> git config --global flag.strictdashdash true
>
> Thank you so much for the spent time reviewing the patch, this is my
> first one in this repository.

It maybe that after review you could suggest an appropriate rewording or
re-arrangement of the man page to better highlight the proper use of the
'--' disambiguation.

Perhaps frame the man page as if it is normal for the '--' to be included
within command lines (which should be the case for scripts anyway!).

Then indicate that it isn't mandatory if the file/branch/dwim distinction is
obvious. i.e. make sure that the man page is educational as well as being a
reference that may be misunderstood.

Those well versed in the Git cli will normally omit the '--', only using it
where necessary, however for a new users/readers of the man page, it may be
better to be more explicit and avoid future misunderstandings.

--
Philip

