Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6BC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 04:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472EF64E41
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 04:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCOEmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 00:42:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55088 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCOEmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 00:42:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33449C1302;
        Mon, 15 Mar 2021 00:42:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5CPaWXXJGg9R
        o+W/x69WlPzFJmY=; b=L/ep7mlXg1MAr3uMthorlmBp20Iza9b8SbR75uGJE9gG
        Eb7/IW/DnSunuKxBDp7fILNkrZch+P5pppanhD5yShwTmv8Hf186+VUcRrIiYrH9
        R+JXdpVapoIXPR5nagi0t9NYcOFec33DddwkVuW8VzeQLnYWC0tgjU/0Zy4ZxIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KDuAT3
        fy2JAVlmBh8Q/+yESlIMccXyaeHdLKWc6kafqBpv+hYJwQf+dErnK+8KCgFGGtqy
        TYLQvPsfGZUJwm0cIQnHM2Op8U+VnL1QHDxkEw3frg3RGaWgXprd7RQa7txD5z4f
        oQAkdreb7uFQiX7YojycYyklHvns9pkIeqPow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AC72C1301;
        Mon, 15 Mar 2021 00:42:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAE56C12FF;
        Mon, 15 Mar 2021 00:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v4] [GSOC] commit: add --trailer option
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
        <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com>
        <xmqqh7ld2syx.fsf@gitster.g>
        <CAOLTT8RNKFC_NzZXGvE4Zz+NmVHCUAn-jZFu-0Nm=7JAS0jBjA@mail.gmail.com>
Date:   Sun, 14 Mar 2021 21:42:16 -0700
In-Reply-To: <CAOLTT8RNKFC_NzZXGvE4Zz+NmVHCUAn-jZFu-0Nm=7JAS0jBjA@mail.gmail.com>
        (ZheNing Hu's message of "Mon, 15 Mar 2021 09:27:28 +0800")
Message-ID: <xmqq8s6p2fkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D24A9A38-8548-11EB-8D36-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:52=E5=86=99=E9=81=93=EF=BC=9A
>> IOW this part would become ...
>>
>>         if (trailer_args.nr) {
>>                 strvec_pushl(&run_trailer.args, "interpret-trailers",
>>                              "--in-place", ...);
>>                 strvec_pushv(&run_trailer.args, trailer_args.v);
>>                 run_trailer.git_cmd =3D 1;
>>                 run_command(&run_trailer);
>>         }
>>
>> > +     } else
>> > +             strvec_clear(&run_trailer.args);
>>
>> ... and there is no need to have "else" that won't need to do
>> anything.
>
> Yes, but we also should clear "trailer_args" in "else" here, and check =
the
> return value of the "run_command()" for clear "run_trailer.args".

No.  If you introduce the separate strvec, the "else" clause runs
only when trailer_args haven't got anything, so there is nothing to
clear.

