Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C285C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2955D20753
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MGHGEA8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUUAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:00:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61887 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:00:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 157B7B814C;
        Tue, 21 Apr 2020 16:00:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PMXdp7dhOjFqBlKhvlk39xr/6Vw=; b=MGHGEA
        8w3Drh5bvCUq6W43oPJu31Ffv7fkJkYywXnW7lrpRCuHGiYpcx5VzU9nKupMsewj
        LymHIKDGxNK3DPt50xi2cSTM9gCcklGT/bnyLbfRb/1DYCPoRPyX5eJo3H+RfdVi
        Y/QuA9jygWrof813M9sAuU7Mg8rh5hmjd4kVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wirUd1h2t5Qr3e+nt6/CnhO4WeW9lLWS
        LuQ32CeDsTsGkUe+RKTCIhnihyw3H/u12X/9qKWyZu45dVkyW3w0wCnA6CCYJvpD
        d7hADEMigI5KWqpQy3Pg20wra0ll41YUjhDF7XHF2tKGT+jVFLpJ6wutBoXIMWX/
        7O4/ES7vkK0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D8D3B814B;
        Tue, 21 Apr 2020 16:00:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5520CB8147;
        Tue, 21 Apr 2020 16:00:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
        <20200421131223.29337-4-shouryashukla.oo@gmail.com>
Date:   Tue, 21 Apr 2020 13:00:42 -0700
In-Reply-To: <20200421131223.29337-4-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Tue, 21 Apr 2020 18:42:22 +0530")
Message-ID: <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8EBD9D8-840A-11EA-8FCA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common issue' section which covers issues with cloning
> large repositories. Use shallow cloning to clone the repository in
> a smaller size.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 13d37f96af..cea293cf07 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -275,6 +275,20 @@ I want to change the remote of my repository. How do I do that?::
>  One can list the remotes of a repository using `git remote -v` command.
>  The default name of a remote is 'origin'.
>  
> +[[shallow-cloning]]
> +The repository I am trying to clone is too big. Is there an alternative
> +way of cloning it in lesser space?::
> +	One can clone a repository having a truncated history, meaning the
> +	history	will span upto a specified number of commits instead of
> +	the whole history of the repository. This is called 'Shallow Cloning'.
> ...

The question is worth keeping but the answer is questionable.

I have a feeling that --depth/shallow is deprecated/frowned upon
these days and more people recommend partial/blob-less clones
instead (a few random people added to Cc: to see if they want to say
something here).  
