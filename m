Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA006C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEBE20848
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4mUk8Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgBLWnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:43:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60666 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:43:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F1034D380;
        Wed, 12 Feb 2020 17:43:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jTwgsaw0et2I5uJ4OzAlhPJgmGY=; b=j4mUk8
        LznJHXHBSbhfwJNcwkpIjPAm8LhSqTnIDwy/qX5b42YMHJ8202jl/pncSwT71Ntk
        b9Kh6LLoAe0lQ5Zlt87QccyGM3dYNc6ztPErblYFXAvMUBs9EyHAecZDBypohBA+
        DN1r8S0YvSxnkGDd9ROILEipjpllVGUFxm9OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b9w00ByOFOeSBmy3QfVEuUsJjTEegfDS
        /3d30PQai0cB1gxC80xDbnespHUZWwDpUU5jHKLlrp+xsjZb3gfVDjUsto998Ht9
        qX4XOX3cnFI+JNw584ZbTtsOUeODMnNF+meU1UJ4YyLkEdWFgA5W4CekPfYC6pW1
        tROdxsZuY38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5725C4D37F;
        Wed, 12 Feb 2020 17:43:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9BFCF4D379;
        Wed, 12 Feb 2020 17:43:19 -0500 (EST)
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
        <xmqqa75t3l1h.fsf@gitster-ct.c.googlers.com>
        <CAJB1erWuCTYtGdjiwBT3hhbH5Jrdr+cE8duwtoH=P7Fe6BmUpg@mail.gmail.com>
Date:   Wed, 12 Feb 2020 14:43:17 -0800
In-Reply-To: <CAJB1erWuCTYtGdjiwBT3hhbH5Jrdr+cE8duwtoH=P7Fe6BmUpg@mail.gmail.com>
        (Masaya Suzuki's message of "Wed, 12 Feb 2020 14:13:29 -0800")
Message-ID: <xmqqftfftoje.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11069BB6-4DE9-11EA-9915-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> Anyway. Is it OK with adding this small note on "prereq is not a
> shallow boundary"?

I thought the text in the latest round is good as-is.

Thanks.
