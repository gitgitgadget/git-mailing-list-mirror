From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] blame: CRLF in the working tree and LF in the repo
Date: Fri, 01 May 2015 10:13:56 -0700
Message-ID: <xmqqbni4xlt7.fsf@gitster.dls.corp.google.com>
References: <55436852.3030002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, kasal@ucw.cz
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 01 19:14:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEVp-0007fH-8I
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbbEAROA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 13:14:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905AbbEARN7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 13:13:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 591CB4CBA8;
	Fri,  1 May 2015 13:13:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KCgLsgVNCmHu
	vKz5SomGKFSDR8w=; b=URvSdyo8SiVnzJxnuHaFj7r2zMaH1TmTRw+DzKWg6JII
	rI6jkM5KLeQ4nkYMvyRD/wNRzYPD1FvPnoNrUps3C52zGOal3LIgL5/D0WEtMN/B
	r58/P5xy8Z5ajYzGzvzfb4avpnwCl7RCE5DNP3Vl1VgUrCX4lf17vvzeMgG1n+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dq/+Hj
	cEwHty3qeDoR+1otlQANLnZOTvmvXUaO0EnO5WcvBPhk05zrImQ67xqf6Y3/3FrU
	gc3xP81FDT3nHJfo9Z66AHr6BmaOF5r6eWHiwtWw1K6ocdrp2982vjqBe0hTVDrj
	D9BT2yCFZa9mI4qvnfCMWYtfx4LFmkr6tdHNY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 507814CBA7;
	Fri,  1 May 2015 13:13:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA6424CBA1;
	Fri,  1 May 2015 13:13:57 -0400 (EDT)
In-Reply-To: <55436852.3030002@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 01 May 2015 13:49:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73FDB0AA-F025-11E4-9F31-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268159>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> A typical setup under Windows:
> core.eol is CRLF and a file is marked as "text" in .gitattributes,
> or core.autocrlf is true

A full sentence (a proper prose) is easier to read.  The above is
unclear if that is what you are unilaterally declaring, a statement
of fact, or something else (see what I queued based on the previous
round on 'pu').

> After 4d4813a5 "git blame" no longer works as expected,
> every line is annotated as "Not Committed Yet",
> even though the working directory is clean.
>
> commit 4d4813a5 removed the conversion in blame.c for all files,
> with or without CRLF in the repo.
>
> Having files with CRLF in the repo and core.autocrlf=3Dinput is a tem=
porary
> situation, the files should be normalized in the repo.
> Blaming them with "Not Committed Yet" is OK.
>
> The solution is to revert commit 4d4813a5.

Do these two (or three) patches separately:

 - One patch to revert it and do nothing else other than justify the
   revert in the log message; and

 - Another patch that demonstrates failures Kasal found so that we
   won't repeat the mistake.

 - Optionally, yet another patch that demonstrates the current
   breakage that exists with or without the reversion.

The former two may be combined into one, but the last one should be
a separate patch, as it does not have anything to do with this
reversion.

In other words, there shouldn't be a new test-expect-failure in
a revert of an existing commit (unless that commit removed that
test-expect-failure in the first place, claiming that it fixed
something, that is).  If you are documenting a failure that has
not been tested in our test suite, do so in a separate patch.

Thanks.

> Reported-By: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since V3:
>  more test cases
>  Sorry for the spam
>
> builtin/blame.c               |  1 +
>  t/t8003-blame-corner-cases.sh | 48 +++++++++++++++++++++++++++++++++=
++++------
>  2 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 06484c2..8d70623 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2348,6 +2348,7 @@ static struct commit *fake_working_tree_commit(=
struct diff_options *opt,
>  		if (strbuf_read(&buf, 0, 0) < 0)
>  			die_errno("failed to read from stdin");
>  	}
> +	convert_to_git(path, buf.buf, buf.len, &buf, 0);
>  	origin->file.ptr =3D buf.buf;
>  	origin->file.size =3D buf.len;
>  	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cas=
es.sh
> index 32895e5..8af36a6 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -191,13 +191,49 @@ test_expect_success 'indent of line numbers, te=
n lines' '
>  	test $(grep -c "  " actual) =3D 9
>  '
> =20
> -test_expect_success 'blaming files with CRLF newlines' '
> -	git config core.autocrlf false &&
> +test_expect_success 'setup crlf files' '
>  	printf "testcase\r\n" >crlffile &&
> -	git add crlffile &&
> -	git commit -m testcase &&
> -	git -c core.autocrlf=3Dinput blame crlffile >actual &&
> -	grep "A U Thor" actual
> +	printf "testcase\n" >lffile &&
> +	git -c core.autocrlf=3Dfalse add lffile crlffile &&
> +	git commit -m "add files" &&
> +	git -c core.autocrlf=3Dfalse blame HEAD -- crlffile >crlfclean.txt
> +	printf "testcase\r\n" >crlffile &&
> +	git -c core.autocrlf=3Dfalse blame HEAD -- lffile >lfclean.txt
> +	printf "testcase\r\n" >lffile
> +	#Keep lffile with CRLF in worktree
> +'
> +
> +test_expect_success 'blame file with CRLF in repo core.autocrlf=3Dfa=
lse' '
> +	git -c core.autocrlf=3Dfalse blame crlffile >crlf_repo_false &&
> +	test_cmp crlfclean.txt crlf_repo_false
> +'
> +
> +#has_cr_in_index() should suppress the normalization, see convert.c
> +#but read_blob_data_from_cache() returns NULL
> +test_expect_failure 'blame file with CRLF in repo core.autocrlf=3Dtr=
ue' '
> +	git -c core.autocrlf=3Dtrue blame crlffile >crlf_repo_true &&
> +	test_cmp crlfclean.txt crlf_repo_true
> +'
> +
> +test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dtrue=
' '
> +	git -c core.autocrlf=3Dtrue blame lffile >lf_repo_true &&
> +	test_cmp lfclean.txt lf_repo_true
> +'
> +
> +test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dinpu=
t' '
> +	git -c core.autocrlf=3Dinput blame lffile >lf_repo_input &&
> +	test_cmp lfclean.txt lf_repo_input
> +'
> +
> +test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dfals=
e' '
> +	git -c core.autocrlf=3Dfalse blame lffile >lf_repo_false &&
> +	grep "Not Committed Yet" lf_repo_false
> +'
> +
> +test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dfals=
e attributes' '
> +	printf "lffile text\r\n" >.gitattributes &&
> +	git -c core.autocrlf=3Dfalse blame lffile >lf_repo_attr_text &&
> +	test_cmp lfclean.txt lf_repo_attr_text
>  '
> =20
>  test_done
