Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE8C2BA83
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 01:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F90B20715
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 01:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eznbm3yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgBHBt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 20:49:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60591 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBHBt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 20:49:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98EBBAAEC5;
        Fri,  7 Feb 2020 20:49:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCgGMA1YV6cnfVyU0Xq0SFXOlgI=; b=eznbm3
        yJNeOzIAxp+lCLQuNqsYMzi+QpVdWieS97gZfHbb7Hqkxkg+TT+Us0fo4QOEEvgb
        lK9rt8J6Y67vTlwY+bYFF8U9Tg/ORfelUtrhnUfGrNZXhwixtc9ZVw1Y0UPuXQ1H
        J3H2rloQnhHbWKdJpYAawWiBRQRjd7KpTwBh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O0WYyfV+mAVEVpRR5rcAV4gF4tUwzt1+
        ucoBurI22Ni6eHYqztRqfVgfhiNqZup5bJdD0pTyvwv6CkTkzqRH9J2pxeZH3LKt
        NJ9aIOZPRMN5aO/mJKdy+seNuDtYGuYULtJ7Ndkphjkd7LmCM45D2fWAvA2eNCug
        nkQSQKrCtfk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90D2BAAEC4;
        Fri,  7 Feb 2020 20:49:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9F58AAEC2;
        Fri,  7 Feb 2020 20:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] doc: describe Git bundle format
References: <20200131221800.240352-1-masayasuzuki@google.com>
        <20200207204225.123764-1-masayasuzuki@google.com>
        <CAJB1erXMR_aCqVPsH6WQZdC7yybOBCUbwkJDv3LtU2f0ymNmbQ@mail.gmail.com>
        <xmqqlfpe2jx3.fsf@gitster-ct.c.googlers.com>
        <CAJB1erVZ5E6FxtD8gJXXpzJjquvksLxpz+h1TzG52Yr9DFmDRQ@mail.gmail.com>
Date:   Fri, 07 Feb 2020 17:49:46 -0800
In-Reply-To: <CAJB1erVZ5E6FxtD8gJXXpzJjquvksLxpz+h1TzG52Yr9DFmDRQ@mail.gmail.com>
        (Masaya Suzuki's message of "Fri, 7 Feb 2020 14:21:37 -0800")
Message-ID: <xmqqa75t3l1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A3223E2-4A15-11EA-BF31-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> Yes. The reason that I've been trying to check the semantics of the
> prerequisites is that I DO recognize that this is possible
> format-wise. I'm not sure if this Git implementation can create such
> bundles, but format-wise such bundles can be created.

Yeah, now I get it.  

The problem is *not* that v2 format "cannot represent a shallow
clone repository", but is that there is nothing that prevents a
bundle in v2 format from depending on objects behind (not just at)
the shallow boundary, making it impossible for a reader to guarantee
that a bundle with prereqs can be used to create an equivalent
shallow repository with shallow boundary at the same place as
prereqs.  IOW, bundle with prereqs in the v2 format allows more
objects to be omitted than an equivalent shallow repository omits,
because prereqs and shallow cutoff points mean different things.

While we are at it, I suspect that with reachability bitmap, a "git
fetch" that updates a history up to commit A to a new history up to
commit B can omit more objects than what is directly reachable from
the commit A.  That is, if A's direct child (call it C) is a commit
that reverts A, a blob in A's tree won't be in the bundle (because A
is a prereq), but the blob at the same path in C is the same blob as
the blob at the same path in A's parent (that is what it means for
that A's direct child to be a revert of A).  In the normal
enumeration based on object-walk to decide which objects to send,
such a blob in C will be included in the pack, but a reachability
bitmap can say "if we assume the reader has A, it must have A^1, so
that blob should exist at the reader, hence can be omitted from the
transfer even though we are sending commit C."
