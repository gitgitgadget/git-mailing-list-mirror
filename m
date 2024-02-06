Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC5389
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178169; cv=none; b=IsiUDhctHtcwmFua/x+Zc1KMR3N3Sx7DvT6r6z0TEibs+WlMVh0hXVRFypNZ2GvhTo71c/pl4bAyS4B3uvYD5zR3d6tJ79A1LNwG7G6LywYRxWm7MJIn0sbPaACdCjIIVQKi6NC/RrBcgp0GXRGjQhCJTYyPM2p5wt0JooHTG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178169; c=relaxed/simple;
	bh=qXDafPYl/ZKQs226D/Lk+iW2k5K0XQ43Cy/9o87afd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1ObZrs9rDIXXNq56jfX9PXlw2vRU4bvD4NHsO3vLTB8jON2w9LIkZ7Yvx0z0wwQ3nppU4uGRy+jTA5wM26RYc4PZx/AywrBmqsOxv/N1A03T0X9o3aI0wLvsl/joPugf1ot1s7DFKKqi9hUbPG35IpdoDsRKPS4dZz7VGvW+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hdUCf4sI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hdUCf4sI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 244A51C842;
	Mon,  5 Feb 2024 19:09:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qXDafPYl/ZKQs226D/Lk+iW2k5K0XQ43Cy/9o8
	7afd4=; b=hdUCf4sIiwZOFkI0A7s4A/OLMusEFQFWVqc0T6W++aFpetxO6D6tP0
	xuv3a7oyOhmxYjj1zymFuX+v+9kvpntjJBO6gjfbRdMJpSQPppuFVW8rku3qjsq9
	SOAPCo62Xjs8yQlqAxY9K0utt/ESMYa4ZQNOsA/Jgcl5zwtaFOkPQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CAAC1C841;
	Mon,  5 Feb 2024 19:09:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF25E1C840;
	Mon,  5 Feb 2024 19:09:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org
Subject: Re: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
In-Reply-To: <CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 5 Feb 2024 15:53:31 -0800")
References: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
	<CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
Date: Mon, 05 Feb 2024 16:09:16 -0800
Message-ID: <xmqqttmmlahf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F82EFCDA-C483-11EE-8B4E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> I'm not super pleased with that second sentence, and maybe we
> shouldn't include it here. Maybe it belongs on the documentation for
> --move and --copy instead? It's sort of mentioned in the text at the
> top describing the -m/-M and -c/-C options, though it's not clear from
> that text what actually happens to the existing copy of <newbranch> if
> one uses --force. If we could include a better description of what
> happens to the existing branch when one uses --force, that'd be nice.

My preference is to limit the "OPTIONS" section to dashed options.
If "--move" takes one or two arguments, update its description to
talk about how these one or two arguments are used, perhaps like

	-m [<oldbranch>] <newbranch>::
	--move [<oldbranch>] <newbranch>::

		Rename an existing branch <oldbranch>, which
                defaults to the current branch, to <newbranch>.  The
                configuration variables about and the reflog of
                <oldbranch> are also renamed appropriately to be
                used with <newbranch>. It is an error if <newbranch>
                exists (you can use `--force` to clobber an existing
                <newbranch>).

or something like that.

Listing non-options in the list may have been a misguided attempt to
"save" description on arguments that are common to multiple options,
but it is not working.  We can see the bad effect of that approach
only by looking at the current description of the above option,
which reads:

	-m::
	--move::
		Move/rename a branch, together with its config and reflog.

It does not mentioning what arguments "--move" takes, and does not
even refer the readers to the entries for <newbranch> and
<oldbranch>, so the only plausible way the users can learn what they
want about this single option is by reading the page from top to
bottom.

And trim the DESCRIPTION part. A lot. Because things are explained
redundantly between there and the OPTIONS part, and their details
are waiting to drift apart unless we are careful.

I think I laid all this out and more in a separate message.

https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/

