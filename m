Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ACEC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A732389F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLGUp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:45:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50962 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLGUpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 15:45:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52DC3AE5D5;
        Mon,  7 Dec 2020 15:45:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sbWKy5FvCoyDFSDNJ0W1ezQBkOc=; b=L2/Gp3
        CR5y0pwz4qHeIbLQITnZqGMDbZ4EsU1xQiEnPpa4wiytzBqNYPXiG73kbtrnYEpN
        OYcpyfF3SabwSnLtHED0zskrhi6mA8CtsN+8cwATV4XRBINah9VQvZWaNah2d6Tg
        x80GqToeiY0Jh4scAm3jrl9QrCQjbvpSM9SJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HWUd6PUybnbdg9jRg+jCNiT0EFyFTqph
        0Yt2Conk4qAJ1woJPVEvsDyJwI2HQjXnvMCJdxux0oUWG51m49O6F+jyMlXjiu0+
        FIc66FpbpqWxgDmOCaTBo+CRAtr4NYrZxb+aYJPO0ah1yuq4hrraJvsCGi9mZHLP
        ZLb5ffp72RQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48795AE5D4;
        Mon,  7 Dec 2020 15:45:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B08BFAE5D1;
        Mon,  7 Dec 2020 15:45:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
        <20201205195313.1557473-2-felipe.contreras@gmail.com>
Date:   Mon, 07 Dec 2020 12:45:12 -0800
In-Reply-To: <20201205195313.1557473-2-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Sat, 5 Dec 2020 13:52:58 -0600")
Message-ID: <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A689694-38CD-11EB-8E77-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We want users to know what is a fast-forward in order to understand the
> default warning.

The intention is very good, but ...

> +------------
> +	  A---B---C master on origin
> +	 /
> +    D---E master
> +------------
> +
> +Then `git pull` will merge in a fast-foward way up to the new master.

... I find the phrase "in a fast-forward way" a bit awkward.
Perhaps use the 'fast-forward' as a verb, i.e.

	Then `git pull` notices that what is being merged is a
	descendant of our current branch, and fast-forwards our
	'master' branch to the commit.

or something like that?  It should be in line with the spirit in
which glossary defines fast-forward, I would think.

> +
> +------------
> +    D---E---A---B---C master, origin/master
> +------------
> +
> +However, a non-fast-foward case looks very different.

s/foward/forward/ (the same typo exists above);

>  ------------
>  	  A---B---C master on origin
>  	 /
