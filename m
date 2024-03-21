Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931D224D7
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043456; cv=none; b=kr47wAcBtX2lkrMomyXhJa5yMlcEboA62LcebJDS3G3mhKNWVt37xdmR4W/B7YfEkAQDs0L39s0fEVWkFJ4rG8Dr0mbAzLVLXj7iY3e/cZFHjitZFelHtaTcdokyxlUP3kOuQY9hSjwIbk2eyzio5Fd0SYBZT9AKNYfdyWD4/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043456; c=relaxed/simple;
	bh=bZRK2pxIn4ziSmJRUbuHkxTXgAdX6DVznfJV4wu6hQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZcUHE7hIcY4o6W5iwWd6yDtGnTsMApnjL+QpyJjuSYFryHK/gzT4EnXBh6vCYYVrvywrFCX0sF5L6udJEoCKceGuD4CvVXT8HbJYDPFybDGk3exAgJHmIFf5Vqkmt8pZpsVK+DdW+mYp8NfZt5xZ0A+UHXN3zWrBeKPrBCUZqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ca7/QXXw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ca7/QXXw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 476D51EBB36;
	Thu, 21 Mar 2024 13:50:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bZRK2pxIn4zi
	SmJRUbuHkxTXgAdX6DVznfJV4wu6hQI=; b=Ca7/QXXwfCASFctxBiykFCS9G1Fg
	73Scw2NrzuU9pO/dgUAvgQYSPD3I1bRo9MHDDQE1IDwLo3VH7nsSl9y5XNKfTP6O
	2RRClzwGpZXpR/dQLXPV/9lMagN9sY3g6eyiKOMeFKcaYHkO8MjX2QPMgaOyFayY
	XAHExENrmfJCi48=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F8FB1EBB35;
	Thu, 21 Mar 2024 13:50:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1BAF1EBB34;
	Thu, 21 Mar 2024 13:50:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Richard Kerry <richard.kerry@eviden.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Merge selected files or folders
In-Reply-To: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
	(Richard Kerry's message of "Thu, 21 Mar 2024 16:50:30 +0000")
References: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
Date: Thu, 21 Mar 2024 10:50:52 -0700
Message-ID: <xmqqbk778oeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 90059560-E7AB-11EE-82DF-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Richard Kerry <richard.kerry@eviden.com> writes:

> I'd like to merge only certain files, or folders, from another
> branch.=C2=A0 What command or options should I be looking at to get
> this done?

If you are using the verb "merge" in the way Git uses, then there is
*no* option to do so and that is very much deliberate, as allowing
such a operation will break your history.

A "merge" commit in Git records the fact that *all* changes that
were done in each parent since the merged branches diverged have
been considered and the tree recorded by the merge commit is the
result.  Hence, if you later change your mind and "merge" other
changes from the same branch, it will result in no change at all, by
definition.

But if you are porting some changes made on another branch to the
current branch, and then planning to record the result as a regular
single parent commit, then there is no fundamental reason to forbid
such an operation.  It is what cherry-pick ought to be able to do,
even though I do not think it accepts a pathspec to limit currently.

Assuming a history of this shape:

      x---x---X (that other branch)
     /
    O---o---o---o---H	(current branch)

such a "cherry-pick" would essentially be applying all the changes
lead to X since the histories forked at O on top of H:

    $ git checkout H
    $ O=3D$(git merge-base X H)
    $ git diff $O X | git apply
    $ git commit -m "picked changes from branch X"

And if you want to limit the paths involved in the operation, the
"git diff" step can be given a <pathspec> to limit the changes that
are ported.

    $ git checkout H
    $ O=3D$(git merge-base X H)
    $ git diff $O X -- thisdir/ that/file | git apply
    $ git commit -m "picked changes from branch X"

Teaching "git cherry-pick" to accept a pathspec and natively=20
perform something like the above is left as an exercise.

HTH
