Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065522F16E
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049510; cv=none; b=uVxgyGby+2kXbIO2v8ObqKPgsYRx4q076W/MQtv+DR+HlC/E6EAFjBa9ZjG1DX1guHxT3PivyA+FbFhViLiRTN7svXDrvmL4w+5/cgOArbcIj7dE0Y854/ZGh9T1rLxEX0FuQKa1lqowAxuA0u4Nkq0baC9o5YyXkN1HDICcZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049510; c=relaxed/simple;
	bh=2yeB9NqkQs7ZUiJn2vlQ/pjhmH/v3QmuzZOMVvp6Kz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JCSiJurDfGaZifWlRF+gD3MBKfGcQjGp5lktxxr1+TQUR0Kqz03rJX57gxTiKB5/XcTtsL+y635xd/WbyA8tUmI2l1kNjWH+J1Km4i7iOLXNDKj9UWAhUDChwU4oxuXVW5q4nKxOZSWAoCnEiTGEVn00qnP8lEEhv5xX9BQqAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qVZY6YgI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hjua7VYO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qVZY6YgI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hjua7VYO"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0740F114008B;
	Thu, 16 Jan 2025 12:45:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jan 2025 12:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737049508; x=1737135908; bh=2yeB9NqkQs
	7ZUiJn2vlQ/pjhmH/v3QmuzZOMVvp6Kz4=; b=qVZY6YgIDGCJQRr+1ehn0h42se
	ervcr5YfQSkB+AzWVJPts42MkkzA9ylV6erFfDLJ2dAb5KtIdfPaS98O6hvryf+u
	63PoXUl9+s5xTDfAu88MFmmI0BI2/OQwD1CbMkUXLYvSGpzEn9KVON2Q7JnSd3yD
	+xAgkaecq2A0vrAE+2K10SWCw21W6GKyNPqUIv6G0dHJiRg6UNTuw7gsnTjhD0CR
	8h92mrZs7wxQsIPHqEx71xZYXE4kQtfcXz7kS9g2dERvcNWCtJk8BVneQOFPCLTw
	H0vERUL2dwioOJE1Y2PJkVz45w4CQt3G2Ih44YMgnKDHyStCIWX4/7KzJxKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737049508; x=1737135908; bh=2yeB9NqkQs7ZUiJn2vlQ/pjhmH/v3QmuzZO
	MVvp6Kz4=; b=Hjua7VYOuiPp4o+hW3SRKjPB+ewqExkuidwpXJxO8YAJ73oNIsS
	KCc/8ljRK6EmKJJAYvKHUwSu5gDZP++dSIiP/tfzcAKi3T47SpkFuH4aIO0QDPBP
	OkSHEKXnV4WrLwryJWrHEJGe8FRflRimUD0ydPflJi4bWe4wB8UMq9PYDNqdvIDf
	2SACg4WyW/Ylr6X1YrG4vPkcTlCVzRx8Xz/fKT9VbWfuC+LhxwFKi6p1BxE8w2kr
	PFQxTJSVxSdrpKyMuK86Ni6289QSVoicoFstZVu50Qysnvgpwh77Vb2HOM5Dm/2N
	Xo/xImfhn3d5MYBvvvaZDfi1TbRQByD9o0g==
X-ME-Sender: <xms:o0WJZ7FnvsDCo0eHQQWSUqLwkqCjhifb0SUR3KO3fKhPY_RYL5SGcw>
    <xme:o0WJZ4VIXX-decFVGZxmJ_r2IzfAU6Y-rs1UjZ9IQoWoG-Zhpnh6-idoLAMzpxopE
    2N_n0WVdkL8DBe_1Q>
X-ME-Received: <xmr:o0WJZ9K22zHxzpCpetqcCnMLKdASxa9PMK9pU8OUkCvxklqTmFMqKRIT-G5f3l9VM_-wNe_EzCnT6cBzyglZ8UzNRPdc_G-JTzJC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:o0WJZ5HvSIudVPEzzoewE1OumoBlPMTLscIQIDDyd7SyZVIw9jUV7Q>
    <xmx:o0WJZxULOqlzq-a5-AK0od9UIcFZ1OB73VR9wIBy_HDEUCcjZ9a3Dw>
    <xmx:o0WJZ0My7iFYECHeQhbMwK7TvSA4XuwwYIuck3EMg5qQB0jd0ngH8Q>
    <xmx:o0WJZw0q9VUKNVmC1FBRdiBdfS81-cKEt80d5tMZZFIsnKy2yKUF8Q>
    <xmx:o0WJZ_cb6wS9XRkj82af4hpqB8ZGey86l7QQysq8nKN4LjA6G1mQvJ3t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:45:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] t/unit-tests: convert mem-pool test to use clar
 test framework
In-Reply-To: <Z4kF1zR9TA8ff2bl@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jan 2025 14:12:55 +0100")
References: <20250116104911.77405-1-kuforiji98@gmail.com>
	<20250116104911.77405-3-kuforiji98@gmail.com>
	<Z4kF1zR9TA8ff2bl@pks.im>
Date: Thu, 16 Jan 2025 09:45:05 -0800
Message-ID: <xmqqjzauslem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 16, 2025 at 11:49:09AM +0100, Seyi Kuforiji wrote:
>> Adapt the mem-pool test script to use clar framework by using clar
>> assertions where necessary. Following the consensus to convert the
>> unit-tests scripts found in the t/unit-tests folder to clar driven by
>> Patrick Steinhardt.
>
> I think it's a minor detail that isn't really worth mentioning that I
> was the one introducing the clar, so I'd leave my name out of it. This
> also applies to subsequent commit messages.

Besides, that part of the description does not read quite
grammatical and the rest of the sentence is missing.
I.e. "Following the lead by somebody, WE DO SOMETHING".
