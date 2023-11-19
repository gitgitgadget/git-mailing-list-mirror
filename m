Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A7yHivc6"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B8136
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 15:24:40 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01C5F1D284D;
	Sun, 19 Nov 2023 18:24:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2UdzPszg9+yvQAoADu9ngwGFz7ovivE4nN8twI
	iPQEY=; b=A7yHivc6e6dzJeHKVBP1hCK3RDxRsePzo81UyzYROFf3Dys4tvBm6Y
	PyFit05AUzoIibtnRaUaR5MgC2uHscD55nE4MXBNxO3UdIm/h4r6mt6KbRlBK+l5
	3HyuUVkNDRH5GjRY9VB41LWo8tTQXiEbYZpRl6nD7FEQTlBfIPYX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC4261D284C;
	Sun, 19 Nov 2023 18:24:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 549701D284B;
	Sun, 19 Nov 2023 18:24:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Glen Choo <glencbz@gmail.com>, Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
In-Reply-To: <20231117203253.21143-1-adamm@zombino.com> (Adam Majer's message
	of "Fri, 17 Nov 2023 21:32:53 +0100")
References: <20231117202513.20604-1-adamm@zombino.com>
	<20231117203253.21143-1-adamm@zombino.com>
Date: Mon, 20 Nov 2023 08:24:38 +0900
Message-ID: <xmqqbkbppbrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF738FB0-8732-11EE-89D3-25B3960A682E-77302942!pb-smtp2.pobox.com

Adam Majer <adamm@zombino.com> writes:

> In a garbage collected bare git repository, the refs/ subdirectory is
> empty.  In use-cases when such a repository is directly added into
> another repository, it no longer is detected as valid.

Josh & Glen [*], isn't this a layout that we  explicitly discourage and
eventually plan to forbid anyway?

*1* who worked on e35f202b (setup: trace bare repository setups, 2023-05-01)
