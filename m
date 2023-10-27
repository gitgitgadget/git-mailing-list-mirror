Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38B405E8
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aMuFidNS"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7931A5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 15:31:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EE671A50C;
	Fri, 27 Oct 2023 18:31:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ktYnDd8ivdPkgzW8qdDPtu3TnTZBahLtexGyE4
	Q6V/4=; b=aMuFidNSG9k5m5CXi70GikMtXwEyBPJPLQAblHyhZx/V+UAj7RW8Rf
	H9S6qbN/Jzi4g0ZpOSlije/b2Il8+luqeZ1QVP98QoCAVw+RjYrobBrv1uPRhen2
	jyHejkIoIGkg7XipsD+tHat3ZV+FQv7UHr8g9QBF4wp0W989ky0hw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 376CA1A50B;
	Fri, 27 Oct 2023 18:31:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC91D1A50A;
	Fri, 27 Oct 2023 18:31:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jeff King <peff@peff.net>,  Michael Strawbridge
 <michael.strawbridge@amd.com>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
In-Reply-To: <ZTjedSluwyrVY+L9@ugly> (Oswald Buddenhagen's message of "Wed, 25
	Oct 2023 11:23:01 +0200")
References: <20231020100343.GA2194322@coredump.intra.peff.net>
	<20231020101310.GB2673716@coredump.intra.peff.net>
	<ZTJaVzt75r0iHPzR@ugly>
	<20231023184010.GA1537181@coredump.intra.peff.net>
	<ZTbOnsxBFERPLN3F@ugly>
	<20231025061120.GA2094463@coredump.intra.peff.net>
	<ZTjedSluwyrVY+L9@ugly>
Date: Sat, 28 Oct 2023 07:31:35 +0900
Message-ID: <xmqq34xvpuig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9706B6B0-7518-11EE-8DEB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Wed, Oct 25, 2023 at 02:11:20AM -0400, Jeff King wrote:
>>The "//" operator was added in perl 5.10. I'm not sure what you found
>>that makes you think the ship has sailed. The only hits for "//" I see
>>look like the end of substitution regexes ("s/foo//" and similar).
>>
> grep with spaces around the operator, then you can see the instance in
> git-credential-netrc.perl easily.

Good find, but given the relative prevalence in use between netrc
helper and send-email, my conclusion is rather opposite.  It seems
to indicate that avoiding "//" would still be prudent if the only
tool we can find find broken on 5.008 is the netrc helper.
