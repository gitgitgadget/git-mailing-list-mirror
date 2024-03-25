Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71065102B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402494; cv=none; b=XADzFEFQxZ+mWxow5djMCE8XqYzJvH4MYBlbt/18R1zEKzz8kllHQQMIqLABgi0cPzg7CkrPSE9BtvTPdyvr3StcytjMPUFu9CJbPjz190lnFuY+/S408YRhs2ZRtTp+xMEXxj4O1knYbaOUFlVS/1KGZWv5pSnK2CM0QvPLlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402494; c=relaxed/simple;
	bh=/FprnCglktDRpOn0VaTVOz9KbDYlf9OG0dbM1YsR4qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ArFn0sBBKzyn+vUAjLkUXlUfb8TEOx6TsfQ5a1n1/4n8R0R522MDItHbFUpmFlLgbfkttV9GShDDL9VvO1tBve6e6+SlFz/FVLD0eYFuAS8CA9n3KE0nfV3AEvfdiOBqOhqjaugbZn4Q4+XzzN1TzZnLBzio+SH12cir07JLNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iJiD2FqJ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iJiD2FqJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B20327B7A;
	Mon, 25 Mar 2024 17:34:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/FprnCglktDR
	pOn0VaTVOz9KbDYlf9OG0dbM1YsR4qw=; b=iJiD2FqJ780EYIet81T7lwKYk+gy
	j7HggKDyom+HqE3J/MkZ9nprpcexKtxpC7fu4EB8eFEXNseP934PUz1upus7WLrS
	XxWFnNjqnzHqEpw/+3cE4+P9BQJiejW583VRAwMldG2OcdrW3lwwKYmGMdpGkJ4q
	hnmZ3pXKLTUGA74=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54C9127B79;
	Mon, 25 Mar 2024 17:34:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91C4F27B78;
	Mon, 25 Mar 2024 17:34:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add-patch: do not print hunks repeatedly
In-Reply-To: <6bc655ea-783e-477e-84ec-04503fa20799@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 25 Mar 2024 22:07:05 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6bc655ea-783e-477e-84ec-04503fa20799@gmail.com>
Date: Mon, 25 Mar 2024 14:34:46 -0700
Message-ID: <xmqqjzlqgfm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8184B40C-EAEF-11EE-AE4F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> ... or an invalid option, i.e: "U"
> ...
>     (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
> ...
>     ? - print help
>     @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next u=
ndecided hunk\n"
>      static int patch_update_file(struct add_p_state *s,
>      			     struct file_diff *file_diff)
>      {
>     -	size_t hunk_index =3D 0;
>     +	size_t hunk_index =3D 0, prev_hunk_index =3D -1;
>      	ssize_t i, undecided_previous, undecided_next;
>      	struct hunk *hunk;
>      	char ch;
>     (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
>
> Printing the chunk again followed by the question can be confusing as
> the user has to pay special attention to notice that the same chunk is
> being reconsidered.
>
> It can also be problematic if the chunk is longer than one screen heigh=
t
> because the result of the previous iteration is lost off the screen (th=
e
> help guide in the previous example).

Indeed.  The more important part of the message from the command in
these cases tells that the previous input was invalid and why.

Stopping after that without showing the hunk again does make sense.
