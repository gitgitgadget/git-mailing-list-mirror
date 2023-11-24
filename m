Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmbDEtc9"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9FDD6C
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 18:12:03 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2DC61B52F1;
	Thu, 23 Nov 2023 21:12:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=42RT9Zase4NGr2Z8bvbd2YsZ1rjrytdcv6F6vs
	Ad+Y8=; b=lmbDEtc9Vi4FLB4w7b30LblDhYSA86r3sajmsgl0k9I5iJmUvwLskx
	lzzVy3uOSrNcejnbAaKNJE//v717XWGsjg5fQSbodnQPMppq8Tq8d36o8d7Pi8qy
	NkS6OsTar+g3WcPz4EN+EeIW/v9LSHaylU7UHHH2JpB+oS6lwqXCI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A50E1B52F0;
	Thu, 23 Nov 2023 21:12:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B6781B52EF;
	Thu, 23 Nov 2023 21:12:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Craig H Maynard <chmaynard@me.com>,  Git Community <git@vger.kernel.org>
Subject: Re: Orphan branch not well-defined?
In-Reply-To: <xmqqwmu79ac4.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Nov 2023 11:03:23 +0900")
References: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
	<CAPx1Gvf_meaEBq9XfS9aPg0yLja-2sAW5SUg0jx6f1jNyfmWHw@mail.gmail.com>
	<xmqqwmu79ac4.fsf@gitster.g>
Date: Fri, 24 Nov 2023 11:12:00 +0900
Message-ID: <xmqqplzz99xr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DB058038-8A6E-11EE-ADC0-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Chris Torek <chris.torek@gmail.com> writes:
>
>> ** Unborn Branch is the better term **
>
> Yes,  To orphan is a verb that denotes the act of becoming on an
> unborn branch, and a few references to "orphan branch" in our
> documentation are misuses of the word, I would have to say.

To be fair, the use of verb "orphan" by the folks first designed the
"checkout --orphan" does make quite a lot of sense and it is very
much consistent with the fact that the operation leaves the index
and the working tree intact (unlike "switch --orphan" that empties
the contents, which came much later).

The intended use case was that the user had the current set of
contents that is desirable with history that is undesirable behind
it, and wanted to part with the baggage^Whistory while keeping the
end state.  The operation was meant to be the first step to create a
"parent-less" (aka "orphaned" from the parents in the original
history) commit that records the desired state.  It is the reason
why "checkout --orphan" keeps the contents intact and moves the HEAD
to be on an unborn branch.
