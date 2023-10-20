Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536529D09
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qYALefHv"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9D10FE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:45:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 38EAF3365F;
	Fri, 20 Oct 2023 17:45:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mYzWem37S+wHakdlsXhEuUYtsb6BNgetOx5yKI
	BB0J4=; b=qYALefHvNWLS1Nj2fdsA3AwOFmIqQgjRVMQT6UxOnMr1OdWdfCg1m+
	3MvagBF3vP1xTmLlTRYlfeNEtNQjcLC8W4McW+Ji8ApR7a4nIP5TfNrQ2q6ZcoMl
	2b6swpgTanCYFjB+WqQ8XP+t6KFSO2pdP2J+z/xU8XLSlVjeOoj1w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 30EF33365E;
	Fri, 20 Oct 2023 17:45:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8E8B3365D;
	Fri, 20 Oct 2023 17:45:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
In-Reply-To: <20231020101310.GB2673716@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Oct 2023 06:13:10 -0400")
References: <20231020100343.GA2194322@coredump.intra.peff.net>
	<20231020101310.GB2673716@coredump.intra.peff.net>
Date: Fri, 20 Oct 2023 14:45:30 -0700
Message-ID: <xmqqedhpotmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FEA74AF0-6F91-11EE-A9F4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>   - the handling for to/cc/bcc is totally broken.

It is good to see another evidence that "--compose" is probably not
as often as used as we thought.  With enough bugs discovered,
perhaps someday we can declare "it cannot be that the feature is
used in the wild, without anybody getting hit by these bugs---let's
deprecate and eventually remove it" ;-)
