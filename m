From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] hooks: Add ability to specify where the hook directory is
Date: Tue, 26 Apr 2016 12:55:03 -0700
Message-ID: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
	<1461694402-9629-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av94k-0007iY-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbcDZTzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 15:55:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845AbcDZTzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 15:55:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2D5B15A93;
	Tue, 26 Apr 2016 15:55:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AXd02Zp45UOM
	fEcd2UGlxNIVEpk=; b=uzyqFPO91YdUGCieHm6nFwh162kz9Xg1cUmuhvTV/SYv
	CyCFtI1JY50F/bnludApNWpziWfueSmaWkRGzHnwa9Kdv4GkMLH5iQk4DxFtvev5
	qoTAfJ7zFPi4RANBewyDzOi3cztEneAQX77Wc9LOfi8i5g5ULOV5kVz44Dr9aVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s/wn/Q
	WA9EThU2h31lwyRQEIgQvN4Q9z8o7U8T6e5uZccZjrzGe7kmacYGM+9r7Iyfb88I
	8Gd/5ZrgLPsorckbIwcieaENmkNTboUiKKczH5mOOr2b5CDihLqZxQk59zn5SIC/
	EZeFD0HE8B7lWkarZqbGGuiGSZ6sCRyRLMazI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA69B15A92;
	Tue, 26 Apr 2016 15:55:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17D8B15A91;
	Tue, 26 Apr 2016 15:55:05 -0400 (EDT)
In-Reply-To: <1461694402-9629-5-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 26 Apr
 2016 18:13:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C541E6A4-0BE8-11E6-B4DB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292656>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +core.hooksPath::
> +	By default Git will look for your hooks in the
> +	'$GIT_DIR/hooks' directory. Set this to different path,
> +	e.g. '/etc/git/hooks', and Git will try to find your hooks in
> +	that directory, e.g. '/etc/git/hooks/pre-receive' instead of
> +	in '$GIT_DIR/hooks/pre-receive'.
> ++
> +The path can either be absolute or relative. When specifying a
> +relative path see the discussion in the "DESCRIPTION" section of
> +linkgit:githooks[5] for what the relative relative path will be
> +relative to.

    The path can be either absolute or relative.  A relative path is
    taken as relative to the directory where the hooks are run (see
    linkgit:githooks[5]).

perhaps?

> +This configuration is useful in cases where you'd like to
> +e.g. centrally configure your Git hooks instead of configuring them =
on

s/e.g. //;

I thought "you can do X (if you want to do X)" were getting
rewritten to "you can do X", not "you can do e.g. X".

> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path=
=2Esh
> new file mode 100755
> index 0000000..f2f0aa9
> --- /dev/null
> +++ b/t/t1350-config-hooks-path.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description=3D'Test the core.hooksPath configuration variable'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'set up a pre-commit hook in core.hooksPath' '
> +	mkdir -p .git/custom-hooks .git/hooks &&
> +	write_script .git/custom-hooks/pre-commit <<-\EOF &&
> +printf "%s" "CUST" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF

	write_script .git/custom-hooks/pre-commit <<-\EOF &&
	printf "%s" "CUST" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
	EOF

I however wonder why this is not "echo CUST" (or even "echo
CUSTOM").

> +	write_script .git/hooks/pre-commit <<-\EOF
> +printf "%s" "NORM" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF
> +'

Likewise.

> +test_expect_success 'Check that various forms of specifying core.hoo=
ksPath work' '
> +	test_commit no_custom_hook &&
> +	git config core.hooksPath .git/custom-hooks &&
> +	test_commit have_custom_hook &&
> +	git config core.hooksPath .git/custom-hooks/ &&
> +	test_commit have_custom_hook_trailing_slash &&
> +	git config core.hooksPath "$PWD/.git/custom-hooks" &&
> +	test_commit have_custom_hook_abs_path &&
> +	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
> +	test_commit have_custom_hook_abs_path_trailing_slash &&
> +	printf "%s" "NORMCUSTCUSTCUSTCUST" >.git/PRE-COMMIT-HOOK-WAS-CALLED=
=2Eexpect &&

And this will become

	test_write_lines NORM CUST CUST CUST CUST >expect &&

> +	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOO=
K-WAS-CALLED

If you did one-line-at-a-time with 'echo', test_cmp would show
line-wise diff, which may make spotting the difference easier.

> +'
> +
> +test_done
