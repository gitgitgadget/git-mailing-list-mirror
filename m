Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E8803
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392974; cv=none; b=qrL5WQNDZliGljnoYAdgcVDb4uawZ1+35EnHQ0gcKRPTgquT13z07XpC69dO/23jC2eWkMayG76TMnBuGGvs/lu0tVpiDFytYrKvjg5uEQwO01b0Tvvi4aR95hyJABEmDuEQVvLjQgwL8Lri1M7U1zIqcutA+unb758A+tYtCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392974; c=relaxed/simple;
	bh=958dUhq3nf/HR39yNj0I5HAXHpGonK5uHMYGa3tBa4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h6/J9cT7O/ht9xm9rEJKRbJuf7mzvTn//mf2dOabvZPEmceTUDzKXqeCC37aNpIo2XrLkb1NKL3VHXdu5Yyagl+++ohSaDIPdef87C41FNbixs8+iJxgMoiD67Wm03jz/6V5yEsBY0fEtGrxG6xlTJELqazSedZKzOIUDKNZr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EK3sssNd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EK3sssNd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8248F1E814E;
	Mon, 25 Mar 2024 14:56:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=958dUhq3nf/HR39yNj0I5HAXHpGonK5uHMYGa3
	tBa4o=; b=EK3sssNdMnr4rUEdo63BiraIdxiumvEzzD4CjO02Lzs0Hq/begn1iv
	laiesRNsYBtCGyxo7kFvlVnSOfiW3JUPQf24HpYnJ7mjYthNYmbYkVBL0qMgeCyQ
	vvQLA8FScLs8YAx7OdxtjTe3lIn5fwCChw5oJJ9GzuUDSycOVO5k4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75CDA1E814D;
	Mon, 25 Mar 2024 14:56:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08EE31E814C;
	Mon, 25 Mar 2024 14:56:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: =?utf-8?Q?Rapha=C3=ABl?= Gallais-Pou <rgallaispou@gmail.com>,
  git@vger.kernel.org,
  David Aguilar <davvid@gmail.com>,  Denton Liu <liu.denton@gmail.com>,
  Paul Mackerras <paulus@ozlabs.org>,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] gitk: add "Hightlight commit name" menu entry
In-Reply-To: <742ac151-74cd-46f8-8dfb-3dcdaa513314@xiplink.com> (Marc
	Branchaud's message of "Mon, 25 Mar 2024 08:52:00 -0400")
References: <20240130085308.5440-1-rgallaispou@gmail.com>
	<27b9c158-5cb1-46bf-851a-88a02448fa2d@xiplink.com>
	<146fbb87-9047-4d96-8d06-76f5710ca9e1@gmail.com>
	<742ac151-74cd-46f8-8dfb-3dcdaa513314@xiplink.com>
Date: Mon, 25 Mar 2024 11:56:08 -0700
Message-ID: <xmqq34sekunr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 580A0494-EAD9-11EE-BA63-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Marc Branchaud <marcnarc@xiplink.com> writes:

> (BTW, on this list we pronounce "the name of the commit" as "the
> commit subject (line)".)

Yup. "subject" probably comes from the fact that the title (the
first paragraph, folded into a single line) of the commit is used on
the "Subject:" header when formatted for e-mail submission, and also
's' in "git log --pretty='%s'" is described as "subject" in the
documentation.  Other words I've seen used are "commit title" and
"oneline description", but "subject" would be the most common, I
suspect.

"commit name" on the other hand brings a different concept, i.e.,
"the commit object name", more strongly to readers' minds, and can
be mistaken as what you'd get in "git log --pretty='%H'".
