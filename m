From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] t7407: make expectation as clear as possible
Date: Tue, 29 Mar 2016 12:30:58 -0700
Message-ID: <xmqqfuv9xerx.fsf@gitster.mtv.corp.google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:31:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzM5-0004CJ-Sc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750AbcC2TbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:31:05 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754157AbcC2TbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:31:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3702850497;
	Tue, 29 Mar 2016 15:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uBPn9ba5SzfE8mR/5WrZauQErHc=; b=gUhAX6
	Vaj6J5iSOvy/tt7JtuCkvh9+HKzjyVAnHKlXgJsSBZetWOBIaTdYwS+0+s0IQCJj
	TX9vWQRSy7BLg8u9hMDhqGbSLqJTWkVsNzEBrDskeSw4TD0bLSwbRHE7+G2yclxA
	kBf9d/7BH2Fk5B47JUi/O0sMXy8V5GO4TasH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jEalqGqEQKEPEisb0cOjNpNaxSlxRVYM
	tUh8Xm5n5VoF1Oh7tJ+8unCO2d3hKDsOk0iRYremWmVLIAI+mZdw9wfynp+v/SU3
	A1t/0c43AiA8GAau+3X91u9HgpX628qmHb4S4EGOFTxsvu+gMR551BnGxKJiQV0J
	wbH1Tllpskw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDB7D50496;
	Tue, 29 Mar 2016 15:31:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19D7D50494;
	Tue, 29 Mar 2016 15:31:00 -0400 (EDT)
In-Reply-To: <1459207703-1635-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Mar 2016 16:28:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C468D69E-F5E4-11E5-B7F7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290171>

Stefan Beller <sbeller@google.com> writes:

> Not everyone (including me) grasps the sed expression in a split second as
> they would grasp the 4 lines printed as is.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I agree that the overlong sed expression is not very readable.
Spelling the expectation out like this patch does would make sense.
A slight possible downside is that future changes in the test setup
may require updating two places now instead of one, but I would say
that would not make a very strong objection--after all, such future
changes may affect the line that is munged by the sed script, in
which case you'd need to change two places anyway (i.e. the previous
"expect" and also the script), and updating two explicit expectation
would be far easier than updating one explicit expectation and the
overlong sed expression.

Perhaps this wants to come much earlier in the series?  It felt a
bit distracting while reading the series in sequence, derailing my
train of thought.

Thanks.

>  t/t7407-submodule-foreach.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 776b349..808c6c6 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -262,8 +262,12 @@ test_expect_success 'test "status --recursive"' '
>  	test_cmp expect actual
>  '
>  
> -sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2 (file2~1)/;/sub[1-3]/d" < expect > expect2
> -mv -f expect2 expect
> +cat > expect <<EOF
> + $nested1sha1 nested1 (heads/master)
> ++$nested2sha1 nested1/nested2 (file2~1)
> + $nested3sha1 nested1/nested2/nested3 (heads/master)
> + $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
> +EOF
>  
>  test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
>  	(
