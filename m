Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D771FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 12:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbcLEMIM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 07:08:12 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:28222 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbcLEMHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 07:07:14 -0500
Received: from PhilipOakley ([92.22.48.207])
        by smtp.talktalk.net with SMTP
        id Ds34clCjvcpskDs34cWeC4; Mon, 05 Dec 2016 12:07:11 +0000
X-Originating-IP: [92.22.48.207]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=zjj91M/Ls5+HWIZCq2s4eQ==:117
 a=zjj91M/Ls5+HWIZCq2s4eQ==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=Noiq74YA7fICtkz-jc4A:9 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <4F8F730766044D0DB6CF89DDC579F36D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Git mailing list" <git@vger.kernel.org>
References: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0> <49DE271A91214D6DADBD4DE667A1659B@PhilipOakley> <20161205071822.ndeswelgj5epej5k@sigill.intra.peff.net>
Subject: Re: Git v2.11.0 breaks max depth nested alternates
Date:   Mon, 5 Dec 2016 12:07:10 -0000
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
X-CMAE-Envelope: MS4wfHn4oE5Cq5Pj9uSQPueA29uadW/3xhMKqLtt31JuvDjxpP3SAWDa89KKSAH48b/VOgrlFTRbhtptJGz21qPrKxQk0Rp6/Vfnw7BHftSwAcQuUAWnLwM9
 SR0Cb30leRnFvagfPH1D4mMsR6nV29DQHDdPgQhmsbmX8i47Uf4vKz+AdffZgLtKWfWuvSW9pbawziBId/gBPKTjdWsvDZVZJiMIUNl2GqJBGtRpnudsIbrX
 ToXNCobFyAyTGEm+HoCF0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Sun, Dec 04, 2016 at 11:22:52AM -0000, Philip Oakley wrote:
>
>> > Ever since 722ff7f876 (receive-pack: quarantine objects until
>> > pre-receive accepts, 2016-10-03, v2.11.0), Git has been quarantining
>> > objects and packs received during an incoming push into a separate
>> > objects directory and using the alternates mechanism to make them
>> > available until they are either accepted and moved into the main
>> > objects directory or rejected and discarded.
>>
>> Is there a step here that after the accepted/rejected stage, it should 
>> then
>> decrement the limit back to its original value. The problem description
>> suggests that might be the case.
>
> No. I thought that at first, too, but this increment happens in the
> sub-process which is using the extra level of alternates for its entire
> lifetime. So it "resets" it by exiting, and the parent process never
> increments its internal value at all.
>
Thanks for the clarification.
--
Philip 

