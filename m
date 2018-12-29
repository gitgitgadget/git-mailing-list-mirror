Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A577A1F405
	for <e@80x24.org>; Sat, 29 Dec 2018 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeL2JOk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 29 Dec 2018 04:14:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40579 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbeL2JOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 04:14:40 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wBT9EVgj3238226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 29 Dec 2018 01:14:32 -0800
Date:   Sat, 29 Dec 2018 01:14:24 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqo995pvmc.fsf@gitster-ct.c.googlers.com>
References: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com> <20181227235526.GF146609@google.com> <xmqqo995pvmc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: RFE: version-controlled merge rules
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
CC:     git@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <0F05FF7B-14C7-46C5-A85C-4C571860E8CA@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 28, 2018 6:35:23 AM PST, Junio C Hamano <gitster@pobox.com> wrote:
>Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> The main issue I see is that this would make it a little *too* easy
>to
>> run arbitrary code on the user's machine.  Build systems often
>already
>> lead to that, but users are more familiar with the risks for build
>> than for version control.
>>
>> See [1] for some related discussion.
>>
>> That said, using the include.path feature (see git-config(1)), it's
>> possible to do something similar:
>>
>> 	[include]
>> 		path = ../.gitconfig
>>
>> Thanks and hope that helps,
>
>The issue the arrangement to specify what kind of files they are in
>the attribute system and to specify what exact commands to be run in
>the configuration addresses is twofold.  The security issue is one
>and poking a hole with include.path mechanism is probably OK as
>there is end-user consent, but I tend to agree that a similar risk
>already exists by a project shipping Makefile et al.
>
>There is the other side of the issue.
>
>The arrangement allows project not to be monoculture by leaving the
>exact command sequence to use on the kind of files (specified by the
>project with the attribute system) up to the end-user in their
>configuration.  While Peter may feel that sort piped to head may be
>available on all the reasonable UNIX systems, his merge driver would
>not work on other platforms.  There already is a similar reliance of
>monoculture by a project shipping Makefile et al, which is an
>interesting parallel.

This is actually a further good reason for doing it this way: it means that more genal drivers can be written using files in the repo, depending on what the baseline of the project is.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
