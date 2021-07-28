Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D15C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 00:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3D0603E9
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 00:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhG1AjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:39:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55573 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbhG1AjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 20:39:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5C381382E8;
        Tue, 27 Jul 2021 20:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cJ1eZDOh+RBYw1CQZ1NaUVs+CMIS+GY9SjW7Z/
        m9oqc=; b=nicBDL85tlXpMaYwozgEz4fhMZmK5rK3yH5tvGpVVTGFbThGBs3yiA
        sUMFxikJdMy/8Jl3EyeZDAhcoWHyoNrr+TlepbNYEmjC+GggNfe5PDYMzSIdt9jC
        6I4UFm2g0IBzlIKinHjIAC0fLmIOYv9BXDXObOta32Gj6k+UzVefE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C26CE1382E7;
        Tue, 27 Jul 2021 20:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E5111382E5;
        Tue, 27 Jul 2021 20:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
        <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
        <xmqqh7gghgtd.fsf@gitster.g>
        <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
        <xmqqfsvzcqmo.fsf@gitster.g> <xmqq8s1rcn0t.fsf@gitster.g>
Date:   Tue, 27 Jul 2021 17:39:03 -0700
In-Reply-To: <xmqq8s1rcn0t.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        27 Jul 2021 17:14:42 -0700")
Message-ID: <xmqq4kcfclw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 362A5932-EF3C-11EB-897E-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Fabian Stelzer <fs@gigacodes.de> writes:
>>
>>>> I think Fabian's "ssh signing" is not as ready as this topic, and it
>>>> can afford to wait by rebasing on top of this topic.  By the time
>>>> "ssh signing" gets into testable shape (right now, it does not pass
>>>> tests when merged to 'seen'), hopefully the "expand install-prefix"
>>>> topic may already be in 'next' if not in 'master'.
>>> I think the test problem is not due to my patch.
>>
>> I've been seeing these test failers locally, every time
>> fs/ssh-signing topic is merged to 'seen' (without the reftable
>> thing).
>>
>> Test Summary Report
>> -------------------
>> t5534-push-signed.sh                             (Wstat: 256 Tests: 13 Failed: 2)
>>   Failed tests:  8, 12
>>   Non-zero exit status: 1
>> t7528-signed-commit-ssh.sh                       (Wstat: 256 Tests: 23 Failed: 2)
>>   Failed tests:  13, 17
>>   Non-zero exit status: 1
>>
>> When reftable thing is merged, either compilation fails or t0031
>> fails, and I suspect that these are not due to the ssh signing
>> topic.
>
> Interesting.  It seems that the failure has some correlation with
> the use of --root=<trash directory> option.
>
>     $ sh t5534-push-signed.sh -i

And 7528 fails with --root set to a /dev/shm/ trash directory.

So,... this "principal with number #" differences come from the
differences in location of the trash directory?  Why?

> --- expect	2021-07-28 00:11:20.863019887 +0000
> +++ dst/push-cert-status	2021-07-28 00:11:20.855019156 +0000
> @@ -1,4 +1,4 @@
> -SIGNER=principal with number 1
> +SIGNER=principal with number 3
>  KEY=SHA256:Szd5rzYOrMBJFTR+gnRUu60YRVqg98UvpcSvmAm89rE
>  STATUS=G
>  NONCE_STATUS=OK
