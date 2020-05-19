Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84362C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21979207C4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 23:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XiHD1Zaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgESXV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 19:21:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56374 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESXVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 19:21:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C9C757638;
        Tue, 19 May 2020 19:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TqeLFmH8Vl6QKbrWFnq2xHYeFqw=; b=XiHD1Z
        azkK+TdGeNmsI9aFDYBJ4nxIiAcMmYpB9wYCYNGXlKXq6XWjIGR54+13ZPQaF8Vm
        O3dVeQG7i8OfYq+HcxBHlPD3vmCZT44Y8Xi+FsOCDSYhhpbctQ8AvZw/oM5fttxI
        GO0CKg75xMR7zxe4iWQNc0RMDs6QqZKuvW23g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DrDb/O4697g0JFqUnN3mY4yWPFScAPoJ
        amUM3kUmpOm9ydS8xqoNlqMo0jRuqTu/RVuWpx6Zqvh+aHHmtZjBVHDEK2WX/JNi
        mBHKPICqFJbesCTja0nQa42b4lr2BiauRza7NzUn3NxBvF7XRY1t4lTFgg1yW8Oe
        Q0EDmy08YB4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92CB957637;
        Tue, 19 May 2020 19:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11B1957636;
        Tue, 19 May 2020 19:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.27.0-rc0
References: <xmqqy2punll7.fsf@gitster.c.googlers.com>
        <CA+kUOanbgUPgCer-sBjX6YROYvZAhzBTUtCnFvuYP1EWvo3VEA@mail.gmail.com>
Date:   Tue, 19 May 2020 16:21:22 -0700
In-Reply-To: <CA+kUOanbgUPgCer-sBjX6YROYvZAhzBTUtCnFvuYP1EWvo3VEA@mail.gmail.com>
        (Adam Dinwoodie's message of "Tue, 19 May 2020 20:10:37 +0100")
Message-ID: <xmqqwo57y0i5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74204758-9A27-11EA-9CC7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

>>       tests: when run in Bash, annotate test failures with file name/line number
>
> At least on Cygwin, this breaks the test output parsing of failures
> when running with prove.

We'll revert this problematic topic out (which hasn't happened yet),
which I hopefully will be able to merge to 'master' before tagging
the -rc1 release candidate.

If possible, could you test the result of merging e31600b0 (Revert
"tests: when run in Bash, annotate test failures with file name/line
number", 2020-05-15) into 'master'?

Thanks.
