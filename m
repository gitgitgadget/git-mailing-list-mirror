Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8FE1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbcJTSqU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:46:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934225AbcJTSqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:46:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F0FC479F2;
        Thu, 20 Oct 2016 14:46:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VSS7PYgU62u2T6ZJS75r7Ap9C2w=; b=uTQf6w
        PFjFdeQMOVYwDbr4ZB69JTF3adufpHa5mV0GK2iRaUAygDwHbRiLTtTkRkuR+VND
        YqjTjx2rOkY+ZuPOuJeQuc0W3OCnaPu1qGQmtJuPyYIoY0Cta6fgXju0KLRMct9+
        RAu36TwY+ex+fgNLNF9VFB0pK5hP0njLbNdPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YjfXL41MKIyl4L+oHnpcMcljn0B19/Or
        AgvqpstFn+zt/sE5DK2ey/M4r3tjT6CvAaKfWPoVna2WW8BfnXhsZLypOvZ7Js4m
        122ETi6bTTBNUlkS/pOxnHcIEYDFmZFlHUSRdkCUm8Of40S6XyEM0NoU7GL2Hyj6
        zr+7LX9Gvgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0412E479F1;
        Thu, 20 Oct 2016 14:46:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 632F5479F0;
        Thu, 20 Oct 2016 14:46:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header mode
References: <1476908699.26043.9.camel@kaarsemaker.net>
        <20161019210448.aupphybw5qar6mqe@hurricane>
        <xmqq4m48j70o.fsf@gitster.mtv.corp.google.com>
        <1476986671.28685.5.camel@kaarsemaker.net>
        <CA+P7+xq5bo-Fwa95j3aynjMP0Qw+PiuMt=hc4ngvTDpeG8nhPw@mail.gmail.com>
Date:   Thu, 20 Oct 2016 11:46:14 -0700
In-Reply-To: <CA+P7+xq5bo-Fwa95j3aynjMP0Qw+PiuMt=hc4ngvTDpeG8nhPw@mail.gmail.com>
        (Jacob Keller's message of "Thu, 20 Oct 2016 11:12:23 -0700")
Message-ID: <xmqq8ttihn9l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B85512A-96F5-11E6-AF46-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I did some searching, and we do use sed so I replaced it with sed \$!d
> which appears to work. I think we should probably implement a
> test_ends_with_nul or something.

As it is "a stream editor that shall read one or more text files", I
do not think "sed" is any better (or any worse) than "tail -n" from
the portability point of view.  They both may happen to work on GNU
systems.
