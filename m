Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A57B1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 16:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGQQfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 12:35:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59049 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQQfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 12:35:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AACA6A371;
        Wed, 17 Jul 2019 12:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ttmw6IKCXF1hiralAvKTUGvX3k=; b=hjs3SG
        ffgxlKT7UTCoH9poeCEF0qn30P9Mc90zi2nb/XgeGqTlZLQ+xc7w+0H4XX2mTTcA
        +XCpN/qyOXZtpufm3Vbg0iAWLh0kxOcjyeSH0z8rXcL3RbluFqUEEKU+h03/U0lO
        48OJZ5+8XEmoTgDvOZIZaTg5JhUVnTYcGmZAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XHBXMsoheU7YYE32+Y1IeZUXiOWOTPKU
        zXUP3IRYWqaOY8knAoeZztqedr2rMQiUhrhpihh1UA0pkUWcDrQBRUN3VmVDWO55
        G+ihN04NIODFDQk6AOATBP5OX28XBLCTKMZk17gWoXyKS+n2d0jQzCfCJt82+/Uy
        AXqoxwBHSF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63A886A370;
        Wed, 17 Jul 2019 12:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 928236A36E;
        Wed, 17 Jul 2019 12:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thurston via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Adding git-ignore command, tests, and documentation.
References: <pull.264.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Jul 2019 09:35:34 -0700
In-Reply-To: <pull.264.git.gitgitgadget@gmail.com> (Thurston via
        GitGitGadget's message of "Tue, 16 Jul 2019 19:49:33 -0700 (PDT)")
Message-ID: <xmqqmuhc1uw9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7ADCAF6-A8B0-11E9-AF48-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thurston via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Instead of managing paths and relative paths such as echo
> "path/to/the/file.txt" >../../../../../../.gitignore git ignore
> path/to/the/file.txt No matter what directory that is in, the correct
> relative path will be added to the gitignore.

Hmph, do you mean you type something like this?

	$ cd path/to/the
	... work in that deep directory ...
	... realize that file.txt in that directory needs ignoring ...
	$ echo path/to/the/file.txt >../../../../../../.gitignore

Wouldn't this simpler to type and less error prone, as you do not
have to count ../?

	$ cd path/to/the
	... work in that deep directory ...
	... realize that file.txt in that directory needs ignoring ...
	$ echo file.txt >.gitignore

