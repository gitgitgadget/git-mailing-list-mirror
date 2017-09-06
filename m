Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBA120281
	for <e@80x24.org>; Wed,  6 Sep 2017 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdIFXlE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 19:41:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64820 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750944AbdIFXlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 19:41:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 065F3A665E;
        Wed,  6 Sep 2017 19:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EghPwKbaxD19
        vph15yi+KM64MA4=; b=si9S4ay7v0Jpwdi+0UMlTW9Ub/gLl4oYcVzNpi7ynC5s
        mQRHakQ8J4lczJmFv4pRg/BSr+x7bhtC1WPihoFbUvgBx6Evqw1ts8G+rDzvzmqG
        Ns1hCddTfoSJYxCno1GTlElwWcGMsM0KHKroLHde8zu/MNNObhVF3yVigDCxbJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OIrPdo
        d94HBB7k6wHFaoSNO1+u7ciLaS4ygyW3zrceuo2mDU+QP+Z2v2ts5MZdArVo5o5H
        YTEleYekDLAJmSau7uZNG5d67VvtI0te4qlGgJ53kTDqjjDeZD3KRPxOAMsaoXQK
        YvnnwIp0GZSsKZ+nGDoh1rWeDrbYQ5wYlVdww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1D70A665D;
        Wed,  6 Sep 2017 19:41:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FDE7A665B;
        Wed,  6 Sep 2017 19:41:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: warn developers on negated options
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170905230845.17108-1-sbeller@google.com>
        <xmqq8thsa901.fsf@gitster.mtv.corp.google.com>
        <xmqqzia88qkj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaHHXdFMeEMfidWj7=FurR3L8VMysLrCLG3OyMtZPCgDQ@mail.gmail.com>
Date:   Thu, 07 Sep 2017 08:41:00 +0900
In-Reply-To: <CAGZ79kaHHXdFMeEMfidWj7=FurR3L8VMysLrCLG3OyMtZPCgDQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 6 Sep 2017 14:36:00 -0700")
Message-ID: <xmqqvakv2y5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D7AC4DBE-935C-11E7-96A1-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Ahh, I was an idiot (call it vacation-induced-brain-disfunction).  I
>> forgot about 0f1930c5 ("parse-options: allow positivation of options
>> starting, with no-", 2012-02-25), which may have already made your
>> new use of "--no-verify" in builtin/merge.c and existing one in
>> commit.c OK long time ago.  A quick check to see how your version of
>>
>>         git merge --verify
>>         git merge --no-verify
>>
>> behaves with respect to the commit-msg hook is veriy much
>> appreciated, as my tree is in no shape to apply and try a patch
>> while trying to absorb the patches sent to the list the past week.
>>
>> Thanks, and sorry for a possible false alarm.
>>
>>> Having said that, because the existing parse_options_check() is all
>>> about catching the programming mistake (the end user cannot fix an
>>> error from it by tweaking the command line option s/he gives to the
>>> program), I do not think a conditional compilation like you added
>>> mixes well.  Either make the whole thing, not just your new test,
>>> conditional to -DDEVELOPER (which would make it possible for you to
>>> build and ship a binary with broken options[] array to the end-users
>>> that does not die in this function), which is undesirable, or add a
>>> new test that catches a definite error unconditionally.
>>
>> This part still is valid.  If Ren=C3=A9's work 2 years ago is sufficie=
nt
>> to address "--no-foo" thing, then there is nothing we need to add to
>> this test, but if we later need to add new sanity check, we should
>> add it without -DDEVELOPER, or we should make the whole thing inside
>> it.
>
> As far as the code is concerned it is only inside the -DDEVELOPER ?
> The intent of this patch is to have a developers aid to remind them
> that too many negations might be a sign of trouble.

I understand that.  What I was saying is that there may be no point
"reminding" them with Ren=C3=A9's "positivation" thing in effect and that
is why I asked you to try the simple two commands out to see if that
is the case.

I did that myself with "git commit --[no-]verify" and they are
indeed OK, so there is no reason to force developers to do this:

	int distim =3D 1; /* default is to distim */
	struct option options[] =3D {
		...
		OPT_BOOL(0, "distim", &distim, N_("distim")),
		...
	};
	...
	if (distim)
		do_the_distim_thing();

if/when the following is more natural in the context of the command:

	int no_distim =3D 1; /* default is to distim */
	struct option options[] =3D {
		...
		OPT_BOOL(0, "no-distim", &distim, N_("bypass distimming")),
		...
	};
	...
	if (distim)
		do_the_distim_thing();

whether it is inside -DDEVELOPER or not.


