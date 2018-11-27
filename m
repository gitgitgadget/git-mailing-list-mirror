Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B8B1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 01:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeK0MMy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 07:12:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58171 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeK0MMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 07:12:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D8F83C190;
        Mon, 26 Nov 2018 20:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gYMSys297xqF
        lRiVHROZBHQCNy0=; b=JHDO6CFrvmckYk9HlGrnJMAL1bgMhibDmmRdXeyqBN36
        iJ2qxq7tszzytgM9M6T+m96mRNtgsiat96nj6m9Iz8G6ezb9MXyK/Yx9b9UMHVxD
        Y5DrVKT0hfboHYyLE12M2YZcB+cWHb+TDcb7tSoTmHWI4S+hGRfM7AYiaO1QTxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tC4VQJ
        RGpTqRFXE2ZZ5s1IR8f7GhswWBk/Yj/kvfe5mACxFIflWY6yfk9CXtaPXKj2NmCM
        RB9O4G1PFzBRT93WccPCwdXXvl7sHPJWOD5czMMGfD/Jvvb6dwVaCtuAuj2X5Zek
        M9ieXlU/FyCVsdUzVh31nB3zg8wa9a0T6OJhA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 164AA3C18F;
        Mon, 26 Nov 2018 20:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B7413C18A;
        Mon, 26 Nov 2018 20:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, svnpenn@gmail.com
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181126173252.1558-1-tboegi@web.de>
Date:   Tue, 27 Nov 2018 10:16:42 +0900
In-Reply-To: <20181126173252.1558-1-tboegi@web.de> (tboegi's message of "Mon,
        26 Nov 2018 18:32:52 +0100")
Message-ID: <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1A51E3CE-F1E2-11E8-BC6A-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> Reported-By: Steven Penny <svnpenn@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> This is the first vesion of a patch.
> Is there a chance that you test it ?
>
> abspath.c       |  2 +-
>  compat/cygwin.c | 18 ++++++++++++++----
>  compat/cygwin.h | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 5 deletions(-)

I am hoping that the funny indentation above is merely an accidental
touch on the delete key and not a sign of MUA eating the patch to
make it unapplicable (and making it harder for those who want to
test to test it).

> diff --git a/compat/cygwin.c b/compat/cygwin.c
> index b9862d606d..c4a10cb5a1 100644
> --- a/compat/cygwin.c
> +++ b/compat/cygwin.c
> @@ -1,19 +1,29 @@
>  #include "../git-compat-util.h"
>  #include "../cache.h"
> =20
> +int cygwin_skip_dos_drive_prefix(char **path)
> +{
> +	int ret =3D has_dos_drive_prefix(*path);
> +	*path +=3D ret;
> +	return ret;
> +}

Mental note: this is exactly the same as mingw version.

I wonder if it makes the rest of the code simpler if we stripped
things like /cygdrive/c here exactly the sam way as we strip C:
For that, has_dos_drive_prefix() needs to know /cygdrive/[a-z],
which may not be a bad thing, I guess.  Let's read on.

>  int cygwin_offset_1st_component(const char *path)
>  {
> -	const char *pos =3D path;
> +	char *pos =3D (char *)path;
> +
>  	/* unc paths */
> -	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
> +	if (!skip_dos_drive_prefix(&pos) &&
> +			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {

When given C:\foo\bar, this strips prefix to leave \foo\bar in pos and
then realizes that it cannot be unc path (because it has dos prefix)
and goes on.  What is returned from the function is "\foo\bar" + 1 -
path, i.e. the offset in the original "C:\foo\bar" string of the
'f' in "foo", i.e. 3.

When given \foo\bar, pos stays the same as path, and it skips the
first backslash and returns the offset in the original string of the
'f' in "foo", i.e. 1.

Both cases return the moreal equivalent --- the offset of the first
component 'foo'.  So this looks correct for these two cases.

>  		/* skip server name */
> -		pos =3D strchr(pos + 2, '/');
> +		pos =3D strpbrk(pos + 2, "\\/");

This is to allow \\server\path in addition to //server/path; the
original looked only for '/' with strchr but we now look for either
'/' or '\', whichever comes earlier.  Both helpers return NULL when
they find no separator, so we should be able to handle the returned
pos from here on the same way as the original code.

>  		if (!pos)
>  			return 0; /* Error: malformed unc path */
> =20
>  		do {
>  			pos++;
> -		} while (*pos && pos[0] !=3D '/');
> +		} while (*pos && !is_dir_sep(*pos));

And whenever we looked for '/', we consider '\' its equivalent.

>  	}
> +
>  	return pos + is_dir_sep(*pos) - path;
>  }

Looks good so far.

Wait, did I just waste time by not looking at mingw.c version?  I
suspect this would be exactly the same ;-)

> diff --git a/compat/cygwin.h b/compat/cygwin.h
> index 8e52de4644..46f29c0a90 100644
> --- a/compat/cygwin.h
> +++ b/compat/cygwin.h
> @@ -1,2 +1,34 @@
> +#define has_dos_drive_prefix(path) \
> +	(isalpha(*(path)) && (path)[1] =3D=3D ':' ? 2 : 0)

Metanl note: this also looks the same as mingw version.

> +int cygwin_offset_1st_component(const char *path);
> +#define offset_1st_component cygwin_offset_1st_component
> +

So, my real questions are

 - Is there a point in having cygwin specific variant of these, or
   can we just borrow from mingw version (with some refactoring)?
   Is there a point in doing so (e.g. if mingw plans to move to
   reject forward slashes, attempting to share is pointless).

 - Would it make it better (or worse) to treat the /cygdrive/c thing
   as another way to spell dos-drive-prefix?  If the answer is "it
   is a good idea", then that answers the previous question
   automatically (we cannot gain much by sharing, as mingw side
   won't want to treat /cygdrive/c any differently).

