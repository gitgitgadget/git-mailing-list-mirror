Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2CC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 01:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1773F64F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 01:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBDBjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:39:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59234 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhBDBjN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 20:39:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F07711CABE;
        Wed,  3 Feb 2021 20:38:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nFFk64qicOekb/w806dHJM2Ovd8=; b=FrKSfv
        IDWobfw9R+W1Wbs3SJ24SKfYKel98oK7bsn/Jnz5pM6TqXIC0lbD/tpCnG9JB6oT
        0zk7v11VPvfTlx9zwKH9Qz5tyFT39aG3+dg2XCxiGilOqsvFL8Ynqs/++VvGt2gC
        CJf1IgfzrZCKSt0uOTOmOvJ5/wHw8WV5MoIFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DEd0XnvGbRHxfXRgD+B79m90gs2ygpJD
        v/yVMloxLswjCbNYScdSCxfLyxql/JajG0R9yucG38qV8ZIIvgpUUkLj17aYb5Xi
        f+WQAvGuZufifjdY1e2RLhbA0dIkKf6C/X7elXKykwpDume48zgKu3gb8N9u+P4R
        4t5a910MlXg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27E0D11CABD;
        Wed,  3 Feb 2021 20:38:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D7C211CABC;
        Wed,  3 Feb 2021 20:38:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <YBn3ndkwo9qvXHFr@danh.dev> <xmqqbld2djx0.fsf@gitster.c.googlers.com>
        <CAN7CjDC8dy4Kp=rD4rSu5pnxUAWQ=GyXmU98BsiL84H2XKbbXA@mail.gmail.com>
Date:   Wed, 03 Feb 2021 17:38:26 -0800
In-Reply-To: <CAN7CjDC8dy4Kp=rD4rSu5pnxUAWQ=GyXmU98BsiL84H2XKbbXA@mail.gmail.com>
        (Miriam R.'s message of "Wed, 3 Feb 2021 23:00:25 +0100")
Message-ID: <xmqqft2ca9yl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE3BA458-6689-11EB-997D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

>> > I think the bisect_log still haven't added back the:
>> >
>> >       We are not bisecting
>> >
>> > as addressing in gohp6kv9bml9qc.fsf@gmail.com
>>
>> OK, I'll put it on hold and wait for a proper fix-up patch.
>>
> I have just sent the new patch series version with this and other minor fixes.
> Best,
> Miriam.

Thanks for a quick turnaround.  Queued and pushed out.

I think the change, especially to the first one, covers the above
comment sufficiently.

1:  7766d1f8a8 ! 1:  97d5ba6a39 bisect--helper: reimplement `bisect_log` shell function in C
    @@ Commit message
         Mentored-by: Lars Schneider <larsxschneider@gmail.com>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +    Helped-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
         Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
         Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
         Signed-off-by: Miriam Rubio <mirucam@gmail.com>
    @@ builtin/bisect--helper.c: static enum bisect_error bisect_state(struct bisect_te
     +static enum bisect_error bisect_log(void)
     +{
     +	int fd, status;
    -+	fd = open(git_path_bisect_log(), O_RDONLY);
    ++	const char* filename = git_path_bisect_log();
    ++
    ++	if (is_empty_or_missing_file(filename))
    ++		return error(_("We are not bisecting."));
    ++
    ++	fd = open(filename, O_RDONLY);
     +	if (fd < 0)
     +		return BISECT_FAILED;
     +
