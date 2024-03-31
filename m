Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E926AEA
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711926402; cv=none; b=U3dVc3e7POnaNV7ObDyxri7rTdifGWG1pPuP/KQpnTBnkUPoTos7IEK8Y1gJqvYm6U4usqYcFKW8YsawdLRI3PMMC45OwbsMWhouhDqdDnHpv1ERiVr/RVdJRA+kMtXrpvfD2kb7S1oXP3y2RZ0JQy2DLdonBq7stEaK4xG3H5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711926402; c=relaxed/simple;
	bh=9D3BJtvyXHLVp0dYT9GJrw2/uDyva2+aOypsRMZtv18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Avg6oZA3JWu/vho46yNcd/OD0TGPwRYgJv9rrEjQ0zf5XYTOkE9O83fzV9AWBEYoIt9knpv5wg3LApKolGn8Bl0N9owe2iikpDGGNanybjEv1rqJZWcAUd7NY1r/Pf921DU0jEiCRkLaAi1N2SraeLXQRdecCCbcXPvUeuocAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U0Plg2/l; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U0Plg2/l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BB7791CF35;
	Sun, 31 Mar 2024 19:06:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9D3BJtvyXHLVp0dYT9GJrw2/uDyva2+aOypsRM
	Ztv18=; b=U0Plg2/lajtwTET1CTCBc3YmBvq1E8ezc7gtFEXT+J/DZF0Q22xHwC
	fgavfPfa/co5dT9S5gOxfVcSLkdutlIOyX+JF9LKsgxfMYkQY2Ko8i1BhjZ2mnCz
	FWapgO5zRDSjD+KYT79wN5rYYXDaYamG8ZRlpeHeLOWghbPmhBxb4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A6DB31CF34;
	Sun, 31 Mar 2024 19:06:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A36B1CF33;
	Sun, 31 Mar 2024 19:06:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Nude F. Ninja" <nudefninja@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: :/regex syntax picks stash entries over regular commits
In-Reply-To: <CAOSCdbFg8jY1_0JE0+xf8oxrJjx-Kj0Cb0pPg3oUAXMN5q=kzw@mail.gmail.com>
	(Nude F. Ninja's message of "Sun, 31 Mar 2024 23:13:03 +0100")
References: <CAOSCdbFg8jY1_0JE0+xf8oxrJjx-Kj0Cb0pPg3oUAXMN5q=kzw@mail.gmail.com>
Date: Sun, 31 Mar 2024 16:06:35 -0700
Message-ID: <xmqqy19ydmro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 535D3CF2-EFB3-11EE-9BF8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Nude F. Ninja" <nudefninja@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I ran git stash push, which created the stash entry "On main: dark
> mode". Then I committed changes before noticing an oversight with the
> previous commit. I wrote the fix and ran git commit --fixup :/dark

It is natural that there are multiple commits that match the pattern
you give in your repository.

One trick I learned that is effective is to explicitly state where
to start searches, e.g. "--fixup 'HEAD^{/dark mode}'", which would
be very much in line to what --fixup wants to do.  The commit to be
fixed up in a later rebase session by definition must be an ancestor
of the current HEAD.
