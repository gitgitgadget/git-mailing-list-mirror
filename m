Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE541F453
	for <e@80x24.org>; Fri, 15 Feb 2019 22:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393155AbfBOWsm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 17:48:42 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:28629 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfBOWsm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 17:48:42 -0500
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id umHegACRk4EosumHegkoHY; Fri, 15 Feb 2019 22:48:39 +0000
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ff5JO626 c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=FpCV9O7Y0firqhz_s2sA:9 a=QEXdDO2ut3YA:10
Subject: Re: [Bug report] git diff stat shows unrelated diff
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
 <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
 <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com> <20190215185202.GA28019@dev-l>
 <CABPp-BEmPQb4Q_38S2A_68m+Cu75VDDD2UV0qWBDjL1OUAug9Q@mail.gmail.com>
 <xmqqzhqw4xqe.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <ad85402e-0ad2-4f4d-3b66-9250115072c0@iee.org>
Date:   Fri, 15 Feb 2019 22:48:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhqw4xqe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGYaf1etUEhHaMgVlhQlNrc8r5In6pXksCqjpEx7MZVRJJc/AUU2xtypCRp6IJfe+ihzvKZnHxFCLa1OOYc/QIK/T6kS+8XbCJr3GdJd52ZpidnUYrhh
 SzmQFa3CSSGP7IakVvWAdV9l+bg4AnLMsnrIJp3FuMVuoyA42+bnHvusUT/aa1qonvQTU/takkvdBoFuhuiDc7I8AN4KWlHB6+ZffOj5pjS0P6TDmq6msJ7E
 /65PxpNkHBVvBzA0AuH1sL80+IXcuaySaSzUFrolGoIj3TXrh2IQ8WTs6GL+ZuLHiFHlehpQbRAxsydzC2gGiHd6t3+MWZjr3YYq6wBPz8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/02/2019 20:12, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>>> Instead of outright deprecating it, would it make sense to include a
>>> configuration option, say "diff.sensibleDots", that would enable a user
>>> to set the dots to the other form if they desire?
>> I think Junio's suggested steps would still have to come first, and
>> there may also need to be a time period after two-dot notation is an
>> error before we were to try to repurpose it for something else (e.g.
>> to make it behave the same as triple-dot).  Adding a config to change
>> things now without both a deprecation and error period would invite
>> horrible surprises and bug reports; people need time and warning to
>> change workflows and fix existing scripts that might be out there.
> Historically, it was a mistake to allow A..B to be used for two
> endpoints, which was made back when we haven't thought things
> through.  That is why I stopped "warn to deprecate and then
> completely remove", as I do not think it would help people very much
> if "git diff A B" can be spelled with two-dots.
>
> But in a distant future long after that happens, by the time nobody
> remembers what A..B meant for "git diff", I do not think I'd
> strongly be opposed to reusing it to mean something different.

Would an option be to add a opt-in config to do the warning, rather than 
start immediately at a deprecation warning?

It would give users the chance to test out their usage early should the 
so wish/desire/notice.

I'd agree that the deprecation period would need to be quite a few 
cycles before the default (unset) would be flipped to warn if not set, 
yet still allow the warnings to be switched off for this case.

(obviously after the current release..)

