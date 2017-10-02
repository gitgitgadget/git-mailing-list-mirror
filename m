Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DB7202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdJBE0Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:26:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57916 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750798AbdJBE0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:26:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B760B93EBA;
        Mon,  2 Oct 2017 00:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0GL6B0whzKFlhehtG5XEXhA0y3o=; b=DwagVX
        Y2l1eTs9tATc5bPC7fsCexrqK6LaXOO83RxC74XYndJQkAWmU5wDLFOB3id3rSca
        OnDTTZWYPpdjRC0wkooXDGJWQhfP9PJkcpG3B9FSlXjMtdgKd2UHCgJxr7qMhg/F
        nLOJ0M269Nb6hAO4bwMwKvhVBWF0WiDs3rpNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NMc7jMRZoEU6DBR7QyMbC4quPe4Zh6tL
        l7q1BjhLoK/8TaOTFZri/VXwKlE5bVb/TSeK8VWAV0PzZWIwkWaLOtKn5Q7H4iH0
        fx1LtEH8gPaeZlw4oeYSj/7XpecgXoRpKWQdLAMDehtUD2C+jQpcQ2hSq78H4llc
        nKvzFQCSzr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE88E93EB9;
        Mon,  2 Oct 2017 00:26:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24FA193EB8;
        Mon,  2 Oct 2017 00:26:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
        <20171002003304.77514-1-me@ttaylorr.com>
        <20171002003304.77514-6-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 13:26:21 +0900
In-Reply-To: <20171002003304.77514-6-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 17:33:04 -0700")
Message-ID: <xmqqo9pqp442.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8D8F8F0-A729-11E7-97FD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> A caveat: trailers_atom_parser expects NULL when no arguments are given
> (see: `parse_ref_filter_atom`). This is because string_list_split (given
> a maxsplit of -1) returns a 1-ary string_list* containing the given
> string if the delimiter could not be found using `strchr`.

OK.  That's unfortunate, but the solution here is far cleaner and
simpler than fixing string-list-split.  Thanks for an updated
explanation here.

