Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA3C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D03D2075E
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+U4S3Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHZQJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:09:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60628 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHZQI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:08:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4793C7D11A;
        Wed, 26 Aug 2020 12:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kIr0PHPRj1BAmQdVz37cYr/OQfc=; b=H+U4S3
        Cyf7NXJML91OGc/yqm8u4XucJwI6x/e/4RTnpIAZSkwDhR2Ph9oEpvwcMgESyBWl
        Akf0GKhBtdAi2BKnT0ga+09SGhnaYVqVxha8PQAWgX8SU0OJGAGmSCC7VwF2+1AP
        +2KBsR2e92rT4v4KEI7q/UkCZdnke0EthGv14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N0NgU2GlKxw4MBp46L4powCt1OCZvT+b
        GA6lT6pM7w4c6UHnj9ZitPLb2R3sB7PHdCYzJ/P+w8nSWWUuuHu55VpL6vXSIruC
        fpaz0Kg2NVeuTh6/qkyqYA3XUYhkd6h0S27v6FGsO5HJ/txQv+itPid6fB1lsQDu
        Zut3Yc3cqNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F4477D119;
        Wed, 26 Aug 2020 12:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2E807D118;
        Wed, 26 Aug 2020 12:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 2/3] cvsexportcommit: do not run git programs in dashed form
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-3-gitster@pobox.com>
        <CAPig+cR-eYCVQLRa0rVhgJ8L60-zCS_aK6_nVERcrXSyApdihw@mail.gmail.com>
Date:   Wed, 26 Aug 2020 09:08:53 -0700
In-Reply-To: <CAPig+cR-eYCVQLRa0rVhgJ8L60-zCS_aK6_nVERcrXSyApdihw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 25 Aug 2020 21:28:29 -0400")
Message-ID: <xmqqa6yhxucq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 709B3E6C-E7B6-11EA-8903-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>> This ancient script runs "git-foo" all over the place.  A strange
>> thing is that it has t9200 tests successfully running, even though
>> it does not seem to futz with PATH to prepend $(git --exec-path)
>> output.
>
> t/test-lib.sh takes care of that for us, doesn't it?

Actually, it is "git" itself.  

The tests spawn "git cvsexportcommit" via the "git" dispatcher.  The
dispatcher adds GIT_EXEC_PATH to PATH in exec-cmd.c::setup_path()
and that is used to (1) locate "git-foo" from /usr/libexec/git-core/
that are not builtin and (2) passed to any processes we invoke.  I
think the latter was originally done primarily for not breaking
hooks, but that is what allows this script going in this particular
case.

If this were only a fluke in the test that kept otherwise unrunnable
script passing, I'd say it is an evidence enough that lets us drop
the cvsexportcommit immediately, but now I rediscovered how it was
supposed to work and saw how it actually does work as designed, I
would not be surprised if it is still used in the wild.

Thanks.



