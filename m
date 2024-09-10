Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF81A7074
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004458; cv=none; b=GU/j2ygZtU94J/NN5g++l20zvFPId8FENbNQ6DASCmYpKx/xSkd3f3yCKublH8a6jSCUYS1tWkZ7V8Dvn4ztOJPIagwg2CZZxlTDmAj0lN453JlxSOun25KddOs0F/G2iYij3o2amvR5EfQrl4TD5sNWDKRLB0RlcFENKITikzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004458; c=relaxed/simple;
	bh=3VcBrcS741J2PxLvYuWZw0yiwxw2jmCcy3Wu5f1ESQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tI11aRpNo8eEwpErHoWWQDWXIlE80fZltgoBPhYZVJPJsHOj0GWYQdltJ9ahT/QvppwrsZbA2M4BXcZE4A/Nl61qTAE2KduxC2+W2/OfzoA28TjNbawlY9oJSbfyQ1MDBByq8wPAr4JNgwbJcbzMXwacuLczbi9NTUrDr0ZFvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZxUqZ2WQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZxUqZ2WQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D43D36044;
	Tue, 10 Sep 2024 17:40:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3VcBrcS741J2PxLvYuWZw0yiwxw2jmCcy3Wu5f
	1ESQA=; b=ZxUqZ2WQIMGhRvGjD+9GDmGTyRtR910zUDYNoGlGwgkKWdygPgnsCk
	/halkIDbtqllOyHPgDX77mdrc0W94DiCeFZB1xmlyj2MhaO5GuJ/aR8vLUy3KOte
	n6o9eeNwcIgctXPMIk36BZaiuHvg5foJrTS+0JOldnLOFD8bN8drA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 652E036043;
	Tue, 10 Sep 2024 17:40:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7EAE36042;
	Tue, 10 Sep 2024 17:40:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin
 functions
In-Reply-To: <9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Tue, 10 Sep 2024 20:59:18
	+0000")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 14:40:54 -0700
Message-ID: <xmqqed5rdw61.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C364EB0-6FBD-11EF-91F7-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  git.c                              |  12 +-
>  help.c                             |   3 +-
>  stkOs5Qh                           | Bin 0 -> 10485768 bytes

WTH is this file?
