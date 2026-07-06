Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635893A6F1A
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336351; cv=none; b=sv2EjnKE27GVdtjSEvM5EbncDOJrbtzTo9LZGX1fNaz3e8gbDlmhb6ZCicyQw+5r+j1eoIsprS0Kdty8gfZUJc4GaedtL/pVae0OMs5twui49vH/M34s1xAHaNv/ZaKTM7AirS/GL49kxEdazeC6wktgALVPaPJqWP8CIoqp+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336351; c=relaxed/simple;
	bh=vQxCJSDj7Wp3FZbAyPY3/G7GDqqFN2smR3b8TjG43Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSX3qLDLjmbgbFFjI0ywILx9FZhszhtJvE5B0m/87/WkkzaI2Hvz1hWxEyn0tTB8J0ve7LiPcBk53ruAT/LW0UZ+8eO/YYhZxWrS6/nebJD2ZqQvfm+1fEgYwcKldyW6GwoTsp50IVA5VTsTn5JZZ8WeavbI865Sl0LMbBW1BGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=AVYTWWx+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="AVYTWWx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783336345; x=1783941145;
	i=oswald.buddenhagen@gmx.de;
	bh=vQxCJSDj7Wp3FZbAyPY3/G7GDqqFN2smR3b8TjG43Us=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AVYTWWx+Hk5vOXqTfvINAzi8lLcBY9eKP3PgLnLaRgpAwvWb28A2kEjKjeXBeC1u
	 9jxZh+jsr8C2KsW3u6h39jijw1f8JV00mFI/REiZBZ6QubJNS884LH13uGGcatsxJ
	 nzHZNPEKoTdniC+kWbQR6uA9YufcCrRGUjdVRCimYteFc4+dDFmAkWAE9rIA850BT
	 NWQG8oM6JCdH8SWfaJsgRsVwGqq88yvUYHBFMmuVzOLknrrzy62S0ZVlNfTyNc0+f
	 ko62yCnn0cyZSTbGzXhTwXBqAF9o6KU3foMok8TSlKQCzQbqs37K8MGkKgwY6pgPu
	 vXp8Wmm19zIbg9cewA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1wuDeA0j6F-007YFX; Mon, 06
 Jul 2026 13:12:25 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wghFQ-GLE-00; Mon, 06 Jul 2026 13:12:24 +0200
Date: Mon, 6 Jul 2026 13:12:24 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] sequencer: use an enum to represent result of
 picking a commit
Message-ID: <akuNmMFST8W2H2Ru@ugly.lan>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <e4050ead27f1e01ca72acc849fa16bd67e0d1c4b.1782833268.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e4050ead27f1e01ca72acc849fa16bd67e0d1c4b.1782833268.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:xY5OXkQyy4In7Ymw8KzqYQfzT2TdT+If5dffiQFhyTEKsGvnSXQ
 mxm28vJiidLtWePj1FCxKD28a8xW/RldAkHqQFQsG6DRveKBxMvZiIrj4XXrFjWM1zCmznM
 6XiHIaXhmTUOFbjog3OfPJPnpE91D9zffX2gQWV1ARNdsYNTvfTvhUIz8mHcgZ+eYiY4L7j
 Iy7sPTpt5LKp/rnMSAKZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XUVx4w37XwU=;91GL8wDGQkMwthDsNF0W8atZmBO
 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
 VaXv+IOIqOrgYLA==
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 04:29:00PM +0100, Phillip Wood wrote:
>Rather than using an integer where -1 is an error, 0 is success and
>1 means there were conflicts use an enum. This is clearer and lets
>us add a separate return value for commits that are dropped because
>they become empty in the next commit.
>
have you attempted widening the scope of the enum? the three conversions=
=20
between the new enum and existing int return values irk me.

