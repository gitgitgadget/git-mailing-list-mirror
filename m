Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C453F107F
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937635; cv=none; b=qoohh6L1fRi2zwIwVHNd4rzh59uaERROYMjy78abA+CfF1k5NLknV4NacfFiNVnRkMVvrIupPuUovvc+iBdfe4lLtYEL/ncbIRFaxPgiRdOYWYrFVB9VVZAWP21xVgqdBPZco6wlyac1y2gRDgpTnp9CzIvG/s37a6O3+pVDLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937635; c=relaxed/simple;
	bh=/MMZKuy+1rEOwRMY/Coa8LPxTUv0dWmKsNKLCKDql9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLkKhQEtoM0bPsmEWBw9/DQJnpN78tJPJ8dc1YSy1u1VA/J3960gW6hw3fHXwC6LVddqE0IaQ66xxV4sFMB3howVcMTSgwHizYn4tnqocoQfkOXf0dNctqjo/TFUi9prYx95wT8ZbUEe2+c4qITrVEFN/2fNboUhiTkgM6A0raM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdIccK4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T73vG7vW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdIccK4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T73vG7vW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 245D91D000FD;
	Fri, 28 Aug 2026 13:20:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 13:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787937633;
	 x=1788024033; bh=46mdubRaQ65vy8KZmdSIRgZTs8jNdxi+tcCvNbnDzOE=; b=
	VdIccK4IKf+EyWnBljFmZqBJZXbGjsZHCFqmWOQFcZaatwXIq4NdBqTeNJ8xUKRY
	SEnrtfkE5uRglSnOCD8FORMobbZdH5d3hgggXqI+Ry9Y/ir0GForuOsOxDVrl2es
	Bbu/5UYlnlttmMvqIL2rU47HC/zXM8u5XUZkXGGTP3sythKkdFBWpQn6odxxVMgV
	5+FoQd6B8Sz/Xn3pd1sZtKWlPUoV65VYUo1JfPAFcb/1DID4Es6qYOVQDjo002cQ
	Gf39soOeb6L0Bj/BXHoKoDpyEoNolSB8N/U2zJ24nkdaCBmgQ2S2T6hdX9elM8rA
	iptv0hfHJ/+WXRtR5or/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787937633; x=
	1788024033; bh=46mdubRaQ65vy8KZmdSIRgZTs8jNdxi+tcCvNbnDzOE=; b=T
	73vG7vWdAa6a/yNwvHbJF8FqqBwJ90WRXQOC0yMCMNzSsF2dxnUrxROOM1ZCSKGu
	sgLQjb1Mork8vocVAP+05sxnYv1cLokARwj8DOMnLaaJYrUBwOcwGv2HhWIzXvGJ
	mzzws9HGcYvIqV1grfHOifYGwwvIv79JPFx5T8eLQC0i1QJtdWfMFXQxMe01t0J/
	VNJg/AiGjHJXWoX57PGs5++HQitfv0dvh/uKBUTojwQDVC5Sd9OLHYLGb9cEzdB/
	3fyI3aFsofMn8Yx2yTEpcflh1OLjULZ4IYTcxmu40JWZlygWrQDYMlFwxVpFU+H0
	X9n7Ec4/CQWySBwk21oBA==
X-ME-Sender: <xms:YMORap6thIxbzvN_XbvQ85CAOtvOehjQb7NGnf70fcjQpcPJkaVgNg>
    <xme:YMORaqkhkxEoobyXmNX4SB3tQJc3N-T_HbYNji_PEo-AP5LfbmE62CEF6RFWqEF5x
    lkeMHitQbp6qI2r9FIOOtRQ5DtgCKHB4IUO7QhXoSVrL5wUNnf_BQ4>
X-ME-Received: <xmr:YMORaqSFcooT-F_e9yzPpVGdGPAeEJbQXPu-GIkXvwKjY9Y7VLy9BkXhz9WpbR5x3vplOIpuPBESqhq1SqISRQ1_OFFkRKQSSQ>
X-ME-Proxy-Cause: dmFkZTGLTScxu9oi6kh+gtgiKdUepv1M461FHa4dUf7dpEqahZBlhzCdQ9WYkb1M/YW/GP
    9BzV9li2r3NNsoPczs5cV19pObdHCdvjOZdtTNXv1DFk0pehIGPHZEajc0H3HoUpVfq9YU
    K3e8FwG1EDZ2dAKTXrJrXX80NB46kio66dLsmgWqRuson7cgc+MqsP3Oef+VFj9WyGXFfl
    azW7529L1aN/igIXjgmahJAEGp5HzxKJpHnSVg0UEfR22TlHJY/4Ny5TeVR3N5AyTvBV1V
    HTROkq6vVPLmyw78qbewL5mpkdIh4+JrTCTLauqauZ0oQD7zx+8XrLhJwIFwYQZe/0lEDJ
    gHaFFv8jfA2h8dDGZGCprl7ZrCkLa/Y3ionZMpfd7wg87vDygxpGYEKPJtxwviUPknp9GE
    vayahz/BkgIy2EserRqbnJipRd5yBiZWVA9P7OFYJ7TOQGfrA+qXrWzrfEHdj+LKG+1whG
    o6X+YW9bcq4ubtlH3SOSuuj3eQVkvroZASh2plwY8hLjae+CE0HKL6/IIaHri59j+fklw3
    Nl3fK5VILHVXT464yzlY9at7JrIVb7TLUKOp8YXS4SWHJQ9cglbeY2tU1iQvlEdfJsS1N7
    qreLy4wnuqgV2SBR/4MbBZgwU3yWNR6SXkCpBrT7WHNl2E+pA9lkpBYpEXTg
X-ME-Proxy: <xmx:YMORapGu8SVO-pF5HrHaOT3e95DaGEt_KdTWIdo_RR6xXivzrqknHw>
    <xmx:YMORavFo31xURzuvxHfIHSjY6IZWgYM-q_49wj_p-Mtt_-RlNfsdxQ>
    <xmx:YMORanRTxI5NawBXZT1msC_TeapDZ8ug5zQC-gzyVkdTAHdlGPhRyQ>
    <xmx:YMORagI3isEmmpMJFx94b7TTYFDLqjOy25rbLS-BJa1M8j5GkRAhUA>
    <xmx:YMORaropXwgQh8LJ2FOAF-ermz4SICUuTXB8OQJskuVspBCm1KhOCQ_p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 13:20:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Grayson Gordon <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
	(Grayson Gordon's message of "Fri, 28 Aug 2026 09:51:45 -0400")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260818214858.65122-1-ggordon@gitlab.com>
	<xmqqpkz4czhu.fsf@gitster.g>
	<CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
Date: Fri, 28 Aug 2026 10:20:31 -0700
Message-ID: <xmqqld9q40ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Grayson Gordon <graysongordon1@gmail.com> writes:

> Junio,
>
> Yes, I was hoping for clarity on how thorough we wanted the testing to
> be. Patrick added a lot of great stuff that I’m happy to use if that’s
> your preference, but we also talked about wanting to keep the tests
> succinct. Please let me know what you feel is most appropriate.

If you can keep them succinct but still test the essential bits,
that would be great, but I am not sure if that is a great question
to ask me ;-)  Patrick?  You said "not 100% sure given the complexity",
but which parts make you feel iffy?  They do look involved but seem
to cover the situations we do care about, except we seem not to test
when the server does not explicitly say "this is still good", or am
I not reading the tests correctly?

Thanks.
