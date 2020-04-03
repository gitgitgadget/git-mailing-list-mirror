Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B2C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D895B20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pno9JwJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbgDCSkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:40:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56718 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgDCSkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:40:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0C3AD4771;
        Fri,  3 Apr 2020 14:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y3R4JVe7un5Z
        9z75FBd9Mj3/afQ=; b=Pno9JwJ4s3AjYh3FuP/op+F43tiUxaN/JPVkfQ0xeLro
        +ybIIWLz+XR1eGB9rN71Z6gjOF8WeqryZTq/eI9OLXuhshN4v04t62AfjFJykhNh
        AF7gHdhlu52t5LQppZxePhgUEDSgBdov2NnL20U8uocR5E2b950/TDhxwfCO8h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NfhVja
        D5bPrjz/+JsUs0zeQKgBx/G28yTjvuif6qL//a0oBT6xGMmJSj58BohUtNvqd+v8
        +rZ+82T3fmZcJy76S+aaxM2iDIaN41l3qwDhkc6w82NCwEyfs/DW5qZE2I5o1Fyk
        Nz3IGghIxReD0JNg5F6WigKqsJhIOwh8SOlXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8078D4770;
        Fri,  3 Apr 2020 14:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBD01D476D;
        Fri,  3 Apr 2020 14:40:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Dominic Chen <d.c.ddcc@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 0/6] Honour and Document --no-gpg-sign
References: <20200331064456.GA15850@danh.dev>
        <cover.1585909453.git.congdanhqx@gmail.com>
Date:   Fri, 03 Apr 2020 11:40:00 -0700
In-Reply-To: <cover.1585909453.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Fri, 3 Apr 2020 17:28:01 +0700")
Message-ID: <xmqqr1x4za4f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 871ED49E-75DA-11EA-BF6F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> The subcommand `git commit` supports a `--no-gpg-sign` argument, which =
is
> useful incases where e.g. a GPG key is specified in `.gitconfig`,
> but is located on a hardware key that may not currently be attached to
> the system.

I see the mark-up in the documentation pages have been changed, and
they all good correct.

Thanks for an update.  Will queue.
