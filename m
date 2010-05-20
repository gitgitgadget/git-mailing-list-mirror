From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 11:15:32 +0200
Message-ID: <4BF4FDB4.2010409@drmicha.warpmail.net>
References: <4BF4E40B.30205@math.tu-dortmund.de> <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com> <4BF4F7D7.60002@drmicha.warpmail.net> <4BF4FA89.2040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <totte.enea@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 11:15:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1r2-0004pS-5K
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 11:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab0ETJPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 05:15:43 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51299 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752447Ab0ETJPm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 05:15:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B725EF77F4;
	Thu, 20 May 2010 05:15:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 20 May 2010 05:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xdZcvvbBZcW7rrPBsbyeqK3+qk0=; b=HEZ4SfkGRx1h6UCtkoNLAcGpdL1grezzNQTiWHs50QsIE4Gln3fwg3C6WEGooMJkuc+ZaJEbaNu4gFD/ZE8Ta9CHjSm7z4fwXK73FvUMP7yHmfC0Yk4pIPuyxEjqjrWcTIDry/WC0zj+m9g6H0A5ZjNmp4VoVzEpz8Krwk0487c=
X-Sasl-enc: XRIQt1nrnreTQnvRATLqfRTQzcf1B4NwYouOib2ISSWE 1274346923
Received: from localhost.localdomain (p548498FC.dip0.t-ipconnect.de [84.132.152.252])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EF92B4D7915;
	Thu, 20 May 2010 05:15:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <4BF4FA89.2040904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147368>

Torsten B=C3=B6gershausen venit, vidit, dixit 20.05.2010 11:02:
> Hej,
> I have the same problem here.
> Below there is a patch, which may solve the problem.
> (Yes, whitespaces are broken. I'm still fighting with
> git format-patch -s --cover-letter -M --stdout origin/master | git=20
> imap-send)
> But this patch may be a start point for improvements.
> Comments welcome
> BR
> /Torsten
>=20
>=20
>=20
> Improved interwork between Mac OS X and linux when umlauts are used
> When a git repository containing utf-8 coded umlaut characters
> is cloned onto an Mac OS X machine, the Mac OS system will convert
> all filenames returned by readdir() into denormalized utf-8.
> As a result of this conversion, git will not find them on disk.
> This helps by treating the NFD and NFD version of filenames as
> identical on Mac OS.
>=20
>=20
>=20
>=20
>=20
>=20
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

You signed off, but is Markus Kuhn's code from UCS GPL2-licensed?
Also, a few tests would be nice.

I remember we had threads on this issue in the past. I haven't checked
yet (Thunderbird pruned my nntp history), but it is worth checking that
you addressed any issues mentioned there.

I have no Mac so I can't test, sorry. Would be happy to run Mac OS in a
vm, but you know...

Thanks for looking into this!

Michael

