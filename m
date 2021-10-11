Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51427C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3759660E9C
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 15:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhJKPvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:51:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51623 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbhJKPu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 11:50:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 279231618ED;
        Mon, 11 Oct 2021 11:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cNWxAvyE87iIh9Tnbog+fA+FsANhAZ8MRrlntk
        ge6t4=; b=HF+rKMSrdZqptryOTMXabxrIJTHtpvAhEcvlfT1K6H4G6YOh9ZseZC
        YzBXZrRA1yMthn1zxM2AolEwAy9UovRj5uQYZBluO8aE32HU0ejmFRyevE8SuWcV
        ryQcPQRqtFRpRY/KwXMs2mgQ+7YiZaUvGYaLoWDpDxjLJ6N29Zc1g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FEB11618EC;
        Mon, 11 Oct 2021 11:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 797781618E9;
        Mon, 11 Oct 2021 11:48:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: add test testing MIME for created archive
 through compression filter
References: <20211011112712.475306-1-bagasdotme@gmail.com>
Date:   Mon, 11 Oct 2021 08:48:53 -0700
In-Reply-To: <20211011112712.475306-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Mon, 11 Oct 2021 18:27:13 +0700")
Message-ID: <xmqqpmsbd0ka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCFCAE7A-2AAA-11EC-A5E8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> +	cat >expect <<EOF &&
> +HEAD.tar.bz2: application/x-bzip2; charset=binary
> +HEAD.tar.gz:  application/gzip; charset=binary
> +HEAD.tar.xz:  application/x-xz; charset=binary
> +EOF

Use <<-EOF and you can align here-document to the script.

> +	file -i HEAD.tar.bz2 HEAD.tar.gz HEAD.tar.xz 2>/dev/null >actual &&

This looks super un-portable.

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/file.html


