Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3571F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeAUXnZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:43:25 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:46105 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeAUXnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 18:43:24 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id dPGkeZbJuAp17dPGkeEmbz; Sun, 21 Jan 2018 23:43:23 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=ygf_6dXbhdRqZs6t8UQA:9 a=QEXdDO2ut3YA:10
Message-ID: <0A3A0675F3984789908D19A7A39235D5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "John Cheng" <johnlicheng@gmail.com>, <git@vger.kernel.org>
References: <CAJzZBAQuOqwRmBLOdUEVMY74_xT2dWe3a+9qT9ufc4bp8gjgig@mail.gmail.com>
Subject: Re: cygwin git and golang: how @{u} is handled
Date:   Sun, 21 Jan 2018 23:43:24 -0000
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
X-Antivirus: AVG (VPS 180120-0, 20/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfP4Br/BxwmtPo6YB6K1vEwjTivsOvgNxi/NBvei/tfQnn27QyJoeYaCxHu1RPMMDjtH6hTWyjCEDV0p3uiPwTL9WczgMHOtP5TGq1PYR97SJAYuPglxh
 P8sP14bktvWppw4kytkZFRVgQEzpuk4TZdRAIzd5xSQZakotSpFyOzMVBU0Lw9eDRFZuOKoz0zpDhRK8jeswmXSiZRBdjgtkVg8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "John Cheng" <johnlicheng@gmail.com>
>I am experiencing a strange behavior and I'm not certain if it is a
> problem with golang or the cygwin version of git.
>
> Steps to reproduce:
> Use golang's os/exec library to execute
> exec.Command(os.Args[1],"log","@{u}") // where os.Args[1] is either
> cygwin git or Windows git
>
> Expected result:
> commit 09357db3a29909c3498143b0d06989e00f5e2442
> Author: John Cheng <johnlicheng@gmail.com>
> Date:   Sun Jan 14 10:57:01 2018 -0800
> ...
>
> Actual result:
> Suppose that cygwin git is specified, the result becomes:
> exit status 128 fatal: ambiguous argument '@u': unknown revision or
> path not in the working tree.
>
> Version:
> git version 2.15.1.windows.2
> git version 2.15.1
>
> I'm not certain if this is a git problem, as I could not reproduce
> this problem using python to script cygwin git.
>
> A list of scenarios I've tested are
> 1. golang + cygwin git = "exit code 128"
> 2. golang + windows git = "exit code 0"
> 3. python + cygwin git = "exit code 0"
> 4. python + windows git = "exit code 0"
>
> I've tried to write a simple program to echo the command line
> parameters passed by go into the process it executes - and it appears
> that go itself does not change "@{u}" into "@u". I'm a bit stuck at
> point to figure out which may be the cause: golang or git. I figured
> I'd start here.
>
There is a similar problem a user is experiencing on Git-for-Windows, that 
we/the user haven't got to the bottom of, but it appears to have a similar 
form where the braces appear to be is some form parsed twice (though thats 
still a guess / hypothesis).

"Aliases in git are stripping curly-brackets (#1220)" 
https://github.com/git-for-windows/git/issues/1220#issuecomment-340341336



Philip

