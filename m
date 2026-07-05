Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF12433E89
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783224486; cv=none; b=MKq9KQFZCtr3b++tHoW51Y8+ffVbobmOw8i+LkqtY4Lc/pOxwDQrG559wc/BysjuMaYvTxpZ8q6fXYxjM/CFiRT2OyKMaU7We5X2nCo1GBBv0/JgEmyYV+/2rtzIWVZa+6YkqDbP7HGNBzNMpaC8pX6uqD/4p9L3vzEom8LKddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783224486; c=relaxed/simple;
	bh=f5lOLCLxr7rml+zU4PNLTT5rS34gs+BDsQwXnh7PT2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdRohLoTA9YsF9Ek1hb91wEINTx+StxshxIneNg6z+DXCGPj40J2e8QEYjLPXSe76HQ4oZ4J12Wx92k2IkMBWddRBXSUFA6BUPNRwxQ3qkXT5oSOyMS64h8jHL7YvSrbpvxYF+57ZYGBFU6V3kem0RMW2NcgMkJ61sjeTm2KTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YZLyxT4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PGHJEN7G; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YZLyxT4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGHJEN7G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 044141D000B6;
	Sun,  5 Jul 2026 00:08:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 05 Jul 2026 00:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783224483; x=1783310883; bh=6LY0bFs8U7
	bCiBnL1pvyKuZA/NCZDGvoKJeSIXnU25M=; b=YZLyxT4I5m6oI4e8whW6guaHXx
	UbvlfJIr0HEFYpe01rDhFc4vBOciQtW+zKHNkXg6uRbBu0X3UnZosU/c9/U5deIV
	TUzlLJZVGOjNIkaoH58fhjyRelO1paSdorIYwIvWVkWHCgTVLE8b5VCuHzEZIgML
	I5qi7RfNMeJEuohjxBo8dEQj2BlRSLwheIb0mskWQSBcYUU6v3umKyv4bXkx/CuY
	sbvUX1vwrk8NslyuEPAqk7UTgt7pI3RM21g1xtXRGUNm7GwxaA3L44v8mG3Nih3Q
	HBUE7/iYsvdmw6XLEhyRgsSgum6/nE1RB2AgMn7CbMnDFGd3vmeYN358U0WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783224483; x=1783310883; bh=6LY0bFs8U7bCiBnL1pvyKuZA/NCZDGvoKJe
	SIXnU25M=; b=PGHJEN7GgvBK+mNod0E6U1F/U+6UnPjo/7uU0Y5yy+zlKeu1vKC
	tj+qM4n/ADDG6Vx1ZAxpxZkyGyDaqTFlC0DbX7d3ZF9AE8qum6l8zzB9J4D16con
	1at5Dv2f9cO8vmWv5GP39dULIo0Al2a9DSUXoM37aj6nJLhw8YdH8T0sua8+Obus
	Bo1zlTTcygZziFd7fWCdhsbQJqMtAjA/iuCgMjU2sPZ1Q70ZLVmerXf/3sOFeW7x
	a+mWtUQopjeA5ArYwnvsxtKF+SZjipsStqgy4YxlilbZY65pawI9hWXfOpHtFU70
	9yFYFJN/rz/fhDUq0Sc7p0xREv2pqCd6DrQ==
X-ME-Sender: <xms:o9hJaiejVreHXFb-bByW5ke8hTf_yKnTs5N7dMzLQ853g1NXShdOHA>
    <xme:o9hJav7C3Rc6RXxFfqRT6AvR_yq3oDU47v6CzHy0xu2rIfOyjFvOAUQbDPofqvsbM
    65LPVgDW-x5DErd68J1q1fhhP2K2wsLGUrSkms0JQj2pT-XcIpPhw>
X-ME-Received: <xmr:o9hJatWUh7UKOc0wdNoFV33ICqYar9VnmF0wUrM_PNnZGqNiDzSHHBmHiQo4ltXxXw0Dft8lhJVjCZwQGxPgCbBvUVic-a81HCpwBSc>
X-ME-Proxy-Cause: dmFkZTF7PU3bt2dKQUWsk5O/9KFr20oJK3FGUt68prOoVVp2FICRHg41u+OX3U7+Uwuzz7
    +O1X/zPcj6xuSGjaz7xlq1eb5Jvw4svOIWQXC9OJa01A5b2OZ4+cARUxfggzid+vASoEmV
    6fnY1bUn0yNHyZ5CqksWMZBjL5tF16nU8fDgw9hGxuaXHVqRBhk9g75A31w1fpdjIkmubn
    LqmNY9IjTDQd3QRztKMDRh7/pEk6aegIIwLxvGktGA+WUK9HI0+Womm84/btm5Zx8pFxPf
    Jl2u95tz9DgpuRcww+DqRGMw9AR2WUgG0fYTb+wg8nDVmjpNzjPz9TpybxLdbv8q63DUAb
    +n0D3aiNK0kTt7t/JSbih0N88uy9/NHdWGv/uXnwqgRXAH5a9RBLFvyo7sDRaF259vO1P2
    99AbDsIKtZ6GqzhTmmXFq+aYEzVHbehcy1ZzL4zFOjkngk0iyi8OzBnVhkeJVtuRXN5W2i
    xTyr1IMn4l7ZiYOK02XdD0Yhtp3ja3IZTC+oE+Uc3wy6rJt3UUhMeCFfxki+HdBgZHbJ6J
    YsPh33Ag15vhgVcUtosTPDgaKfTnMGHd6+rFnC+9orMlXyguaLd5smLmNhYsosii22NVWk
    XBJB22Zzf2Y06Zbm3P3SVsQKRfnkm3crf+Ow7BK1E9xmxaB0QtO/FXaKsZrw
X-ME-Proxy: <xmx:o9hJam4su-jT-4dfTtWqYsFhGwK_vzzFoExRx7YnbXrSOQz5VdK3FA>
    <xmx:o9hJagqOegHkHDF8yR116UeN42LQ8a4_z9ECLtL_ULuXiT8bqeGrkg>
    <xmx:o9hJahmVM-nKptwm0OLRMNljoc4TM4L82vYGbKObcnG0Kj0J2okG8Q>
    <xmx:o9hJakNo_9GS7y9k64cdbJpsAceCOh7Z_nyposW0bcpXnASWX8Cbqw>
    <xmx:o9hJakaQrL269qDdlBaTX9ow30GX7UDbvjA1z_2WAbmoBMXqKHnP2b4W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 00:08:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Shardul Natu <snatu@google.com>,
  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v4 0/2] Makefile: link osxkeychain helper against Rust
In-Reply-To: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com> (Shardul
	Natu via GitGitGadget's message of "Sat, 04 Jul 2026 18:05:53 +0000")
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
	<pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 21:08:02 -0700
Message-ID: <xmqqpl12dqot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2:
>
>  * Split the original combined commit into a two-patch series to separate
>    prerequisite bug fixes from Universal Binary features.

This was addressing Patrick's comment, which was already done in v3;
hopefully that is now settled?

>  * Added $(call mkdir_p_parent_template) prior to invoking lipo to guarantee
>    that parent target directories exist.

Obviously correct ;-).

>  * 
>

It is a mystery what the third bullet point was ;-)

The changes relative to v3 (which I looked at) look good now.

Thanks.
