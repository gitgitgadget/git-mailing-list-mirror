Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014712AAC8
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638661; cv=none; b=NhFzYhinYpZCbd0ODKvrBlT9Oepvyx7N9lXrWrR8mmKm3hQAoU2hhfxYFsNprNovmxLdkYFh2O77wDdrPCxxmtmi9eHIQZR/BohNesjfyt6gi1NA1mFTJ234ITTHYea23FWnQMIACloItMx2hK0ownHsQlojQh28LE7jsK9HNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638661; c=relaxed/simple;
	bh=7VgWd6bZZvaOnfIvy61Io8gWCIaTAHugyxis0exjytI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MAh+OseMNdoFYz+GntCbc9dVqu2ost5HVRliLFL9xUYzVhhzwnivQ7Yneb55XC+jDxJ1D68+PxSnuBEoDq1rGm9D1Igv4W6mOzEacyE9JOPqJoUZe00wmgJtTFeLfX9/v1pBglL97EvxiNBb2po0xW41K5ylyTdZqisqIl2/Tlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dK13OEZu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dK13OEZu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0835C1EAAED;
	Thu, 28 Mar 2024 11:10:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7VgWd6bZZvaO
	nfIvy61Io8gWCIaTAHugyxis0exjytI=; b=dK13OEZufnuXW6LD1Itp8mK7y7Q8
	WbSRvIMAcBrcHceS31rKNkCR8oDosoyyMsanIaixKP1Uz517BeoWRPR0Pt08IPpK
	Ty6trJB62GZ36J7rNiMLZlp/1EuTKjEDPQ7u/kSMkYGuuBb14yCkN6FXdEQCOZXH
	EsO6pZUiC6VYhAE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00BD51EAAEC;
	Thu, 28 Mar 2024 11:10:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A4AB1EAAEA;
	Thu, 28 Mar 2024 11:10:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: GSoC 2024 [RFC PATCH] Fix Git command exit code suppression in
 test script t2104-update-index-skip-worktree.sh
In-Reply-To: <CAHCXyj1vbGqmXjeUyN7AgBtkvtsGUtmXwb=timJ3s48F=8Kd7Q@mail.gmail.com>
	(Aishwarya Narayanan's message of "Thu, 28 Mar 2024 14:10:04 +0530")
References: <CAHCXyj1vbGqmXjeUyN7AgBtkvtsGUtmXwb=timJ3s48F=8Kd7Q@mail.gmail.com>
Date: Thu, 28 Mar 2024 08:10:57 -0700
Message-ID: <xmqqttkqwfwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 61AC644A-ED15-11EE-9ADC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Aishwarya Narayanan <aishnana.03@gmail.com> writes:

> Dear Git Contributors,
> Please find attached a patch addressing an issue in the test script
> t2104-update-index-skip-worktree.sh. The issue pertains to the
> inadvertent suppression of exit codes from Git commands when used in
> pipelines, potentially leading to false positives in test results.

The above belongs to the space after the three-dash line before the
diffstat.

There are many things in this proposed log message that can be
improved by reading and following Documentation/SubmittingPatches
document.  The above is one of them.

> From a80ff00cda2445f93eac1510f0434095f342887b Mon Sep 17 00:00:00 2001
> From: Aishwarya <your@email.com>
> Date: Thu, 28 Mar 2024 13:54:35 +0530

Copying a patch into e-mail (be careful not to corrupt whitespaces
and line-folding) is pefectly fine, but the above should not even
appear anywhere in your message.  The first one is there to serve as
a hint to help find(1) the type of the mailbox file and to separate
patches in a file (when you have multiple patches in a file).  From:
and Date: will be taken from the e-mail headers (so your MUA should
send as the address you sign off your patch with).

> Subject: [PATCH] This commit addresses an issue in our test scripts whe=
re the
>  exit code of Git commands could be inadvertently suppressed when used =
in
>  pipelines. Such suppression can lead to tests passing despite failures=
 in Git
>  commands, potentially masking bugs or regressions.

The first paragraph of the message you write in "git commit -e" should
be a single-line that is around 50 columns wide or less.

> Changes made:
>
> - Modified instances where `git ls-files -t` and similar Git commands
> are used in pipelines, to capture their output in a variable first.
> This ensures that the exit code of the Git command is correctly
> evaluated.
> - Applied checks for the exit code immediately after the command
> execution, allowing the script to exit with an error if the Git
> command fails.
> - Adjusted related test cases to work with the new method of capturing
> and evaluating Git command outputs.

And these bulleted list should not have to be there---the code
change should be obvious enough.

> These changes improve the robustness of our testing framework by
> ensuring that the failure of a Git command in a test script is
> correctly detected and reported. This is crucial for maintaining the
> reliability and integrity of the Git project as we continue to evolve
> and enhance its functionality.

Missing sign-off.

> ---
>  t/t2104-update-index-skip-worktree.sh | 66 ++++++++-------------------
>  1 file changed, 20 insertions(+), 46 deletions(-)
>
> diff --git a/t/t2104-update-index-skip-worktree.sh
> b/t/t2104-update-index-skip-worktree.sh
> index 0bab134d71..c552d2208e 100755
> --- a/t/t2104-update-index-skip-worktree.sh
> +++ b/t/t2104-update-index-skip-worktree.sh
> @@ -3,65 +3,39 @@
>  # Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
>  #
>
> -test_description=3D'skip-worktree bit test'
> -
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> -. ./test-lib.sh
> -
> -sane_unset GIT_TEST_SPLIT_INDEX
> -
> -test_set_index_version () {
> -    GIT_INDEX_VERSION=3D"$1"
> -    export GIT_INDEX_VERSION
> -}
> -
> -test_set_index_version 3
> -
> -cat >expect.full <<EOF
> -H 1
> -H 2
> -H sub/1
> -H sub/2
> -EOF
> -
> -cat >expect.skip <<EOF
> -S 1
> -H 2
> -S sub/1
> -H sub/2
> -EOF
> -

It is not clear what all of these removals have to do with the
changes the proposed log message talked about.  With the above
change, nobody creates expect.full or expect.skip, but yet the
remaining tests still do use these two files.  We no longer force
the index version to 3, either.

>  test_expect_success 'setup' '
>     mkdir sub &&
>     touch ./1 ./2 sub/1 sub/2 &&
>     git add 1 2 sub/1 sub/2 &&
> -   git ls-files -t | test_cmp expect.full -
> -'
> -
> -test_expect_success 'index is at version 2' '
> -   test "$(git update-index --show-index-version)" =3D 2

I do not know what justifies the index-version check, so I won't
comment on this change.

> +   output=3D$(git ls-files -t)
> +   echo "$output" | test_cmp expect.full -

It is unsual to take the output into a variable, echo it and pretend
as if that is in file '-'.  A more usual construction would be

	git ls-files -t >actual &&
	test_cmp expect.full actual

> +   if [ $? -ne 0 ]; then
> +       exit 1
> +   fi
>  '

Documentation/CodingGuidelines; we prefer "test" over "[]", indent
with tab, and write the conditional like so:

	if ...
	then
		...
	fi


Besides, you should not "exit" from test_expect_success block to
begin with.  Perhaps you didn't read t/README especially the part
"And here are the "don'ts:""?  Please do so before touching any
tests.

I'll stop here.
