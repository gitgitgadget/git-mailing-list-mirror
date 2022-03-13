Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F242C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiCMA2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 19:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiCMA2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 19:28:06 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2298109A5D
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 16:26:59 -0800 (PST)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22D0QsJB083010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Mar 2022 19:26:54 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Sean Allred'" <allred.sean@gmail.com>
Cc:     <git@vger.kernel.org>, <sallred@epic.com>, <grmason@epic.com>,
        <sconrad@epic.com>
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
In-Reply-To: <xmqq4k42n2g8.fsf@gitster.g>
Subject: RE: Dealing with corporate email recycling
Date:   Sat, 12 Mar 2022 19:26:49 -0500
Organization: Nexbridge Inc.
Message-ID: <01cc01d83671$0acd4a20$2067de60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDHpNtgb5IcYOGFILwDPZIseKDDCgE3FbtSrtPefDA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 12, 2022 7:04 PM, Junio C Hamano wrote:
>To: Sean Allred <allred.sean@gmail.com>
>Cc: git@vger.kernel.org; sallred@epic.com; grmason@epic.com;
>sconrad@epic.com
>Subject: Re: Dealing with corporate email recycling
>
>Sean Allred <allred.sean@gmail.com> writes:
>
>> As a baseline, we know the following statements are true:
>>
>>   1. A person's preferred name can change at any time.
>>   2. A person's preferred email can change at any time.
>>   3. Neither of these pieces of information are necessarily
>>      identifying in a given codebase.
>
>Another thing we know is
>
>    4. People know that old e-mail addresses stay in archives and
>       address books of people, and find it wise to avoid reusing an
>       address somebody else (especially well-known ones) has been
>       using, so that they do not get e-mails from total strangers
>       and having to tell them that the intended recipient does not
>       read the mailbox anymore.
>
>>   1. Do nothing.  Leave it to the developer to determine the correct
>>      contact information without assistance.
>>
>>      This doesn't really resolve the confusion, but it is technically
>>      an option.
>>
>>   2. Use gitmailmap(5) functionality to resolve historical emails to
>>      primary emails.
>>
>>      Sadly this doesn't actually solve the email recycling problem.
>>      Since one email could be used by multiple developers, there's no
>>      way (that I can see) to use a single mailmap file to resolve one
>>      of these emails to a single person.
>
>
>GNU arch (tla) had an interesting idea around this area and used
combination of
>time and e-mail address to identify a person.
>one@corp--$date referred to the person who had control of the address on
the
>specified date, where $date can be abbreviated to
>2022 or 202201 to mean 20220101.
>
>The mailmap allows "Name e-mail" or "e-mail" to be mapped to canonical
"Name
>e-mail", but we should be able to coax "valid time range" information
encoded in
>each entry of the .mailmap format, i.e. "if you see 'Name e-mail' between
time X
>and Y, map that to...".

Is there anything we could do around the new signature infrastructure
relating to this? I am NOT a fan of SSH keys without passphrases, but what
if we could use the coaxing above and map to SSH expiring keys then stitch
in signatures (a.k.a. sign the commits) to correspond to the users in the
given timeframe - then destroy the private keys to prevent further signing.
After that the Name/email becomes somewhat irrelevant from an integrity
standpoint.

