Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33ECC1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 22:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDKWGd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 18:06:33 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:33133 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbeDKWGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 18:06:32 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 6NsrfDvCRHCow6Nsrf6N8t; Wed, 11 Apr 2018 23:06:31 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8
 a=pGLkceISAAAA:8 a=LjjBTJ79kyfajMSPMiIA:9 a=QEXdDO2ut3YA:10
 a=jYKBPJSq9nmHKCndOPe9:22
Message-ID: <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Eric Sunshine" <sunshine@sunshineco.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Cc:     "Git List" <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Date:   Wed, 11 Apr 2018 23:06:30 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180411-6, 11/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfNjjSZwAVfwDKl3nxcxzHqW9ADXuN8st/2ev5aeVwTwoId/AIGTZUQ9vJzJXBeaVQ/jUQhbaNgwefXtp92YUjWkEboSXvYsiA1HrWUBxgcv36+6/MWEm
 OIfqAwr1Y3oPmi/xKtNwkif3tA71PjEM2il2zeP9xIkhFWxYqax2iehX8USNNWYAnmMswRUMDeelM9veK640t48wb32GC8+phlDa/ujaXwkMkOYjbQH24DsQ
 S0JanEA/C7DV3+oy9UoV+m6Cp7QpNLHmwipqlSjq3MQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric Sunshine" <sunshine@sunshineco.com> Monday, April 09, 2018 6:17 
AM
On Mon, Mar 26, 2018 at 12:55 PM, Nguyễn Thái Ngọc Duy
<pclouds@gmail.com> wrote:
> This is pretty rough but I'd like to see how people feel about this
> first.
>
> I notice we have two places for command classification. One in
> command-list.txt, one in __git_list_porcelain_commands() in
> git-completion.bash. People who are following nd/parseopt-completion
> probably know that I'm try to reduce duplication in this script as
> much as possible, this is another step towards that.
>
> By keeping all information of command-list.txt in git binary, we could
> provide the porcelain list to git-completion.bash via "git
> --list-cmds=porcelain", so we don't neeed a separate command
> classification in git-completion.bash anymore.

I like the direction this series is taking.

> Because we have all command synopsis as a side effect, we could
> now support "git help -a --verbose" which prints something like "git
> help", a command name and a description, but we could do it for _all_
> recognized commands. This could help people look for a command even if
> we don't provide "git appropos".

Nice idea, and you practically get this for free (aside from the the
obvious new code) since generate-cmdlist.sh already plucks the summary
for each command directly from Documentation/git-*.txt.

I'm only just catching up, but does/can this series also capture the 
non-command guides that are available in git so that the 'git help -g' can 
begin to list them all?

It was something I looked at some years ago (when I added the -g option) but 
at the time the idea of updating the command-list.txt was too invasive.

Just a thought.

Philip

