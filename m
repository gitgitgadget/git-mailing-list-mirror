Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E604C1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933225AbcKNSBe (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:01:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54114 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932899AbcKNSBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 13:01:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FD094F4F4;
        Mon, 14 Nov 2016 13:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VberNBvpRd/4le9APXdaF31cr38=; b=QxjEcd
        DY/H5avlw4zIYqST7WeGd0h9JOKKOfvLwf9ucoRAqCtsi5XHb4GVO5gg5XWXQUX4
        Vejqq+xJFW9zodZltScyI8NDAtYhrAN8UrJ5NPPV4ALRAe3Wc54oomFX/ONrIhKa
        VnSivL4McHHCVZO0s5AeSa4ckx6bn6vpVZrDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7jW/2vuOlAhpz6ypDuOwui5OW0q6k8f
        qkByxOJ/ttumahTSEPIEZJ50Y6hCzk2ByPyBMqOnOZ78SVYR0IoVALqENDW+P56e
        c98ysNAmOGrh6T5KC3jW5GK181cAwBIj6P8ChSvouVlfYxQm10auSw8q+d8wFEgZ
        hWkmd6ojEMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 988B04F4F3;
        Mon, 14 Nov 2016 13:01:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0763B4F4F2;
        Mon, 14 Nov 2016 13:01:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
        <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
        <alpine.DEB.2.20.1611121106110.3746@virtualbox>
        <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
Date:   Mon, 14 Nov 2016 10:01:29 -0800
In-Reply-To: <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Mon, 14 Nov 2016 16:31:06 +0100")
Message-ID: <xmqqoa1ix7nq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F338D9A-AA94-11E6-83CA-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> *My* idea of --no-index was for it to behave as similar to the
> --index-version as possible, regarding formatting etc., and to be a good
> substitute for ordinary diff. The proposed patch achieves exactly that -

Does it?  It looks to me that it does a lot more.

> why should a *file* argument (which is not a pathspec in --no-index
> mode) not be treated in the same way in which every other command treats
> a file argument? The patch un-breaks the most natural expectation.

I think a filename given as a command line argument, e.g. <(cmd), is
now treated more sensibly with [2/2].  Something that is not a
directory to be descended into and is not a regular file needs to be
made into a form that we can use as a blob, and reading it into an
in-core buffer is a workable way to do so.  

However, when taken together with [1/2], doesn't the proposed patch
"achieves" a lot more than "exactly that", namely, by not treating
symbolic links discovered during traversals of directories given
from the command line as such and dereferencing?
