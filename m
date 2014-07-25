From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 3/4] refs.c: move ref parsing code out of resolve_ref()
Date: Fri, 25 Jul 2014 09:12:53 -0700
Message-ID: <CAL=YDWnWAoCrJn28vGKb=xrKKO=fCN=Uz+nM+eh+dYbHCFYpgQ@mail.gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
	<1406285039-22469-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:13:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAi7A-0001LP-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbaGYQMz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 12:12:55 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:53351 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbaGYQMy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 12:12:54 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu12so7574071vcb.6
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XYDUyP4uSkkoCiuAOYmM7RrfJklk8ZPUst0cI8ENd8s=;
        b=A6hVnd01P4BSDyUVKP825ApHjFvptqLYqUZ7Cn8orTVegY56F0sxTZGlTQnfsnV0pW
         FI845JuHGNshngFom5t6RkT/aCs+dJKpxAh/xhSIjTqte/1gXkgVZYTVh9MgZJj5UUwp
         Gl2WdJapARVUmUsHpCXqsHOMmLKAb27NoTpyKntBF04hNofAzXlRYkVR6/eqJsielGCJ
         5cUqE0FDNTIhy/aTUK5Cfrv40+INeAAFWna2xYg/cMiYzu18QFp+3z0BweApbFxY3Jri
         QecEMXzCT7704Ydo9D512N2lCmFobkLD/Dy5pKBgjRrMYIzBJchKU31a9m2THv2/BoF5
         sJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XYDUyP4uSkkoCiuAOYmM7RrfJklk8ZPUst0cI8ENd8s=;
        b=KsZRIrw8Ddy0hMgTBsuu4UskkRd+v7dHCm9aZxUSl1cKhsdhlGinTAAte6+UauHl8f
         xCxQqI1hN1hNPZn5EcEyDKxOzEaNeiS7uckcXwmNRf8LYx5h0NERXJYFmrPGF2gcYLGn
         oIuv1TyLY9yGxrzmsTR1Gn8mwXcCcAmIOTtNAqpKZkbi7LnvNI+gdVlDv4JKoRrr7RtR
         LJdNLZ6BmSPO8c1JFxHVb5PwsvNYr3sReXN21epsFbUwxFgqPnIs9ea7g9HlhoQ/jmqZ
         HnXumgE+JL2uf+iBbK5CZMRqIC1xpf7NAc3pdNkRN2lffjMvEOoxBXmGsSWn52L7eCaH
         LL8Q==
X-Gm-Message-State: ALoCoQndVEcs2LLZjXUog29oaTHKPbpp7DslulBBELPqmnJuFFIDuFJJmgxgWMeQb3V8am6q56Q5
X-Received: by 10.52.148.2 with SMTP id to2mr18768223vdb.38.1406304773595;
 Fri, 25 Jul 2014 09:12:53 -0700 (PDT)
Received: by 10.52.180.6 with HTTP; Fri, 25 Jul 2014 09:12:53 -0700 (PDT)
In-Reply-To: <1406285039-22469-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254231>

Nice.

On Fri, Jul 25, 2014 at 3:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h |  11 ++++
>  refs.c  | 204 ++++++++++++++++++++++++++++++++++--------------------=
----------
>  2 files changed, 120 insertions(+), 95 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 5ffbafb..40a63d9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1003,6 +1003,17 @@ extern int read_ref(const char *refname, unsig=
ned char *sha1);
>  extern const char *resolve_ref_unsafe(const char *ref, unsigned char=
 *sha1, int reading, int *flag);
>  extern char *resolve_refdup(const char *ref, unsigned char *sha1, in=
t reading, int *flag);
>  extern int resolve_ref(const char *refname, struct strbuf *result, u=
nsigned char *sha1, int reading, int *flag);
> +/*
> + * Given a ref in "ref" and its path, returns
> + *
> + * -2  failed to open with ENOENT, the caller is responsible for
> + *     checking missing loose ref (see resolve_ref for example)
> + * -1  if there's an error, "ref" can no longer be trusted, "flag" m=
ay
> + *     be set. errno is valid.
> + *  0  this is a symref, "ref" now contains the linked ref
> + * +1  normal ref, "sha1" is valid
> + */
> +extern int parse_ref(const char *path, struct strbuf *ref, unsigned =
char *sha1, int *flag);
>
>  extern int dwim_ref(const char *str, int len, unsigned char *sha1, c=
har **ref);
>  extern int dwim_log(const char *str, int len, unsigned char *sha1, c=
har **ref);
> diff --git a/refs.c b/refs.c
> index bec2bb1..2769f20 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1533,6 +1533,105 @@ static int handle_missing_loose_ref(const cha=
r *refname,
>         }
>  }
>
> +int parse_ref(const char *path, struct strbuf *ref,
> +             unsigned char *sha1, int *flag)

