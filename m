Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5A9C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E6E2070A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OTQuWI/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgETROR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:14:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59379 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETROQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:14:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 011C7DA768;
        Wed, 20 May 2020 13:14:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OHYSi0YkED13
        Z2jHdQ0oP3gsfgY=; b=OTQuWI/c+Bmb9QorJ7el6DrFG/RNlV4RsApe9W2T3B5V
        mnGGdud7B6fABz8PH+9ZvBtM3Ac/muHx5xXK6YfWyk0uURn3VSuTm5TK90gIXxL5
        TqIgCPJI3a6mJjUaafxZk7z7fN7HpD/jdl+b9LPU9lZYkO+e5qmidjbpKOuMM+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Bk3X3W
        CvmMAHY6OWu3NAl0r6sIp+sIm2vSGnGK2ZgeG01R1/drngj8fCyaamegp13YhUUA
        rV9zTIc5xJLVjKEDXWf1+d1r2pZd1jAsiUwRAzT8FWCoB7jBPe/9P+9fnUKJGYMR
        eP1UDq4HH5p77yhh/0Yf7eQIWeDSJE85Y0CJM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED06CDA767;
        Wed, 20 May 2020 13:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 975B7DA766;
        Wed, 20 May 2020 13:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com
Subject: Re: [PATCH 2/3] bisect: remove CR characters from revision in replay
References: <20200520034444.47932-1-carenas@gmail.com>
        <20200520034444.47932-3-carenas@gmail.com>
        <xmqqzha2wt7t.fsf@gitster.c.googlers.com>
        <20200520170843.GC20332@Carlos-MBP>
Date:   Wed, 20 May 2020 10:14:09 -0700
In-Reply-To: <20200520170843.GC20332@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 20 May 2020 10:08:43 -0700")
Message-ID: <xmqqeerewmu6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52C4B102-9ABD-11EA-B3DA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> that works (kind of), but will cause test t6030.66 to fail, with a git
> segfault nonetheless, because we can't handle anymore a line line:
>
> git bisect start '--term-new' 'term1' '--term-old' 'term2' '32a594a3fda=
c2d57cf6d02987e30eec68511498c' '88bcdc1839f0ad191ffdd65cae2a2a862d682151'

Yuck.  Thanks for noticing.

> will follow up with a fix for the segfault, unless someone else beats m=
e to
> it.

Thanks.
