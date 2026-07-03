Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2343A1B5
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047156; cv=none; b=uWcswDSjjDCvRniNDEvSffzhZ0p7SaSTvFBQVM/BdfddkkBZonDqJJNx4hl/ikPFdaXKQqv/84NB7GGn4ULtOXjz/ZJ25Qo9zHc4Akf1xqCVaJROkDWMLTlgxPcaGkEd/iRCuGepM0Cl7O0sj3fXlTwxVyQnluWTSd+urw1a0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047156; c=relaxed/simple;
	bh=tmeIn7m+RhifunZPt37owoVqmWfG4v17LiUVo2/PCKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UcTo+d/Lp1BnyyagpAxM6I+bCeowJj6+r7DrJss1qYQfIKhBZyUeyAHPKMmyPcMUtGS2vr67GvfJlSMqoICDjyNkUNRzkutsAXILD7COVrrcJN+0ekK3gIV1M/DN6AM3OwpKpHLJayk7i3sMps3cv36p3ik3+XfQ5vAuCiQb68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wpIpfrQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jnIzhAUu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wpIpfrQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnIzhAUu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BD59EC0095;
	Thu,  2 Jul 2026 22:52:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 22:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783047153;
	 x=1783133553; bh=coBrbtyDHbfrj9KFTfKZ2mn8XwRhg+vScWFeY6MEGdU=; b=
	wpIpfrQ+awr6CqhS5Dip5YY/Kx0ue/F+gkiORMX4ZRQszVS9HNX04dAbHby+2equ
	FzVKzEE1Xy3uJ4k+kwiib93m15xQ6FRe60J+pIx/+W/zjsMWZWv3C/wgJ4lt9Tdi
	c/ml43Y+VdVDS+gkR4xXHLVndce2Eevsg1ol985rCV1SWZVT8+VPCsj0la7f9zmX
	WyDIwbpwLHbY5b5py+HM6T3EFrgsnSlGWWIZF0j4NNUOEDsMKAlIa8yyQ8F+mgYY
	Du+vTOd+HOCZInG/Eo/rkPeXLXMPJDKmPql3YOnCCqeZFcnVi80/TXiy1vWwjTN1
	kQY0MWGzoQ+UCsTdLVbfww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783047153; x=
	1783133553; bh=coBrbtyDHbfrj9KFTfKZ2mn8XwRhg+vScWFeY6MEGdU=; b=j
	nIzhAUuWGHgdbWwjZEW67GSpcchSMipNqihBMnN1rZ196Wnbl/rs4sYa36a0mV7H
	MnjVcn0HYD4HHLTMrgqtkA9lJQl7PNAvNnpNdpAKqJh5HmdZjzyE9uocRF0iGDC0
	wLzMWZKLaDAxzMgiBNCgKmpr/4UExEWa1BF2kSJnTDogHGRwAt68KSPhleF65P0y
	uT7vbys0mdbhU7K+LDyXKINL4Ua99dNk+BTTg2vckfJ9kPAqff4siDhvvA/f2aRh
	+S/NfQMQp5Xigw6sGieivTbLopAiDXMbxrUWLAcy1RoqUH26ilYrIY7U/8j2VPaK
	WCVcf+jtg1KcATqyhci1g==
X-ME-Sender: <xms:8CNHaqWRtQw2uv2qolqBM-2pMty0ncmROrEnm5S0IbXqgs3eTMgbzw>
    <xme:8CNHaqSCttu1GIix9nI3iGeRiK2y4Lk_UNYsZIfwgP_UiI87XX_6ThSnmYqYm0BCL
    79R1fMpCeHfYUfWNz6Xd_XCvbJV36-Fe1nxIsTJD3MvEi0yi3qZng>
