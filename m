Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EC01F461
	for <e@80x24.org>; Sun, 19 May 2019 01:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfESA4k (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 20:56:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56196 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfESA4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 20:56:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A12FC52722;
        Sat, 18 May 2019 20:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ysWwoTvzDHyx
        V1PzOkEnVULQsFk=; b=ejtmJfrtNpsvX7ig/BNu04WFw7G0LAC8iqgQomQyBqqK
        ESmE2uWrjSNVmDE7XsF4e5vice8D30DEhrbob/w7VwwCnc2P3EtfkHaHYMGfo69r
        bJizBLrZlnc/RUqTxykOwgkdN+1wG1XMF9UdMtog/w0q31swTxUERNiraMoSL5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LUxqTn
        CNuwcrrmfbub/bzvCs3iORp2kn8he7CKsaOqwkuZZkoF/KMVC3Z6FhbFmk3k9k4K
        AOZtUG4uZzIpVsYQqaI0SEVrMjry5xag5tFfgQK2cxdlBeNIxtrm5FGdqpIm/DAB
        31eYw4pgpsfK75PvSNsvJwzLdMV/x/jmgJPLk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9969152721;
        Sat, 18 May 2019 20:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAC9952720;
        Sat, 18 May 2019 20:56:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Osipov <michael.osipov@siemens.com>
Subject: Re: [PATCH v2] Makefile: remove the NO_R_TO_GCC_LINKER flag
References: <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
        <20190517215847.28179-1-avarab@gmail.com>
Date:   Sun, 19 May 2019 09:56:32 +0900
In-Reply-To: <20190517215847.28179-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 17 May 2019 23:58:47 +0200")
Message-ID: <xmqqa7fj2ren.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F2FF2B3E-79D0-11E9-A68B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> It's not needed to simply link to libraries like say libpcre,
> but *only* for those cases where we're linking to such a library not
> present in the OS's library directories. See e.g. ldconfig(8) on Linux
> for more details.
>
> I use this to compile my git with a LIBPCREDIR=3D$HOME/g/pcre2/inst as
> I'm building that from source, but someone maintaining an OS package
> is almost certainly not going to use this. They're just going to set
> USE_LIBPCRE=3DYesPlease after installing the libpcre dependency,
> which'll point to OS libraries which ld(1) will find without the help
> of CC_LD_DYNPATH.
> ...
> Our use of "-R" dates back to 455a7f3275 ("More portability.",
> 2005-09-30). Soon after that in bbfc63dd78 ("gcc does not necessarily
> pass runtime libpath with -R", 2006-12-27) the NO_R_TO_GCC flag was
> added, allowing optional use of "-Wl,-rpath=3D".

Yeah, I recall I had to add -R back when I was with my previous
employer, where I had Sun with GNU toolchain as the primary
environment and many libraries were custom built outside the system
path.


> diff --git a/Makefile b/Makefile
> index f965509b3c..ce7a489d64 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -265,10 +265,6 @@ all::
>  #
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
> -# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
> -# that tells runtime paths to dynamic libraries;
> -# "-Wl,-rpath=3D/path/lib" is used instead.
> -#

I am not sure if -R was a GCC-only thing; we might want to, instead
of removing this seciton, replace it with something like

    # Use "CC_LD_DYNPATH =3D -R" if your compiler uses "-R/path/to/lib"
    # to specify the runtime paths to dynamic libraries.  These days,
    # GCC uses -Wl,-rpath=3D/path/to/lib and that is used by default
    # instead.

to help those whose build suddenly starts breaking.

   >  # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profil=
e feedback,
>  # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?=
id=3D49299)
>  #
> @@ -1160,6 +1156,7 @@ endif
>  # which'll override these defaults.
>  CFLAGS =3D -g -O2 -Wall
>  LDFLAGS =3D

Or it could be a single liner at this point in the file, perhaps

    # Really old GCC used "CC_LD_DYNPATH =3D -R" for the runtime dynlib p=
ath

> +CC_LD_DYNPATH =3D -Wl,-rpath,
