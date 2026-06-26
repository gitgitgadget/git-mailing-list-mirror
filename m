Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472A3ACF1C
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511516; cv=none; b=r/yVyMRaObJqkmV/bGI9rUBIPXluntkgrOg30EEqVE/uVK0vtPUuCdJ/cAeffW9iSxlQ2JxlNk5Chpbo7qwzjfjkJNG9E7U7CygM1SuHvL8oP6YLe4tzeb2jXHTulFcMzy4KBkqVS2ETsY7Yj+EGbWzDitbdtpZUjPspJH8Stt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511516; c=relaxed/simple;
	bh=buxmWuJrjA1CBqCI9RH0G8WxBxiY3AoskN4bZr9n51g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rWSz28MPexhhbs3Faap3gi3igIqUsIFMKUSvncxJaOj4uP5S/VjSDBYvId6heXyaLGTU8K7wjlKA/MDRsNiv4ZxA810KVLizyDDvmhBerIW2a24YCt49jtDDDexaWe+gm9gD3VqE9Km6+eNeXSDj0TL5VFJUtxloc8JN1lwhuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WmLNxNDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBRKSbB2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WmLNxNDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBRKSbB2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 950ED1D000FD;
	Fri, 26 Jun 2026 18:05:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 18:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782511513; x=1782597913; bh=7PPF2/dPjY
	/mazSncYhwQtr8I1/7SXrmWW3bgpXifT4=; b=WmLNxNDZJbnWzJUKkfsRZeB6tY
	6/T8RRGHjZyk0jydozQ7rPoI906Hizz7PyrOmE4VnHIeikqmU01M2yG3RDXrxVCP
	g5kBL6onW13G+ggnFx9TMwov9VraY4Nd02H1Y2JCSQzSmU/ppI0BJw4A7KdAxN42
	F69JlwBYtERm+Ig1u+W9TeDGyepTZp+NpKK72G1bPWdYRmZGRKem9HHqWWhEhTko
	3IBXhSYtRw3GYmUIHT4ZkKXcM7smbx3xEVvq30+I085RAizX9VboQ/n2NbcRA8lT
	WlBOEWsWjezJhWXg/sTHGbbjxrXFGuSaYOlv/FuT1sW3bMEkXeiKzsK3IECg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782511513; x=1782597913; bh=7PPF2/dPjY/mazSncYhwQtr8I1/7SXrmWW3
	bgpXifT4=; b=XBRKSbB2wYi6EwnSu+ESlcKrKp6OVTTFHXKk+NoEjRi+tK2GUog
	8eNqNWMK9W907wcJLCoTjjTpsYdvdc+cm/eEnlCI/jAHpNab9/GRusOlIy17zn/K
	jtUjfzGDF9EcDULwZjqlcGcd44Fo7Z+Wabp0LOvR0RinaK9/Jj4jN5j4IhZev+38
	iC/bIpPvR0dlP2odetOrYGW35Fmi8TNv5XfBD/RyWMx3NEFCiZHPZvpFdOYKNCxi
	RPBcEN0BhhPL0rzZPoLNrY2qN4hz1+cq8yNw+ms8q5shJ864H24y7gKMDDKe26h3
	arAVUuZHmJG44+il+MkNlRkJv3r/FjGIedQ==
X-ME-Sender: <xms:mPc-ar7MAxgUp08BoMKpVRpO4IjvBO-vIU8WhueNIescDx5nL7BKoA>
    <xme:mPc-arT17a2U08d8cB4MJ6PEuV0CNa-p1y8GT6QNA3Jh4ykZh_xpJ2FDWxpdTS_dP
    -0fpUrn0UPDFtBzE14GiNF4dccnglKr12LxUqHYA1B0TWq7id8>
