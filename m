Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0526E26
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESX1PBi+"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF72110E
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 05:44:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 525A12DCE0;
	Thu, 26 Oct 2023 08:44:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pbYj/MJ9RyJ06i0WNrm0hm/Ek0uyAw0o4SVmN/
	Ud/xU=; b=ESX1PBi+M6PWR0l6TU/nXC59IhMWx3/SI8Ikk+AuQiOQSzfJxo/ptx
	/grDYYJoV4Dko/mfbUi/pnYuCnthcCC3p3+SddkcDLts4n16NbYV2Gs6ih0UDX5b
	1x/AWvu7B8o3cQtBtyziBs9M1F/qAUJzBiSintsQ1syxK+OLeWhDw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A5352DCDF;
	Thu, 26 Oct 2023 08:44:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DBC0B2DCDE;
	Thu, 26 Oct 2023 08:44:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Jeff King <peff@peff.net>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] send-email: move validation code below
 process_address_list
In-Reply-To: <ddd4bfdd-ed14-44f4-89d3-192332bbc1c4@amd.com> (Michael
	Strawbridge's message of "Wed, 25 Oct 2023 14:51:29 -0400")
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
	<xmqq1qe0lui2.fsf@gitster.g>
	<20231011221844.GB518221@coredump.intra.peff.net>
	<xmqqzg0oiy4s.fsf@gitster.g>
	<20231011224753.GE518221@coredump.intra.peff.net>
	<b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
	<20231020064525.GB1642714@coredump.intra.peff.net>
	<20231020071402.GC1642714@coredump.intra.peff.net>
	<20231020100343.GA2194322@coredump.intra.peff.net>
	<xmqqil71otsa.fsf@gitster.g>
	<20231023185152.GC1537181@coredump.intra.peff.net>
	<393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
	<ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
	<xmqqmsw73cua.fsf@gitster.g> <xmqqil6v3cgq.fsf@gitster.g>
	<ddd4bfdd-ed14-44f4-89d3-192332bbc1c4@amd.com>
Date: Thu, 26 Oct 2023 21:44:33 +0900
Message-ID: <xmqqlebpr1se.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6AB3E59A-73FD-11EE-A46C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Michael Strawbridge <michael.strawbridge@amd.com> writes:

> From 67223238d9b1977d20b1286055d7f197e4d746e9 Mon Sep 17 00:00:00 2001
> From: Michael Strawbridge <michael.strawbridge@amd.com>
> Date: Wed, 11 Oct 2023 16:13:13 -0400
> Subject: [PATCH v2] send-email: move validation code below
>  process_address_list

Why do these in-body headers to lie about the author date?

By the way, the in-body header does seem to support the header line
folding (see the "subject" one here).
