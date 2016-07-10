Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46162018E
	for <e@80x24.org>; Sun, 10 Jul 2016 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbcGJVR7 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 17:17:59 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:46932 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215AbcGJVR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 17:17:58 -0400
Received: from PhilipOakley ([92.22.19.161])
	by smtp.talktalk.net with SMTP
	id MM6sblgC5cpskMM6sbjAed; Sun, 10 Jul 2016 22:17:55 +0100
X-Originating-IP: [92.22.19.161]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=N0qRY0xy2VMmJNirM7OQXw==:117
 a=N0qRY0xy2VMmJNirM7OQXw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=8pif782wAAAA:8 a=lblLghs1IiH5hmB1EDIA:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=0rJpSBR2IEkCROgwrX0h:22
Message-ID: <A584078D859245AABA92ADC75B82A77A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
References: <20160625164654.5192-1-philipoakley@iee.org><20160630202509.4472-1-philipoakley@iee.org><20160630202509.4472-5-philipoakley@iee.org><xmqqk2h5vz2m.fsf@gitster.mtv.corp.google.com><38FAE374CD2D44EC9C86167F98953271@PhilipOakley><CAPc5daW_Kf8UG2zm4vBS9f4tN+bXusdZQkcwnssNs+gdk8J75w@mail.gmail.com> <xmqqziq1ufmk.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2 4/4] doc: clarify that `^r1` will exclude `r1` itself
Date:	Sun, 10 Jul 2016 22:17:56 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNeAviRiLFAkY4fB6yJhM3ifqPPgLGvS/sH+oBktPRqUqhtuderKACojBmg4Z7SNSHjDCJ+T1CblUt+cfUbDZIyChYptcDzc+s2U/U2Lo9gADDmlBFVe
 6wZT7Hgu9mO5e6kTVkPPS74pCqDDo+bMnjIbIZQ0VkLq3x00n/nxwL+1oG9IVvwrldXney5uf0Cj865jZ1Y2NWLox9IJE65XoeKMn7mlXJtJeI3CuP5CvlZJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com> : Saturday, July 02, 2016 12:01 
AM
> Junio C Hamano <gitster@pobox.com> writes:
>
>> On Fri, Jul 1, 2016 at 3:08 PM, Philip Oakley <philipoakley@iee.org> 
>> wrote:
>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>  To exclude commits reachable from a commit, a prefix '{caret}'
>>>>>  notation is used.  E.g. '{caret}r1 r2' means commits reachable
>>>>> -from 'r2' but exclude the ones reachable from 'r1'.
>>>>> +from 'r2' but exclude 'r1' and those reachable from 'r1'.
Hi Junio
Sorry for the delay in response, I'd been away and had some catch up to do.

I think we may have dropped into a YXproblem.

My particular concern was the literary conflict between the implicit 
'inclusive' aspects and the explicit 'exclusive' parts of the descriptions, 
a sort of barber shaving problem [1], especially when used in conjunction 
with the negation.

It's the potential for reader confusion at that point (particularly for a 
string of pearls case) I was trying to address. However, you are right that 
'reachable' also isn't as well defined as it might be.

For example, in a DAG, we should have no cycles where directed edges lead 
can back to their start point, yet (for reachability discussions) we want to 
imply an extra loopback edge, all of which is part of the sloppiness of 
natural languages.

This potential for confusion is further shown in the summary where both 
<rev> and ^<rev> say "(i.e. ancestors of)"!

In summary, I think that both the definition of reachability needs 
clarifying, and that c0ffee..deadbeef excludes any serving of c0ffee, even 
for a line of pearls, should be covered.

>>>>
>>>> Well, if you have to spell that out, you'd want to spell out r2 side
>>>> too, no?  That is,
>>>
>>> The clarification wasn't about what "reachable" means but about 
>>> inclusivity,
>>> such as whether 0..4 would give 0,1,2,3,4 or would be 'off by one' and 
>>> only
>>> give 1,2,3,4. And in this case it's the latter.
>>
>> Well, you have the same inclusivity issue on the opposite end, no? Is 
>> 0..4
>> a range with 0,1,2,3,4? 0,1,2,3? 1,2,3,4? or 1,2,3?

In most natural language we have 0:4 is 0,1,2,3,4 so the exclusion of 0 
would be the one to note.

>>
>>> Describing 'reachability' is a whole different kettle of fish, as you
>>> highlight below, and would be separate from this patch.
see below.

>>
>> I am not sure I agree. It all is about "is the endpoint included or 
>> not?".
>
> This did not come out as illustrating as I hoped.  Let's put it
> differently.
>
> I think this is all about how "reachable" is defined.  "Am I an
> ancestor of myself?" is the question.

I don't think that just clarifying "reachability" would be sufficient. 
Necessary yes, sufficient no.

>
> If "all commits reachable from r1" includes 'r1', then, it is clear
> that "... but exclude those reachable from 'r1'" means 'r1' is not
> part of the resulting set.
>
> If I were not an ancestor of me, on the other hand, "... but exclude
> those who are ancestors of 'r1'" would not exclude 'r1'.  If 'r1' is
> reachable from 'r2', then 'r1' would be in the resulting set.
>
> The same thing happens at the opposite end of the "range".  If I am
> an ancestor of me, then "all commits reachable from 'r2'" does
> inculde 'r2'; if I am not an ancestor of me, 'r2' is not part of the
> resulting set.
>

> Note.
> I said "range" in quotes, because this is not like
> drawing a straight line and placing two points to denote the
> lower and the upper bounds of the "range".  What Git does is
> a set operation, "r2 ^r1" excludes what is reachable from r1
>        from the set of commits that are reachable from r2.

The understanding of this "Y" branching "range" is the part that was the 
'whole new kettle of fish' for me, especially with the rtbs, that caught me 
out during early contributions.


>
> By choosing the definition of "reachable" consistently, 0..4 can
> mean either 1,2,3,4 (I am reachable from myself) or 0,1,2,3 (I can
> not be reached by me), and in order to clarify that we give 1,2,3,4
> and not 0,1,2,3, we still need to clearly define what "reachable"
> means.

I'll re-think the patch (4/4) to cover thse issue.

>
> But any other interpretation, e.g. 0,1,2,3,4, is incoherent.
> --
Philip

[1] https://en.wikipedia.org/wiki/Barber_paradox 

