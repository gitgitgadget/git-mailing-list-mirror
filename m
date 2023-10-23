Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061B1B26C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RT6ruXOQ"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E8B0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:47:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D71553F10C;
	Mon, 23 Oct 2023 13:46:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EPeWT+IuxG2gI2jX9yEjPPY3YYhR+JOb/zcsLk
	DtE+E=; b=RT6ruXOQqXbKugvfQNQaCAI1FB+dJHILQ0m6uBKYeojVR00ka8nlN0
	CUxXyg0avouF/ga28N5vcgSDHHLMzCLOFHXmV5WDrOlyTG+uBrr/9Iuc1mDuTumr
	wK0+N3XaLzayiKKlgM5EE2pciJJ2P5Z9JGH+dPe8y5VR8QQPPa5Mc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CEB563F10B;
	Mon, 23 Oct 2023 13:46:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 661403F10A;
	Mon, 23 Oct 2023 13:46:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Javier Mora <cousteaulecommandant@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  cousteau via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
In-Reply-To: <CAH1-q0hrfROfQROXGoCfde4MFkEjxjSMneDcqLO1pqYpe+bN9g@mail.gmail.com>
	(Javier Mora's message of "Mon, 23 Oct 2023 17:27:17 +0100")
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
	<CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
	<xmqqa5sap44i.fsf@gitster.g> <ZTYi55w_70ZlP8Ew@tanuki>
	<CAH1-q0hrfROfQROXGoCfde4MFkEjxjSMneDcqLO1pqYpe+bN9g@mail.gmail.com>
Date: Mon, 23 Oct 2023 10:46:54 -0700
Message-ID: <xmqqjzrdnsdt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28A69824-71CC-11EE-B34E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Javier Mora <cousteaulecommandant@gmail.com> writes:

>> The output of `git bisect -h` suffers the same problem. Perhaps this
>> patch can fix that, as well?
>
> Certainly possible.  Probably best if I put that on a second patch
> though (i.e. a separate commit).  Or should I just squash everything
> together?

In this case, a single patch is the way to go; otherwise we will
(tentatively) be in an inconsistent state after applying one until
the other gets applied.

> There are still multiple .po files containing the old string, I guess
> I don't need to touch those?

Correct.

> Speaking of which, looking at the .po files I've found that there's
> also a `git bisect--helper` command; I don't know if that's relevant
> nor how to modify that.

bisect--helper has been retired but most of the messages used by it
should have been in use by bisect proper, so only the "this message
appears here" comments may be wrong.

In any case, touching po/ is not in the scope of this isolated fix.
The i18n group has their own workflows to update the files there,
and those touching the code and docs should not have to touch them
in general.

>> I wonder if we should eventually move these into the
>> proper SYNOPSIS section.
>
> Seems reasonable.  I was actually wondering about that.

But not as a part of this isolated fix.
