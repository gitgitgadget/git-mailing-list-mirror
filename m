Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="brkdtvoM"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F275FD
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:15:12 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 377691C8A30;
	Sun,  3 Dec 2023 08:15:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=28BzWP3NY/yCRPCgdmkvM83cksOkNQntY6mtZm
	dmfLw=; b=brkdtvoMO8MiFF+hhgpsGpXiYTCs/jy7CGmEfnhRi+RLyNS0rE1Jfw
	bXI0IwpHNn7FEmKjVc59TmABKLlEOOXrzgH1fhEZ6cj97GKH8h4AKyyBekYEOyuz
	8FlrGG/aqXVgy4cO1hQEzz2rT06jYOKeIRmJAUVY+NY21OeAdI6to=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 304CD1C8A2F;
	Sun,  3 Dec 2023 08:15:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D2831C8A2E;
	Sun,  3 Dec 2023 08:15:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julian Prein <druckdev@protonmail.com>
Subject: Re: [PATCH v2] hooks--pre-commit: detect non-ASCII when renaming
In-Reply-To: <pull.1291.v2.git.git.1701360836307.gitgitgadget@gmail.com>
	(Julian Prein via GitGitGadget's message of "Thu, 30 Nov 2023 16:13:56
	+0000")
References: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com>
	<pull.1291.v2.git.git.1701360836307.gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 22:15:09 +0900
Message-ID: <xmqqplzn4eci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC9686AE-91DD-11EE-ACBE-25B3960A682E-77302942!pb-smtp2.pobox.com

"Julian Prein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julian Prein <druckdev@protonmail.com>
>
> When diff.renames is turned on, the diff-filter will not return renamed
> files (or copied ones with diff.renames=copy) and potential non-ASCII
> characters would not be caught by this hook.
>
> Use the plumbing command diff-index instead of the porcelain one to not
> be affected by diff.rename.

Makes sense.

An obvious alternative would be to pass "--no-renames" and keep
using the Porcelain "git diff", but this is how the plumbing
"diff-index" and friends are meant to be used.  Looking good.

Will queue.  Thanks.
