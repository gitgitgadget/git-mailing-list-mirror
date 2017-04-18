Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106341FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 00:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbdDRA00 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:26:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62714 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751528AbdDRA0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:26:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFDCF72B29;
        Mon, 17 Apr 2017 20:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EenmiWWTsyLkJ+oEidN7O4BS7Yw=; b=m9ZxmO
        QNj1TfBv8jjbfQyyqcZSvdUyYz4o3HJdVkOsVIsuB702lxGKGU2W+DZwFxREIuQH
        edBg+6zsR7UIejnvXey6O9tLiQTeOMVybeN3A3WO53WrH+GdsO5tAjFFdw6ngKjx
        pGNrCCszouqqHhQ6DRXehCc0HmF0mEjG0c9+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M9ZsVHeISggyDZIDzqomKakPnzWWYeIW
        z9Bdz9NmGfLZM/N3KIqxToW8mGKdGRWnlIMTmfeG+uZnw5v5LXKUdQA3Z4a8U6eM
        vhRrJs9DJo6rZvZ9Q3S/2L3pkmLFyoMcFA1mzCk1G2hDZuu+D/yujOrQN2rjAdbp
        JBXQVKHFIuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6E1B72B28;
        Mon, 17 Apr 2017 20:26:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4012372B27;
        Mon, 17 Apr 2017 20:26:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
References: <1492287435.14812.2.camel@gmail.com>
        <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
        <1492347718.19687.14.camel@gmail.com>
        <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
        <1492368692.22852.9.camel@gmail.com>
        <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
        <1492380399.19991.13.camel@gmail.com>
        <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
Date:   Mon, 17 Apr 2017 17:26:22 -0700
In-Reply-To: <5EBADDE444D141918F6873BE8456E026@PhilipOakley> (Philip Oakley's
        message of "Mon, 17 Apr 2017 17:04:05 +0100")
Message-ID: <xmqqefwqims1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6DB90A4-23CD-11E7-8934-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> I'd guess that the misunderstanding is that you maybe thought that the
> whole directory would be reset to it's old state and the files b and c
> deleted, rather than just the named files present in that old commit
> being extracted. If we'd created and added a file d just before the
> checkout, what should have happened to d, and why?

It probably is a bit unfair to call it "misunderstanding".  I've had
this entry in the "Leftover Bits" list for quite some time:

    git checkout $commit -- somedir may want to remove somedir/file that
    is not in $commit but is in the original index. Anybody who wants to
    do this needs to consider ramifications and devise transition plans.
    Cf. $gmane/234935

In the thread, this message:

https://public-inbox.org/git/xmqqeh8nxltc.fsf@gitster.dls.corp.google.com/

may be a good summary.
