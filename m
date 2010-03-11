From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] worktree setup: call set_git_dir explicitly
Date: Thu, 11 Mar 2010 13:24:14 -0800
Message-ID: <7vljdyy2kh.fsf@alter.siamese.dyndns.org>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
 <1268313754-28179-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 22:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npprr-0004Io-4U
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 22:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0CKVYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 16:24:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab0CKVYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Mar 2010 16:24:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E332A1BC4;
	Thu, 11 Mar 2010 16:24:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=249uiHv21ddh
	MDgt+iavqYUUfNU=; b=lf0UJ/kgRaDCDv8JQj7fYkn2n0zPucob4himhLXRnfZ1
	ieWaIwS7sUTvqv4vSseodL6qySSZY3LiR2c+Lq0oNKckBgWWk/WfaAO4qLenTuUM
	M+yZc0hRlJVFV3s/MoZTfMr/eKffPS7A5Re+opf5oOx4N+njSdSZ/h5a4tZFHvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Jd26kV
	8PXRaDytb1lyn0KXx9DeRDfjal1JUAaT+mRNWvyoxGW9aRwczSAmRQnFiqjabuEL
	bJ0E75TmRqXMrafPdn2KnW+dDBD62mWB1HsvS0fPPd9OVfsZkPhbxp2qf38+Rlqk
	Wvy7u6SmyhfbB68WoTe6aRwAl3kBpgTDp0C5g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1960BA1BC3;
	Thu, 11 Mar 2010 16:24:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2BF3A1BC0; Thu, 11 Mar
 2010 16:24:15 -0500 (EST)
In-Reply-To: <1268313754-28179-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\, 11 Mar
 2010 20\:22\:22 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 73ED3A52-2D54-11DF-BFA8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142001>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  setup.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index e067292..43a8609 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -350,14 +350,17 @@ static const char *setup_git_directory_gently_1=
(int *nongit_ok)
>  				/* config may override worktree */
>  				if (check_repository_format_gently(nongit_ok))
>  					return NULL;
> +				set_git_dir(gitdirenv);
>  				return retval;
>  			}
>  			if (check_repository_format_gently(nongit_ok))
>  				return NULL;
>  			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
>  					get_git_work_tree());
> -			if (!retval || !*retval)
> +			if (!retval || !*retval) {
> +				set_git_dir(gitdirenv);
>  				return NULL;
> +			}
>  			set_git_dir(make_absolute_path(gitdirenv));
>  			if (chdir(work_tree_env) < 0)
>  				die_errno ("Could not chdir to '%s'", work_tree_env);
> @@ -392,8 +395,10 @@ static const char *setup_git_directory_gently_1(=
int *nongit_ok)
>  	offset =3D len =3D strlen(cwd);
>  	for (;;) {
>  		gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> -		if (gitfile_dir || is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) =
{
> -			if (gitfile_dir && set_git_dir(gitfile_dir))
> +		if (!gitfile_dir && is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
> +			gitfile_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
> +		if (gitfile_dir) {
> +			if (set_git_dir(gitfile_dir))
>  				die("Repository setup failed");
>  			inside_git_dir =3D 0;
>  			if (!work_tree_env)


Yes, you have more calls to set_git_dir() than before.  But it is not
explained why "calling set_git_dir explicitly" is a good thing anywhere=
 in
the series.

Can you write down the set of rules for your setup sequence, the goal
after everything from this 37-patch series is applied?  Something along
the lines of (just illustrating the kinds of things to be described):

 - Definition.

   The following state variables belong to the setup system:

   - git_dir: holds the location of $GIT_DIR as a path relative to cwd
   - is_bare_repository(): returns foo;
   - is_inside_working_tree(): returns bar;
   - ...

 - Rule for the callers of the setup system:

   Once main() starts, this and that needs to be called in this order
   before trying to access any of the above state.  Specifically, the
   following call could access state variables, and should not be calle=
d
   before this set-up is done:

    - git_config(): needs to know where git_dir is;
    - setup_revisions(), parse_options(), ...: needs to know the prefix=
;
    - ...

 - Rule for the implementation of the setup system:

   Upon the first call the caller makes into the setup system:

   1. If the caller does not care about being in a git repository,
      skip everything up to step #n.

   2. First inspect GIT_DIR; if set, go to step #5.

   3. Otherwise try to find GIT_DIR by checking .git or "." is a git
      directory; repeat this step by checking one directory closer to t=
he
      root level until GIT_DIR is found or CEILING is reached.

   4. If there is no GIT_DIR, then chdir back to the original location,
      and skip everything up to step #m.

   5. As a side effect of finding the GIT_DIR, the configuration file i=
s
      read from there, and we will know the value of core.worktree.

   6. Inspect GIT_WORK_TREE; if set then git_work_tree is known.
      Otherwise, if core.worktree is found in step #5, that is the valu=
e
      of git_work_tree.  Otherwise determine git_work_tree in this
      fashon. ...

   ...


Without seeing such a design that you can clearly explain to others, th=
e
series looks nothing more than a sequence of "I noticed this so am
applying this random patch" and is impossible to review.
