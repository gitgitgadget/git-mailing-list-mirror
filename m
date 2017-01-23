Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA61720A17
	for <e@80x24.org>; Mon, 23 Jan 2017 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdAWX1X (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 18:27:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54868 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751445AbdAWX1W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 18:27:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6701F63B32;
        Mon, 23 Jan 2017 18:27:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rJbHTnocjyuZSXD3VPr+uZv45Tg=; b=E5jTBe
        /b6stImOcMsQUMfFNP934S5rWrb/35quQ/R9mWHUII9B4gM8KfR1u6GjZt0yjPFA
        SN7ADa21skxK7rySZaBezLB+9KSPkLMp5eiuufYCMwEMj0allJHwYGEW+boFkNZD
        ejgG5QMvZ7e+0jSS7ppYBuCmh0ASDewqdVdZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pM7ALUO/3zoD89D2nXswwmOM7R2+8Yjh
        DaqSz5+D9sjz+nIeAk3dpzXuQLGXej9iSUXSaX6Ob+D+sgAo1g4OEE+VLaQFHXJ0
        x3+jlAcAiSNAM5kD4giI+5J0msVCSXuhnNp423b4NhUYRgeCgmObXnD+eIuFFF61
        MnY/tkfXox4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FAD363B31;
        Mon, 23 Jan 2017 18:27:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1B9563B30;
        Mon, 23 Jan 2017 18:27:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
        <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com>
        <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
        <xmqqbmuxr0pd.fsf@gitster.mtv.corp.google.com>
        <CAOxFTczrLmWZg3720HMUA-13q9ADi_rK5k0x+TEYyKR=xR5b_w@mail.gmail.com>
Date:   Mon, 23 Jan 2017 15:27:19 -0800
In-Reply-To: <CAOxFTczrLmWZg3720HMUA-13q9ADi_rK5k0x+TEYyKR=xR5b_w@mail.gmail.com>
        (Giuseppe Bilotta's message of "Mon, 23 Jan 2017 23:35:38 +0100")
Message-ID: <xmqqsho9pdbc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CAEC37E-E1C3-11E6-9444-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Mon, Jan 23, 2017 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> On Mon, Jan 23, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> Should we plan to extend this to the interactive backend that is
>>>> shared between rebase -i and rebase -m, too?  Or is this patch
>>>> already sufficient to cover them?
>>>
>>> AFAIK this is sufficient for both, in the sense that I've used it with
>>> git rebase -i and it works.
>>
>> That is a good news and at the same time a bit awkard one ;-)
>>
>> The mention of "passed to 'git am'" twice in the documentation and
>> help text would lead people to think "rebase -i" would not be
>> affected and (1) would need more work to do so, or (2) the user does
>> not want "rebase -i" to be unaffected for whatever reason, and gets
>> surprised to see that it actually does get affected.
>
> I'm not sure I follow. If the user doesn't want to signoff during a
> rebase, they can simply not pass --signoff. If they do, they can not
> pass it. Am I missing something?

alias.

Which also means that there needs to be --no-signoff option that can
be given to countermand an earlier --signoff, if a user did

	[alias] rb = rebase --signoff

and wants to disable it one time only with

	$ git rb --no-signoff

>
>> In any case, will queue as-is so that we won't lose the patch while
>> waiting for people to raise their opinions.
>
> Thanks.

Thanks.  The final version would also need tests, so it may be a
good time to start thinking about what aspect of this feature wants
to be protected against future breakages.
