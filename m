Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126EC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD2761241
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFVdy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 6 Jul 2021 17:33:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:40187 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFVdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:33:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 166LVBMo053958
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Jul 2021 17:31:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'Alex Henrie'" <alexhenrie24@gmail.com>,
        "'Richard Hansen'" <rhansen@rhansen.org>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>        <20210705123209.1808663-2-felipe.contreras@gmail.com>        <87bl7f5ho1.fsf@evledraar.gmail.com>        <60e4bf9a6a628_1c4281208b@natae.notmuch>        <04de01d772a8$540c6690$fc2533b0$@nexbridge.com> <xmqq1r8bi2l0.fsf@gitster.g>
In-Reply-To: <xmqq1r8bi2l0.fsf@gitster.g>
Subject: RE: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Date:   Tue, 6 Jul 2021 17:31:05 -0400
Message-ID: <04e001d772ae$3d87e0b0$b897a210$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEjwC2BG0r8Ti4tiVL2ONsdEMpHYQJC7SfhAdO76CQCFHAokgHyNSSTA1ClLhWsQmu1EA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 6, 2021 4:56 PM, Junio C Hamano wrote:
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>>>If you do:
>>>
>>>  % git merge --ff-only
>>>  fatal: Not possible to fast-forward, aborting.
>>>
>>>That "aborting" part is redundant; we know `git merge` should abort
>> if the fast-forward is not possible, we explicitely told git to do
>> that.
>>
>> `git merge` is a special operation where errors (conflicts, for one)
>> may leave the repository in a merge pending state where you
>> subsequently may have to use `git merge --abort` to reset the
>> situation or `git add` to continue. The `aborting` output makes it
>> clear that you do not have to do the `--abort` and *cannot* do the
>> `add` because there was an implicit `--abort` done resulting from the
>> failure. This is important information for the user.
>
>If so, adding ", aborting" to the end is misleading.  In this particular failure mode, the command pretends that the merge did not even
>start.

You know that, and I know that. I contend that git users do not generally want to care about failure modes. While a flow description might be instructive, I doubt many git users would look at it. We can only hope that front ends know how to make this clean for them.

-Randall

