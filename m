Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4617CB
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGsmr+JW"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC5D52
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 18:54:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C0291A5CF;
	Fri,  3 Nov 2023 21:54:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MO641VUvWb9S+y4wIBotaMsjWeEKtM+xRxrdPm
	oLKsQ=; b=tGsmr+JWQARUCkfmEMnsclj37n4/vkkzAlev5qK7R/nb4wIPOhKIxv
	x6JjTXRAmz639aF7iOeEkOqRXluPURLNv9X/Ydpk1jlWZKuFpddeat8SqET/igzV
	cysIbpNnYy/u9yFOKJprvSm51JmbuZxxPYCr2kCGX+yftO5pEcf2E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34A5D1A5CE;
	Fri,  3 Nov 2023 21:54:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C44821A5CD;
	Fri,  3 Nov 2023 21:54:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  Liam Beguin
 <liambeguin@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
In-Reply-To: <4e3a5661-cba0-4849-8340-06d8d4094f48@gmail.com> (Andy Koppe's
	message of "Fri, 3 Nov 2023 08:22:05 +0000")
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
	<20231027184357.21049-1-five231003@gmail.com>
	<4e3a5661-cba0-4849-8340-06d8d4094f48@gmail.com>
Date: Sat, 04 Nov 2023 10:54:33 +0900
Message-ID: <xmqqy1fegu5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A8D2130-7AB5-11EE-A8BF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> I'm not sure that this is the right way to handle a missing '@' here
> actually, because %al already returns the whole email field in that
> case, which makes sense as the likes of the 'mail' command would
> interpret it as a local username.

We could expand "%am" to \C-h (\010) so that "%al@%am" would end up
displaying the same as "%al" but that would be way too cute for its
own worth ;-)

It is unfortunate that "%al@%am" cannot be the same as "%ae" for
local-only address, but giving an empty string for "%am" if "%ae" is
local-only would be the best we could do for our users, and certainly
much better than giving the same as "%ae", as you said above.

Thanks.

