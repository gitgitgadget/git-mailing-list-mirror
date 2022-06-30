Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93501C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 15:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiF3Pyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiF3Pyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 11:54:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6F1AF23
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:54:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E9D113399C;
        Thu, 30 Jun 2022 11:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RlmOEfb9F7MTaT5lc1IeelXXA834hHLjIh42P0
        squfE=; b=MTiA94C8QUDhZivjfMzRjOaaaz0RWFyndxxX44d1jorp+sXPepShRY
        veVAmaPpqwbdUyYjeZpNtUNS7bCi9svWADfTZzIftwRDgauBXaouF0bPA6VgHaRX
        35MByO+A8DLNqiTT3PpwT45SFtc8A+9ZcRll4ZW/aXLHuoHqvPdZ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96F5513399B;
        Thu, 30 Jun 2022 11:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02E7913399A;
        Thu, 30 Jun 2022 11:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] ls-files: update test style
References: <pull.1269.v2.git.1656407664694.gitgitgadget@gmail.com>
        <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com>
        <xmqqzghwim3m.fsf@gitster.g> <2022062915111229306214@oschina.cn>
Date:   Thu, 30 Jun 2022 08:54:25 -0700
In-Reply-To: <2022062915111229306214@oschina.cn> (lilinchao@oschina.cn's
        message of "Wed, 29 Jun 2022 15:12:13 +0800")
Message-ID: <xmqq1qv6gn9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB69C4B8-F88C-11EC-AF36-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

>>Mention end of here-document marker should by default be quoted,
>>unless the body needs $variable_interpolation? 
> Sorry, I don't get it. I don't see many of ending "EOF" are quoted in our tests.

We encourage to quote the end marker when there is no interpolation
in the here-document, so that ones that do not quote can stand out
and grab attention by developers who are reading the tests, i.e.

	cmd <<-EOF
	$variable interpolated
	EOF

The fact that EOF is not quoted serves as a signal to readers that
they may want to inspect the here-doc text carefully with the
variable interpolation in mind.  If the EOF marker is quoted,

	cmd <<-\EOF
	literal here text
	EOF

even if there are many lines in the here-document, the readers may
not have to be so careful---what is used is what they see (modulo
removing the leading indentation tabs).


