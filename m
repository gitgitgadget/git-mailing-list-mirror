Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6914BC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D35214AF
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HrmVs7Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgDXUA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:00:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64357 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:00:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B83847135;
        Fri, 24 Apr 2020 16:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lnlwo0oD9QyfT8GmfJ0RH9TVm9E=; b=HrmVs7
        Yj4uK8gDTn1sEEyh1Ybd+ll+bI2aFPWxG6p3YDCgipoS3iEIJrwDpZTXzSYg0WUA
        ht7xpwc5Bo7G27dPLUroWK2qnLsUiNp146JILeqB7z5ehBKDfdNlexpppvAB90Zy
        tJOdZdzLdaNvlMF81a1XW/xrp3GBSxj7JlUjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eQpxRKyg2vrS7jNoI2FEkDle2KnyqwCD
        L14f7liQga7FfQj81+QTP7+LzqTKFpzqNIffOme4YMJKLaNMEC7JdonJDyQ65WkB
        TUipKityiprG4WznrYJM3JlX29g79kvdkUzeJUgQ3LgYhGwekMWzF2iKgXICGtkK
        OY/hUIehIbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FDC547134;
        Fri, 24 Apr 2020 16:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E09CC47133;
        Fri, 24 Apr 2020 16:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Garima Singh <garimasigit@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] minor fixups for gs/commit-graph-path-filter
References: <20200423205851.GA1633985@coredump.intra.peff.net>
        <dde036bb-303c-a9d1-6bf2-880428cfb7c0@gmail.com>
        <20200424165805.GC58621@syl.local>
Date:   Fri, 24 Apr 2020 13:00:23 -0700
In-Reply-To: <20200424165805.GC58621@syl.local> (Taylor Blau's message of
        "Fri, 24 Apr 2020 10:58:05 -0600")
Message-ID: <xmqqr1wcd57s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C9472E8-8666-11EA-9A65-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> To be clear, I don't care about them either ;). Maybe it's time that we
> relax that rule (if it seems that a good number of us don't mind it
> either way)..?

I'd prefer our reviewers (even more preferably the authors) to be
careful about new code, but it probably is not worth reviewing
patches that only fix them and do nothing else.

