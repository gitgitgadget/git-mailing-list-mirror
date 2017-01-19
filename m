Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BBE20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdASVHk (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:07:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59177 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751076AbdASVHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:07:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E355C6196D;
        Thu, 19 Jan 2017 16:06:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yI4SnJo4Kg1rW2RGA9iT45VFJTs=; b=pPsvSQ
        wZFk8aJ/F+cdpCi6wsC2EtN/m24Z5ftEMcTehdXH/4wt+L97OzdIZUUqzSIL4lRq
        qCJ9k4rcp4n9q6vL7aODSjqNCuUPCNCN/OkQ517eqzTDy6NCs7mlvHJQurtX3Efx
        ZBd0YDpfTJatZaHVdHL3VABWk+fRb/Jwian6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jzc4oai1uAF2jF7Q1YXHrnqkgwia+uuV
        qlwZ4R6NTJwL9oJNOGctgKVgkHlNs/v1fjDBywJnL42IcTa1FcI/0UO/GYob0sny
        XgazTmhM29PSMb6oE499hbh76JBKu7+aUGYawvXssqv34McLRxlcQGl/uvpj6W3x
        RHH8g4iEhFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8E1C6196C;
        Thu, 19 Jan 2017 16:06:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 313BD6196B;
        Thu, 19 Jan 2017 16:06:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 2/5] name-rev: extend --refs to accept multiple patterns
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
        <20170118230608.28030-3-jacob.e.keller@intel.com>
Date:   Thu, 19 Jan 2017 13:06:46 -0800
In-Reply-To: <20170118230608.28030-3-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 18 Jan 2017 15:06:05 -0800")
Message-ID: <xmqqfukezrmh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3041A712-DE8B-11E6-98FE-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git name-rev to take multiple --refs stored as a string list of
> patterns. The list of patterns will be matched inclusively, and each ref
> only needs to match one pattern to be included. A ref will only be
> excluded if it does not match any of the given patterns. Additionally,
> if any of the patterns would allow abbreviation, then we will abbreviate
> the ref, even if another pattern is more strict and would not have
> allowed abbreviation on its own.
>
> Add tests and documentation for this change. The tests expected output
> is dynamically generated, but this is in order to avoid hard-coding
> a commit object id in the test results (as the expected output is to
> simply leave the commit object unnamed).

Makes sense.  

I do not see anything that requires "... generated, but" there,
though, as if it is a bad thing to do to prepare expected output
dynamically.  I'd just reword "generated.  This is..." to make it
neutral.
