Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m/WX2/k5"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724B115
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 15:30:28 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6284A1D2889;
	Sun, 19 Nov 2023 18:30:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WJQqAv5Vb0Cz4F2KSR9ADZ6u08zzjp1SOTm4e7
	/nbL4=; b=m/WX2/k5tsSXLPCP+J0KHjMU1eQASl+MIbEKjvKz6mFljgT+JTNRyY
	4l08iMrvAQbhUArmEz/8g5gb79UiHwaxRc5GmDBfGeqViQsuUA3PdKfFYofylLyQ
	7GyMbU95vv3evyy9QeHSqcc4hRic/Kfhk2X+zdXU8pTUSRHH+zLg0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AEF1D2888;
	Sun, 19 Nov 2023 18:30:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7DD41D2887;
	Sun, 19 Nov 2023 18:30:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Antonin Delpeuch <antonin@delpeuch.eu>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-file: add --diff-algorithm option
In-Reply-To: <de04aec0-a195-45da-8951-bb30f2a629a3@gmail.com> (Phillip Wood's
	message of "Sun, 19 Nov 2023 16:43:19 +0000")
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
	<653b08fd-2df3-4a7a-8082-fdb809e87784@delpeuch.eu>
	<de04aec0-a195-45da-8951-bb30f2a629a3@gmail.com>
Date: Mon, 20 Nov 2023 08:30:25 +0900
Message-ID: <xmqq7cmdpbhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E85D59C-8733-11EE-B75C-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I can see there's an argument for changing the default algorithm of
> "git merge-file" to match what "ort" uses. I know Elijah found the
> histogram algorithm gave better results in his testing when he was
> developing "ort". While it would be a breaking change if on the
> average the new default gives better conflicts it might be worth
> it. This patch would mean that someone wanting to use the "myers"
> algorithm could still do so.

Sounds like a sensible thing to do.  First allow to configure the
custom algorithm from the command line option (and optionally via a
configuration variable) and ship it in a release, start giving a
warning if the using script did not specify the configuration or the
command line option and used the current default and ship it in the
next release, wait for a few releases and then finally flip the
default, or something like that.

Thanks.
