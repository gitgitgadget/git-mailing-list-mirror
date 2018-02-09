Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053F71F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbeBIWoO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:44:14 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5307 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBIWoO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:44:14 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id kHOuecedDQS2UkHOuejfZj; Fri, 09 Feb 2018 22:44:12 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=WbR8UwpX c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=CEtC_dnCAAAA:8
 a=uPZiAMpXAAAA:8 a=_ck9QOsXO3iGXedCoEsA:9 a=wPNLvfGTeEIA:10
 a=Fr9QGtSrJqje8MTI1nyQ:22
Message-ID: <7135CFE5288C49EEA02785C1F407B46D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     "Git Mailing list" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41> <9803DEA99A6545F7A3F9A3CE08FE2263@PhilipOakley> <alpine.LFD.2.21.1802091553290.17104@localhost.localdomain>
Subject: Re: "git bisect run make" adequate to locate first unbuildable commit?
Date:   Fri, 9 Feb 2018 22:44:12 -0000
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
X-Antivirus: AVG (VPS 180209-2, 09/02/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBQvwvlJ1+LIvYThhAEaLW5CjWYt3fHDUspmCzzWVqWnBbTttXFgalWQ9nUw08TRKlTT6UoV35PvjvRAs49HemtKEjr3qp9ZRpHGqu7mi93cSTU0EgwF
 iDf8s/HXqW0VkFakEPIJYeClkp96j+7AJ0CACPpp6LzjPSa9EVPiZYeRtUZEyPANTeCtWrvgP+3fTETRsloEMCO+iYdbcwOIKIc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert P. J. Day" <rpjday@crashcourse.ca>
> On Fri, 9 Feb 2018, Philip Oakley, CEng MIET wrote:
(apologies for using the fancy letters after the name ID...)
>
>> From: "Robert P. J. Day" <rpjday@crashcourse.ca>
>> >
>> > writing a short tutorial on "git bisect" and, all the details of
>> > special exit code 125 aside, if one wanted to locate the first
>> > unbuildable commit, would it be sufficient to just run?
>> >
>> >  $ git bisect run make
>> >
>> > as i read it, make returns either 0, 1 or 2 so there doesn't appear
>> > to be any possibility of weirdness with clashing with a 125 exit code.
>> > am i overlooking some subtle detail here i should be aware of? thanks.
>> >
>> > rday
>>
>> In the spirit of pedanticism, one should also clarify the word
>> "first", in that it's not a linear search for _an_ unbuildable
>> commit, but that one is looking for the transition between an
>> unbroken sequence of unbuildable commits, which transitions to
>> buildable commits, and its the transition that is sought. (there
>> could be many random unbuildable commits within a sequence in some
>> folks' processes!)
>
>  quite so, i should have been more precise.
>
> rday

The other two things that may be happening (in the wider bisect discussion) 
that I've heard of are:
1. there may be feature branches that bypass the known good starting commit, 
which can cause understanding issues as those side branches that predate the 
start point are also considered potential bu commits.
2. if you just want the first parent check for the bad commit point, that 
mark the second parents of merges as being good.

Also, I'd expect that the skipped commits aren't 'counted' (too hard?) for 
the bisect algorithm's reporting.

https://stackoverflow.com/questions/5638211/how-do-you-get-git-bisect-to-ignore-merged-branches 
contains a number of the ideas..

Philip

