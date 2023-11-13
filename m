Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659D3E461
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlgCv1Q6"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F4B8F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:42:13 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DD4625586;
	Mon, 13 Nov 2023 18:42:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=706gOrfrx9pG/LprbnXcEughKrIULDHbos1GfX
	6wRL8=; b=BlgCv1Q6Ijs3e3p/lYudyJsIw26XsgnufqRljO6toSK8VyhtTG0M5H
	yPajzIrfe8Hn/7gU6hBEhAP/B1kp7mUD6BkJN7ytsTRSlgE6wIdmGfDR8I1wTgde
	tvROnF5quLuueu5L33TJmrTtsxsl/DDji5YhWuXUvArXXIwZt/H5A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 65A8E25585;
	Mon, 13 Nov 2023 18:42:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04F7B2557B;
	Mon, 13 Nov 2023 18:42:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] t: improve compatibility with NixOS
In-Reply-To: <ZVHM-0d7g45P3Uoj@tanuki> (Patrick Steinhardt's message of "Mon,
	13 Nov 2023 08:15:07 +0100")
References: <cover.1699428122.git.ps@pks.im> <cover.1699596457.git.ps@pks.im>
	<xmqqh6lttaj4.fsf@gitster.g> <ZVHM-0d7g45P3Uoj@tanuki>
Date: Tue, 14 Nov 2023 08:42:08 +0900
Message-ID: <xmqqcywd43vz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4338C2EE-827E-11EE-854F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Fair enough. I assumed that it would ease your workload instead of
> creating more work for you. But I'll keep in mind that it doesn't and
> refrain from doing this in the future.

Thanks.  

With or without conflicts, basing your work on 'next' would not be a
good idea to begin with, as we never merge 'next' down to 'master'
(we only merge individual topics).

The following applies not specifically to you but to all
contributors.

What is helpful is in a tricky case is to start your topic branch
development at an appropriate base (often the tip of 'master', but
for a bugfix the tip of 'maint'), merge in other topics in flight
you depend on that are not in the target base (which limits what you
can depend on if you are writing a bugfix on 'maint'), and then
start building on top of the merge result.  Then communicate how you
built this (artificial) base clearly in your cover letter.

Whether you have "other topics in flight" merged to your base or
not, creating a trial merge of your topic to seen to see how others'
work-in-progress may interact with your work would be a valuable way
to keep aware of what is cooking and how you will be affected.

Thanks.


