From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] pack-refs: remove all empty directories under
 $GIT_DIR/refs
Date: Sat, 11 Feb 2012 00:26:23 -0800
Message-ID: <7vhayxn5cg.fsf@alter.siamese.dyndns.org>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
 <1328946907-31650-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 09:26:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw8II-00032N-Rr
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 09:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab2BKI01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 03:26:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab2BKI00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 03:26:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91F7C4780;
	Sat, 11 Feb 2012 03:26:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DMpFkr38UfeC
	0zSRynECVYu76TU=; b=GvTQ1ZByjCVUcz5KWBlFfjyXJQTkX35o0uDQDPrvg8NU
	v7m5QU+y9kKk8ILCq9USyA/OpL2jbnfa2G8VYRMCgjjt/dvAoyRnt+dFLQi0O3Gh
	pGjHg86WaJR4qkAMN3hNhEtvLf3TzRWoR8O+nbNWayKUtOhxW3FWcfLIAam+t2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d04quX
	oFuUadawnFEOPVPNtWNh6bdMuVywyOfY+00j8BErux5h2/6snlEXP6luNzhXPghH
	zs73xuSfCJ4Cngebz3KcU5+lYTIzw6OUybnZOLWllvJrLJGBd85i0bnz50i2/kPS
	BqsAU+Xz0oMTlnSbgGs+DjuzsEJ2yo0GIHJpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A43D477F;
	Sat, 11 Feb 2012 03:26:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D19477C; Sat, 11 Feb 2012
 03:26:24 -0500 (EST)
In-Reply-To: <1328946907-31650-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 11 Feb
 2012 14:55:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E91BB0-548A-11E1-A52F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190502>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Deleting refs does not remove parent directories if they are empty.
> Empty directories add extra overhead to startup time of most of git
> commands because they have to traverse $GIT_DIR/refs.

Perhaps drop the first line and replace with the description of what yo=
u
do differently from the first round?

    "git pack-refs" tries to remove directory that becomes empty but it
    does not try to do so hard enough, leaving a parent directory full =
of
    empty children directories without removing.

or something?

> Some directories are kept by this patch even if they are empty (refs,
> refs/heads and refs/tags). The first one is one of git repository
> signature. The rest is created by init-db, one may expect them to alw=
ays
> be there.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  v2, no more refs code change.
>
>  Part of the reason I do not want to update delete_ref() is because i=
t
>  won't remove empty directories in existing repositories.

While I agree with Peff that people would expect doing other things whi=
le
pack-refs is running would be much "riskier" and doing this inside
pack-refs is far more preferable than doing so during normal read-only
operation, I wonder why we would want a completely separate pass that
scans the entire hierarchy.  Would it make more sense to note the
directory for which rmdir() fails in try_remove_empty_parents(), and
revisit only these directories, at least?

Wouldn't we want to rmdir() the corresponding logs/ hierarchy while at =
it
to be consistent?

>
>  pack-refs.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  1 files changed, 53 insertions(+), 0 deletions(-)
>
> diff --git a/pack-refs.c b/pack-refs.c
> index f09a054..bb3a9c4 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -91,6 +91,58 @@ static void try_remove_empty_parents(char *name)
>  	}
>  }
> =20
> +static int prune_empty_dirs(const char *path)
> +{
> +	int nr_entries =3D 0, pathlen =3D strlen(path);
> +	DIR *dir;
> +	struct dirent *de;
> +	char *subpath;
> +
> +	dir =3D opendir(git_path("%s", path));
> +
> +	if (!dir)
> +		return 0;
> +
> +	subpath =3D xmalloc(pathlen + 257);

What is this 257 about?

> +	memcpy(subpath, path, pathlen);
> +	if (pathlen && path[pathlen-1] !=3D '/')
> +		subpath[pathlen++] =3D '/';
> +
> +	while ((de =3D readdir(dir)) !=3D NULL) {
> +		struct stat st;
> +		int namelen;
> +
> +		if (de->d_name[0] =3D=3D '.') {
> +			if (strcmp(de->d_name, "..") && strcmp(de->d_name, "."))
> +				nr_entries++;
> +			continue;
> +		}
> +		nr_entries++;
> +		namelen =3D strlen(de->d_name);
> +		if (namelen > 255)
> +			continue;
> +		if (has_extension(de->d_name, ".lock"))
> +			continue;

This is a sign that somebody else might be actively accessing this
repository.

> +		memcpy(subpath + pathlen, de->d_name, namelen+1);
> +		if (stat(git_path("%s", subpath), &st) < 0)
> +			continue;
> +		if (S_ISDIR(st.st_mode)) {
> +			int removed =3D prune_empty_dirs(subpath);
> +			if (removed)
> +				nr_entries--;
> +			continue;
> +		}
> +	}
> +	free(subpath);
> +	closedir(dir);
> +	if (nr_entries =3D=3D 0 &&
> +	    strcmp(path, "refs") &&
> +	    strcmp(path, "refs/heads") &&
> +	    strcmp(path, "refs/tags"))
> +		return rmdir(git_path("%s", path)) =3D=3D 0;
> +	return 0;
> +}
> +
>  /* make sure nobody touched the ref, and unlink */
>  static void prune_ref(struct ref_to_prune *r)
>  {
> @@ -109,6 +161,7 @@ static void prune_refs(struct ref_to_prune *r)
>  		prune_ref(r);
>  		r =3D r->next;
>  	}
> +	prune_empty_dirs("refs");
>  }
> =20
>  static struct lock_file packed;
