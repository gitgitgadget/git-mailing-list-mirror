From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 1/2] config: define and document exit codes
Date: Tue, 17 May 2011 12:46:36 -0300
Message-ID: <BANLkTikjY956f7LxXGY5fcLkJJDuMnt6OQ@mail.gmail.com>
References: <20110517140725.GA17193@sigill.intra.peff.net>
	<6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 17 17:46:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMTr-0003CJ-Ky
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab1EQPqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 11:46:37 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:48713 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238Ab1EQPqh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 11:46:37 -0400
Received: by pxi16 with SMTP id 16so424987pxi.4
        for <git@vger.kernel.org>; Tue, 17 May 2011 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f2eCa25J3tqVhyBDL6+6H4Gwl6KP4eRPWz3qur9obdU=;
        b=l2d8i8Y5KwwZnxslAryXt1SVOqIXvdAp3xwk56Yc7OfqLOI7ww6yii29MB4KhgWrgA
         T9hTwnyRXVmv+mBzaAuGYB6Ugveroblmct19MvJjGSwbDs9fVfV0b2W5nxSMDtvuEKJI
         LMTbAaiU0EndPswK4iNvz6d1LwfK4gK4l3Pl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CFE7vafp29o2OjyOo8YbKa0HQtcrVqLLRgrKrVDJMX970VmEOvhnclufnZms5CGxcW
         XCndwOCBqfD8FFKmGDoOVHV3VZkYG3CJcp5Mhn5KNHD+Mh39Sg0yYjLGihnzemgcPx4g
         GUIAw5tIrgfALRr0TOk+hZwxxouJlZeLkKm+4=
Received: by 10.142.225.9 with SMTP id x9mr513486wfg.99.1305647196547; Tue, 17
 May 2011 08:46:36 -0700 (PDT)
Received: by 10.143.76.1 with HTTP; Tue, 17 May 2011 08:46:36 -0700 (PDT)
In-Reply-To: <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173808>

On Tue, May 17, 2011 at 12:38 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The return codes of git_config_set() and friends are magic numbers ri=
ght
> in the source. #define them in cache.h where the functions are declar=
ed,

Why defining them on cache.h? Just because the functions are declared
there? Is this a good reason? I think this pollute even more the
cache.h and these constants are not used outside of config.c. So I'd
move them back onto config.c. Maybe it's fine as is though.

