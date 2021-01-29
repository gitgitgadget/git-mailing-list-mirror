Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F19FC433E9
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED42961481
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA2Avt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:51:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58329 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhA2Aup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:50:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98800FBF3D;
        Thu, 28 Jan 2021 19:50:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3WWZAtAl391ZDZthpk5s24zLw60=; b=abAESG
        Iezi7Z34oKEf4fSYVw36b8By8i95VOkEwVGpUFfliLuUTlQWWMrn5Ao+pPYDSxSA
        Kj2KYICIpDJZz1UkqNskYBRfL/Y8pwCQNPLxUDZgiqbEvGsG/NRJ7B6yKnTQwlY1
        JcyfgoOD5UVoJXT3x3dmII8C8JLfn+an72PgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o9Q1FaCEzGBtdLiJ+5A4pbw41KaC1KLA
        3GJ1zbN6QcfooTE4zItfN6m7Lgjh2AOpxjvoh7GnRiGG/CewSbyGtzo1XkEJFKBX
        SZ1Ml878xLhIE5xjhrz6VW25A91IWe2ZIWQE7rtv+l8GKeRdDf+acPZofcjCHp38
        /wjidLBmZho=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90A9BFBF3C;
        Thu, 28 Jan 2021 19:50:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B74ADFBF37;
        Thu, 28 Jan 2021 19:50:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v4 7/7] bisect--helper: retire `--check-and-set-terms`
 subcommand
References: <20210125191710.45161-1-mirucam@gmail.com>
        <20210125191710.45161-8-mirucam@gmail.com>
Date:   Thu, 28 Jan 2021 16:49:59 -0800
In-Reply-To: <20210125191710.45161-8-mirucam@gmail.com> (Miriam Rubio's
        message of "Mon, 25 Jan 2021 20:17:10 +0100")
Message-ID: <xmqqczxova6g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAA2CECA-61CB-11EB-8AAA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> The `--check-and-set-terms` subcommand is no longer from the
> git-bisect.sh shell script. Instead the function
> `check_and_set_terms()` is called from the C implementation.

Nice to see these intermediate state going away.

Reviewers and mentors, how close do you folks think these patches
are to the completion?  It looks quite good to me (admittedly I gave
only a cursory look to these recent iterations).

Thanks.