X-ME-Received: <xmr:mPc-aon1xx9d-LeOEZYu_t_1uoM6PtO7rsyaCqgWa3rsWesLOA1VWtoHrP14uGBl3AxAt9CpBdgAOwk-ZgvvqfZ28Z3aAHDG5BSFLv4>
X-ME-Proxy-Cause: dmFkZTGcQZOHCTqwBplfhR0NkAQiMSiPDiMLOdbO2VEFYhXAp0h3x6g5Pyw1MdUH9r5vc2
    N/9WOgLhv+nWAYvpD2Q9Y+gIvgg1MAU6YW0slP666sdT/0QmIeIP+KC+CDIewIcGwIgewn
    Uvh1qZb1iaOYIOCESL+b5vuxE6SfQaPmtC31dn98a6hghkQRlpe/qVBowNbtBQgyqrBjOM
    t03sO3mhggM/8jLVu3goeTp+62r0bqWfQ5oPcB7oBkmYAIyhX6RJwlxbdi3PjckRT1jJhh
    SaMA5W1oc/8aPFkrgGCG6Ohmt2lswVCMiKQkhD+MuTIMzNRhnhn55bgS/CsAnhsPe+KBXZ
    0unNOz1XtM3VlGtFLUtQ7E40Dg0LhzD9VR/zgPxlr1PfGzrCns6IPscHI3yBu6E3TLw59K
    4A4XNtUcLMvgTdLHOhsPjEGAq/6BlT/IySZHWlepbwo3VYoBN//emIXFQRZ1mTQtVpQsIY
    eys28BQhKjGyYmFoepH1y2VyN3inWRZyqkHoN9kDMn7Kaftb2plAt0KvetPTxO+hh4FJYV
    CoQWEstXS4GwK+UNBwUVGM27xwW48o0jqUeuaa6hwzuMNtGTwkBGYoNjjyEYdi8DvTtcv1
    EsjRdhS+RTQlbRPS++AW4PJ1/TmVLVrOoax6R9HEPb3mqaHxv2iCjkALNSlA
X-ME-Proxy: <xmx:mPc-anTFb3J7X9cEMcakBOTzmtr8p2fvfNq5KnMduorjGtY3wYw23A>
    <xmx:mPc-antPGFiTA7J4visHs74pfz0dwdmwO0lJXTcPW0-R464MIMvN0A>
    <xmx:mPc-ao7M0Hz55FNNKRrfX7FhgA-u-JdSvI6fawbrvQ5NZ0sKIErF7w>
    <xmx:mPc-aqgcetTeDXyZ5qPUHANwk3qWcprDycK0olY-vmXg4HvK7lPptQ>
    <xmx:mfc-aiY0OQJVkuQtENz5nm4PSMtSyVafcHCzjTBwqeWSUJeW1oejFytF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 18:05:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,
  Mikel Forcada <mikel.forcada@gmail.com>,  Ralf Thielow
 <ralf.thielow@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Bagas
 Sanjaya <bagasdotme@gmail.com>,  Dimitriy Ryazantcev <DJm00n@mail.ru>,
  Peter Krefting <peter@softwolves.pp.se>,  Emir SARI <bitigchi@me.com>,
  Arkadii Yakovets <ark@cho.red>,  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,  Teng Long <dyroneteng@gmail.com>,  Yi-Jyun
 Pan <pan93412@gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.55.0 translations
In-Reply-To: <20260613061658.1767987-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Sat, 13 Jun 2026 14:16:56 +0800")
References: <20260613061658.1767987-1-worldhello.net@gmail.com>
Date: Fri, 26 Jun 2026 15:05:10 -0700
Message-ID: <xmqqh5mp5561.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> Git v2.55.0-rc0 has been released, and we are starting a new round of
> localization for Git 2.55.0. Since the last release, 125 catalog entries need
> to be translated. Please open a pull request against the l10n coordinator
> repository (URL below) before the update window closes on Sat, 27 Jun 2026.
> ...
> **Reminder: the update window closes on Sat, 27 Jun 2026.**

Thanks.  

The cut-off date will be tomorrow.  Hopefully I'll hear from you on
28th in time for the final on 29th.
