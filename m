Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF4C433E9
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6094229CA
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 02:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgLWC2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:28:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60872 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgLWC2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 21:28:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED7EE92A33;
        Tue, 22 Dec 2020 21:27:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yu+vCUD3NHfJ
        CDNEBfBBScaFaHQ=; b=DbTeuNtsKWlM8Tya5Fu1BA99WhPjZbcYFU+ugF5x5RQG
        ERvDArLofMHhwmv19nDcYTl1qao7vgDOWz1DTWD5Dlky1B7OsovxdNuOGtF0329U
        ofi3GE2u09AQ3eMbac+tkuiks7KAsOzzsuy7OLE3Cw5cUKoBSVbVwc0x4v5vra8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eOljmq
        BIoDXQbs+HI049u8PKIX6UqpWZ3UAueEm9Vv9HfMFQXDjg13P7Ge1bvkxm1K5YWr
        B3vXCstlxiIId7qaF9TYAe4qSjQYVCOl4M/RNBnEZLuX3Hg4bDLPrqg5WvvDnWMU
        Sfk8tPM0GQ3PS+uFqJpc/TpZJae7xRraqhZsc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E473E92A32;
        Tue, 22 Dec 2020 21:27:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69D5992A2F;
        Tue, 22 Dec 2020 21:27:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 09/20] mktag tests: stress test whitespace handling
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-10-avarab@gmail.com>
Date:   Tue, 22 Dec 2020 18:27:58 -0800
In-Reply-To: <20201223013606.7972-10-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Dec 2020 02:35:54 +0100")
Message-ID: <xmqqh7oddzo1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 79516E6A-44C6-11EB-9B44-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +cat >tag.sig <<EOF
> +object $head
> +type commit
> +tag mytag
> +tagger T A Gger <tagger@example.com> 1206478233 -0500
> +
> +
> +this line comes after an extra newline
> +EOF
> +
> +test_expect_success 'allow extra newlines at start of body' '
> +	git mktag <tag.sig
> +'

OK.

> +cat >tag.sig <<EOF
> +object $head
> +type commit
> +tag mytag
> +tagger T A Gger <tagger@example.com> 1206478233 -0500
> +
> +EOF
> +
> +test_expect_success 'allow extra newlines at end of headers' '
> +	git mktag <tag.sig
> +'

I am not sure what the contrast between "at start of body" and "at
end of headers" means.

Ahh, OK, we are making sure that we "allow a blank line after the
headers before an empty body".

Makes sense (but see below).

> +space=3D' '
> +cat >tag.sig <<EOF
> +object $head
> +type commit
> +tag mytag
> +tagger T A Gger <tagger@example.com> 1206478233 -0500$space
> +
> +EOF
> +
> +check_verify_failure 'extra whitespace at end of headers' \
> +	'^error: char.*: malformed tag timezone$'

OK.  Presumably all the other header lines forbid trailing space
as a malformed line?

> +cat >tag.sig <<EOF
> +object $head
> +type commit
> +tag mytag
> +tagger T A Gger <tagger@example.com> 1206478233 -0500
> +EOF
> +
> +check_verify_failure 'disallow no header / body newline separator' \
> +	'^error: char.*: trailing garbage in tag header$'

Now I am confused.  This fails because...?   We earlier saw that we
"allow" a blank line after the header when no body is present, but
this says the test fails if a blank line exists after the header
when no body exists.  I do not have any objection to the behaviour
of the command, but doesn't this mean the earlier test was not
labelled correctly?  It may make more sense to move this test next
to the earlier one, and name them

    "require a blank line before even an empty body (1)"
    "require a blank line before even an empty body (2)"

or something?  The earlier one ensures that a payload with such a
blank line is OK, and this one ensures that a payload without such a
blank line causes a failure.

Thanks.


> +
>  ############################################################
>  # 24. create valid tag
