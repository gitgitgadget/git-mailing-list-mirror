Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC65C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 23:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4905864FD0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 23:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhBBXUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 18:20:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52465 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhBBXUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 18:20:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDBA01125B0;
        Tue,  2 Feb 2021 18:19:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PxFw0sZHItpnZA41ib10q9DEiS8=; b=Cj2189
        mSYaF7zPfguoThjO7Ju49n70LturGw9JqE8OIKnE8NIDAGF2cbdcQ+C1YEwM+LJp
        2X/5bqMdE0GubiL8CX2LtgBb2k6HYmY43wMAOFA64IVYtEGjLq6FbEE2SQfNUDaU
        up6Pen2m7ixb+Spe9Gre5UIy0WaWkLc+A1o+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nQZ/ZIWBRk0gDFdcuYO+m3vQyhcxLSm9
        UFXsHJ9SeGRxRPBqeSr4iBMtvnf1KiNwB5/OTZotjQzrIbAYHlb79S+JcNrEazgc
        TuLW3ihE/cdWwS0gB/2M+3Cl/ISJZGkyI+YqB7/1zZiQXNDqzak33x6bbFg/cJzk
        r8no9z8PvFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6ACA1125AF;
        Tue,  2 Feb 2021 18:19:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A5551125AB;
        Tue,  2 Feb 2021 18:19:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v2 2/6] doc hash-function-transition: use SHA-1 and
 SHA-256 consistently
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <681ce4129dc35b6a61aac0dbd1b9b9d638a2b78d.1612282749.git.gitgitgadget@gmail.com>
        <xmqqft2egsxq.fsf@gitster.c.googlers.com>
Date:   Tue, 02 Feb 2021 15:19:47 -0800
In-Reply-To: <xmqqft2egsxq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 02 Feb 2021 11:39:45 -0800")
Message-ID: <xmqqk0rqdpm4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 251172AC-65AD-11EB-9F1A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Thomas Ackermann <th.acker@arcor.de>
>>
>> Use SHA-1 and SHA-256 instead of sha1 and sha256  when referring
>> to the hash type.
>
> Ahh.  [1/6] was supposed to be only about formatting, and I found it
> a bit irritating that it had some of these changes mixed in, as it
> was not entirely clear to me that [1/6] covered all those lowercase
> sha1 and sha256 instances, or just some of them.
>
> Moving them from [1/6] to this step would help future readers by
> reducing such irritation (I do not know if it is worth it until
> I read through the series to the end).

It seems that only one hunk in 1/6 had premature conversion.
I've tried to locally move it around before queuing.

Thanks.

1:  eea107fb0e ! 1:  5df3cc249d doc hash-function-transition: fix asciidoc output
    @@ Documentation/technical/hash-function-transition.txt: network byte order):
      Loose object index
      ~~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/hash-function-transition.txt: the following steps:
    -    they will be discarded.)
      3. convert to sha256: open a new (sha256) packfile. Read the topologically
         sorted list just generated. For each object, inflate its
    --   sha1-content, convert to sha256-content, and write it to the sha256
    +    sha1-content, convert to sha256-content, and write it to the sha256
     -   pack. Record the new sha1<->sha256 mapping entry for use in the idx.
    -+   SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
    -+   pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
    ++   pack. Record the new sha1<-->sha256 mapping entry for use in the idx.
      4. sort: reorder entries in the new pack to match the order of objects
         in the pack the server generated and include blobs. Write a sha256 idx
         file
2:  58934c8b43 ! 2:  8488d4f5f1 doc hash-function-transition: use SHA-1 and SHA-256 consistently
    @@ Documentation/technical/hash-function-transition.txt: the following steps:
     -3. convert to sha256: open a new (sha256) packfile. Read the topologically
     +3. convert to SHA-256: open a new SHA-256 packfile. Read the topologically
         sorted list just generated. For each object, inflate its
    -    SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
    -    pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
    +-   sha1-content, convert to sha256-content, and write it to the sha256
    +-   pack. Record the new sha1<-->sha256 mapping entry for use in the idx.
    ++   SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
    ++   pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
      4. sort: reorder entries in the new pack to match the order of objects
     -   in the pack the server generated and include blobs. Write a sha256 idx
     +   in the pack the server generated and include blobs. Write a SHA-256 idx
3:  4a710c8715 = 3:  454a9437cf doc hash-function-transition: use upper case consistently
4:  7e690524ac = 4:  b2c881b66b doc hash-function-transition: fix incomplete sentence
5:  80089fe818 = 5:  4ee4775ca3 doc hash-function-transition: move rationale upwards
6:  b221eae801 = 6:  c27c52ca0c doc: use https links
