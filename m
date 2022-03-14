Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A41C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 22:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiCNW0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbiCNW0h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 18:26:37 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BA3DA73
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 15:25:24 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nTt7y-000Bw9-DR;
        Mon, 14 Mar 2022 22:25:22 +0000
Message-ID: <e49830fb-aef1-6848-4101-60cbb66704f6@iee.email>
Date:   Mon, 14 Mar 2022 22:25:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Dealing with corporate email recycling
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean Allred <allred.sean@gmail.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>
 <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email> <87ilsha2b7.fsf@gmail.com>
 <xmqqtuc1tpdj.fsf@gitster.g> <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email>
 <xmqq1qz4p6qn.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq1qz4p6qn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2022 21:24, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 13/03/2022 23:16, Junio C Hamano wrote:
>>> Sean Allred <allred.sean@gmail.com> writes:
>>>
>>>> rather than use magic comments :-) Adapting to your suggestion, this
>>>> might look like the following:
>>>>
>>>>     A. U. Thor <foo@example.com> <ada.example.com> <[ approxidate ]>
>>> You'd probably want a timerange (valid-from and valid-to), instead
>>> of one single timestamp?
>> I'm not so sure that the date range approach won't bring it's own
>> problems. What happens outside the date range? i.e. Do we then have
>> three identities: Before, During, and After, with only 'During' being
>> defined?
> I have been assuming that the default is "what the commit has is
> correct".
That default is only true when there are no date limitations because of
email re-use. i.e. singleton persons with unique emails do fit that
default, which should be the majority.

If an old email has been reused, then that default becomes false, which
was Sean's starting point. In the corporate case, two (or more) distinct
individuals have used the same commit|author email address, and the hope
is, for a way of providing a disambiguation of those persons, based on
their email and the commit date.

>
>> I more see a single date being used as a termination point for an
>> existing email sequence that defines a retrospective end point for the
>> mapping of the old email addresses to a single person.
> Implicitly specifying the valid-from date (which is either the
> beginning of time, or the newest of valid-until time for the same
> identifying string that is older than the valid-until date for the
> entry in question) is fine.  I do not see fundamental difference
> between the approach you suggest and having an explicit valid-from
> date.
With the first case we guarantee that we have named cover for all of the
chronology via bisection, while the trisection can leave gaps without
any allocation to a person,  or possibly overlaps.

A more convoluted case would be where three persons share the same
emails in a rollover fashion, so the mailmap's simple name/email
handover becomes knotted and intertwined in the handovers
(Joe3->Joe2->Joe1).

P.



