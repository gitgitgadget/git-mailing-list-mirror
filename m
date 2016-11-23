Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92A91FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 22:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933813AbcKWWbL (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 17:31:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53270 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933256AbcKWWbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 17:31:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A74F50415;
        Wed, 23 Nov 2016 17:30:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=puQw2vVTXGdpvI0fI+QOkyR2C/A=; b=GU+8J8
        LP4XxaiyLKsHXtQuSyZck4LZIRRpjyPQTBEQVlzvJ2KJdW9wJPJtNt825NcfEGHP
        IYWIyaiPXJ2xUTDFyX63YMl2C7cdDSp9IFJAWAAtLB0Sxx5/jk3PHA9KmPj5GDNY
        NS1xWdERrmlFyABAXq774IhUFSXj/6Gaj3VmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vKweQZ1ehOHXz9OjX2UcyKe/1fBVNYxn
        1zsUE6HM2fWux5LCuwq+pXMlKdoqqHWUEUx/v2TjypkuwecRpgRNw9hOFTBhTFDV
        ClAZ4QzumxZeFhvW3N6jqZmeZt1AuJYGqoY23X8meBojUTN7Nfwn0p6qTEP6aArN
        a3USvgO1t58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEA1650413;
        Wed, 23 Nov 2016 17:30:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E5FC50412;
        Wed, 23 Nov 2016 17:30:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 1/1] difftool: add the builtin
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
        <cover.1479938494.git.johannes.schindelin@gmx.de>
        <3e9a2f31c779476c7524849a2e5307f2d3396fe8.1479938494.git.johannes.schindelin@gmx.de>
        <xmqqwpftltq9.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 23 Nov 2016 14:30:05 -0800
In-Reply-To: <xmqqwpftltq9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 23 Nov 2016 14:25:02 -0800")
Message-ID: <xmqqshqhlthu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 630464BE-B1CC-11E6-9ACB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... I do not think you can safely add these two bits here until the
> migration completes.

I accidentally removed a more useful bit I wrote after the above
sentence while editing.

The NEEDSWORK comment in 73c2779f42 ("builtin-am: implement skeletal
builtin am", 2015-08-04) mentions why it calls setup-git-directory
and setup-work-tree instead of letting run_builtin() do so; perhaps
you can do something similar here to fix this.

> I doubt that setting core.usebuiltindifftool to false and running
> the tool from a subdirectory and a pathspec work correctly with this
> patch.  If running difftool from a subdirectory with a pathspec is
> not tested in t7800, perhaps we should.
>
> It is nice that we can now lose PERL prerequisite from t7800 ;-)
>
> Thanks.
