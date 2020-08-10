Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB301C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFA72075F
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CfwEUMdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHJPPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:15:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64592 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHJPPq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 11:15:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94C1685197;
        Mon, 10 Aug 2020 11:15:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MJ/pQKcuF8F+
        moEbsFl60Zw+76o=; b=CfwEUMdpR+I/A0nJaztYCEJ1pQGKbKLTJhHYFJkOzqcO
        yjp526OqPfTCaHo85k3Tl9KYuAFP4dIK1Qje7pYR3TU9LDQhYMk5/QRjWfeIMOnI
        X9vkEGHWc/iNyqu2JW5Xxsm8TK0HVlVFGvtWwn/CL9pPyMQcswfCZg38ja/vJu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uuFpmB
        Xu1kVxkiSWRZl8ZF6HG3xuezAbqZAMjqx0uJjOl2wS7LXfSsutVg5WxdIKufxI2j
        RH5JDBMWlPQWoFHzLiBNmOX3vcKPZSg8SqCJ1dUpJKwGP42BSEKyrAX43lMzcNVZ
        Q+w4EsPtr/muEqkpPIfPWfOXVOiIw04bbjj2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D05285192;
        Mon, 10 Aug 2020 11:15:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01B3585183;
        Mon, 10 Aug 2020 11:15:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <xmqqd03zej8w.fsf@gitster.c.googlers.com>
        <20200810100038.GB37030@coredump.intra.peff.net>
        <20200810123148.GB17119@danh.dev>
Date:   Mon, 10 Aug 2020 08:15:41 -0700
In-Reply-To: <20200810123148.GB17119@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Mon, 10 Aug 2020 19:31:48 +0700")
Message-ID: <xmqqy2mmcz1e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5AFC06DC-DB1C-11EA-977A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Reading both of your two's emails, I think this one could be used:
> I'll resend this serie if this serie is deemed useful with this
> explaination.
>
> 	diff: index-line: make object name's abbrev length configurable
>
> 	There are some projects that want to archive and track only
> 	released version of other software projects. They also want
> 	to backport some changes into those versions unsupported by
> 	upstream. Most of git hosting services support some method to
> 	download patches without cloning the full (potentially large)
> 	repository and/or fiddling with git partial-clone or
> 	sparse-checkout.
>
> 	Most of those git hosting services generate those patches with
> 	git-format-patch(1) or something alike. Due to its large
> 	amount of objects, their object names' abbreviation in the
> 	index-line is usually long but not full.
>
> 	A lot of those patches couldn't be applied cleanly to old
> 	versions of said software, thus requires some changes from
> 	developer and they needs to be regenerated from their trimmed
> 	tree. Because the archive tree has significantly fewer
> 	objects, the abbreviation in the index line is usually shorter
> 	than the original patch. Thus, it generates some noise when
> 	said developers try to compare the new patch with the original
> 	patch if there's an exact file-hunk match.
>
> 	Make the object name's abbreviation length configurable to
> 	lower those noise.

I agree with Peff that with the above as the sole motivating use
case, the "--full-index" option is the right approach.  It is a much
more robust solution than "--abbrev=3D16 would be long enough for all
project participants to avoid length drift".  IOW these four
paragraphs do not argue _for_ this change, at least to me.

On the other hand, I think you could argue that "--full-index" is
merely a synonym for "--abbrev=3D40", and the patch fixes the
inconsistency between the object names on the "index" line, which
can choose only between the default abbrev length and the full
abbrev length, and all the other places we show object names, which
uniformly honor the "--abbrev" option.


> 	<Below is the  note in 2/2, I don't know if it's worth put
> 	into commit message>
>
> 	To preserve backward compatibility with old script that specify
> 	both --full-index and --abbrev, always shows full object id
> 	if --full-index is specified.
