From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 01/72] gettext.h: add no-op _() and N_() wrappers
Date: Sun, 20 Feb 2011 22:11:51 +0100
Message-ID: <AANLkTinZSpz=H9dt6kRDhOtght_YB4qVpw5WENEYmaQZ@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<1298143495-3681-2-git-send-email-avarab@gmail.com>
	<20110220020130.GA17225@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 22:12:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrGZS-0006XX-Gn
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 22:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab1BTVLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 16:11:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1BTVLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 16:11:53 -0500
Received: by fxm17 with SMTP id 17so895827fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 13:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bKSQfsYayyfoWVLHVOO6uUUg1K2B2U3R135nksJNQkQ=;
        b=P65qpEMhSrZge5k8YdGmCJTxoIXM8KNewV+YG9p62FT3n/J13WBno54zcOYfn5Sa2K
         D9OSRiNUZgMQXuYx6W3235lnebfLDXSvnFArbxT/WIis1d6Dsa3RMwE48sLc1zQgUsGH
         2+CWkXSWwxfnMtAkqINWA9CevHqDFJ32Efq0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hqjzRPkaXY3IpGpNdR6gXFWLxJk4xLy9lagPniV7uLsj6EZlU5v2gQ+KH6bqxF0c/Z
         kzYEb3yP4j9FnaV3j5UiXM5/YMHU0F92cUjDb6/fbGtf52xU/iQy5Tl/LJAKRBlUdQY0
         eA77Gp2wZu65VOtgQrmf1fhQubtnYx/XXRx8E=
Received: by 10.223.70.136 with SMTP id d8mr907617faj.3.1298236311981; Sun, 20
 Feb 2011 13:11:51 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sun, 20 Feb 2011 13:11:51 -0800 (PST)
In-Reply-To: <20110220020130.GA17225@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167428>

On Sun, Feb 20, 2011 at 03:01, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Add a new header called gettext.h which is currently a no-op.
>
> Thanks. =C2=A0I'd suggest squashing this with patch #2 (#including
> gettext.h in cache.h).
>
>> --- /dev/null
>> +++ b/gettext.h
>> @@ -0,0 +1,9 @@
>> +/*
>> + * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>
> Is such a simple header file copyrightable? =C2=A0But I don't mind.
>
>> + *
>> + * This is a skeleton no-op implementation of gettext for Git. It'l=
l
>> + * be replaced by something that uses libintl.h and wraps gettext()=
 in
>> + * a future patch series.
>> + */
>> +#define N_(s) (s)
>
> Might be nice to make this an inline function, for type safety.
>
>> +#define _(s) (s)
>
> This one can't be a function, though, since it needs to transform
> literals to literals.
>
> Some possible tweaks:
>
> =C2=A0- protect against double inclusion
> =C2=A0- make _ into a function
> =C2=A0- add a comment vaguely explaining N_
> =C2=A0- avoid confusing errors if some other header has pre-defined _=
=2E
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0gettext.h | =C2=A0 19 +++++++++++++++++--
> =C2=A01 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/gettext.h b/gettext.h
> index c68bbe9..2f806cb 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -1,3 +1,10 @@
> +#ifndef GETTEXT_H
> +#define GETTEXT_H
> +
> +#ifdef _
> +#error "namespace conflict: '_' is pre-defined?"
> +#endif
> +
> =C2=A0/*
> =C2=A0* Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> =C2=A0*
> @@ -5,5 +12,13 @@
> =C2=A0* be replaced by something that uses libintl.h and wraps gettex=
t() in
> =C2=A0* a future patch series.
> =C2=A0*/
> -#define N_(s) (s)
> -#define _(s) (s)
> +
> +static inline const char *_(const char *msgid)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return msgid;
> +}
> +
> +/* Mark msgid for translation but do not translate it. */
> +#define N_(msgid) (msgid)
> +
> +#endif

Thanks for this. This was raised earlier in the discussion for this
series (by you, IIRC). I've considered it, and while I see your point
(type safety =3D good) I think I like my way of doing it better.

The _() macro/function is usually a macro and not a function. The good
thing about this is that I can prove that it's a no-op on all
compilers, whereas if it's an inline function (stupid) compilers will
actually make it into a function, which'll result in overhead,
which'll mean I can't advertise this series as a "no-op" anymore.

Check out some of the recent work in perl.git for reference. There's
now a probe in perl which check is the compiler can *really* handle
inline functions, and if not perl will fall back on using macros.

I'd rather not use inline functions for every string in Git without
such a probe, especially since it's for a very marginal gain. Using
_() for non-strings isn't going to make it past the list, and if it's
used with e.g. multiple arguments compilers will already whine about
it.

So that's why I didn't do it. But if everyone else feels strongly
about it I'll change my mind, I don't care *that* much about it, but
I'd prefer a macro.
