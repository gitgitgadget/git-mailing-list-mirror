Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658013C810
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813400; cv=none; b=k1cNWqKBLCSCClEdj3rstfVJ6L1fi7F/FdkTvRzXvysRkpXfCRWfMMntxHjRDMr1PN40dyMiHdOdv5wUhJRwNGuyXvIAY1dZbBHd4KFAq4EPUFXjHgIixDEpMKkGeUKD7tOMw8cEWgLPy9Sm4Vu5G4oQ2iX/M9t3v/tjKYlsM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813400; c=relaxed/simple;
	bh=5IEO0gDkjt1LonUtvmn8FrrFfjEKbCPoZWVlDwnChGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VBjlxHLyrPpUdDXuwj2iu6//EIlaM6hH2bFKHXJBZhgshypZW+CKDkNrpJqjuRxFVZ3wsX2OGBGPojG6IV1SbXO3Pl3g8s+NIVBSpz53pRiIZJshIvkpjyCF5NEnTEyeQYMOus14GiMzK4cylYJJzeVcCtOLns3CUJJeELfCxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zl3T0ZVy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zl3T0ZVy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E74F1F2BB2;
	Thu, 11 Apr 2024 01:29:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5IEO0gDkjt1LonUtvmn8FrrFfjEKbCPoZWVlDw
	nChGc=; b=Zl3T0ZVyv74OfPcJlKZQuKOR8DV0wDjZ4aqafBqAx5UL9dRe8f+V7t
	5VZ2x2s2qAyNZo79XuPT4iWFVyHsY/n899TOkINiInqyCNYEARs2mmZk3X+gofe+
	pneeRmA+6RCKSqQOm4HUjeD56fksfbltBJUlqOMTdhCAd6dxozs/o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6504D1F2BB1;
	Thu, 11 Apr 2024 01:29:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0E831F2BB0;
	Thu, 11 Apr 2024 01:29:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org
Subject: Re: [PATCH] mailsplit add option to include sanitized subject in
 filename
In-Reply-To: <CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
	(Jacob Keller's message of "Wed, 10 Apr 2024 20:22:02 -0700")
References: <20240409000546.3628898-1-jacob.e.keller@intel.com>
	<xmqqpluz2tau.fsf@gitster.g>
	<CA+P7+xooa08Y-D8CXDGK7_aZ5c2b9iXM6+rFS5qNLyZaG0Kh3A@mail.gmail.com>
Date: Wed, 10 Apr 2024 22:29:55 -0700
Message-ID: <xmqq4jc8sbzg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88601172-F7C4-11EE-801D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.keller@gmail.com> writes:

> No, I mean git am invokes git mailsplit to split a mailbox file into a
> temporary directory, and then expects to find exactly "0000", "0001",
> "0002" etc, but not "0001-fix-bug" and "0002-implement-feature"

Ah, of course.  "am" invokes mailsplit with the understanding that
its external interface is that it will get the total number as
decimal number from its standard output, and the files are named as
just numbers in the specified directory, with specified precision.
If you are mucking with mailsplit to update its output, of course
you must update the expected way "am" receives its input.