X-ME-Received: <xmr:8CNHaoNSCHY4xop86lUqZg_OMiQmpv9vUGNXllQtSTjHYfmc1fDi1gYHv6uPG0Q3H7IHdlyWalNHOG1hVhT7UjE9CPrXprHuBG8FFv0>
X-ME-Proxy-Cause: dmFkZTF9dmKQtK1IE3HzoNIjCuDvlngKXVr1f4RQ5hrkomjjQE+qbFC71lIiMalJPd478Q
    rzsFzyHUCi4jH7iggBwZDpTzLEK+FCRqad+GCOdQ9nJ+QWzLr/K9eBdTH5mSUBa195BDnY
    922wEkRkNXoYbh9ET8uDsYId/4N/zZQtRaGVCrJP/NeTV6+jqMGffCJKVISeIw8PsNTDwx
    +WAshxgJ5jNiI0yusy6fm8ikLbkAZ0ro2lX13h1RK9oIlwtKqYjBxbflwapgrobzxsXzCW
    mRummsywrWInt7UQ4k7jO54SMcdobyyOM+ehlYTkx04SDgbqDJKaL2Wd9AeDBdFMmPKUiC
    KOnrL1szT8ArXoZ4uc1yJ8Nztg/LHn71JIEkLpSWKPk/kM0rC5Ooz2sHRZ7Kl0snp3kjPU
    F6z7dLOpfBuoEyUSAAxGlBzPjnobrN4Hk16oFBmFMcuFrRbvDzBJJxlhmdUCX/IhogOIsL
    MlvL/gUNpTB1yIwgtj9eJiFkbY0Dn7dGfzMwEcN2ZSUeXDEJ+z/hdl3P4TIRuYuO2yUeDM
    zNuTahNbK6OX8S9JmCrX8NuEkpySZx7eacPVaI6HRi25oxMKtXzx0xF9zO5ZIBAlw/5sLC
    T25Ihh0I3fVV2H7+HOuHBFhLtIUlfDtGjZ3x6QRzdqh/nHvguTfYjeVKIg+w
X-ME-Proxy: <xmx:8CNHaoRDXkpLA0qMZL8kQlzGxbkeK4arfteR-miHnmGNlbMGqEuFkA>
    <xmx:8CNHamgm8XYWmkKKhQNV3HSwfiqdA8nUdKsfGO4BgdEoxdIGwZMDOg>
    <xmx:8CNHah_pPnRrC24mhRhbbQB7LSnwoU32EawcDRLtTs9IoqHu5BJ4_Q>
    <xmx:8CNHatGS19zsDYgRlkEWqJuw8MhQijBETmuqvwf0yykJzdmxB9a0Zg>
    <xmx:8SNHak47dcb7deT__AAt_oxqa3MHhAy7Ddt8E7UONUwhU4fyBrxnUst3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 22:52:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  oxsignal
 <awo@kakao.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 05/12] t/unit-tests: introduce test helper to write
 reftable blocks
In-Reply-To: <CAP8UFD3d4e_OOQrNUXU5iVavwhuCZfiNUuE-hH=hwV84xN+pEg@mail.gmail.com>
	(Christian Couder's message of "Thu, 2 Jul 2026 11:31:25 +0200")
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
	<20260629-pks-reftable-hardening-v2-5-b0228e7d908d@pks.im>
	<CAP8UFD3d4e_OOQrNUXU5iVavwhuCZfiNUuE-hH=hwV84xN+pEg@mail.gmail.com>
Date: Thu, 02 Jul 2026 19:52:30 -0700
Message-ID: <xmqq8q7slr81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jun 29, 2026 at 11:02 AM Patrick Steinhardt <ps@pks.im> wrote:
>> ...
>> +static int cl_reftable_write_block(struct reftable_buf *buf,
>> +                                  uint8_t block_type,
>> +                                  struct reftable_record *recs,
>> +                                  size_t nrecs)
>
> Yeah, I suggested:
>
> int cl_reftable_write_block(struct reftable_buf *buf, uint8_t block_type,
>                            size_t block_size, uint32_t header_off,
>                            struct reftable_record *recs, size_t nrecs)
>
> which accepts `size_t block_size` and `uint32_t header_off` as
> arguments, so that more existing tests could be refactored using
> cl_reftable_write_block().
>
> Your choice to not have these extra arguments is reasonable though, as
> they are not needed for the code that your series adds, and they make
> the implementation of cl_reftable_write_block() a bit more complex.
>
> Also they can still be added in the future if we really want to clean
> up more existing tests.
>
> This version of your series looks good to me now.

Thanks, both.
