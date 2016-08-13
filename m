Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31341F859
	for <e@80x24.org>; Sat, 13 Aug 2016 00:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbcHMAI0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 20:08:26 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:4920 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbcHMAI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 20:08:26 -0400
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YMUwbWi6kY8RwYMUwbsclK; Sat, 13 Aug 2016 01:08:23 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VwiX1yt0AAAA:8 a=Up7x3JJXXO5eKBmt9UEA:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22 a=AjGcO6oz07-iQ99wixmX:22
 a=iG_63O-Bpzwuoh8g-5IN:22
Message-ID: <F3BA479B58944083A62896E2F0504D48@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>,
	"Ralf Thielow" <ralf.thielow@gmail.com>
Cc:	<git@vger.kernel.org>, <larsxschneider@gmail.com>, <me@jnm2.com>
References: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com><20160812201011.20233-1-ralf.thielow@gmail.com><xmqqk2flvfhb.fsf@gitster.mtv.corp.google.com> <xmqq1t1tvbu8.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] help: make option --help open man pages only for Git commands
Date:	Sat, 13 Aug 2016 01:08:22 +0100
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
X-CMAE-Envelope: MS4wfEF6Y9WG2uhLWmfz45gyCA0N5O6w24k+jcVud8tzL+zd7O9E/V+DwdeUAcV4k2QOaV00rYkAAXUZTdmFJI2/qkH9FUyIxiCLkqpRN6UQ5Kq/XkQ5rJoH
 ZCJOAemA3R6WlB7ZOqZO25MT2kbTROppi6VocJ1w4b6jPrtO8MJazEzHD6aXNuhNNv86QFzaKhm38MODs2X+c9w+UX72a0iQ1rHZwectXK4jnTkNPC4bbYk3
 SyLz++0D2cFAtEl2LjV660Ekp1CpySGKcudfpiCBNoX3za/v7F3ShqlwEM9d6b6A
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
To: "Ralf Thielow" <ralf.thielow@gmail.com>
Cc: <git@vger.kernel.org>; <larsxschneider@gmail.com>; <me@jnm2.com>
Sent: Friday, August 12, 2016 11:53 PM
Subject: Re: [PATCH] help: make option --help open man pages only for Git 
commands


> Junio C Hamano <gitster@pobox.com> writes:
>
>> I love it when I say "This shouldn't be too hard; somebody may want
>> to do a patch", with just a vague implemention idea in my head, and
>> a patch magically appears with even a better design than I had in
>> mind when I said it [*1*] ;-)
>
> Having said that, I wonder if we could do a bit better.
>
>    $ git -c help.autocorrect=1 whatchange --help
>    WARNING: You called a Git command named 'whatchange', which does not 
> exist.
>    Continuing under the assumption that you meant 'whatchanged'
>    in 0.1 seconds automatically...
>    No manual entry for gitwhatchange
>
> We are guessing that the user meant "whatchanged"; shouldn't we be
> able to feed the corrected name of the command to the machinery to
> drive the manpage viewer?
>
But does it cope with the Guides? Should it cope if spelt that way?

git help revisions
git revisions --help

?

I suspect that the former should work, but not the latter, as a reasonable 
approach. I just haven't checked.

The other moderately low hanging fruit is to do the (full) list of guides as 
part of 'help'.

Philip 