> ---
> name-hash.c |   40 ++++++++++++++++++++++++++++++++++++++++
> utf8.c      |   55 ++++++++++++++++++++++++++++++++++++++++++++++++--=
-----
> utf8.h      |   11 +++++++++++
> 3 files changed, 99 insertions(+), 7 deletions(-)
>=20
> diff --git a/name-hash.c b/name-hash.c
> index 0031d78..e6494e8 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -7,6 +7,7 @@
>   */
> #define NO_THE_INDEX_COMPATIBILITY_MACROS
> #include "cache.h"
> +#include "utf8.h"
>=20
> /*
>   * This removes bit 5 if bit 6 is set.
> @@ -100,6 +101,25 @@ static int same_name(const struct cache_entry *c=
e,=20
> const char *name, int namelen
>      return icase && slow_same_name(name, namelen, ce->name, len);
> }
>=20
> +#ifdef __APPLE__
> +struct cache_entry *index_name_exists2(struct index_state *istate,=20
> const char *name, int icase)
> +{
> +    int namelen =3D (int)strlen(name);
> +    unsigned int hash =3D hash_name(name, namelen);
> +    struct cache_entry *ce;
> +
> +    ce =3D lookup_hash(hash, &istate->name_hash);
> +    while (ce) {
> +        if (!(ce->ce_flags & CE_UNHASHED)) {
> +            if (same_name(ce, name, namelen, icase))
> +                return ce;
> +        }
> +        ce =3D ce->next;
> +    }
> +    return NULL;
> +}
> +#endif
> +
> struct cache_entry *index_name_exists(struct index_state *istate, con=
st=20
> char *name, int namelen, int icase)
> {
>      unsigned int hash =3D hash_name(name, namelen);
> @@ -115,5 +135,25 @@ struct cache_entry *index_name_exists(struct=20
> index_state *istate, const char *na
>          }
>          ce =3D ce->next;
>      }
> +#ifdef __APPLE__
> +    {
> +        char *name_nfc_nfd;
> +        name_nfc_nfd =3D str_nfc2nfd(name);
> +        if (name_nfc_nfd) {
> +            ce =3D index_name_exists2(istate, name_nfc_nfd, icase);
> +            free(name_nfc_nfd);
> +            if (ce)
> +                return ce;
> +        }
> +        name_nfc_nfd =3D str_nfd2nfc(name);
> +        if (name_nfc_nfd) {
> +            ce =3D index_name_exists2(istate, name_nfc_nfd, icase);
> +            free(name_nfc_nfd);
> +            if (ce)
> +                return ce;
> +        }
> +    }
> +#endif
> +
>      return NULL;
> }
> diff --git a/utf8.c b/utf8.c
> index 84cfc72..8e794dc 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -2,6 +2,11 @@
> #include "strbuf.h"
> #include "utf8.h"
>=20
> +#ifdef __APPLE__
> +static iconv_t my_iconv_nfd2nfc =3D (iconv_t) -1;
> +static iconv_t my_iconv_nfc2nfd =3D (iconv_t) -1;
> +#endif
> +
> /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ *=
/
>=20
> struct interval {
> @@ -424,18 +429,13 @@ int is_encoding_utf8(const char *name)
> #else
>      typedef char * iconv_ibp;
> #endif
> -char *reencode_string(const char *in, const char *out_encoding, cons=
t=20
> char *in_encoding)
> +
> +char *reencode_string_iconv(const char *in, iconv_t conv)
> {
> -    iconv_t conv;
>      size_t insz, outsz, outalloc;
>      char *out, *outpos;
>      iconv_ibp cp;
>=20
> -    if (!in_encoding)
> -        return NULL;
> -    conv =3D iconv_open(out_encoding, in_encoding);
> -    if (conv =3D=3D (iconv_t) -1)
> -        return NULL;
>      insz =3D strlen(in);
>      outsz =3D insz;
>      outalloc =3D outsz + 1; /* for terminating NUL */
> @@ -469,7 +469,48 @@ char *reencode_string(const char *in, const char=
=20
> *out_encoding, const char *in_e
>              break;
>          }
>      }
> +    return out;
> +}
> +
> +char *reencode_string(const char *in, const char *out_encoding, cons=
t=20
> char *in_encoding)
> +{
> +    iconv_t conv;
> +    char *out;
> +
> +    if (!in_encoding)
> +        return NULL;
> +    conv =3D iconv_open(out_encoding, in_encoding);
> +    if (conv =3D=3D (iconv_t) -1)
> +        return NULL;
> +    out =3D reencode_string_iconv(in, conv);
>      iconv_close(conv);
>      return out;
> }
> +
> +#ifdef __APPLE__
> +char*
> +str_nfc2nfd(const char *in)
> +{
> +    if (my_iconv_nfc2nfd =3D=3D (iconv_t) -1) {
> +        my_iconv_nfc2nfd =3D iconv_open("utf-8-mac", "utf-8");
> +        if (my_iconv_nfc2nfd =3D=3D (iconv_t) -1) {
> +            return NULL;
> +        }
> +    }
> +    return reencode_string_iconv(in, my_iconv_nfc2nfd);
> +}
> +
> +char*
> +str_nfd2nfc(const char *in)
> +{
> +    if (my_iconv_nfd2nfc =3D=3D (iconv_t) -1){
> +        my_iconv_nfd2nfc =3D iconv_open("utf-8", "utf-8-mac");
> +        if (my_iconv_nfd2nfc =3D=3D (iconv_t) -1) {
> +            return NULL;
> +        }
> +    }
> +    return reencode_string_iconv(in, my_iconv_nfd2nfc);
> +}
> +#endif /* APPLE */
> +
> #endif
> diff --git a/utf8.h b/utf8.h
> index ebc4d2f..db29c8a 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -13,8 +13,19 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
>=20
> #ifndef NO_ICONV
> char *reencode_string(const char *in, const char *out_encoding, const=
=20
> char *in_encoding);
> +char *reencode_string_iconv(const char *in, iconv_t conv);
> +#ifdef __APPLE__
> +char *str_nfc2nfd(const char *in);
> +char *str_nfd2nfc(const char *in);
> +#else
> +#define str_nfc2nfd(in) (NULL)
> +#define str_nfd2nfc(in) (NULL)
> +#endif
> #else
> #define reencode_string(a,b,c) NULL
> +#define reencode_string2(a,b) NULL
> +#define str_nfc2nfd(in) (NULL)
> +#define str_nfd2nfc(in) (NULL)
> #endif
>=20
> #endif
