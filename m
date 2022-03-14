Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3856C4332F
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiCNL6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiCNL5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 07:57:43 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4CE4830C
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 04:56:22 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nTjJE-0000us-8h;
        Mon, 14 Mar 2022 11:56:21 +0000
Message-ID: <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email>
Date:   Mon, 14 Mar 2022 11:56:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Dealing with corporate email recycling
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Sean Allred <allred.sean@gmail.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org, sallred@epic.com,
        grmason@epic.com, sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>
 <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email> <87ilsha2b7.fsf@gmail.com>
 <xmqqtuc1tpdj.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqtuc1tpdj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2022 23:16, Junio C Hamano wrote:
> Sean Allred <allred.sean@gmail.com> writes:
>
>> rather than use magic comments :-) Adapting to your suggestion, this
>> might look like the following:
>>
>>     A. U. Thor <foo@example.com> <ada.example.com> <[ approxidate ]>
> You'd probably want a timerange (valid-from and valid-to), instead
> of one single timestamp?
I'm not so sure that the date range approach won't bring it's own
problems. What happens outside the date range? i.e. Do we then have
three identities: Before, During, and After, with only 'During' being
defined?

I more see a single date being used as a termination point for an
existing email sequence that defines a retrospective end point for the
mapping of the old email addresses to a single person. Future emails for
the same mailbox will be for a different 'current' person. This would
match the single linked list commit history view using the chronology
heuristic.

The key here being to have a final identity system in place so that you
can uniquely identify the old John Doe, from the newer John Doe`s at the
relevant time point in the mailmap.

>
> Because at least three valid forms of mailmap entries should be
> understood by the current generation of mailmap readers, i.e.
>
>     Human Readable Name <e-mail@add.re.ss>
>     Right Name <right@add.re.ss> <wrong@add.re.ss>
>     Right Name <right@add.re.ss> Wrong Name <wrong@add.re.ss>
>
> the extended entry format to record the validity timerange should
> be chosen to cause parsers that are prepared to take these three
> kinds of lines to barf and ignore.
The presence of a _sequence_ of name/email changes isn't well defined.
As I remember it we take the name/email updates in sequence and then
apply a last one wins approach. It's not clear what would be done when
we have two, or three different John Doe sequences all mixed in.


A broader issue for the corporate email mailbox systems is those that
are allocated to roles. So you may have Traning1@corp.com thru
Training9@corp.com (we had) and if that training includes practical low
hanging fruit examples from a project, it's difficult to disambiguate
those commits. More likely is say, having TestPC1 - TestPC9 that
included debug commits, perhaps even with pair programming test & debug
sessions, so allocation to individuals (rather than mailbox) becomes a
real problem. Hopefully that's rare in Sean's case.

Philip



 
