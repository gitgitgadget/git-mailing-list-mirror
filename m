Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9CE1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 17:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbdLMRCp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:02:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56967 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753356AbdLMRCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:02:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E25AB5082;
        Wed, 13 Dec 2017 12:02:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uuobU35DIF2KmI8TUat2IS44TWY=; b=L54az+
        hpYeE+qu9NWCtWUnPTYJCvTNbLrwQeGxAqPS4mglYiY15dGKX8Xv1G7Whv8S3s+D
        GDeyYPNbCIznhvW4U56/0x58wW2WFxNTnVDEezk2XXqTjnWBXvNSic1kgR4gLYty
        EHYjQMQMHXTyAaELIAVjFfQ5x2UGYXhwwjD40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j2kiVEon6A5WrBqP4Ys0JUlzKAQXx3Tt
        cpT5e2peR5TJgzole/SDF9Xp8mNA2JJ046ryisVRk38fMKpz7khwBskyE3Piyok+
        U4Mr3gx008pd2rIfQvR8fGtl6wyb0jI2h3U0TCyUTzScEzZqu/3/9rQVXjk9MVx3
        SLfHfTZi5eU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17231B5081;
        Wed, 13 Dec 2017 12:02:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85C66B5080;
        Wed, 13 Dec 2017 12:02:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "David A. Wheeler" <dwheeler@dwheeler.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
        <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
Date:   Wed, 13 Dec 2017 09:02:42 -0800
In-Reply-To: <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
        (Jacob Keller's message of "Tue, 12 Dec 2017 21:40:12 -0800")
Message-ID: <xmqq8te6y30t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F6991FE-E027-11E7-8506-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I know we've used various terms for this concept across a lot of the
> documentation. However, I was under the impression that we most
> explicitly used "index" rather than "staging area".
>
> Additionally, I think there are many other locations which
> consistently use "index" as the term already.

Another reason why we would want to standardize in the other
direction is because "X acts as Y" does not mean "X is Y".

It is true that we (and also "newbie friendly" tutorials) often
explain the index like so: "When working towards the next commit,
you improve the contents a bit in the working tree, you 'git add' it
to the index to make the contents of the index closer to what you
want to have the next commit.  The index works like the staging
area."

But that is not the only thing the index does.  When "git merge"
finds conflicting changes, it adds the contents for common, our and
their variants to the index for the path.  This is quite different
from how you use the index "as staging area"; the index is being
used as the "merging area".  When "git clean" wants to see which
paths it finds on the filesystem are not of interest, it consults
the index, which acts as the list of paths that are of interest.
