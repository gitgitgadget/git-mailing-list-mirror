Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A3C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8781C20719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z34ac+rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCWUuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:50:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51927 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWUuy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:50:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E3B7BD0AC;
        Mon, 23 Mar 2020 16:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jVMonrdWLqVANyVOFn3JymBzABc=; b=Z34ac+
        rAuJT6ZQvy6zxpMCNgpifR97P9bzbiXgrey8frFPYNRFai3p/uMXnpjN6OhqB8Mu
        xDL4zRtwnOeTNibc445f0LphDCwi9XFlbqpbs5O8KVyy24bRfTXVyXRB3yrqMz/D
        iPCBdVNuhZdAVqcywQUG1EhPwa/V5UQJ7mk28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QL8fy0oc99H6rG4TmyvA4Hje8i3koUCK
        lvAh/7ImyxO5vB1PnvCSulYfx4s0avvmfaHtwfVc4dSeSz2cSSAN8g/tPf4d/pyv
        E/q27J7StU6JoGTWZIsnvbKpySiuy7Wn3OkghuEMB1fiT/s+vu6U7NdO4fjlOsvy
        Ts07huNsJNk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85F6EBD0AB;
        Mon, 23 Mar 2020 16:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7834BD0A6;
        Mon, 23 Mar 2020 16:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
        <20200323150449.GC11801@danh.dev>
Date:   Mon, 23 Mar 2020 13:50:48 -0700
In-Reply-To: <20200323150449.GC11801@danh.dev> (Danh Doan's message of "Mon,
        23 Mar 2020 22:04:49 +0700")
Message-ID: <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA57812C-6D47-11EA-8AA5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> A comment in test-lib-functions::test_cmp mentions that
> there _is_ a diff out there that doesn't understand "-u".

That came from 82ebb0b6 (add test_cmp function for test scripts,
2008-03-12).

The change history at the end of the page:

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html

suggests that POSIX did not require "diff -u" until Issue 7, so it
is not surprising that the lack of "diff -u" to cause test_cmp to
fail was of real concern back in March 2008, as the application of
the errata have been only an year and half old, according to:

  https://www.opengroup.org/austin/docs/austin_325.txt

I vaguely recall that some open source projects only took the copied
context diffs and not unified ones the last time I checked, but
admittedly (1) that "last time" was a long time ago and (2) our
popularity and the fact that we do not understand copied context
[*1*] may have forced people to move away from "-c" and adopt "-u"
at the same time.  

So it might be OK to write off any system that does not understand
"diff -u" as an unusable trash these days ;-)

IOW, I think I am fine with assuming "diff -u" is available, like
Dscho's patch does.

Thanks.


[Footnote]

*1* It used to be my desire to teach "git apply" and "git diff" to
    also work with copied context format, but procrastination made
    it less and less relevant X-<.
