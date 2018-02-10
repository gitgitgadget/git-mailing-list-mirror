Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0385D1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBJK3m (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 05:29:42 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53045 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeBJK3m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 05:29:42 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id kSPcedJkTQS2UkSPcejoNh; Sat, 10 Feb 2018 10:29:40 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=WbR8UwpX c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=fGO4tVQLAAAA:8 a=yMhMjlubAAAA:8 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8
 a=RjlvyoGj4PKBH3jMlusA:9 a=QEXdDO2ut3YA:10
Message-ID: <BD73CAACE3734EE89EE1CFBE1DC55FEC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <noloader@gmail.com>, "Git List" <git@vger.kernel.org>
References: <CAH8yC8nodewYm-J3ye5Lnq-Zf9JziejL8L3TxTEwVoq8hD--HA@mail.gmail.com>
Subject: Re: Crash when clone includes magic filenames on Windows
Date:   Sat, 10 Feb 2018 10:29:40 -0000
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
X-Antivirus: AVG (VPS 180209-2, 09/02/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfNrJJY0tvMx0YUt9M7g+/wIji6JPZy2cLqDI/TAiVpGH/hpPfZzE6ibmKhMgheMrQ9xchqwD2OJy/hv4/mpJyBa3fE3seHFEh1kOl4MyjiHE91GkHI10
 paGJJdRNFoxMpVK4R4pUpGiSl++RzwGBxz1SyagAIJzNOkA7w/BssAbrNZ3M9JYayeMQ7zCnpbvYoyS689O2ARWEFije104LZGw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeffrey Walton" <noloader@gmail.com>
> Hi Everyone,
>
> I'm seeing this issue on Windows: https://pastebin.com/YfB25E4T . It
> seems the filename AUX is the culprit. Also see
> https://blogs.msdn.microsoft.com/oldnewthing/20031022-00/?p=42073 .
> (Thanks to Milleneumbug on Stack Overflow).
>
> I did not name the file, someone else did. I doubt the filename will be 
> changed.
>
> Searching is not turning up much information:
> https://www.google.com/search?q=git+"magic+filenames"+windows
>
> Does anyone know how to sidestep the issue on Windows?
>
> Jeff
>
This comes up on the Git-for-Windows (GfW) issues fairly often 
https://github.com/git-for-windows/git/issues.

The fetch part of the clone is sucessful, but the final checkout step fails 
when the AUX (or any other prohibited filename - that's proper cabkward 
compatibility for you) is to be checked out then the file system (FS) 
refuses and the checkout 'fails. You do however have the full repo locally.

The trick is probably then to set up a sparse checkout so the AUX is never 
included on the FS.

However it is an open 'up-for-grabs' project to add such a check in GfW.

Philip 

