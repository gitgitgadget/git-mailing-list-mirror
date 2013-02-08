From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Fri, 08 Feb 2013 10:35:49 -0800
Message-ID: <7v1ucq3b7e.fsf@alter.siamese.dyndns.org>
References: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 <1360318171-17614-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3so4-0006Nl-7h
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946793Ab3BHSfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 13:35:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946783Ab3BHSfw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 13:35:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A688FC8C4;
	Fri,  8 Feb 2013 13:35:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7RWDqoMr1/W4
	+QvcAxKSM89xEUs=; b=YouNCHuqnYBPCLWfvVuz7FD2TnAsJ39u9NNcgU8LQOeZ
	87af2tAbIpVqavCudOPOu8/fNX/FOudvsUi7mJfhKs4LzceiFsgPm55dSjH+CuJQ
	bdMjGUAeavuKOPKj9CnW8wHpxMdXjmhmqYewVzSV0VHplLZ9GpLWXsP7n8m/9d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pUonGD
	QLzSdm7+Bt19UQi86tqaHjSYYKJX4LIKsBf8CtQ8fidel0HLquEfbYYoUalMmW5/
	VKgLAiBA/MakQ1nMp9XO9ovjtnSlZ/eo247/z7/JGdgsdSZnZ0u88e68g6hNgjAH
	845IL7+7y56BK5dUJwCB6dmqBJn2bjwT8TMBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B45DC8C3;
	Fri,  8 Feb 2013 13:35:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDD8DC8C2; Fri,  8 Feb 2013
 13:35:50 -0500 (EST)
In-Reply-To: <1360318171-17614-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Feb
 2013 17:09:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CFC6C5C-721E-11E2-AC9E-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215797>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This prints more helpful info when HEAD is detached: is it detached
> because of bisect or rebase? What is the original branch name in thos=
e
> cases?
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Keep "no branch" in all cases. Just append "rebasing/bisecting [%s]"
>  when applicable.
>
>  builtin/branch.c            | 44 +++++++++++++++++++++++++++++++++++=
++++++++-
>  t/t6030-bisect-porcelain.sh |  2 +-
>  2 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6371bf9..26c0c3d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -550,6 +550,48 @@ static int calc_maxwidth(struct ref_list *refs)
>  	return w;
>  }
> =20
> +static char *get_head_description()
> +{
> +	struct stat st;
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct strbuf result =3D STRBUF_INIT;
> +	int bisect =3D 0;
> +	int ret;
> +	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode))
> +		ret =3D strbuf_read_file(&sb, git_path("rebase-merge/head-name"), =
0);
> +	else if (!access(git_path("rebase-apply/rebasing"), F_OK))
> +		ret =3D strbuf_read_file(&sb, git_path("rebase-apply/head-name"), =
0);
> +	else if (!access(git_path("BISECT_LOG"), F_OK)) {
> +		ret =3D strbuf_read_file(&sb, git_path("BISECT_START"), 0);
> +		bisect =3D 1;
> +	} else
> +		return xstrdup(_("(no branch)"));
> +
> +	if (ret <=3D 0) {

Doesn't the general "negative signals an error" apply here?

The end result may be the same, as the later part of this function
that uses sb with len=3D=3D0 ends up showing the same "bisecting" (or
"rebasing") without any other information, but the logic to reach
that outcome looks wrong.

> +		if (bisect)
> +			return xstrdup(_("(no branch, bisecting)"));
> +		else
> +			return xstrdup(_("_(no branch, rebasing)"));
> +	}
> +
> +	while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
> +		strbuf_setlen(&sb, sb.len - 1);
> +
> +	if (bisect) {
> +		unsigned char sha1[20];
> +		if (!get_sha1_hex(sb.buf, sha1))
> +			strbuf_addstr(&result, _("(no branch, bisecting)"));
> +		else
> +			strbuf_addf(&result, _("(no branch, bisecting %s)"), sb.buf);
> +	} else {
> +		if (!prefixcmp(sb.buf, "refs/heads/"))
> +			strbuf_addf(&result, _("(no branch, rebasing %s)"), sb.buf + 11);
> +		else
> +			strbuf_addstr(&result, _("(no branch, rebasing)"));
> +	}
> +	strbuf_release(&sb);
> +	return strbuf_detach(&result, NULL);
> +}

We may want to refactor wt_status_print_state() and its callee a bit
so that it and this part can share the logic without duplication and
risk implementing subtly different decision.  wt_status used to have
clean separation between collection phase and presentation phase,
but the wall between the phases seems deteriorated over time as more
"in progress" crufts have been piled on top.

Such a refactoring may look larger than necessary, but on the other
hand, I do not see this feature very useful if it can over time
drift away from what we will see in "git status", so...

> =20
>  static void show_detached(struct ref_list *ref_list)
>  {
> @@ -557,7 +599,7 @@ static void show_detached(struct ref_list *ref_li=
st)
> =20
>  	if (head_commit && is_descendant_of(head_commit, ref_list->with_com=
mit)) {
>  		struct ref_item item;
> -		item.name =3D xstrdup(_("(no branch)"));
> +		item.name =3D get_head_description();
>  		item.width =3D utf8_strwidth(item.name);
>  		item.kind =3D REF_LOCAL_BRANCH;
>  		item.dest =3D NULL;
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.s=
h
> index 3e0e15f..9b6f0d0 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git=
/BISECT_START" not modified if
>  	cp .git/BISECT_START saved &&
>  	test_must_fail git bisect start $HASH4 foo -- &&
>  	git branch > branch.output &&
> -	test_i18ngrep "* (no branch)" branch.output > /dev/null &&
> +	test_i18ngrep "* (no branch, bisecting other)" branch.output > /dev=
/null &&
>  	test_cmp saved .git/BISECT_START
>  '
>  test_expect_success 'bisect start: no ".git/BISECT_START" if mistake=
n rev' '
