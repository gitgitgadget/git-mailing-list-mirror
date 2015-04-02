From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add test for showing discarded changes with diff --cc
Date: Thu, 02 Apr 2015 13:55:58 -0700
Message-ID: <xmqqy4mai71d.fsf@gitster.dls.corp.google.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
	<1428006853-21212-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kirill Smelkov <kirr@mns.spb.ru>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:56:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydm9l-0003qH-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbbDBU4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:56:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752252AbbDBU4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 16:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAC2944FEF;
	Thu,  2 Apr 2015 16:55:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VnoHGOWLFffd5oiTKkw3MzE/jgU=; b=r3zkZ9
	bcO3G4PQY7XeSpOCMMItwB3FKY+naXvoqPvRRB34t04gHvz9MVBz6xVK+HQ1gQx8
	DxaFP7amWpkagi49zfWKRPr+t9WDpLJdEDlOKnplwW4AuM2uYK6rhoKdA96cowIf
	qllhKh7IjYZKUv28JjjZjB6SAFULpa34h6rTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DWgWrW7uCZT3k47V3V4qaAlU1VqgNhoK
	r+AkEPW0I4VZd7ysK+zfGJpg28DuYrizu65CApkJBAvnr7MUDFfJRKeTxdQ27UH7
	PXMNfKI1BmTlL2pWt67DoHWLtPlAtudz77ipFwJVzY82CDUHqPM9OhMDTtbqnrTK
	f1/1VGnNvkI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C25F544FEE;
	Thu,  2 Apr 2015 16:55:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4537B44FEC;
	Thu,  2 Apr 2015 16:55:59 -0400 (EDT)
In-Reply-To: <1428006853-21212-2-git-send-email-max@max630.net> (Max
	Kirillov's message of "Thu, 2 Apr 2015 23:34:10 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA37B592-D97A-11E4-A1C7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266674>

Max Kirillov <max@max630.net> writes:

> If a hunk has been changed in both branches and conflict resolution
> fully takes one of branches, discarding all changes that are in the
> other, then the merge is not shown in 3-way diff which git uses by
> default.
>
> The advice is to use flag --cc and and explicitly add the mergebase was
> given in $gmane/191557. It was discovered though that it does not always
> work. If the whole file has not changed at all compared to one of
> branches then no difference is shown for this file.
>
> This looks inconsistent and for particular scenario of viewing discarded
> changes is undesirable.
>
> Add the test which demonstrates the issue.
>
> Signed-off-by: Max Kirillov <max@max630.net>

Thanks.  I will not have time to review this properly at the moment
while preparing 2.4-rc1, and I do not want to spend time figuring
out if the parent culling you are chaning was done deliberately (in
which case this patch may be breaking things) or not.

So I'll give a preliminary nitpicks first ;-)

>> Subject: Re: [PATCH 1/4] Add test for showing discarded changes with diff --cc

Subject: t4059: test 'diff --cc' with a change from only few parents

or something?  "<area>: <what you did>" without capitalization of
the beginning of what you did and the full-stop at the end.

> ---
>  t/t4059-diff-merge-with-base.sh | 100 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100755 t/t4059-diff-merge-with-base.sh
>
> diff --git a/t/t4059-diff-merge-with-base.sh b/t/t4059-diff-merge-with-base.sh
> new file mode 100755
> index 0000000..e650a33
> --- /dev/null
> +++ b/t/t4059-diff-merge-with-base.sh
> @@ -0,0 +1,100 @@
> +#!/bin/sh
> +
> +test_description='Diff aware of merge base'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	mkdir short &&
> +	mkdir long &&
> +	for fn in win1 win2 merge delete base only1 only2; do
> +		test_seq 3 >short/$fn
> +		git add short/$fn &&
> +		test_seq 11 >long/$fn &&
> +		git add long/$fn
> +	done &&

Two nits:

 - Style: have "do" on its own line.  A good rule of thumb is that
   you shouldn't have to type ';' when you are writing a shell
   script, unless you are terminating a case arm with ';;'.

	for fn in ...
        do
        	...
	done

 - Correctness: aside from missing && after "test_seq 3", if the
   last step "git add long/$fn" failed in an earlier iteration, you
   would not notice any breakage.  Either

	(
                for fn in ...
                do
                        ... &&
                        ... &&
                        ... || exit $?
                done
	)

    or

	for fn in ...
        do
        	... &&
                ... &&
                ... || return $?
	done

    The latter is only valid in our test scripts, where the test
    framework gives you an artificial "caller" of the "subroutine"
    you are writing as the test body.

> +	test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" >long/base &&
> +	git add long/base &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change1/" >long/win1 &&
> +	git add long/win1 &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change2/" >long/win2 &&
> +	git add long/win2 &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2merged/" >long/merge &&
> +	git add long/merge &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "/^2/d" >long/delete &&
> +	git add long/delete &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change1/" >long/only1 &&
> +	git add long/only1 &&
> + test_seq 11 | sed -e "s/^7/7change1/" -e "s/^11/11change2/" -e
> "s/^2/2change2/" >long/only2 &&
> +	git add long/only2 &&

Patch is line-wrapped around here?
