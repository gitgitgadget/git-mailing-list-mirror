Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC44C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 22:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiFWWMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFWWMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 18:12:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160A4D9C2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 15:12:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2E5414321A;
        Thu, 23 Jun 2022 18:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jNOYtoLuXTzr
        mTZh1gBoMyTK07cWk5tchq3Z5hkE3a0=; b=yhdc+5q9hWlvJUA7anZSV5MINt8K
        tBSCiC2s7Y9hwaRSxUKgb1aYGKBDp5QAvjrygv32p8Cyfi4UjvkmpnAjU+saQ7Ys
        VjHpfiRHp3D7dov/yrQMi0CnC52UYJlvTV70amcRQnhkRxYOu+WhMLDzvnzKVzJ4
        ZlY1U1Rz6/b4ORw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92F01143219;
        Thu, 23 Jun 2022 18:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 728B4143218;
        Thu, 23 Jun 2022 18:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/test-without-templates
References: <xmqq7d584hqb.fsf@gitster.g>
        <220623.86sfnvk5rw.gmgdl@evledraar.gmail.com>
Date:   Thu, 23 Jun 2022 15:12:06 -0700
In-Reply-To: <220623.86sfnvk5rw.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Jun 2022 12:55:07 +0200")
Message-ID: <xmqqr13fxc5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8534DB06-F341-11EC-AD97-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jun 22 2022, Junio C Hamano wrote:
>
>> * ab/test-without-templates (2022-06-06) 7 commits
>>  - tests: don't assume a .git/info for .git/info/sparse-checkout
>>  - tests: don't assume a .git/info for .git/info/exclude
>>  - tests: don't assume a .git/info for .git/info/refs
>>  - tests: don't assume a .git/info for .git/info/attributes
>>  - tests: don't assume a .git/info for .git/info/grafts
>>  - tests: don't depend on template-created .git/branches
>>  - t0008: don't rely on default ".git/info/exclude"
>>
>>  Tweak tests so that they still work when the "git init" template
>>  did not create .git/info directory.
>>
>>  Will merge to 'next'?
>>  source: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
>
> Presumably the submitters vote doesn't count for much, but FWIW I think
> it's ready & that there's nothing outstanding left to address.

I do not think they make any particular test to break, but I do not
think it is a good idea overall to give a false impression to the
users that it is OK to use incomplete templates that lack things
expected by Git in properly initialized repositories.  And these
patches definitely take things in that wrong direction.