Can you make this function static?
It is not used by anything outside of this series and thus making it
static avoids growing the public refs api.


> +{
> +       struct strbuf buffer =3D STRBUF_INIT;
> +       struct stat st;
> +       const char *buf;
> +
> +       /*
> +        * We might have to loop back here to avoid a race condition:
> +        * first we lstat() the file, then we try to read it as a lin=
k
> +        * or as a file.  But if somebody changes the type of the fil=
e
> +        * (file <-> directory <-> symlink) between the lstat() and
> +        * reading, then we don't want to report that as an error but
> +        * rather try again starting with the lstat().
> +        */
> +stat_ref:
> +       if (lstat(path, &st) < 0)
> +               return errno =3D=3D ENOENT ? -2 : -1;
> +
> +       /* Follow "normalized" - ie "refs/.." symlinks by hand */
> +       if (S_ISLNK(st.st_mode)) {
> +               struct strbuf new_path =3D STRBUF_INIT;
> +               if (strbuf_readlink(&new_path, path, 256) < 0) {
> +                       strbuf_release(&new_path);
> +                       if (errno =3D=3D ENOENT || errno =3D=3D EINVA=
L)
> +                               /* inconsistent with lstat; retry */
> +                               goto stat_ref;
> +                       else
> +                               return -1;
> +               }
> +               if (starts_with(new_path.buf, "refs/") &&
> +                   !check_refname_format(new_path.buf, 0)) {
> +                       strbuf_reset(ref);
> +                       strbuf_addbuf(ref, &new_path);
> +                       if (flag)
> +                               *flag |=3D REF_ISSYMREF;
> +                       strbuf_release(&new_path);
> +                       return 0;
> +               }
> +               strbuf_release(&new_path);
> +       }
> +
> +       /* Is it a directory? */
> +       if (S_ISDIR(st.st_mode)) {
> +               errno =3D EISDIR;
> +               return -1;
> +       }
> +
> +       /*
> +        * Anything else, just open it and try to use it as
> +        * a ref
> +        */
> +       if (strbuf_read_file(&buffer, path, 256) < 0) {
> +               strbuf_release(&buffer);
> +               if (errno =3D=3D ENOENT)
> +                       /* inconsistent with lstat; retry */
> +                       goto stat_ref;
> +               else
> +                       return -1;
> +       }
> +       strbuf_rtrim(&buffer);
> +
> +       /*
> +        * Is it a symbolic ref?
> +        */
> +       if (!skip_prefix(buffer.buf, "ref:", &buf)) {
> +               int ret;
> +               /*
> +                * Please note that FETCH_HEAD has a second line
> +                * containing other data.
> +                */
> +               if (get_sha1_hex(buffer.buf, sha1) ||
> +                   (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[=
40]))) {
> +                       if (flag)
> +                               *flag |=3D REF_ISBROKEN;
> +                       errno =3D EINVAL;
> +                       ret =3D -1;
> +               } else
> +                       ret =3D 1;
> +               strbuf_release(&buffer);
> +               return ret;
> +       }
> +       if (flag)
> +               *flag |=3D REF_ISSYMREF;
> +       while (isspace(*buf))
> +               buf++;
> +       if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
> +               if (flag)
> +                       *flag |=3D REF_ISBROKEN;
> +               strbuf_release(&buffer);
> +               errno =3D EINVAL;
> +               return -1;
> +       }
> +       strbuf_reset(ref);
> +       strbuf_addstr(ref, buf);
> +       strbuf_release(&buffer);
> +       return 0;
> +}
> +
>  /*
>   * 'result' content will be destroyed. Its value may be undefined if
>   * resolve_ref returns -1.
> @@ -1542,9 +1641,8 @@ static int handle_missing_loose_ref(const char =
*refname,
>  int resolve_ref(const char *refname, struct strbuf *result,
>                 unsigned char *sha1, int reading, int *flag)
>  {
> -       struct strbuf buffer =3D STRBUF_INIT;
>         int depth =3D MAXDEPTH;
> -       int ret =3D -1;
> +       int ret =3D 0;
>
>         if (flag)
>                 *flag =3D 0;
> @@ -1557,108 +1655,24 @@ int resolve_ref(const char *refname, struct =
strbuf *result,
>         strbuf_reset(result);
>         strbuf_addstr(result, refname);
>
> -       for (;;) {
> +       while (!ret) {
>                 char path[PATH_MAX];
> -               const char *ref =3D result->buf;
> -               struct stat st;
> -               const char *buf;
>
>                 if (--depth < 0) {
>                         errno =3D ELOOP;
> +                       ret =3D -1;
>                         break;
>                 }
>
> -               git_snpath(path, sizeof(path), "%s", ref);
> -
> -               /*
> -                * We might have to loop back here to avoid a race
> -                * condition: first we lstat() the file, then we try
> -                * to read it as a link or as a file.  But if somebod=
y
> -                * changes the type of the file (file <-> directory
> -                * <-> symlink) between the lstat() and reading, then
> -                * we don't want to report that as an error but rathe=
r
> -                * try again starting with the lstat().
> -                */
> -       stat_ref:
> -               if (lstat(path, &st) < 0) {
> -                       if (errno =3D=3D ENOENT)
> -                               ret =3D handle_missing_loose_ref(ref,=
 sha1,
> -                                                              readin=
g, flag);
> -                       break;
> +               git_snpath(path, sizeof(path), "%s", result->buf);
> +               ret =3D parse_ref(path, result, sha1, flag);
> +               if (ret =3D=3D -2) {
> +                       ret =3D handle_missing_loose_ref(result->buf,=
 sha1,
> +                                                      reading, flag)=
;
> +                       ret =3D ret ? -1 : 1;
>                 }
> -
> -               /* Follow "normalized" - ie "refs/.." symlinks by han=
d */
> -               if (S_ISLNK(st.st_mode)) {
> -                       /* no need to reset buffer, strbuf_readlink d=
oes that */
> -                       if (strbuf_readlink(&buffer, path, 256) < 0) =
{
> -                               if (errno =3D=3D ENOENT || errno =3D=3D=
 EINVAL)
> -                                       /* inconsistent with lstat; r=
etry */
> -                                       goto stat_ref;
> -                               else
> -                                       break;
> -                       }
> -                       if (starts_with(buffer.buf, "refs/") &&
> -                           !check_refname_format(buffer.buf, 0)) {
> -                               strbuf_reset(result);
> -                               strbuf_addbuf(result, &buffer);
> -                               if (flag)
> -                                       *flag |=3D REF_ISSYMREF;
> -                               continue;
> -                       }
> -               }
> -
> -               /* Is it a directory? */
> -               if (S_ISDIR(st.st_mode)) {
> -                       errno =3D EISDIR;
> -                       break;
> -               }
> -
> -               /*
> -                * Anything else, just open it and try to use it as
> -                * a ref
> -                */
> -               strbuf_reset(&buffer);
> -               if (strbuf_read_file(&buffer, path, 256) < 0) {
> -                       if (errno =3D=3D ENOENT)
> -                               /* inconsistent with lstat; retry */
> -                               goto stat_ref;
> -                       else
> -                               break;
> -               }
> -               strbuf_rtrim(&buffer);
> -
> -               /*
> -                * Is it a symbolic ref?
> -                */
> -               if (!skip_prefix(buffer.buf, "ref:", &buf)) {
> -                       /*
> -                        * Please note that FETCH_HEAD has a second
> -                        * line containing other data.
> -                        */
> -                       if (get_sha1_hex(buffer.buf, sha1) ||
> -                           (buffer.buf[40] !=3D '\0' && !isspace(buf=
fer.buf[40]))) {
> -                               if (flag)
> -                                       *flag |=3D REF_ISBROKEN;
> -                               errno =3D EINVAL;
> -                       } else
> -                               ret =3D 0;
> -                       break;
> -               }
> -               if (flag)
> -                       *flag |=3D REF_ISSYMREF;
> -               while (isspace(*buf))
> -                       buf++;
> -               if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)=
) {
> -                       if (flag)
> -                               *flag |=3D REF_ISBROKEN;
> -                       errno =3D EINVAL;
> -                       break;
> -               }
> -               strbuf_reset(result);
> -               strbuf_addstr(result, buf);
>         }
> -       strbuf_release(&buffer);
> -       return ret;
> +       return ret > 0 ? 0 : -1;
>  }
>
>  const char *resolve_ref_unsafe(const char *refname, unsigned char *s=
ha1, int reading, int *flag)
> --
> 1.9.1.346.ga2b5940
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
