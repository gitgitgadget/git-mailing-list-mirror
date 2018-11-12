Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E721F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 05:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeKLPQ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 10:16:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50011 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeKLPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 10:16:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30632100CAA;
        Mon, 12 Nov 2018 00:24:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P2NVAJycqqPHuUxZpsTRVRACrLo=; b=Ho5Ifq
        e66oXt88LKKh7AQKXF1acvZtnHbD6TCKawrf1yZQXFW2xHYumPFvKJjpWbXV+Ljv
        gYkzj1rMAeAHoDaLbvv0IdwOXegBhRhQhoFz9kPoS8sG1fdasD09XbiBdismjgfE
        BibSf7SnfVbdfyl4jE9pKqLsGSzBrb8uvlnaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fhXsKy2xVFuHCaQ7QURaUXr+WczJuFeW
        X9ba/p7vfbbBhLpf2XxmYInrU3rq20v+s/XSl3qYWrNQuHKcsHWa6fYV0iPZ7xQT
        /oDx1RDRKy+G3rTPKZqe0WJxpqnbaKnKzpsHuIUdtU6BqNYjdYdHbPCi38rAVwHC
        CKctRFeLRwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28DB7100CA8;
        Mon, 12 Nov 2018 00:24:53 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D5F8100CA7;
        Mon, 12 Nov 2018 00:24:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] ref-filter: add docs for new options
References: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
        <01020166f76d851b-3a0f5414-48ce-4172-8200-0a59fd3f66d9-000000@eu-west-1.amazonses.com>
Date:   Mon, 12 Nov 2018 14:24:51 +0900
In-Reply-To: <01020166f76d851b-3a0f5414-48ce-4172-8200-0a59fd3f66d9-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 9 Nov 2018 07:44:01 +0000")
Message-ID: <xmqqmuqe3m1o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4856FAD2-E63B-11E8-B6FE-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

>  objectname::
>  	The object name (aka SHA-1).
>  	For a non-ambiguous abbreviation of the object name append `:short`.
>  	For an abbreviation of the object name with desired length append
>  	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
>  	length may be exceeded to ensure unique object names.
> +deltabase::
> +	If the object is stored as a delta on-disk, this expands to the 40-hex
> +	sha1 of the delta base object. Otherwise, expands to the null sha1
> +	(40 zeroes). See `CAVEATS` section below.

I know existing description for other things nearby still talk about
SHA-1, but we can prepare ourselves better with something like:

	This expands to the object name of the delta base for the
	given object, if it is stored as a delta.  Otherwise it
	expands to the null object name (all zeroes).

> +Note that the sizes of objects on disk are reported accurately, but care
> +should be taken in drawing conclusions about which refs or objects are
> +responsible for disk usage. The size of a packed non-delta object may be
> +much larger than the size of objects which delta against it, but the
> +choice of which object is the base and which is the delta is arbitrary
> +and is subject to change during a repack.
> +
> +Note also that multiple copies of an object may be present in the object
> +database; in this case, it is undefined which copy's size or delta base
> +will be reported.

OK.


>  SEE ALSO
>  --------
>  linkgit:git-show-ref[1]
>
> --
> https://github.com/git/git/pull/552
