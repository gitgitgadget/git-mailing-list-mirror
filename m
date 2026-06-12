Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B72F28FC
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277713; cv=none; b=OxAEQtK6QIraKoK9Z6wk2aVmeaW9es6MmVq8yxp/LgFfzyFIehyguAhshvww6wD3qcKO8giDn70I2i24YOWsVDeHA8s+R7Uln1k5jr8niby2IUthQOohb5rPmrT4O0uNhiM18wENPhm35W5/NMmcQAPVjD5Ib+h0ezLHIa0PA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277713; c=relaxed/simple;
	bh=OCGjR84Duf1l2/zoZplmNPyT9QRTVmzab38x1DYADu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpyX8VzEbbOjIzm4GcRcpihioQoWBLuSEXI2Jrf6X6HyV7zAmHax8D8FvsbYpFwxRrUTToioj0J5ELjWbuolr+JikyJeRDDx6m34gWIaXj/M402u3A7k3LZZgqmfekC9KhUXorFw0sXl1BHFf//1rlOFGIGrru/uU2NfvZDAtZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hX+0Igue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X5e53KLn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hX+0Igue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5e53KLn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C4FB7A009F;
	Fri, 12 Jun 2026 11:21:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 11:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781277711;
	 x=1781364111; bh=8RE6VFOFBD6DBt+q/gMkTrhIChxBk4fmgegb5InTcmg=; b=
	hX+0IgueQ11KQ5W4h1OVZqkqA02R02baImb5+fTQ2WrE8rpg9NzRCHy4kTw10rZu
	RInGTRhLn8E3sjYf+hScuA0IFih58o2W0q9LP7eW0R01b0XbpToA2p1VLN+xtWOT
	STQH4F2DbaRvQQnr5kzMC9UyGoYp9NbaOeme9WpEdmyOwR+eLEfTNLbKlVGZn6Gz
	ELL5/LKUEzO2GUkw1OZF0On+Hg/7Jbyfv28dgdvitoDJZAbGcDvYzYlYGGfVJQs4
	WJxSYPvET0nAA/zJi8TR5Qabm0S0mi11TUTiYSV54H6s8f08JV1DxYcV8DtcTbnf
	ECzBScGNV9dgAEa7O9RViQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781277711; x=
	1781364111; bh=8RE6VFOFBD6DBt+q/gMkTrhIChxBk4fmgegb5InTcmg=; b=X
	5e53KLntPnLvVHin3tlx5c24N258lMuX8ApCqT/Yl4AAubXeTiSaGevgGlWq3Jmo
	pLorg1ZohWg1k++ch8KRYR/ITFj5/8y+Hd3+BQxFLiKEiUe899ULo6oDkiWCMHMe
	KY1TezDkLq1UrtVMOS8rPZ2Nqeee3J1742O56x74TfEUxPxvCQl7jcWHyDaH3Hqy
	PzmNIP23fATCUT5QYV0gBAKqJ5qiiNtoOuldYXE697aggM3PlNrdt2IJrV9G4fSg
	IqRp1Dm4UNGD8BvYo2vs2EQLStYmY9W4Nox9bx1vKFD+uhrVRIk2spkHzRpLhDNa
	2Hve+2eNZZiGSi8dH1BnQ==
X-ME-Sender: <xms:DiQsas2OKrt3M2bkA5AcSuY_LsAEeZQhkPxv1wC0FH1lTZc-UoYNIA>
    <xme:DiQsapX_NFdZEA1p6JjFO7jXDXAqylIJFGopVQ-1puzYRgXZyIAldt0lC3cs7bfCt
    O06BFLDvVSg_dz9bHkbzJDANUIUnsOXlRbR9pQtfKHogmenW_hFCw>
