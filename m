Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066412B93
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717780456; cv=none; b=Q3OdKAHinYsms4SqhkGVLVbUri4THPYV8MyVJKv0tK/E29YxKVpQgg8yxJdPvB3kwK4Agj9EaQc8vl+ByqNLE7kdDjFnW6GdX2GbyKVUx5/2N9dzKwTOtwS7zp1Ta3zugimuWYucnqU7O7nU/+dRnwFnEY9BPOah/fT6jbv/qjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717780456; c=relaxed/simple;
	bh=a1GJfczwi1eET9EEfWv+NKG2uJd1tC98NT8LeCK1sCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3ZQfRypQZqJnMNPg14euIfTB3yLfJP/wp8hcp5X5IYLObpU0usbeH+gabXx/BdSR6l2Yjla+zLPtroNSsg4iNNBKsf4DFK+Es0aqdWX9Ki+Xi70/5S/WlU44nvdeR3+Cd7Tpo+4iSDv3aaJCaMhC5MJWuLPcbjpmuOi0m1u7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1DlojK4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1DlojK4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D239C37389;
	Fri,  7 Jun 2024 13:14:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a1GJfczwi1eE
	T9EEfWv+NKG2uJd1tC98NT8LeCK1sCk=; b=e1DlojK4qanPAxGsrgmNG1GeOq6y
	0xSLAnynWCfXSerpSjxDbJF47yNg0+UohWQvao+Zz2j0Nf6sT0I6UFwl7qbY2nEL
	vSqI4WwpOFBiGaD0RM4H6BpGw9e6tx6Xs6FId6GMluDmciH2YtD7Ee4/auAPIktV
	OhwvW0B5WnJlPf0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C9F6337388;
	Fri,  7 Jun 2024 13:14:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E99FC37387;
	Fri,  7 Jun 2024 13:14:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/2] t4014: cleanups in a few tests
In-Reply-To: <20b95372-12cf-49bd-b1b7-dc069e7c86dd@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 7 Jun 2024 18:30:17 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
	<cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
	<9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
	<20b95372-12cf-49bd-b1b7-dc069e7c86dd@gmail.com>
Date: Fri, 07 Jun 2024 10:14:10 -0700
Message-ID: <xmqqed98ekv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5BEC6D16-24F1-11EF-8081-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Arrange things we are going to create to be removed at end, and then
> start creating them.  That way, we will clean them up even if we fail
> after creating some but before the end of the command.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  t/t4014-format-patch.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index e37a1411ee..5fb5250df4 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -820,8 +820,8 @@ test_expect_success 'format-patch --notes --signoff=
' '
>  '
> =20
>  test_expect_success 'format-patch notes output control' '
> +	test_when_finished "git notes remove HEAD" &&
>  	git notes add -m "notes config message" HEAD &&
> -	test_when_finished git notes remove HEAD &&

If "notes add" fails to create a note for HEAD, test_when_finished
would notice that it cannot remove a note from HEAD, wouldn't it?
If you do

                ! grep "notes config message" out &&
                git format-patch -1 --stdout --no-notes --notes >out &&
        -	grep "notes config message" out
        +	grep "notes config message" out &&
        +	git notes remove HEAD
         '

at the end of this passing test to remove the note from HEAD (so
that when-finished handler has nothing to remove), and run "sh
t4014-format-patch.sh -i -v", this test piece 4014.70 fails with

	...
            notes config message
        Removing note for object HEAD
        Object HEAD has no note
        not ok 70 - format-patch notes output control

A failure in the when-finished handler is noticed (which we might
argue is a misfeature), and that is why it is a good idea to write

	test_when_finished 'rm -f cruft-that-may-be-created' &&
	do what might create cruft-that-may-be-created

with "-f".

A standard trick can be found in the output of

	$ git grep 'finished.*|| *:' t/

Thanks.
