Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753A61FDA
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069076; cv=none; b=RlBkt9gfO+7ElnbG5jhGTXdGij+utf4+nTunP7Ow5wdVcbblPdn63F0wduHoMaQoZFuTnEupfxVdZ9/9Ol5OOeP6/KZ9Yppb4gNIsPWSQr+rPnai7HHxBRbRl7Q3gAyBNPc+kWLiR7B2TEC9iCFKfGEF/OfP4U1+KIWw0U8c0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069076; c=relaxed/simple;
	bh=Wt+/RH0QRqwTAy1vz1kRG/ShdmmQ/JDMHtliCuA+bdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YdJpkf3QJLk4cFANS5G3cgHUZQ50b14RQwJtec3DZKI0YXV/APKiQhJxtlqjevQeJH3QQtW8O2pC2ZxdTcOi7YKghnO2gCtZjBm37+rpjfV1KEF2ODjCcVoy2B/NivhyLCpM+T9LoBNkco2CIa24Hlc+RhC9joBLOMXMNBPoyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YGVxk7ky; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YGVxk7ky"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F03D023452;
	Mon, 15 Jul 2024 14:44:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wt+/RH0QRqwTAy1vz1kRG/ShdmmQ/JDMHtliCu
	A+bdQ=; b=YGVxk7kyYjA6r+DPNAsvq6or4zS4LpvQYFXPMeWLAdmmvOprQxhJml
	Nlwmq9aH0XbzoTlqNr49M1l/g49x8rXzWkpNS5qJVADmKyVCAZyfVB2tuBKFf4QM
	Vr1whb4lA3pfU5cFrv17w3mAgy9pG+VZ+QFzNQENwH9+vG5Wsv7Fk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E8B8323451;
	Mon, 15 Jul 2024 14:44:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 237A42344E;
	Mon, 15 Jul 2024 14:44:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: clarify post-receive hook behavior
In-Reply-To: <dzdoaldgm5sk25ll57okroqcnhqurtoqmo7d5xsjnrjpgveqzx@63w4uav6jtd6>
	(Justin Tobler's message of "Mon, 15 Jul 2024 13:22:36 -0500")
References: <20240712224748.56843-1-jltobler@gmail.com>
	<20240714194626.29512-2-jltobler@gmail.com>
	<xmqqfrsa7j4p.fsf@gitster.g>
	<dzdoaldgm5sk25ll57okroqcnhqurtoqmo7d5xsjnrjpgveqzx@63w4uav6jtd6>
Date: Mon, 15 Jul 2024 11:44:29 -0700
Message-ID: <xmqqjzhm3376.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 45B5AEB6-42DA-11EF-8055-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> I think it makes the most sense to drop the link:*html used here and
> just rely on the linkgit: reference. I'll adjust this in v3. Thanks for
> the feedback.

That sounds like a sensible and conservative approach.

Thanks.