X-ME-Received: <xmr:DiQsanKM0H2XwDDrNXLPSuwH9d9IlG6G0YTo678zOUhj7hFecvcamVIzm3AbDPPDBKm3MmwSZrjmqElTvldDfAbGxYBRHOtuxFmP>
X-ME-Proxy-Cause: dmFkZTGPwPe475dhneHvE9sJQWJpyq366gklHT6ltgfcTzWyJ9n1kzboJiMfH3ghApgXUp
    6g4uPqWNT6U2p66ETs5d4iAn06FonHzG2o3IssTRfyKZ+HcRFIlZbdEPxhxFy4/0bc2npv
    VTcsJuPHEq0AON3rIahkRnQ38lk5yYxQrkM8rkKY2BNx67FrvQ2soCrCyNbW647Yq1hZ0K
    NKmRYsb5DYjL0isFdO3wPgSKMoAVxQ6RXjzez3LhYCsBO9CDiVqHZyDo6/r4q1Ye+U/dVb
    YaJIhAPgaIUIrESEof8fbEt+DXpuD55Mr0pQWgTugPUMVAsrqhw5v6S53HomC6PF7AvfRT
    K0DL6p/iyuoftVwlij18X1BP2sg82CbAISrwJ3fMUaITeh7tUEO/UQxUgTXW6tIvU0BBx+
    QBAqKjenT5A/7/faWEDjBkSSDqjKwARvpKne0laqQNsWa/Wiw/h2CXU0GNpJ5ARB2DpiMG
    ZUOZLBmmKGVNTfvTerZ7I0YDzSqcDWVBn4VCMt5RmQAzgzn+dIAwxx7JNW0LK09zemRTz8
    L1oyJeqm9+2xlL8pMwq9wiXsDvpWPSnx57PXwAf6pKjuAIvtXbjGmYOJ17lzmjZN2ZVvOg
    /jcrHq2Gje9A3C6C8bwTY+e5BL0rhPiO0Rdu+hoeJUIqGPQeRWF8lXgbdeVQ
X-ME-Proxy: <xmx:DiQsar2mwdMuHW2lsvg6sKmiMboASp2ADdKw-TEg9Rqu_hGtp-FYFg>
    <xmx:DiQsat6gMglRqg3IYzkBZdMgmddpMlvqEiRfmYXALuDvJaJlF4fjGQ>
    <xmx:DiQsak9SC4qKf_QzJ0gGwtjPgkKpYfbHCSN90C8d0OjxAb9dzfJ6IA>
    <xmx:DiQsakVhc8ljyU_oNmlWpTG-_sMIcXOSqBdmfE-2kkdkznAfNxzDtg>
    <xmx:DyQsaliPhr3V67Y3CpRTmrEoFJkLopC7fYs_s2AsQ2COnU9jUZJXlGZ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:21:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  ps@pks.im,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v2 3/3] environment: move trust_executable_bit into
 repo_config_values
In-Reply-To: <CAP8UFD0X48BJcjLrr8mY0x3A03NSEN35G7jrvdvvp7Qm5PYAdw@mail.gmail.com>
	(Christian Couder's message of "Fri, 12 Jun 2026 09:48:37 +0200")
References: <20260530160520.77859-1-cat@malon.dev>
	<20260610093635.139719-1-cat@malon.dev>
	<20260610093635.139719-4-cat@malon.dev>
	<CAP8UFD0X48BJcjLrr8mY0x3A03NSEN35G7jrvdvvp7Qm5PYAdw@mail.gmail.com>
Date: Fri, 12 Jun 2026 08:21:48 -0700
Message-ID: <xmqqv7bnhjhv.fsf@gitster.g>
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

> On Wed, Jun 10, 2026 at 11:37 AM Tian Yuchen <cat@malon.dev> wrote:
>
>> +/*
>> + * Getters for the `repo_trust_executable_bit` fields of `struct repo_config_values`.
>
> s/Getters/Getter/
> s/fields/field/
> s/repo_trust_executable_bit/trust_executable_bit/
>
>> + * They check `repo->gitdir` to prevent calling repo_config_values()
>> + * before the configuration is loaded or in bare environments.
>> + */
>> +int repo_trust_executable_bit(struct repository *repo);
>
> Thanks.

Thanks.  

A hopefully small and final reroll is in order, and
<21f74852-2209-4d77-94f4-b2b9412eb8e0@malon.dev> has already
promised one.

