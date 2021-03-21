Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2566DC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC02F61934
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 19:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCUTG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 15:06:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52475 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCUTF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 15:05:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CBF8C4B0E;
        Sun, 21 Mar 2021 15:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xjavltn/soz/
        ERFihvSuhgZfEVQ=; b=AuLXPVrbKws7KvUXT8KVNN/732+tIeOrTbf5gKY1r3ct
        gpVOiAJJtUY8JYgv3Avn8G8Ahk6koeEjuSLXh3BiOOVWK/fHqtWNFEK6NhELrYxw
        MUl7/QrmrhR6fqhQVREupNhE5JJ0ZyLhp28lXCRwJ9KC3A9/V/tcQlq6T11iw+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=llVX+A
        +SkANCRGux2mS5lTuFoteP7U/S6Ktzm2b5CCuvM7J/s82VdEvd9pEADm5yFTZEc9
        9/PD8jlQmhAfcPnLxJznmI5mcRzif/2lQvIQXItf8pzt8B0MB65eZ9seA85E5qy0
        DCyunQJBjysp48dmY8nqiRLfDfn/ZBwnlw8NE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74FD0C4B0D;
        Sun, 21 Mar 2021 15:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08F09C4B0B;
        Sun, 21 Mar 2021 15:05:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
        <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <xmqqzgyw9wn3.fsf@gitster.g> <xmqqo8fc9vwp.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 12:05:55 -0700
In-Reply-To: <xmqqo8fc9vwp.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        21 Mar 2021 11:57:58 -0700")
Message-ID: <xmqqeeg89vjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76E795BC-8A78-11EB-8282-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And also =C3=86var is right.  The original just has a format-patch outp=
ut
> in $_ and prints it to the output stream in one go.

Sorry but I misread the patch.  By dropping the $/ =3D undef, it wants
to read from $fd (which is "format-patch --stdout" output) one line
at a time.  So unless a line has two addresses, this would "work" as
intended.

Again, as I said, I do not agree with the definition of "work" here,
though ;-).
