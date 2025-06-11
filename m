Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3B2580F9
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749684922; cv=none; b=EnDekldVk43husRv2/8yuDWZGaEsOTX6n12bjf5i3IT8snDyWqW/j8oWMEzEWZU6JRW0DiENlA31r9ZCUxnv/BkvVEsQNmBF6URm/oHGz/slX3DHYh2RI3prcbIUOsMnZXaAv5pSpemPWdufddQd5nOo3PPxwIBptXrLoZgU9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749684922; c=relaxed/simple;
	bh=COr29DRZ+vAtj0s2BQRj8JkBJo88mh44Gak9foIxOP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uvFSfsNyKK3j5gWHRRugc6B6Yf81w/W7CX9IFD8LDZNZBFORG4JkfDbCSBMHlDHeA0sBA8fw9Zx6f9fdSBpSpsji2Hy9LUUASfTR6x+nw1wAIJPHox+Qgu88rq70i+PpCrzeYIvvD8ARsSbxqg9xNa43WCLhAzo6gCNM2Ey2FkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j/ihPH2k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VnwVcnK9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j/ihPH2k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VnwVcnK9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 21D9013804EF;
	Wed, 11 Jun 2025 19:35:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 11 Jun 2025 19:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749684919; x=1749771319; bh=yPb5KTToeY
	Tn7CoiLs84d0wnMOYVthyxmzjOkXivXdg=; b=j/ihPH2kPxx3g7yrySUWGIFG5a
	G0cXHlvyvUbBHZTEO2yj/AtY17skbHCPufDjxFuKaIU2RYrmCGfWwolxWtjVhkY9
	9CpEp/5AFG5Qv/60FHIf8VeGrD6/KyfVSh9fo0Rs5UHinHyXPfySfhyTRowSO505
	zx2Jmg1ccw22pT73fNBnp6Vm/sPvWfsPYd6DWSbAprLubBIkh0MLt5dpO0a6RNGF
	r1/AidEhWma89/SSXPSwjQSZTToUO+eUoPDZ75+1MgvfxZMuIoGQyW/IRWj3hBUo
	VtiUECELFSMJmlvM3rWfn3vynLPdKuwzuDYm6Kik6sltSW2pz8FIqL4eMEmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749684919; x=1749771319; bh=yPb5KTToeYTn7CoiLs84d0wnMOYVthyxmzj
	OkXivXdg=; b=VnwVcnK936TpcosW28WZhB7u3sfoCRjSmkA2nf6GuC93yGnXeNA
	rndqhmzgs0H/V29+QRW/DbJNE9ax/s3cXeWvXp5IQkm1hdzqB/3vaqaPF9UjrQMy
	GP25apFvo1CI96LFo4ZNjAp0Yu92JCpKrXXpH+y3rE+CxBaCykX7VJuGDa9sJtmK
	4ifSPk8WOdiaJsS0GJUAaytNNKNJ0c4QwnT4LoHfgLAg+K9htAaxYOd5F8b/KDYr
	xV20aeCsRKjlO2TLfItIjAm0jrzhBcmkzzEcnER21GsLEeJdKdIDyolGcxq3bodx
	BQ5UO2RoCc5eQW+HHnycYyCOR7xRzzHP3Ag==
X-ME-Sender: <xms:thJKaPFEnhX-dt9Sj79dpKjX-NNbWiZNmAhIVzPACXgc0ml88kWh-A>
    <xme:thJKaMX8dTqF1iv0qjAo6ECQQlrk7OVcA-78-s9bzA7YACARfu6d9COT_VDyEVsYA
    sNYVMxLjWR-oj3GoQ>
X-ME-Received: <xmr:thJKaBL2UbhjH0EQs8thLhPezAtXQPn9Ap9bLWSk0i-YtgIQM17uB1raQ49my2NiVXfFI1MNI6MC9NhdMTxQNtDwOym2bP7V59GX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshht
    hhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehvihgrkhhlihhushhhihhnsehgihhtlhgrsgdrtg
    homhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:thJKaNFdddcG3uY6DVSBdbqFOS4u8q768KzDm4nhxYRrs9L8TXGZvA>
    <xmx:thJKaFV8MiYanEDXmYCWjJqtHwQKR4C3p8gw0Fg5D9-r4Xl6GQfuPg>
    <xmx:thJKaIPqdXSBQxzafIUA7HvdWsu5K3DfD3Xx379FldzlzdX8Da18Fg>
    <xmx:thJKaE0dSMT-AlCsX2_T11trmE_hBAhQv_Ib3tPGhVzYl8Jg7-gjOg>
    <xmx:txJKaHsVn8Vzf3rNo3cDoW6QvC3CRYA1DJd7WL2JvFxX-u5Q2GIVeAO2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 19:35:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: siddharthasthana31@gmail.com,  git@vger.kernel.org,
  christian.couder@gmail.com,  viakliushin@gitlab.com,  johncai86@gmail.com
Subject: Re: [PATCH] cat-file: fix mailmap application for different author
 and committer
In-Reply-To: <CAPig+cTezW8XYjNo3L3Qy+f+aiCXppTj-Z=N0bBMG8mp9jJ8ZA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 11 Jun 2025 15:05:14 -0400")
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
	<xmqqy0tyi8aj.fsf@gitster.g>
	<CAPig+cTezW8XYjNo3L3Qy+f+aiCXppTj-Z=N0bBMG8mp9jJ8ZA@mail.gmail.com>
Date: Wed, 11 Jun 2025 16:35:16 -0700
Message-ID: <xmqq7c1hhmx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> may be easier to read and more portable (as some implementation of
>> sed is picky about semicolon concatenated multiple commands).
>
> For what it's worth, Git test scripts already contain a fair number of
> uses of semicolon-separated `sed` commands, and we haven't heard of
> any problems with them; not even from the very old and quite picky
> Solaris `sed` (or was it the ancient SunOS `sed`?).

I think it was of BSD lineage, but I phrased it poorly.

>     sed -n '/ version /{p;q}'

This pattern did cause issues in the past.  I was hoping that we can
avoid it by training our developers to avoid concatenation with
semicolons in general, but {grouped} commands cannot be fed without
properly using semicolons anyway, so it would not help to just
generally avoid use of semicolons.

On the other hand, the suggestion that was given in the message ...

>> > +     sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&
>>
>> Perhaps just a  matter of taste, but
>>
>>         sed -n -e "/^author /s/>.*/>/p" -e "/^committer /s/>.*/>/p"

... is much shorter, simpler and easier to understand.  With the
added benefit that you can even line-wrap sensibly

        sed -n -e "/^author /s/>.*/>/p" \
	       -e "/^committer /s/>.*/>/p"

there really isn't a good reason not to adopt the style, compared to
the way the patch was originally written.
