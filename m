Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F141F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeKLDuM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Nov 2018 22:50:12 -0500
Received: from mail118c25.carrierzone.com ([64.29.147.188]:39965 "EHLO
        mail83c25.carrierzone.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729274AbeKLDuM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Nov 2018 22:50:12 -0500
X-Authenticated-User: federico@speakeasy.net
Received: from [10.201.178.19] (mobile-107-107-59-118.mycingular.net [107.107.59.118])
        (authenticated bits=0)
        by mail83c25.carrierzone.com (8.14.9/8.13.1) with ESMTP id wABI0vK3016533;
        Sun, 11 Nov 2018 18:00:58 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: BUG REPORT: git clone of non-existent repository results in request for credentials
From:   Federico Lucifredi <flucifredi@acm.org>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <87y39z3ea8.fsf@evledraar.gmail.com>
Date:   Sun, 11 Nov 2018 13:00:56 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C44E4FCB-D968-43E6-82CC-7D2F73D461C7@acm.org>
References: <708E1759-B2E3-436C-9D54-214159655B1B@acm.org> <87y39z3ea8.fsf@evledraar.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-CSC:  0
X-CHA:  v=2.3 cv=HLbt6Llv c=1 sm=1 tr=0 a=LNSZ+IFO4fyWyOuoxMsISQ==:117
        a=LNSZ+IFO4fyWyOuoxMsISQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
        a=FYT53FELAAAA:20 a=TXhh1AoAAAAA:20 a=9R0tsZj6x_0fnnFuSdYA:9
        a=QEXdDO2ut3YA:10
X-CTCH-RefID: str=0001.0A090206.5BE86E5B.003E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was afraid that was the reason. Oh well, at least we know why :-)

Thanks Ævar!

Best-F

> On Nov 11, 2018, at 9:00 AM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> 
>> On Sun, Nov 11 2018, Federico Lucifredi wrote:
>> 
>> git clone of non-existent repository results in request for credentials
>> 
>> REPRODUCING:
>> sudo apt install git
>> git clone https://github.com/xorbit/LiFePo4owered-Pi.git    #this repo does not exist
>> 
>> Git will then prompt for username and password on Github.
>> 
>> I can see a valid data-leak concern (one could probe for private repository names in a brute-force fashion), but then again the UX impact is appalling. Chances of someone typing an invalid repo name are pretty high, and this error message has nothing to do with the actual error.
>> 
>> RESOLUTION:
>> The error message should indicate that the repository name does not exist.
> 
> This is a legitimate thing to complain about, but it has nothing to do
> with git itself maintained on this mailing list, but the response codes
> of specific git hosting websites. E.g. here's two issues for fixing this
> on GitLab:
> 
> https://gitlab.com/gitlab-org/gitlab-ce/issues/50201
> https://gitlab.com/gitlab-org/gitlab-ce/issues/50660
> 
> These hosting platforms are intentionally producing bad error messages
> to not leak information, as you note.
> 
> So I doubt it's something they'll ever change, the bug I have open with
> this on GitLab is to make this configurable for privately run instances.
> 

