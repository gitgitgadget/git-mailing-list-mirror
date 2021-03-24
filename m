Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B59C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C833161A21
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhCXRx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:53:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62826 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhCXRxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 13:53:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFE8EC2D65;
        Wed, 24 Mar 2021 13:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xlpzUMXBaPq4VeWT+kKT0KiNE0Q=; b=bCuhwO
        sHEy7VCg1df9EWT4ciRF+i5Fy/N3F1CQ89k1bu2PvpCHN8gVHWNobywOG9+SkNJ6
        yCRuo21Uxx3NwSthkfaTgZ0cEi6AgVWm07c99WxbbA8Vg1b83VDSd+/yVtAI/gru
        rOyU6HmwLw80JQ1P0NpGo+YRIsPO8jCWRsD3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pjXowEqPyMH0IXKiCFT4Om/XCrBYP1wc
        BDOhnjL1drQijfdf1c2KUFF6AypU3Z7R2MYJDFVfT7tm9A9GqN8QKtgy1rslbjow
        RmGYHayPIGnn7dJRfIV4nfxdIiS8K+dj7eFt04+bmJgylhhwRxOtKD5OtlJan1pN
        gmgoFEnsO2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8A9CC2D64;
        Wed, 24 Mar 2021 13:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72D80C2D63;
        Wed, 24 Mar 2021 13:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-format-patch: Document format for binary patch
References: <20210324123027.29460-1-bagasdotme@gmail.com>
        <20210324123027.29460-3-bagasdotme@gmail.com>
Date:   Wed, 24 Mar 2021 10:53:32 -0700
In-Reply-To: <20210324123027.29460-3-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 24 Mar 2021 19:30:27 +0700")
Message-ID: <xmqqa6qszbdv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9C5C30E-8CC9-11EB-BA7B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Document binary file patch formats that are different from text file
> patch.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git-format-patch.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 247033f8fc..8de172b1f4 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -725,6 +725,28 @@ diff format is described as below:
>  
>  include::diff-generate-patch.txt[]
>  
> +Binary Files
> +~~~~~~~~~~~~
> +For binary files, the diff format have some differences compared to text
> +files:

I do not think this is specific to 'format-patch'.  If we need to
describe 'git diff --binary', it should be done there, so that
readers of "git diff --help" would also be able to learn the format.

> +1. Object hashes in index header line (`index <hash>..<hash> <mode>`)

s/Object hash/Object name/;

> +   are always given in full form, as binary patch is designed to be
> +   applied only to an exact copy of original file. This is to ensure
> +   that such patch don't apply to file with similar name but different
> +   hash.

... with similar but different object name.

cf. Documentation/glossary-contents.txt tells you what "object name" is.

> +2. There are additional extended header lines specific to binary files:
> +
> +        GIT binary patch
> +        delta <bytes>
> +        literal <bytes>
> +
> +3. The diff body can be either delta or full (literal) content,
> +   whichever is the smallest size. It is encoded with base85 algorithm,
> +   and emitted in 64 characters each line. All but the last line in
> +   the body are prefixed with `z`.

I do not think this is all that useful; it clutters the description
for a reader who is not interested in reimplementing an encoder or a
decoder from the document.

And it is way too insufficient for a reader who wants to reimplement
an encoder or a decoder.  For example,

 - It does not say anything about what the delta is and how it is
   computed.

 - The 'z' is redundant; the more important is to say that the first
   byte signals how many bytes are on that line and it is a mere
   artifact that we cram up to 52 bytes on a line.

 - It does not say anything about how the binary patch ensures that
   it is reversible (i.e. can be given to "git apply -R").

Thanks.
