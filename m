Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB34620899
	for <e@80x24.org>; Sun, 30 Jul 2017 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbdG3P51 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 11:57:27 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:36374 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753963AbdG3P51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 11:57:27 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id bqard3eK6iSHabqardv2ym; Sun, 30 Jul 2017 16:57:26 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=LtVNH8unAAAA:8 a=uPZiAMpXAAAA:8 a=NEAV23lmAAAA:8 a=Eg-pCkOYQ3Wi1Bdemk8A:9
 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=AueyrETzaJnuU_qMmc6C:22
Message-ID: <9C6ADE7816804DDDB398A5D64920FEA0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "John Szakmeister" <john@szakmeister.net>
Cc:     <git@vger.kernel.org>
References: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>        <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley>        <CAEBDL5X3wr=4A+W_sQzSE9BazoxoS2bwcOBZV5Jw=WCWZHAi6A@mail.gmail.com>        <xmqq4lu1ej0d.fsf@gitster.mtv.corp.google.com>        <CAEBDL5U=pcqwzeQstiBBJpXngXeB4xTfKb7mos68kRAeumc5Rg@mail.gmail.com> <xmqqd18lolnm.fsf@gitster.mtv.corp.google.com>
Subject: Re: Expected behavior of "git check-ignore"...
Date:   Sun, 30 Jul 2017 16:57:26 +0100
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
X-Antivirus: AVG (VPS 170730-2, 30/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfLDHF5KW4Xa3+6CPxICikkDUdXOFhuxfXRtHGzU2j9n/O0TWBWmnJq8FWsAKwj2fFSTbWMfvVPuaPRie+47Jq7S6r2PLKFaIVuBkJz1zHvXbcrIO+8DZ
 GLXH/oVGqWUgzf5dx4DMm3Sl2Hien9w+TzSFyiB//nlkXxg3Z2mImhuldC7eXJMEpqwgVn3wjfWi713SaGKncuaPDvPQFSIYQiXhhu4f+IPGe5667yv806sk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, July 27, 2017 6:05 PM
> John Szakmeister <john@szakmeister.net> writes:
>
>> On Mon, Jul 24, 2017 at 3:23 PM, Junio C Hamano <gitster@pobox.com> 
>> wrote:
>> [snip]
>>> I am reasonably sure that the command started its life as a pure
>>> debugging aid.
>>>
>>> The treatment of the negation _might_ impose conflicting goals to
>>> its purpose as a debugging aid---a user who debugs his .gitignore
>>> file would want to know what causes a thing that wants to be ignored
>>> is not or vice versa, and use of the exit status to indicate if it
>>> is ignored may not mesh well with its goal as a debugging aid, but I
>>> didn't think about the potential issues deeply myself while writing
>>> this response.  As you mentioned, use of (or not using) "-v" could
>>> be used as a sign to see which behaviour the end-user expects, I
>>> guess.
>>
>> Is there another way of checking to see if a file is ignored?  If so,...
>
> Maybe I sounded like waffling, but I do think "check-ignore" when
> used as an end-user tool should be that command, to get a preview of
> what would happen if you gave the path to "git add".
>
> I was merely giving a possible explanation why it may not behave
> like so in the current code, i.e. those who used it for debugging
> their .gitignore files may have felt that the current way to handle
> negation were more convenient during their debugging session.
>
> But I think there is a way out to satisfy both groups of people.
>
> What if we (re)define that "-v" is a way to ask "which entry, if
> any, decides the final fate of this path?" question, and that is a
> sign that the user is using it to debug their .gitignore?  And we
> use the exit status to mean "Yeah, there is an explicit entry that
> decides the fate of the path" in that case, which is what the
> current behaviour seems to be---the command exits with non-zero
> status only when there is nothing that matches in the exclude
> mechanism (which makes the final fate of the path to be 'not
> ignored').
>
> And we interpret the lack of "-v" as a signal that the user wants to
> learn the fate of a given path via the exit status of the command,
> which will "fix" the exit code to match the expectation in your
> initial message in this thread.
>
> Would that work well?

The old answer on StackOverflow 
https://stackoverflow.com/questions/12144633/which-gitignore-rule-is-ignoring-my-file 
has some of the older gory detail.

I also see that one of the changes was reverted (Revert "Merge branch 
'nd/exclusion-regression-fix', 5cee3493, 18 Mar 2016 
https://github.com/git/git/commit/5cee349370bd2dce48d0d653ab4ce99bb79a3415#diff-b9ad88b4882e66b5be4541046b713b51). 
It doesn't look like any follow up happened to the check-ignore docs.

To me, the return status for the plain vanilla case should always work 
correctly. So that is, given one path, using the current index, we know if 
it is, or is not, ignored.

The verbose output for debugging should be able to be varied at will (e.g. 
re-inclusion can show all operative lines in the debug output). It shouldn't 
be a backward compatibility issue.

Maybe that, verbosely, for each path given, the summary status is also given 
now that re-inclusion should be possible, which would not have been required 
before.
--
Philip 

