Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C24BC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A5660FE3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJ2Vam (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:30:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64021 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJ2Vaj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:30:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F458FC7B4;
        Fri, 29 Oct 2021 17:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OyAvYe0G0H5j
        46V2pX/ng46dQ/L6c90hArCvR/te6Xw=; b=Cyn4II5NLDzWQ1uIGLlUvnqKpyX2
        XV2QP4J7BbFtTPLblZuw75UNqrB31dB73bT99lDWp82t83WG7bVPlCdakNOtPIjW
        QXxDsMr8Z2ZpDorxk0YHK3ZLTlEaI2+5hH+3nvOm1WUJFmNpU5AN8aoYkASm6JKJ
        vYx0fcS1gUvaNlM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0399BFC7B3;
        Fri, 29 Oct 2021 17:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 332F7FC7B2;
        Fri, 29 Oct 2021 17:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
        <20211029184512.1568017-1-eschwartz@archlinux.org>
        <20211029184512.1568017-3-eschwartz@archlinux.org>
        <xmqqy26bk2k9.fsf@gitster.g>
Date:   Fri, 29 Oct 2021 14:28:07 -0700
In-Reply-To: <xmqqy26bk2k9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        29 Oct 2021 13:18:14 -0700")
Message-ID: <xmqq7ddvjzbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CC8EDF2-38FF-11EC-B426-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eli Schwartz <eschwartz@archlinux.org> writes:
>
>>  +
>> +** 'tags[=3D<BOOL>]': Instead of only considering annotated tags,
>> +   consider lightweight tags as well.
>
> This part contradicts what Jean-No=C3=ABl's df34a41f is trying to
> achieve, which can be seen in these hunks from it:
> ...
> So, let's instead use
>
>     tags[=3D<bool-value>]: Instead of only considering ...
>
> i.e. lowercase, with -value suffix.

The other topic merges earlier to 'seen' before your topic, and FYI,
the diff between the tip of 'seen' before and after your topic gets
merged looks like this, with my semantic conflict resolution.

Notice the way placeholders are spelled in lowercase and generally
have more descriptive names.

Thanks.

diff --git c/Documentation/pretty-formats.txt w/Documentation/pretty-form=
ats.txt
index d465cd59dd..25cfffab38 100644
--- c/Documentation/pretty-formats.txt
+++ w/Documentation/pretty-formats.txt
@@ -220,6 +220,12 @@ The placeholders are:
 			  inconsistent when tags are added or removed at
 			  the same time.
 +
+** 'tags[=3D<bool-value>]': Instead of only considering annotated tags,
+   consider lightweight tags as well.
+** 'abbrev=3D<number>': Instead of using the default number of hexadecim=
al digits
+   (which will vary according to the number of objects in the repository=
 with a
+   default of 7) of the abbreviated object name, use <number> digits, or=
 as many digits
+   as needed to form a unique object name.
 ** 'match=3D<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
 ** 'exclude=3D<pattern>': Do not consider tags matching the given
@@ -273,11 +279,6 @@ endif::git-rev-list[]
 			  If any option is provided multiple times the
 			  last occurrence wins.
 +
-The boolean options accept an optional value `[=3D<value>]`. The values
-`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
-sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
-option is given with no value, it's enabled.
-+
 ** 'key=3D<key>': only show trailers with specified <key>. Matching is d=
one
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
@@ -313,6 +314,11 @@ insert an empty string unless we are traversing refl=
og entries (e.g., by
 decoration format if `--decorate` was not already provided on the comman=
d
 line.
=20
+The boolean options accept an optional value `[=3D<bool-value>]`. The va=
lues
+`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
+sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
+option is given with no value, it's enabled.
+
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
