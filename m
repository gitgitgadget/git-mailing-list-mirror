Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336DC20281
	for <e@80x24.org>; Tue, 23 May 2017 23:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030848AbdEWXY5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 19:24:57 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:57911 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966651AbdEWXY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 19:24:56 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id DJAcdfp7LgKstDJAcdtrIz; Wed, 24 May 2017 00:24:55 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=NEAV23lmAAAA:8 a=B6uEKOEFvkZkFpfEu_AA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?F=C3=A9lix_Saparelli?= <felix@passcod.name>
Cc:     <git@vger.kernel.org>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com> <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
Date:   Wed, 24 May 2017 00:24:52 +0100
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
X-CMAE-Envelope: MS4wfAcwfn7ASzYCG/doNKRwQhHRWDa8stJpd6UC/5WVHTIulQ/jghNgGOyptXwqfqwk8zwTLFx+NlYEr6BjiwKxY7uBomPJLzFHvP+nXMxsh9BL//7svahk
 vpRgPPtaYMe66v5rZUx2aEyBYmUvbvf7IU9SGGi86ZUxJoYMMzxwHPRnFggKy5rV82AAgowutqdIDryBnDXWUt4Waw3DRjWET4S0Hg0Lwnz5E9xBtbiUobNB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Félix Saparelli <felix@passcod.name> writes:
>
>> I created a git repository that, for joke reasons, has a single branch
>> called MASTER (in uppercase). Upon cloning this repo, git attempts to
>> checkout the master branch (in lowercase), which does not exist.
>
> See what Git told you carefully and you can guess, I think.

guessing is rarely a good user experience ;-) however...
>
>> $ git clone git@github.com:passcod/UPPERCASE-NPM.git
>> Cloning into 'UPPERCASE-NPM'...
>> remote: Counting objects: 14, done.
>> remote: Compressing objects: 100% (11/11), done.
>> remote: Total 14 (delta 3), reused 14 (delta 3), pack-reused 0
>> Receiving objects: 100% (14/14), done.
>> Resolving deltas: 100% (3/3), done.
>> warning: remote HEAD refers to nonexistent ref, unable to checkout.

Perhaps here the warning message could include the value of the ref provided 
by the remote's HEAD which would then more clearly indicate to the user what 
was expected.

I haven't had chance to look at how easy that maybe in the code - perhaps a 
bit of low hanging fruit for someone?

>
> So you have MASTER but not master, but your HEAD still is pointing
> at non-existing master.  As HEAD is the way the remote tells the
> clone what the default branch to be checked out is, the command
> reports "we cannot do a checkout of the default branch."
>
--
Philip 

