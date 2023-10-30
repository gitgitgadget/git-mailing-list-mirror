Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C719BA8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OybCvTfk"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7395F7
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:35:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C82C21CD114;
	Mon, 30 Oct 2023 19:35:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jMQwHbXu7YQ5AgD7Z+pKhjjrz8uc2Gpw7vJx2s
	YzITQ=; b=OybCvTfkSBvlo9pVesXxUQXPVbQjU4+Bi4xTSqYTvwUUpFoUAcrva8
	utsxEXgnb2mCCOe7E9EzxLsXpbaCSchnZgXcNGMPzEaIiBLwyz8Bliv+gtyxzRE6
	tnX/iUHnzlDcYWix3bviBi4ymEdFIhbMO1Za7XeZp/a4t3K4ehPo8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A28E41CD113;
	Mon, 30 Oct 2023 19:35:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5F491CD111;
	Mon, 30 Oct 2023 19:35:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Tony Tung <tonytung@merly.org>
Subject: Re: [PATCH] sequencer: remove use of comment character
In-Reply-To: <CABPp-BE6_nuMeiqOAMGwP8SH=d1+i57-STgTNKU8-Gnkv2jW=Q@mail.gmail.com>
	(Elijah Newren's message of "Mon, 30 Oct 2023 10:26:18 -0700")
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
	<xmqq7cn4g3nx.fsf@gitster.g>
	<CABPp-BE6_nuMeiqOAMGwP8SH=d1+i57-STgTNKU8-Gnkv2jW=Q@mail.gmail.com>
Date: Tue, 31 Oct 2023 08:35:06 +0900
Message-ID: <xmqqa5rzadlh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5C8FAB2-777C-11EE-BCFE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

> I thought the point of the comment_line_char was so that commit
> messages could have lines starting with '#'.  That rationale doesn't
> apply to the TODO list generation or parsing, and I'm not sure if we
> want to add the same complexity there.

Thanks for a healthy dose of sanity.  I noticed existing use of
comment_line_char everywhere in sequencer.c and assumed we would
want to be consistent, but you are right to point out that they are
all about the COMMIT_EDITMSG kind of thing, and not about what
appears in "sequencer/todo".
