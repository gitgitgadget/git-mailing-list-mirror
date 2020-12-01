Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E1C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03777206E0
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CfwEuDH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLAUuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:50:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52288 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAUug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:50:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C2B7A09E5;
        Tue,  1 Dec 2020 15:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OFm2n0fzNaWv
        sWng0xMYQSZFFeo=; b=CfwEuDH59is05T2+ExLjkoonO0aueIAmqamb2hFGJtRU
        iE7Sm5BoGCwvlRMwo8FUZ4mRZdhh5Rg1EpdcmfcZ7KT8sGSLCTBaLawumIK5NKVn
        cAQbVNwXCvIAEUBC3HFwlGkXtb09S1p9e8sBFcxI8cLHxvMhmj5rH6l6CIt33BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ix2Y6u
        I6J6Ehv/gaoblIkMLaPZytOTT13MwJWcrd1zsG4gS2s6bvUfHDO/d9157mDfO082
        z4n0KDvIQ4+gW9IU0EOmAqg0sqXbnBgumAIG27sNoqgSW4Khyv9qG7MiabNWghgP
        4HsQr8CVKhdZpgSF4juNRktX9uBprZKGbSOug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 241D0A09E4;
        Tue,  1 Dec 2020 15:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8B0BA09E1;
        Tue,  1 Dec 2020 15:49:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 03/10] mktag: reword write_object_file() error
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-4-avarab@gmail.com>
        <xmqq1rg9p9as.fsf@gitster.c.googlers.com>
Date:   Tue, 01 Dec 2020 12:49:53 -0800
In-Reply-To: <xmqq1rg9p9as.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 01 Dec 2020 12:20:59 -0800")
Message-ID: <xmqqczztnte6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3659050-3416-11EB-BBC9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the error message emitted when write_object_file() fails to
>> make more sense. At this point we're not writing a "tag file" (which
>> as an aside we never do, we just write to stdout). We are writing an
>> annotated tag object, let's say that instead.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>>  builtin/mktag.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/mktag.c b/builtin/mktag.c
>> index ff7ac8e0e5..603b55aca0 100644
>> --- a/builtin/mktag.c
>> +++ b/builtin/mktag.c
>> @@ -171,7 +171,7 @@ int cmd_mktag(int argc, const char **argv, const c=
har *prefix)
>>  		die("invalid tag signature file");
>> =20
>>  	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
>> -		die("unable to write tag file");
>> +		die("unable to write annotated tag object");
>
> "write an annotated tag object"?

Actually, there is no such thing as an "unannotated tag object".
Perhaps _("unable to create a tag object")?

>
> It is not just this call to die(), but we'd eventually want to _(l10n/i=
18n)
> these messages.  Perhaps in a separate step but on all messages fed
> to die/error/warn in this file.
>
>> =20
>>  	strbuf_release(&buf);
>>  	printf("%s\n", oid_to_hex(&result));
