Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4938B1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 21:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfILVmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 17:42:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfILVmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 17:42:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2ED757AE63;
        Thu, 12 Sep 2019 17:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k8OcKsLRyno7UCxZehGvruRgX/4=; b=GnrpDq
        wNiTZLiP2JV+46MFDpXkcbSoIk56XbFXZJnh30kLq/uNAKq6AG20qcC6hiMfv0ST
        djwFz2ABefSpXwxoeuGIts7hwB1ylFtpuW+IxoV5f0D/jLBBJRru++cwqgzh0WXC
        1kbtPUb6om7XaLgqTM8X7QpxUT2fA5PoD4ido=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gslOlto0IGA4a/kEJdUW5ir5LmU/eRTq
        AbXK/gUQzttef1kL8c8gSyy9w4OP+VQ8aBXPB0F0+c0wSHwseT/WlvaaqMXNu/jR
        m7fLSkGGY9iZEyWPO3QMaB7u+lJ7nJDIMs7GQZjkham5pYsaDZkF2xS3E9ZVnkCh
        dn+ZkmvVH9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27B737AE60;
        Thu, 12 Sep 2019 17:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 557D57AE5F;
        Thu, 12 Sep 2019 17:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Makefile: define THIRD_PARTY_SOURCES
References: <cover.1568101393.git.liu.denton@gmail.com>
        <cover.1568309119.git.liu.denton@gmail.com>
        <3878cb2598c677d139c8734b61772d0cdcfdb935.1568309119.git.liu.denton@gmail.com>
Date:   Thu, 12 Sep 2019 14:42:02 -0700
In-Reply-To: <3878cb2598c677d139c8734b61772d0cdcfdb935.1568309119.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 12 Sep 2019 10:28:30 -0700")
Message-ID: <xmqq5zlxfaz9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 292D2EC8-D5A6-11E9-9ECC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> After looking through the source files in compat/ and investigating the
> files' content and/or its Git history, I've determined the list of files
> that were copied from a third-party source. Place the names of these
> files into the THIRD_PARTY_SOURCES variable in the Makefile.

Please make sure readers won't get fooled into thinking these are
filenames.  They are meant to be used in $(filter-out) as patterns
to match the names of third-party source files.

Also, the paragraph before that talks about "I did this", but
claiming credit is much less important than why we are doing this in
the first place, which you forgot to say (perhaps because you were
too deeply into the task and the motivation was too obvious to you).

So, if I were doing this patch, I'd justify the whole thing as such:

	Some files in our codebase are borrowed from other projects,
	and minimally updated to suit our own needs.  We'd sometimes
	need to tell our own sources and these third-party sources
	apart for management purposes (e.g. we may want to be less
	strict about coding style and other issues on third-party
	files).

	Define the $(MAKE) variable THIRD_PARTY_SOURCES that can be
	used to match names of third-party sources.


>  
> +THIRD_PARTY_SOURCES += compat/inet_ntop.c
> +THIRD_PARTY_SOURCES += compat/inet_pton.c
> +THIRD_PARTY_SOURCES += compat/obstack.%
> +THIRD_PARTY_SOURCES += compat/nedmalloc/%
> +THIRD_PARTY_SOURCES += compat/poll/%
> +THIRD_PARTY_SOURCES += compat/regex/%
> +THIRD_PARTY_SOURCES += sha1collisiondetection/%
> +THIRD_PARTY_SOURCES += sha1dc/%

Before this block, please explain that this is meant to be a list of
patterns suitable for $(filter-out) and friends in a comment.

Thanks.
