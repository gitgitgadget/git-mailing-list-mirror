Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDF8BE0
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833269; cv=none; b=O/BBXhJ5FPS1A9iRdNUCt384cZZfyIyErIAe4WgHftP3kYgJ/+LUImSWSiuysntV/9jY+5VN40SvYjitmrLGadepn8uITVDEl8bhkiJ5B+Fy+choemN1u/0gzCCbQTwr1zWgU3TGOIaKfc+/qpiudzzPFQNHP9BwIZ3I+UjyxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833269; c=relaxed/simple;
	bh=gVRv+tZQgdUtS0/yjQ6mTGxI2VDlUz64MC/6l2zzQs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDHs2gwRWuYNzFf6ybKB28aaMTNbXhvNTgVWqboe0XwGD9wewPbJOooSwu4qGz/4wuq02MXQx2oPhIJzbu4lPHIH5SxOkPFsguC2Dj3L65NO51t7R7NG9t85NqBkBLaZO+fQoUvigqznjLXTOOw+GOGI0lzjYUfMdHqpJj+/Bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W2Jc0QHc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W2Jc0QHc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0412133ADD;
	Fri, 12 Jul 2024 21:14:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gVRv+tZQgdUtS0/yjQ6mTGxI2VDlUz64MC/6l2
	zzQs0=; b=W2Jc0QHcFvrQDlYGH2mvqING91SptfIKjNjPXvgHgA86lCJLPjMv8C
	oWLNDmCg7IbZ9QoYPO0sAE5T++zaQ4kA0ZWhyS4/j/m5F5EQyMAfVa09P/2e28Ey
	HvpElpkf/oPAt2gbk/au0/bjqAGRITjRW+mvAR8KStBvwRhKBl32g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F157533ADC;
	Fri, 12 Jul 2024 21:14:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4FA8733ADB;
	Fri, 12 Jul 2024 21:14:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  "Johannes Schindelin"
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: fix build of `t-oidtree`
In-Reply-To: <D2NXQ2WZFF24.1GVN7WUJ5PCHZ@gmail.com> (Ghanshyam Thakkar's
	message of "Sat, 13 Jul 2024 04:34:46 +0530")
References: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>
	<xmqqa5iml28j.fsf@gitster.g> <D2NXQ2WZFF24.1GVN7WUJ5PCHZ@gmail.com>
Date: Fri, 12 Jul 2024 18:14:16 -0700
Message-ID: <xmqq1q3yjdp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A51484A-40B5-11EF-9821-C38742FD603B-77302942!pb-smtp20.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> Changes look correct to me. I was not aware of the existance of
> CMakeLists in the tree cause there was no mention of CMake support
> in the docs about building git from source, but it was my mistake
> for grepping for 'test-lib' in just the Makefile instead of project
> wide. Apologies for the negligance and thanks for the patch.

No need to apologize.  Nobody caught during the review, so it is not
even your fault ;-) 

And the CMakeLists is not even meant to work with anything but for
Windows, IIRC (even though it might work by accident).
