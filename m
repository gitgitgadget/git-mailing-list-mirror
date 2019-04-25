Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E0C1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 05:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfDYFip (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 01:38:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56588 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfDYFip (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 01:38:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D53EC14EA6B;
        Thu, 25 Apr 2019 01:38:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TLElSibe58GsMUnRc8SShmcJJAw=; b=HSVv+R
        BuFhooooIG5Q+i4WWKKnJJiMV5PzGFgR0dLBtKsa4HAA4gXrGf9jfDY6/h0S8gYR
        fUXNPXkTlfRXqXbzWilQ1i640bOI6RzyG/RaxRGtas1LswBZaCygw/JDQhbZSFtz
        EdUWsi6f7A+WAlKMNqq6TQS3CAk4PXT+fzihM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pwOUJ60RhMMjOcBKeOmr+iOejQbCZq1H
        9h3H/VCqPXQzGVXv4QnPdA5eJt6FRSkmKpfsqxMr6g81Aro0h4jnu4KLq2lt0mhZ
        l5z1Fho5heWn630eYwYgjWA7IH8l8zqOU1AA32wBTtYF11/BoLZnrlM4M7Jcx1P8
        iyBjbALcyHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB86114EA6A;
        Thu, 25 Apr 2019 01:38:42 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43D6A14EA69;
        Thu, 25 Apr 2019 01:38:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 00/11] Create 'expire' and 'repack' verbs for git-multi-pack-index
References: <pull.92.v4.git.gitgitgadget@gmail.com>
        <20190424151428.170316-1-dstolee@microsoft.com>
Date:   Thu, 25 Apr 2019 14:38:41 +0900
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 24 Apr 2019 11:14:17 -0400")
Message-ID: <xmqqbm0uy78e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62A01038-671C-11E9-A698-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Updates in V5:
>
> * Fixed the error in PATCH 7 due to a missing line that existed in PATCH 8. Thanks, Josh Steadmon!
>
> * The 'repack' subcommand now computes the "expected size" of a pack instead of
>   relying on the total size of the pack. This is actually really important to
>   the way VFS for Git uses prefetch packs, and some packs are not being
>   repacked because the pack size is larger than the batch size, but really
>   there are only a few referenced objects.
>
> * The 'repack' subcommand now allows a batch size of zero to mean "create one
>   pack containing all objects in the multi-pack-index". A new commit adds a
>   test that hits the boundary cases here, but follows the 'expire' subcommand
>   so we can show that cycle of repack-then-expire to safely replace the packs.

I guess all of them need to tweak the authorship from the gmail
address to the work address on the Signed-off-by: trailer, which I
can do (as I noticed it before applying).