> and use the constants in the source.
>
> Also, mention the resulting exit codes of "git config" in its man pag=
e
> (and complete the list).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> =C2=A0Documentation/git-config.txt | =C2=A0 18 ++++++++++--------
> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 10 ++++++++++
> =C2=A0config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 20 ++++++++++----------
> =C2=A03 files changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.=
txt
> index 8804de3..e7ecf5d 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -50,16 +50,18 @@ The default is to assume the config file of the c=
urrent repository,
> =C2=A0.git/config unless defined otherwise with GIT_DIR and GIT_CONFI=
G
> =C2=A0(see <<FILES>>).
>
> -This command will fail if:
> -
> -. The config file is invalid,
> -. Can not write to the config file,
> -. no section was provided,
> -. the section or key is invalid,
> -. you try to unset an option which does not exist,
> -. you try to unset/set an option for which multiple lines match, or
> -. you use '--global' option without $HOME being properly set.
> -
> +This command will fail (with exit code ret) if:
> +
> +. The config file is invalid (ret=3D3),
> +. can not write to the config file (ret=3D4),
> +. no section or name was provided (ret=3D2),
> +. the section or key is invalid (ret=3D1),
> +. you try to unset an option which does not exist (ret=3D5),
> +. you try to unset/set an option for which multiple lines match (ret=
=3D5),
> +. you try to use an invalid regexp (ret=3D6), or
> +. you use '--global' option without $HOME being properly set (ret=3D=
128).
> +
> +On success, the command returns the exit code 0.
>
> =C2=A0OPTIONS
> =C2=A0-------
> diff --git a/cache.h b/cache.h
> index 2225c3f..57a98d2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1018,6 +1018,16 @@ extern const char *packed_object_info_detail(s=
truct packed_git *, off_t, unsigne
> =C2=A0/* Dumb servers support */
> =C2=A0extern int update_server_info(int);
>
> +/* git_config_parse_key() returns these negated: */
> +#define CONFIG_INVALID_KEY 1
> +#define CONFIG_NO_SECTION_OR_NAME 2
> +/* git_config_set(), git_config_set_multivar() return the above or t=
hese: */
> +#define CONFIG_NO_LOCK -1
> +#define CONFIG_INVALID_FILE 3
> +#define CONFIG_NO_WRITE 4
> +#define CONFIG_NOTHING_SET 5
> +#define CONFIG_INVALID_PATTERN 6
> +
> =C2=A0typedef int (*config_fn_t)(const char *, const char *, void *);
> =C2=A0extern int git_default_config(const char *, const char *, void =
*);
> =C2=A0extern int git_config_from_file(config_fn_t fn, const char *, v=
oid *);
> diff --git a/config.c b/config.c
> index 671c8df..9d36848 100644
> --- a/config.c
> +++ b/config.c
> @@ -1123,12 +1123,12 @@ int git_config_parse_key(const char *key, cha=
r **store_key, int *baselen_)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (last_dot =3D=3D NULL || last_dot =3D=3D=
 key) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error("key doe=
s not contain a section: %s", key);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -2;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CONFIG_NO_=
SECTION_OR_NAME;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!last_dot[1]) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error("key doe=
s not contain variable name: %s", key);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -2;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CONFIG_NO_=
SECTION_OR_NAME;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0baselen =3D last_dot - key;
> @@ -1165,7 +1165,7 @@ int git_config_parse_key(const char *key, char =
**store_key, int *baselen_)
>
> =C2=A0out_free_ret_1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(*store_key);
> - =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 return -CONFIG_INVALID_KEY;
> =C2=A0}
>
> =C2=A0/*
> @@ -1221,7 +1221,7 @@ int git_config_set_multivar(const char *key, co=
nst char *value,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error("could n=
ot lock config file %s: %s", config_filename, strerror(errno));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(store.key=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CONFIG_NO_=
LOCK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -1235,12 +1235,12 @@ int git_config_set_multivar(const char *key, =
const char *value,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ( ENOENT !=3D=
 errno ) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0error("opening %s: %s", config_filename,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(errno));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D 3; /* same as "invalid config file" */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D CONFIG_INVALID_FILE; /* same as "invalid config file" *=
/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if nothing =
to unset, error out */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =3D=3D=
 NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D 5;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D CONFIG_NOTHING_SET;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -1268,7 +1268,7 @@ int git_config_set_multivar(const char *key, co=
nst char *value,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R=
EG_EXTENDED)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error("invalid pattern: %s", =
value_regex);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(store.value_regex);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 6;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CONFIG_INVALID_PATTERN;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -1290,7 +1290,7 @@ int git_config_set_multivar(const char *key, co=
nst char *value,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regfree(store.value_regex);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(store.value_regex);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D 3;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D CONFIG_INVALID_FILE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -1303,7 +1303,7 @@ int git_config_set_multivar(const char *key, co=
nst char *value,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if nothing =
to unset, or too many matches, error out */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((store.see=
n =3D=3D 0 && value =3D=3D NULL) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(store.seen > 1 && multi_repl=
ace =3D=3D 0)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D 5;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D CONFIG_NOTHING_SET;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -1364,7 +1364,7 @@ int git_config_set_multivar(const char *key, co=
nst char *value,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (commit_lock_file(lock) < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error("could n=
ot commit config file %s", config_filename);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 4;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CONFIG_NO_=
WRITE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> --
> 1.7.5.1.514.gd181fb
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
