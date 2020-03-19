Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C73C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 22:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D320772
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 22:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qQHy60Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCSWQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:16:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSWQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 18:16:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE319A9F8E;
        Thu, 19 Mar 2020 18:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vthkg9g0+5m3
        PWaexfi91WhEWnM=; b=qQHy60LgDbKGQuS2HXr5pe/bADFB3plsJaYWDSRTkN1k
        8VSNmm2NGPLPrkTKRvRwaLD6nx9JbXzjJAcRwAMXxkAGXlYF2hIxq7PtTZAVfUwM
        x1SNdetQIHNtVyaleMjvf9n8lsObo1wZwQbITDLQ/tud72syaOC6Qt4LWld3A5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DNqabC
        T2Y8MadWnEhPTzsNGvlhJ86Rcu9lszR/nDAMEwsHUDoILpBICUPPRMH528DJY5YC
        U4qpnOM8jm66GI+TEZMX3O/u8vf5xzsYyF2zhZbOhChTpIFxOwHTrj9fHCPnJOSF
        xo7DVQ2JFFevQSxgAySgExYwXpdu+1M1cEqkY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5876A9F8D;
        Thu, 19 Mar 2020 18:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15C61A9F87;
        Thu, 19 Mar 2020 18:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/6] t7063: use POSIX find(1) syntax
References: <cover.1584625896.git.congdanhqx@gmail.com>
        <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
        <20200319161200.GF3513282@coredump.intra.peff.net>
Date:   Thu, 19 Mar 2020 15:16:09 -0700
In-Reply-To: <20200319161200.GF3513282@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Mar 2020 12:12:00 -0400")
Message-ID: <xmqqsgi4c7o6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D3445F0-6A2F-11EA-AAA9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 19, 2020 at 09:00:06PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>
>> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
>> update feature, 2016-08-03), we started to use ls as a trick to update
>> directory's mtime.
>>=20
>> However, `-ls` flag isn't required by POSIX's find(1), and
>> busybox(1) doesn't implement it.
>>=20
>> Use an equivalence `-exec ls -dils {} +` instead.
>
> Makes sense. I wonder if we need all of "-dils", but it's not clear to
> me which syscalls actually trigger the FreeBSD lazy-update behavior. I
> guess probably it's stat()ing the directory, so "ls -ld" would be
> sufficient (and that's implied by the examples in 6b7728db81).
>
> But I doubt the extra options would create a portability problem, so I
> think it's fine either way.

Thanks.  I too wondered if -dils is really needed (POSIX of course
have all of them, but we have to deal with non-POSIX systems, too,
and I am not sure how things like "-i" works there).

s/equivalence/equivalent/; perhaps?
