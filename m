Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43166C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F5C20747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="br1rK0oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgFKA1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:27:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56680 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFKA1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:27:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B28E962E98;
        Wed, 10 Jun 2020 20:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G4TIY6wUKNrR2i6Un5ywX5ey5Lg=; b=br1rK0
        oHFh7sZCiQQnOWepLOZ6sJfcs/EMjpoGId9BM3QtAISzy7B2uKNIA7IeN6ie+xq8
        CIvvO8Saj0vk/F29Lo9lnI5IZCoONU+uKWVEYF5O4wfPA411v4f1kQm0SevvFa3m
        p0u3i5dHazA+9lyaeBH1ZArc2nPEgcONPUePI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZPShMRBj+40oS8al7I5Yh1d9cYMwbFc
        +bR16aRg+sz1UOas+c7cLv9nA4+mF0878L9FzuUmmF+TIZMWZTEj1ff0I5s5OzYF
        8055oFwvwLofrN5E0nXw77GXFVnJ3ydAb8+wNo8EbPHXlTUzN056LRlx7uXB4sCR
        JHu/aqeCXUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB60D62E97;
        Wed, 10 Jun 2020 20:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C62762E96;
        Wed, 10 Jun 2020 20:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #02; Wed, 10)
References: <xmqq7dweebnl.fsf@gitster.c.googlers.com>
        <20200610235713.GX6569@camp.crustytoothpaste.net>
Date:   Wed, 10 Jun 2020 17:27:14 -0700
In-Reply-To: <20200610235713.GX6569@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 10 Jun 2020 23:57:13 +0000")
Message-ID: <xmqqwo4ecuql.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CE486AE-AB7A-11EA-ABCA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-06-10 at 23:36:30, Junio C Hamano wrote:
>> * bc/sha-256-part-2 (2020-05-27) 44 commits
>> ...
>>  - t1050: match object ID paths in a hash-insensitive way
>> 
>>  SHA-256 migration work continues.
>
> I assume you're waiting for something on this, and it's probably a
> review, but I didn't see a comment to that effect.  Am I correct?

More or less.  It actually is weaker; I didn't have enough energy to
give attention to the topic between issue #1 and issue #2 this month
to even bother adding such a comment.  By default nothing happens
without input, and I try not to be the only reviewer of a large
topic like this one---I always prefer to have second sets of eyes.

Thanks for working on it.  A large refactoring like this one, the
sooner we can absorb it, the less blocking it would be for other
topics in flight.

