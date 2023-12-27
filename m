Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEB48CD9
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IqoAb6M/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E827437FDD;
	Wed, 27 Dec 2023 17:15:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X2fTjx2wbhu68J3pgr9eUKRV9XVC8i9Uy73jDv
	ST7RI=; b=IqoAb6M/TNAY/jE1m+X3sRsfZbmJArEFofeXjNek8rMz4s76NSHLfA
	unzG9I4olRzv/Bqcl13QFGMBISXutFDybs+Zf6hTjOEWP4KeQ2bjchFA1OP0wGGN
	bb2RoC3uSdehSaXRdTicBAKfsReFcxicF/8NvvKdlmlMdhSjk0qeQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E09ED37FDC;
	Wed, 27 Dec 2023 17:15:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7103337FD9;
	Wed, 27 Dec 2023 17:15:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sebastian Thiel <sebastian.thiel@icloud.com>,  Josh
 Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
In-Reply-To: <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
	(Elijah Newren's message of "Tue, 26 Dec 2023 22:54:11 -0800")
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
	<xmqq8r5gfc3j.fsf@gitster.g>
	<CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
Date: Wed, 27 Dec 2023 14:15:44 -0800
Message-ID: <xmqqsf3nl2b3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7BC1F906-A505-11EE-A327-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

> There are
> precisely two choices in our design for how older Git versions can
> treat precious files:
>   * ignored-and-expendable
>   * untracked-and-precious
> If we pick syntax that causes older Git versions to treat precious
> files as ignored-and-expendable, we risk deleting important files.

Yes but not really.  I'd expect the adoption of precious feature and
the adoption of versions of Git that supports that feature will go
more or less hand in hand.  Projects that, for any reason, need to
keep their participants at pre-precious versions of Git would
naturally refrain from marking the "precious" paths in their "ignore"
mechanism before their participants are ready, so even if we chose
syntax that will make the precious ones mistaken as merely ignored,
the damage would be fairly small.
