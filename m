Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AF19067C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888198; cv=none; b=n6qmcjAmjRMitODSR+Xgskws/twsZL7Zvqxj1kpGywgZ+bDxkZFZoqw+BEQB0H+3L4RfPXWPKkEObv/cgNKxX7lDEzNZCEiito7ty/gIN6OKX802HaRoIULUISWENtRkcWOmbbfhbupEhN7P3QZbtEuGAN2zCFGrlGQjV1eVpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888198; c=relaxed/simple;
	bh=tAXXs2EQsSEtamlSNWBCAOa6QfYV/qAqdnG9Ti/1DVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMEyEI/XpXqTz00TKXGkC2+H6HAcjfoXQAXZEDeLRReeW9i7r8BaA+Qxdj02I0Ke/GSf5dt12K4vSUpX75CHPU9OlA4ZL27NZq7lDtbvZ8Fp9cFgfwB698kgShpaj09PgA2CMpxW9eRKkG6Ob37c5M9B/kIdcxfaolxtTaTT6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gZiUTcr7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXCjqarQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gZiUTcr7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXCjqarQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37F7425401BB;
	Mon,  2 Jun 2025 14:16:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 14:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748888194; x=1748974594; bh=P9Wn6BxnUs
	flzt/HsLzXcXpfxZPViiGdiCDwl6OBAsI=; b=gZiUTcr7AJqbthxFia2k+v4SjP
	jsA1ur4fScx+JqkyeCb/MsDd5uhdFn/N+I7V1G82q/wpcDczBdrev5cTOvBQqASr
	kWCEIg58O3iEs7fswjKoxGUYSg8Ylx3UhFPmMEBY+hbiTNEpuOYhISbbj86g7nkS
	la1ANV1Wn6l6RE8ReTlIFZdqijGp0S8PDVyl1FyGPXKnCKMrrYTPC+74TiLCRC7o
	BAwIkVRiZuNgf8P7mcmVxxDKgJzWUVLTX+I3e6K+xQiDFWAB24dZUUaoVDAggasW
	Jwd3p36c9zphfwxCILTOcftw7WMf7+5lhiKHJhsdjfzGecx2Sda3+CYt8vGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748888194; x=1748974594; bh=P9Wn6BxnUsflzt/HsLzXcXpfxZPViiGdiCD
	wl6OBAsI=; b=QXCjqarQChyHCWc7ByERAXZQ20ciVeNYlrfAK6gOUeNAmS5dwM2
	N9W7JVD5ddHcf1aDKYZY33j/YWDmHOrX89y8Lpox/LfwQY1o4oM9zazqGIT5BQoC
	K0iJtsSdNt6AB2XeaciyrpMcMJ+3sgLIr+Eq7ujyZMNNWMFjJlO5+7lZ1mNhNkG+
	PU+P4VgufbYDFSyNm9vTo9nypci8ZT/9G6bpxMN1BImrQ83c14O3AOpFWggq80mW
	dj+MEU0Ng052Xa/dGdrGYXC7PgRVd4nT3jh0GbMyZTjM5jvc4OhnnOqzS060uFRX
	kYKyAdRkxVjb8o7cLpjflv5AiPXeGt/+ChQ==
X-ME-Sender: <xms:geo9aHafU-UmkiuBEYJH50pUieoDIuhWNZYxb5aqPY4velISEAZJtQ>
    <xme:geo9aGYFnWIOfd33ErzIM6tw6PlqLxndnsM0tiHNTnWW5BpCrKa6AT4sDF6m7i2t1
    FwVUE8BPFQDSHjUKQ>
X-ME-Received: <xmr:geo9aJ9IHXUX18hIdcu-URloJ0I1RNJWZATtYk6f9fRINN6e_7xFnuLKUAroTKB1vT7r-BdVQDwHmzguKPkt6Eu46ms4YJydFRfZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeefieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:geo9aNoxLkZ-zv9EQf1kmtuPYAc-7ix0-hLY4j2n33WV92M5usBjtA>
    <xmx:geo9aCrasJ-9PFU7lKvcnw2neJxAsXccRRuh9k-gdhaViKm1WjjtMw>
    <xmx:geo9aDQ87e3Eht1koMD8spUXAGKyJT5aLIGad9BL5scI5-CXWSftYg>
    <xmx:geo9aKrrpnx-hAcjg9veWgOWjiNhrKYgsC5bAdka_edKCzWf0jPGSg>
    <xmx:guo9aDhb7qwN7dYcjMQMK8P5jLbhEsxwUuOEkMA4y7Fm9vPN7wjjTT79>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 14:16:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip
 connectivity check
In-Reply-To: <2e17bd1a-aa4e-70c5-3bea-eb4d95e66756@gmx.de> (Johannes
	Schindelin's message of "Mon, 2 Jun 2025 18:06:40 +0200 (CEST)")
References: <20250520014920.201736-1-jltobler@gmail.com>
	<20250520163218.263921-1-jltobler@gmail.com>
	<20250520163218.263921-3-jltobler@gmail.com>
	<74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>
	<gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
	<2e17bd1a-aa4e-70c5-3bea-eb4d95e66756@gmx.de>
Date: Mon, 02 Jun 2025 11:16:32 -0700
Message-ID: <xmqqiklet3en.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Do you have any idea why this particular test case, in conjunction with
>> > Windows and Meson (and only on GitHub) acts up like this?
>> 
>> Thanks Johannes for the report. I'm not quite sure yet what is going on
>> here, but I'll dig into this a bit and see what I can figure out. :)
>
> Thank you so much!

Thanks for working well together.

