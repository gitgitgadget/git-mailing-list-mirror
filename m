From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v5] diff --stat: tests for long filenames and big
 change counts
Date: Wed, 15 Feb 2012 09:12:50 -0800
Message-ID: <7vvcn810ml.fsf@alter.siamese.dyndns.org>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
 <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 18:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxiPc-0002RC-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 18:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab2BORM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 12:12:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab2BORMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 12:12:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D9466EB2;
	Wed, 15 Feb 2012 12:12:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rsyNaW2HEFdD
	uFu+25ku+DcEUAg=; b=VvHvzsM/CmygLMRNudlv+JB5Ts6BuvP5AFB8AG/HEGR5
	qQTuq+CL7KLNxSpmhcecrIYyuSOtDZ6qNltAC16pCR2WJ3xaDxRiuPaBXYcRyrvN
	qmlyPSOGu1jAHMMtGql8GB16S4IqGWUZlQDr+ry7xitt3CLVBW74M0/DgiGrkSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QDWZww
	B0QRXnzqmGwRbicp8a96GQ+e5xCHzM9StDK5X8uW4FPSNcn7tFAdss6D18L9XAZ1
	QU74REFHGTjzgDQg8TrUM5W3PJFJIp8Rn2gCfxXkTaIqyr9yjdflYiocBnWdyKqC
	ISK7CUU2r98Z5CWBw1QQEMV+1BEWqdAE4H1ZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53E5E6EB1;
	Wed, 15 Feb 2012 12:12:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E446EAC; Wed, 15 Feb 2012
 12:12:52 -0500 (EST)
In-Reply-To: <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 15 Feb 2012
 12:03:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B493FBC-57F8-11E1-A29E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190838>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Eleven tests for various combinations of a long filename and/or big
> change count and ways to specify widths for diff --stat.
> ---

Sign-off?=20

> Tests added in previous version of 'diff --stat: use full terminal wi=
dth'
> are extracted into a separate patch. The tests are usefull independen=
tly
> of that patch anyway.

Thanks.

> +# 120 character name
> +name=3Daaaaaaaaaa
> +name=3D$name$name$name$name$name$name$name$name$name$name$name$name
> +test_expect_success 'preparation' "
> +	>\"$name\" &&
> +	git add \"$name\" &&
> +	git commit -m message &&
> +	echo a >\"$name\" &&
> +	git commit -m message \"$name\"
> +"

Just for future reference.

The last parameter to test_expect_success shell function is `eval`ed by
the shell and $name is visible inside it; you do not have to use double
quote around it and then use backquote to quote the inner double quote.

> +cat >expect <<'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aa |    1 +
> +EOF
> +test_expect_success 'format patch graph width defaults to 80 columns=
' '
> +	git format-patch --stat --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'

Hrm, this does not seem to pass, making the result of applying [1/3] fa=
il;
I see that the elided name is shown much shorter than the above expects=
=2E

Perhaps this test found a bug in a "very long name, small changes" corn=
er
case?  If that is the case, we'd mark it as test_expect_failure, and
explain the tests that expect failure demonstrates a buggy behaviour, e=
=2Eg.

	When a pathname is so long that it cannot fit on the column, the
	current code truncates it to make sure that the graph part has at
	least N columns (enough room to show a meaningful graph).  If the
	actual change is small (e.g. only one line changed), this results
	in the final output that is shorter than the width we aim for.  A
	couple of new tests marked with test_expect_failure demonstrate
	this bug.

in the log message (note that I am not sure if that is the nature of th=
e
bug, or what the actual value of N is).

And then a later patch [2/3] that updates the allocation between name a=
nd
graph will turn test_expect_failure to test_expect_success; that will m=
ake
it clear that your update fixed the bug.

> +cat >expect <<'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
> +EOF
> +test_expect_success 'format patch --stat=3Dwidth with long name' '
> +	git format-patch --stat=3D40 --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'

Likewise.

> +test_expect_success 'format patch --stat-width=3Dwidth works with lo=
ng name' '
> +	git format-patch --stat-width=3D40 --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'

Likewise.

> +test_expect_success 'format patch --stat=3D...,name-width with long =
name' '
> +	git format-patch --stat=3D60,29 --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'format patch --stat-name-width with long name' =
'
> +	git format-patch --stat-name-width=3D29 --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'

Likewise.

> +test_expect_success 'preparation' '

There was another "preparation" in this script already, which originall=
y
threw me off while chasing which part of the test is failing. Can you
reword/retitle this one?

> +cat >expect <<'EOF'
> + abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
> +EOF
> +test_expect_success 'format patch graph part width is 40 columns' '
> +	git format-patch --stat --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'

This test shouldn't be added in [1/3] because "cap the graph to 40-col"=
 is
a new feature that is introduced in the later step.

> +test_expect_success 'format patch ignores COLUMNS' '
> +	COLUMNS=3D200 git format-patch --stat --stdout -1 >output
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'

This is a good test to have in [1/3], but the expectation should not ca=
p the
graph part to 40 columns.  The patch that updates diff.c to implement t=
he
cap in [2/3] should have an update to the expectation, whose diff hunk =
may
look liks this:

@@=20
 cat >expect <<'EOF'
+ abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
- abcd | 1000 ++++++++++++++++++++++++++++++++++++++++=20
 EOF

That would make the effect of the patch clearer.

> +cat >expect <<'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
> +EOF
> +test_expect_success 'format patch --stat=3Dwidth with big change and=
 long name' '
> +	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
> +	git add aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
> +	git commit -m message &&
> +	git format-patch --stat-width=3D60 --stdout -1 >output &&
> +	grep " | " output >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

The same comment as the previous one.  Because you change the allocatio=
n
to the graph part in your patch to diff.c, which hasn't happened in [1/=
3]
yet, this should expect the existing behaviour (narrower graph) in this
step, and then be updated to expect the output shown above in the [2/3]
patch that changes the implementation in diff.c.
