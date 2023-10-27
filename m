Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D801A702
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UW6Bmyrt"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E910E
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:04:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A40C24627;
	Fri, 27 Oct 2023 09:04:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CxIeQnzTn5+5
	5b1yhHdkRB0UDDEyhNCHuG7tg+kfxEA=; b=UW6BmyrtmhZdzozVcLuGixDU36DV
	4oMhxKi4nbmKmZIU9HWJfemvq79T2nrZeiQyauV0CAy/Gp2SE8Gm2WCHvoROuXB9
	Me1PLaG9DyGmBArwKqQFrX/7L6CYLo4IvV+JJ/vaChONjLON8zarAJ7SpxE9P8bg
	jFHfvHJABRS/744=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 018B124626;
	Fri, 27 Oct 2023 09:04:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4476A24621;
	Fri, 27 Oct 2023 09:04:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,  Jeff King
 <peff@peff.net>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move validation code below
 process_address_list
In-Reply-To: <20231025074317.r3sydthautjjsf5y@pengutronix.de> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 25 Oct 2023 09:43:17
 +0200")
References: <xmqqzg0oiy4s.fsf@gitster.g>
	<20231011224753.GE518221@coredump.intra.peff.net>
	<b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
	<20231020064525.GB1642714@coredump.intra.peff.net>
	<20231020071402.GC1642714@coredump.intra.peff.net>
	<20231020100343.GA2194322@coredump.intra.peff.net>
	<xmqqil71otsa.fsf@gitster.g>
	<20231023185152.GC1537181@coredump.intra.peff.net>
	<393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
	<ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
	<20231025074317.r3sydthautjjsf5y@pengutronix.de>
Date: Fri, 27 Oct 2023 22:04:15 +0900
Message-ID: <xmqqpm10p67k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 55DED87E-74C9-11EE-AC2D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

>> This fixes email address validation errors when the optional
>> perl module Email::Valid is installed and multiple addresses are passe=
d
>> in on a single to/cc argument like --to=3Dfoo@example.com,bar@example.=
com.
>>=20
>> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
>
> If you do Fixes: trailers as the kernel does, this could get:
>
> Fixes: a8022c5f7b67 ("send-email: expose header information to git-send=
-email's sendemail-validate hook")

While referring to a concrete commit object name is great, we tend
not to use that particular trailer in this project; rather, we
prefer to see description on how and in what way the culprit change
was undesirable.

> I tested this patch on top of main (2e8e77cbac8a) and it fixes the
> regression I reported in a separate thread (where Jeff pointed out this
> patch as fixing it).

Great.  Thanks.
