Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25A21CFFD
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593702; cv=none; b=jvb/6DjlHCEK6x3UiHGTEkCJq+hwJ0tx8YMwtgIIqj0iX+PBvLeEnEQRwdew/MIWhdhNcRAYfX+NHCMW6nMiHSM36CL0MZkkh9E6wTTdrqq6q4RhbpQNHrvoXvhNH+9QUyYk3FoqeKvkQINu7fVpbjrUxFBRWBVhi5aszWa8+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593702; c=relaxed/simple;
	bh=+A2lbUWMF3zeOri2lTpCdvzyxSTXqWXrSgWp0ZTcze8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oLXVKdd1xncg0xgObyd1wvhtOmWP7bG8OOl0D5RnKn8EJbQASz3b2qKxgPv7R3NvcH7uM4rqfASuUhXn9QNrRMweHE9lKj3E0jc1sSnRpVDGnO0lHUZGu0+C296JOiQx+NNbbXsSngTZrpZbjO24cDmJ39kiXBTB4s/ResdTmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d2gFVYfU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cmmyUpD+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2gFVYfU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmmyUpD+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63AAD1400074;
	Wed, 19 Nov 2025 18:08:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 18:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763593699;
	 x=1763680099; bh=L5FA94rO5CQ6nj501B2pyho/g1L57nTk74DuKEDmofM=; b=
	d2gFVYfUBLuGv3Oif0AI3kOv8URnT/FAt6tRiC3dPcl5qEkn7GMb7TW4AW7GpvS1
	ecpYy8AH97fDrAwr7WQKCfRsLQlSi+iWmlBuipfa61fua0BA6Z7WnqNphUuNcHvb
	d2DwDebQy6MMm96u5N+vXnB0j84T4mmd6VTcMi3SVPZWxCUp5a+gC+uZr9wdN1W9
	SHdIptHKZFt9m9LV92EJtUluTmt/8vHrdpRS+e92df5rcapCM045wJlZV+fe47RO
	H0eCDOAAcYij1CKX4EQKKfA1JyoNIpLt2XzkzC1yLYRS20XFYKbH4EI3OC63wBtq
	O/N3nTtHFM385y1b42AF6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763593699; x=
	1763680099; bh=L5FA94rO5CQ6nj501B2pyho/g1L57nTk74DuKEDmofM=; b=c
	mmyUpD+GlNI6gw8NgeEeigWRGLp1lWLa4PwwGiOxL4BJN5NGQTQEsK0Ial+Jbnkw
	x8oUqqh38QG4i2QgTydcym8UcVX4UOw9mFqmbH2Kf/x7JHZ8yXPx8uyRClAB3/F5
	THIScVZEKrLywyGX9O0TvNFHvaD7uKnp8KxXRHdBk3AZWvIPoOiMsg71BQoVMOnj
	LeOSFn8+hKtcKrSK+Ij9DpXJZN7nFoEVyQ/EPfS9QrnQZ9U8Yc6B91xFZg6ZJfOs
	eZBg7RAa/qQf73gxo7vzOxqyyVAORGEFXkpNIewEn4oSKaHjbpwFPppuhJq252St
	gF0xBI9RZsOMvh2fEVGyQ==
X-ME-Sender: <xms:400eaSnKw7Gya8_-urnDRkSmw-5nJmWOU_xXA1YeOZCPwtHcnWvfsw>
    <xme:400eadgqO3siq2omSWyTKT-XF2f8aZwva8y2T8c1uEBVf1xSJxaNA28LtGWZtCzfm
    3318qpMgS8ZAIq1awh2hp-tWnu1FnV7M9NNdRSJo_lXdzb6XLEwTw>
X-ME-Received: <xmr:400eaaeokrgsNskHD7kZhDbbNFHMeHzYEo1doZcI2gIukjhGoivYsLloyRf-n4JLcrwSKHYgM7U3ERkcuyYn8UcKlEkm1x8Jo58N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:400eadhI2YnsdVPEG7kin6F5AXVO_lmiNSDJ30EZvaP_l49gTETK0A>
    <xmx:400eaSzji8ZYZqaBBGOhLBMDe3fTrZz6K3FSCo5nq8lYYz0-Lg3h6A>
    <xmx:400eaZNgaVsCbCgQ9UYFm9YS6WhFuhVE7H5mIwxGi71YWyEUhQKA2g>
    <xmx:400eaTWnLignnVXFO70Kq6Oz9cB2kOjS2PHVyzSHBQw1Dc3ZvFpE0g>
    <xmx:400eaTp3A4mf_SMWVP0HSz6EX9os1chEJIOI7PnH7bQOvLeR5vTdaPB2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:08:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v7 3/3] fetch: fix failed batched updates skipping
 operations
In-Reply-To: <CAPig+cRjN85S3oCvazAvUD_V0EwkzdvKAm+DC66+uVijF5=HQA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 19 Nov 2025 17:20:19 -0500")
References: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
	<20251119-fix-tags-not-fetching-v7-3-0c8f9fb1f287@gmail.com>
	<CAPig+cRjN85S3oCvazAvUD_V0EwkzdvKAm+DC66+uVijF5=HQA@mail.gmail.com>
Date: Wed, 19 Nov 2025 15:08:17 -0800
Message-ID: <xmqqo6oxaae6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Nov 19, 2025 at 4:47 PM Karthik Nayak <karthik.188@gmail.com> wrote:
>> Fix a regression introduced with batched updates in 0e358de64a (fetch:
>> use batched reference updates, 2025-05-19) when fetching references. In
>> the `do_fetch()` function, we jump to cleanup if committing the
>> transaction fails, regardless of whether using batched or atomic
>> updates. This skips three subsequent operations:
>> [...]
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> @@ -1639,6 +1639,93 @@ test_expect_success "backfill tags when providing a refspec" '
>> +test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
>> +       test_when_finished rm -rf base repo &&
>> + [...]
>> +       git init --bare repo &&
>> +       (
>> +               cd repo &&
>> +               ! test -f FETCH_HEAD &&
>
> Is this supposed to be asserting that the file does not exist or that
> the path is not a file? If the former, then test_path_is_missing()
> would be a better choice.

Thanks for carefully reading.  Personally, I think this is not
needed, as we have just created a new repository.  It might be
even better to replace it with

		rm -f FETCH_HEAD &&

to clarify that we do want to see this _created_ with a failing "git
fetch", not merely left behind.

>
>> +               git remote add origin ../base &&
>> +               >refs/heads/foo.lock &&
>> +               test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
>> +               test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
>> +               test -f FETCH_HEAD

More importantly, should we inspect the contents of this file to see
what gets recorded.  If we are fetching foo and bar, and we made foo
fail, do we expect foo and bar in the file?  Or do we expect only bar
in the file?  Something else?

