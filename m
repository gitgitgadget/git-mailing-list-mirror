From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] status:introduce status.branch to enable --branch by default
Date: Mon, 10 Jun 2013 11:17:50 -0700
Message-ID: <7vmwqxj0dt.fsf@alter.siamese.dyndns.org>
References: <1370878068-7643-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<1370878068-7643-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6fF-0000nz-JB
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab3FJSRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:17:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab3FJSRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:17:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A48B2278A0;
	Mon, 10 Jun 2013 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dCEYBioIryS30tw/sr6d/ydTqpA=; b=iDgr4I
	eLPyc3U0O0qEfjjz5nZKAGtQ7UlKwpYuz4fZRwyR1hiycbiahdu3fGXo2pF3Bu0W
	FDaLd2oeLmoSc78C1d2dCEElp+C/5meALdWzdPuOE+uOjKtNl7Xul47S+uyKQS0c
	qOCuvT6E8/uRfIiOBdq1jEzo5ms0o6994VcRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hyFVfGGgNt4vWD/1D285twtYpvYId3cj
	kGXR1KcJBdWQiDn/CcdAAh522JlgVWr6M+Q0uMAJttE3UJZba6H9e80w1wPG44FX
	VFk+GDqHD3d8hWztb2RVOpUy7BgSe8uuk7DrcSqz2TJfRqrFZtozq7dYvcjM8aFe
	0pWIGvjgCdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938842789F;
	Mon, 10 Jun 2013 18:17:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0A442789A;
	Mon, 10 Jun 2013 18:17:51 +0000 (UTC)
In-Reply-To: <1370878068-7643-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge Juan Garcia Garcia's message of "Mon, 10 Jun 2013 17:27:48
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10418032-D1FA-11E2-9E49-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227340>

Jorge Juan Garcia Garcia  <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
writes:

> Some people often run 'git status -b'.
> The config variable status.branch allows to set it by default.
>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>
> Changes since v2:
>  -removal of double quotes in test
>
>  Documentation/config.txt |    4 ++++
>  builtin/commit.c         |    4 ++++
>  t/t7508-status.sh        |   27 +++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1983bf7..ecdcd6d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2070,6 +2070,10 @@ status.short::
>  	Set to true to enable --short by default in linkgit:git-status[1].
>  	The option --no-short takes precedence over this variable.
>  
> +status.branch::
> +	Set to true to enable --branch by default in linkgit:git-status[1].
> +	The option --no-branch takes precedence over this variable.
> +
>  status.showUntrackedFiles::
>  	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
>  	files which are not currently tracked by Git. Directories which
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 287f1cb..f2b5d44 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1117,6 +1117,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  			status_format = STATUS_FORMAT_SHORT;
>  		return 0;
>  	}
> +	if (!strcmp(k, "status.branch")) {
> +		s->show_branch = git_config_bool(k, v);

This one, unlike 1/2, acts correctly when status.branch is set to
no.  Good.

The same comments as 1/2 apply to the test script additions in this
patch.

> +		return 0;
> +	}
>  	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
>  		s->use_color = git_config_colorbool(k, v);
>  		return 0;
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index d99ca9f..5e6df95 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1366,6 +1366,33 @@ test_expect_success '"status.short=false" weaker than "-s"' '
>  	test_cmp actual expected_short
>  '
>  
> +test_expect_success '"status.branch=true" same as "-b"' '
> +	git -c status.branch=true status -s >actual &&
> +	git status -sb >expected_branch &&
> +	test_cmp actual expected_branch
> +'
> +
> +test_expect_success '"status.branch=true" different from "--no-branch"' '
> +	git -c status.branch=true status -s >actual &&
> +	git status -s --no-branch  >expected_nobranch &&
> +	test_must_fail test_cmp actual expected_nobranch
> +'
> +
> +test_expect_success '"status.branch=true" weaker than "--no-branch"' '
> +	git -c status.branch=true status -s --no-branch >actual &&
> +	test_cmp actual expected_nobranch
> +'
> +
> +test_expect_success '"status.branch=false" same as "--no-branch"' '
> +	git -c status.branch=false status -s >actual &&
> +	test_cmp actual expected_nobranch
> +'
> +
> +test_expect_success '"status.branch=false" weaker than "-b"' '
> +	git -c status.branch=false status -sb >actual &&
> +	test_cmp actual expected_branch
> +'
> +
>  test_expect_success 'Restore default test environment' '
>  	git config --unset status.showUntrackedFiles
>  '
