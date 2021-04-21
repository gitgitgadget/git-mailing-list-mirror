Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF8C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8047161422
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbhDUXdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:33:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55027 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhDUXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:33:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31586121E3D;
        Wed, 21 Apr 2021 19:32:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j2m/nO7wqji8Wllly+wDKhFajV0=; b=Bxhda1
        ne0Y5uC86v3oPyCQlMYcUxzQmxjix96EH/Sq3sCm7Q8cekH4/+5xcTWMKaSSvcs9
        oN7O7uG9QFy0mEIhqPpBsaw97uJj9aY7hPrreug7eGb/1ICtYN4xqSsMaTLYCUM2
        BAe0AthaZ9KlnMVms04ImUoYc6IW01haKtCuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QzluNOeIS4uLySWeOAr6kBq52CIerFqJ
        wKHyKLf8eMzKCpzNMPjUj9H0KsIuIIZT+LFmDEjihmZT/KdkjqJj7Hab8QsX5YI3
        pgwYPNFzceUL9q8VBk+o5KAMvbe2P2xoCNqwMqPRZN5FjyZcdKNBI9uY0gkYW1+T
        ianVQATIF04=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29BDB121E3C;
        Wed, 21 Apr 2021 19:32:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FABE121E3B;
        Wed, 21 Apr 2021 19:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
References: <YIAAzJTG1UitiWyu@danh.dev>
        <20210421104102.3409-1-congdanhqx@gmail.com>
        <20210421104102.3409-2-congdanhqx@gmail.com>
        <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
        <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
Date:   Wed, 21 Apr 2021 16:32:40 -0700
In-Reply-To: <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 21 Apr 2021 13:32:32 -0400")
Message-ID: <xmqq5z0fxlgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE296B30-A2F9-11EB-8013-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Apr 21, 2021 at 12:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>     count_ls_files 5 -s &&
>>     count_ls_files 3 -u &&
>>     count_ls_files 1 -u one~HEAD &&
>>     ...
>>
>> The nice thing about having a helper function is that it can clean up
>> after itself by not leaving a new file lying around, thus you wouldn't
>> have to make adjustments to the expected number of untracked files (as
>> mentioned in the commit message). If this is the sort of thing which
>> comes up often enough (if there are more such cases beyond the two
>> scripts you changed in this series), then it might make sense to
>> promote the helper function to test-lib-functions.sh.
>
> The frequency with which this idiom crops up with commands beyond
> git-ls-files suggests the more general solution of supporting it
> directly in test-lib-functions.sh for any command. For instance:
>
>     test_cmd_line_count = 3 git ls-files -u &&
>
> Or, perhaps, a new mode of test_line_count():
>
>     test_line_count = 3 -c git ls-files -u &&

That looks nice on paper, but may be going too far.

We may want to count the lines in the error message, or we may want
to count the lines after filtering the output with pipe.

A test file that is dedicated to test ls-files with a file local
helper "count_ls_files" smells like a better place to stop, at least
to me.
