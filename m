Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43F8C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9736220714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vqGlwpjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgC0Vjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:39:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53862 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0Vjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:39:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B00F0BCDBF;
        Fri, 27 Mar 2020 17:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hv00JH9B9lnwcPDNDIEaAq6dh0A=; b=vqGlwp
        jwWMyAArIa/nKMhS0aqBTyatVZrjLxkbVWuifpd8QzIyF31ab7xn9h6mfZlB0UMu
        +5BF/zjGqsY6MAT0OUB3lyz2rn1nSN3ovhd/lDu+0ZaxuvgZaGZnFvag8eABR/kT
        6onv+FVPy2VwVPj/gT/1NkbA/s0e10tLE2tfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oaV+lfSwq6hMFk9rV85oOLhCJc180mxN
        gDoQ3TdkX1szG1OF9GjAqHWfnDv5UKwkNzx9ob46bHxQmp0rv2GUAW3EqRWnll5B
        /VJAs2upjnbxvz58OV9NhPtOaaj4clRUzjqC8v073gxuiWUcGsERqD+EAPsrZH0N
        8zgLLGAU5r0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7B46BCDBE;
        Fri, 27 Mar 2020 17:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0D20BCDBA;
        Fri, 27 Mar 2020 17:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs
References: <cover.1585209554.git.liu.denton@gmail.com>
        <38924d9c4994b5bad93cbbd2659666f6b452a89f.1585269773.git.liu.denton@gmail.com>
        <xmqqimipherm.fsf@gitster.c.googlers.com>
        <CAPig+cR0rNnVRF-Xei-n2HaxLR=9yF=7aya3mdApaqfEXmcPLg@mail.gmail.com>
Date:   Fri, 27 Mar 2020 14:39:37 -0700
In-Reply-To: <CAPig+cR0rNnVRF-Xei-n2HaxLR=9yF=7aya3mdApaqfEXmcPLg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 27 Mar 2020 16:29:20 -0400")
Message-ID: <xmqqwo75eaue.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75E9AB5C-7073-11EA-94A8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 27, 2020 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Subject: Re: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs
>>
>> Forgot to do the final "rebase -i --autosquash"?
>
> My guess is that Denton sent this "fixup!" to have it queued atop [1]
> in response to the review comment[2] pointing out the bad indentation

Ah, [9/9] fooled me (and caused me not to see eight in [1/8]-[8/8]
and I mistook they were [1/9]-[8/9].

Usually people do the "oops, here is a hotfix" by marking such a
"beyond the original set" patch as [9/8].

In any case, I think I've squashed it to the original.
Thanks.
