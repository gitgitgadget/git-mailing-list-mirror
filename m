Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FD9C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbiAXSHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:07:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54764 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244950AbiAXSHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:07:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC2C21754E6;
        Mon, 24 Jan 2022 13:07:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ut9el8saEC6ta4ZVApnO6Y19AfLOhvWj0octTv
        HOxV4=; b=cZNz0g4Evwgr/6rL++Jb8sSN+u8ibs+MMw9UXViSIB3sAw3IunNK1J
        JS2Vt96SNQSKu3Bvk0X57zOZaTuJ3hRD3Rv9w4qFdqf6iDMp1JjwDmIGDkZIFbAl
        u67q1fW/KymOMo3BM12osJnVl+NHw9gpB705Ostyk+mlkKRYJ9N10=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2D6D1754E5;
        Mon, 24 Jan 2022 13:07:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 388BC1754E4;
        Mon, 24 Jan 2022 13:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
        <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
        <xmqqilufl5cv.fsf@gitster.g>
        <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
        <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
        <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
        <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
Date:   Mon, 24 Jan 2022 10:07:13 -0800
In-Reply-To: <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
        (Michael Herrmann's message of "Mon, 24 Jan 2022 10:48:27 -0300")
Message-ID: <xmqqk0ep57ou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75638C44-7D40-11EC-8E47-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Herrmann <michael@herrmann.io> writes:

> I now believe this is a bug in Git because calling `git status` fixes
> the problem.
>
> 1) Create a hard link to a file in a Git repo.
> 2) Call `git status`.
> 3) Call `git reset --hard`.

It is merely because you helped Git to realize that there is no need
to change the contents of hte file with "reset --hard".

With another step 1.5 "append a line to the file in question", git
should severe the link, I would think, as at that point, to revert
the contents of the file in question to its pristine state, it needs
to modify it.






