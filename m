Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB46C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710BC60F6F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhJOQxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:53:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54455 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbhJOQxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:53:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B1D1FEFBB;
        Fri, 15 Oct 2021 12:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dSjKGDxKxuwT
        lf8FYH355NwXrfRL6+k0ncVGOcY7o2w=; b=EOTWPFzKik4p/RLH2gV7khumJWB1
        txt3X0L4e5NnK3dx0srYGgGPKKT7j+wZ+IdPwFsbXxwleZK4YEd4+5W+d4jpiqdv
        N1H/tyaOs4Ap7/UPMF0bK3e8cEAW+TO+1m9WzuUGQJnIa07s2iBGG7Vi0wEqO+xz
        AFsSWWfBHehPBco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91C71FEFBA;
        Fri, 15 Oct 2021 12:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AF53FEFB9;
        Fri, 15 Oct 2021 12:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        vagabon.xyz@gmail.com, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] archive: rewrite description for compression level
 option
References: <20211015121336.46981-1-bagasdotme@gmail.com>
        <87h7die9jj.fsf@evledraar.gmail.com>
Date:   Fri, 15 Oct 2021 09:50:52 -0700
In-Reply-To: <87h7die9jj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 15 Oct 2021 14:46:29 +0200")
Message-ID: <xmqq7dee8c5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0FA9AE86-2DD8-11EC-A610-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<ex=
tra>]
>> +'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [-#]
>>  	      [-o <file> | --output=3D<file>] [--worktree-attributes]
>>  	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
>>  	      [<path>...]
>> @@ -65,10 +65,6 @@ OPTIONS
>>  	Look for attributes in .gitattributes files in the working tree
>>  	as well (see <<ATTRIBUTES>>).
>> =20
>> -<extra>::
>> -	This can be any options that the archiver backend understands.
>> -	See next section.
>> -
>>  --remote=3D<repo>::
>>  	Instead of making a tar archive from the local repository,
>>  	retrieve a tar archive from a remote repository. Note that the
>> @@ -88,17 +84,13 @@ OPTIONS
>>  	of the current working directory are included in the archive.
>>  	If one or more paths are specified, only these are included.
>> =20
>> -BACKEND EXTRA OPTIONS
>> ----------------------
>> -
>> -zip
>> -~~~
>> --0::
>> -	Store the files instead of deflating them.
>> --9::
>> -	Highest and slowest compression level.  You can specify any
>> -	number from 1 to 9 to adjust compression speed and ratio.
>> -
>> +-#::
>> +	Select the compression level. The supported levels and default
>> +	value (if none is selected) are depending on compression command
>> +	backend configured for the selected format (either explicitly with
>> +	`--format` or inferred from file name specified with `-o`). Common
>> +	values are `-0` for only storing files (zip only), `-1` for fastest
>> +	compression time, and `-9` for best compression ratio.
>
>
> This is getting there, but I think we really should not have a -# in th=
e
> synopsis, since that's not how we refer to a digit-wildcard in any othe=
r
> context. And users might assume that a literal -# is meant, some
> commonly used tools even support that, e.g. try:
>
>     curl -L -o /dev/null -# https://cdimage.debian.org/debian-cd/curren=
t/amd64/iso-dvd/debian-11.1.0-amd64-DVD-1.iso
>
> Let's just use "[-<0..9 digit>[", or "[-<digit>]" in the SYNOPSIS and
> explain that it's 0..9 below in this section..

I agree with you about `-#`.

I do not think it is a good idea to remove the backend-specific
option section like this patch does, as the next archiver may not
even support `-<digit>`.  Even with the existing two backends, the
description of it need to be different (cf. the other response I
sent you last night on "--fast/--best"?).  Rather, the first thing
to improve would be to _add_ a section for `tar` format, next to the
`zip` format, I would think, as those who wants to write `tar` do
not have to read `zip` specific options, and vice versa.

The new paragraph on `-#` in the patch may work as a replacement for
existing explanation for `zip`-specific extra options, but it needs
to drop the changes made to make it applicable to any format, like
"depending on ... backend" and "(zip only)" if we want to take it.

Thanks.
