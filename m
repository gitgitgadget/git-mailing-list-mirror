Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49557E4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SPDrd1FG"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096EBC6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:21:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F3981FA33;
	Mon, 30 Oct 2023 20:21:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fhPoAx27JvzktkJ8etZksPqRM2w1M32bur1lNB
	onuUA=; b=SPDrd1FGC6gZobV4JFHZDs/0J4C0EsTkNzUG9dWG25/PT00q6720Wm
	c0PiYCHUDxEwxnHHzVcYkTmCzsDg5xQHePiojFMWzX1QJ1i7x/zeoAEMcB0+2s4e
	v9eyFkymmhgXoM4H8Ee5acMfRBeoJZn5h3v7OU1JghYYZexz/DIKM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 971481FA32;
	Mon, 30 Oct 2023 20:21:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34BFD1FA30;
	Mon, 30 Oct 2023 20:21:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] commit: detect commits that exist in
 commit-graph but not in the ODB
In-Reply-To: <ZUAg5dj272mhHPZf@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 17:32:21 -0400")
References: <cover.1698060036.git.ps@pks.im>
	<0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>
	<xmqqy1fr3kh6.fsf@gitster.g> <ZUAg5dj272mhHPZf@nand.local>
Date: Tue, 31 Oct 2023 09:21:04 +0900
Message-ID: <xmqqwmv37ibz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61EB6EC2-7783-11EE-8E80-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 24, 2023 at 12:10:13PM -0700, Junio C Hamano wrote:
>> > We look at a ~30% regression in general, but in general we're still a
>> > whole lot faster than without the commit graph. To counteract this, the
>> > new check can be turned off with the `GIT_COMMIT_GRAPH_PARANOIA` envvar.
>>
>> Very nicely described.  Will queue.  I'll go offline for the rest of
>> the week but if there are no significant issues discovered by the
>> time I come back, let's declare a victory and merge these two
>> patches down to 'next'.
>
> I think we're close here. There are a couple of small comments that I
> made throughout these two patches, but nothing major.

Thanks for a comment.
