From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] grep: use regcomp() for icase search with non-ascii patterns
Date: Mon, 06 Jul 2015 22:10:33 +0200
Message-ID: <559AE0B9.2040704@web.de>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg> <1436186551-32544-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 22:11:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCCjS-0001JR-9T
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbbGFULK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 16:11:10 -0400
Received: from mout.web.de ([212.227.17.11]:51641 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220AbbGFULH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 16:11:07 -0400
Received: from [192.168.178.27] ([79.253.167.251]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LzbLS-1YyEWI26C2-014nav; Mon, 06 Jul 2015 22:11:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:34qxABfQkI5KFCohalwi3ZYER8aq4IsOSVqnre3MaJlwKTxEi8p
 GMmLjJv7Gf+8N7S/X9jw3oyIv/F6F4OFDvJmCUB9J33oOWJ0gSZHDI8RyBA0BdoYhYs6WxS
 2w1a8zNDUDcbuFSRAOd5eUUY1xFZDCQL17eMCD61/vbU3JKOzqJ2ESboRr5CKr6Lmb4Z/Ed
 h6XVVXiCujjr/RVNiP79w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jnzV2+zs5go=:NsUQW7q4LdQIQfcMKldl75
 vNckLK0J7EPLiLEfuVignkBBKyaEZHeLwzfpGefa874azm7UYZV53L081QSO90z1p4pmXQomK
 YPjOCWoUDX6l5kRZvI6+LEpzyCI8d7XUiHBn1io5gssnqADfSWjGLDIXmVWh2tcUDDsovPPhe
 QDowZv1lUYHrFW/yo5wqRyxt2NGQ+xxeBJs1LsO++QU4OUppVBObzfaccFF54in5DB81zFX6I
 VQjyCAi/+3Ag2mX0bHOl89CYSo78N1SemlVcM1JubO373xGWCcOYSAk5fjmH0GVuCSelS1JzM
 D66iqcYsI2+riH1g7bzzy1ErUByPKdICJ1MdKUZgsZX4MS0L3ooFeb5Ln+A0Kw5hLRokO4zKt
 CdzcbpDbRVtaSa9qsrjbY2UACVyWPxwo+IcyazOZyfoGwtc+Sf6azrKQRO4921ueeH7+iiBpz
 8Uw7xWwcICwd9MPMQnm0tBeHnrjfZnmtSeJBvDbyHDF/m2KEbYbDmgha8/WC8iu+84gURKUW8
 6Kc8PvZnfEnTA57Z3bKKFP2N5/TyjW3GLuCYtStVyB/TiHpw/2fJL4afDacOXtWSs4c/D6oUD
 2xiyVlOo1BaDAh69SGK9Ftne7VkqrVgtUVHMjumy6/xZQNZN7wmQsCTP3kDMtO/fdfDB6v6DT
 4ChbSxdUt0fj4zEa/EFEncbAIBjVi2h0SPU+uk0iaebHX/Vq1AA0RISFM/qp/SJCjfIk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273456>

Am 06.07.2015 um 14:42 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
> Noticed-by: Plamen Totev <plamen.totev@abv.bg>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>   grep.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index b58c7c6..48db15a 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -378,7 +378,7 @@ static void free_pcre_regexp(struct grep_pat *p)
>   }
>   #endif /* !USE_LIBPCRE */
>
> -static int is_fixed(const char *s, size_t len)
> +static int is_fixed(const char *s, size_t len, int ignore_icase)
>   {
>   	size_t i;
>
> @@ -391,6 +391,13 @@ static int is_fixed(const char *s, size_t len)
>   	for (i =3D 0; i < len; i++) {
>   		if (is_regex_special(s[i]))
>   			return 0;
> +		/*
> +		 * The builtin substring search can only deal with case
> +		 * insensitivity in ascii range. If there is something outside
> +		 * of that range, fall back to regcomp.
> +		 */
> +		if (ignore_icase && (unsigned char)s[i] >=3D 128)
> +			return 0;

How about "isascii(s[i])"?

>   	}
>
>   	return 1;
> @@ -398,18 +405,19 @@ static int is_fixed(const char *s, size_t len)
>
>   static void compile_regexp(struct grep_pat *p, struct grep_opt *opt=
)
>   {
> +	int ignore_icase =3D opt->regflags & REG_ICASE || p->ignore_case;
>   	int err;
>
>   	p->word_regexp =3D opt->word_regexp;
>   	p->ignore_case =3D opt->ignore_case;

Using p->ignore_case before this line, as in initialization of the new=20
variable ignore_icase above, changes the meaning.

>
> -	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
> +	if (opt->fixed || is_fixed(p->pattern, p->patternlen, ignore_icase)=
)
>   		p->fixed =3D 1;
>   	else
>   		p->fixed =3D 0;
>
>   	if (p->fixed) {
> -		if (opt->regflags & REG_ICASE || p->ignore_case)
> +		if (ignore_case)

ignore_icase instead?  ignore_case is for the config variable=20
core.ignorecase.  Tricky.

>   			p->kws =3D kwsalloc(tolower_trans_tbl);
>   		else
>   			p->kws =3D kwsalloc(NULL);
>

So the optimization before this patch was that if a string was searched=
=20
for without -F then it would be treated as a fixed string anyway unless=
=20
it contained regex special characters.  Searching for fixed strings=20
using the kwset functions is faster than using regcomp and regexec,=20
which makes the exercise worthwhile.

Your patch disables the optimization if non-ASCII characters are=20
searched for because kwset handles case transformations only for ASCII=20
chars.

Another consequence of this limitation is that -Fi (explicit=20
case-insensitive fixed-string search) doesn't work properly with=20
non-ASCII chars neither.  How can we handle this one?  Fall back to=20
regcomp by escaping all special characters?  Or at least warn?

Tests would be nice. :)

Ren=C3=A9
