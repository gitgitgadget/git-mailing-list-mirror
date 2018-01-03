Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B7B1F42B
	for <e@80x24.org>; Wed,  3 Jan 2018 23:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeACXxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 18:53:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750913AbeACXxR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 18:53:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D64D4C8B;
        Wed,  3 Jan 2018 18:53:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ebhLBbd44kWs36dOr5lpZWF2suk=; b=jlRAyy
        burEu1/UNwhXXkiEoQgi/VrkYLiBs1uj/jF2PAuZJWkejG16QAWhH5Ubhh4mfZ4z
        gLlnYwJtBLn6jE9W2EM+Xw0g/zGmSvGuufs5h2g64bQ4TcR/mbMrrocaOgJhoOny
        pDV/+22nqgKbub5XHaavB+dMgqZJ7l4iovMkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g0P8MuRRe8DgQB0JaX/ntLxBU9jFUrrr
        1GcwrzBxnwbK38aK8yJRiUGgNK5nBZQm7FbdqqzQIKBA/N4iPsCqs/LSc0etIlCM
        HamT/0FCtaEXj8+1SgANSTU2Z4XtzLwrbqon+LbhWSKgI3vaMsRe7K7CfJQC6U6M
        iRQsofmUtDc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1226FD4C8A;
        Wed,  3 Jan 2018 18:53:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8992AD4C89;
        Wed,  3 Jan 2018 18:53:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cheng <johnlicheng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Misleading documentation for git-diff-files (diff-filter)
References: <CAJzZBAT--X8GXg_knege_pZ8A=_Qk9nyMCLaoRMvjhUFGQYsZA@mail.gmail.com>
Date:   Wed, 03 Jan 2018 15:53:15 -0800
In-Reply-To: <CAJzZBAT--X8GXg_knege_pZ8A=_Qk9nyMCLaoRMvjhUFGQYsZA@mail.gmail.com>
        (John Cheng's message of "Wed, 3 Jan 2018 08:07:03 -0800")
Message-ID: <xmqqvagifqj8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44828340-F0E1-11E7-BD05-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cheng <johnlicheng@gmail.com> writes:

> I wanted to know if git diff-files shows files that are not in the
> index but are in the working tree.

At least in the original design of Git, that would fundamentally be
impossible, as Git _only_ cares about paths that are in the index,
so a new file won't be in the picture until it is added.  Because a
change is shown as "A"dded by the diff family of commands only when
the old side lacks a path that appears in the new side, there is no
way "diff-files" that compares the index and the working tree would
see a path that is missing from the old (i.e. the index) side.
