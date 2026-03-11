Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F62E9EB5
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251568; cv=none; b=k4SgfqeVhRwqMIpKiNxh9iw07jz8TJTS4kH99gnsNW3OvpooAxZoo1ay0WBkT/5JR8yZJECRi+2/LnVRGaUEm1u1xE3c3tq/lZTT1F7VrKdq+KiH1LPgONHe8IpLRleGL3caTCbKzCZZ8Js0sxzwY5jHIjwwaHQGK4AA6OLkvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251568; c=relaxed/simple;
	bh=YUZmQT32G89+LJT+AKWZmkbOk7qNqAeiqIs+pz2+7i0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/hC1Rf++lEeyKlmptbooZGSJXh/+leF/z95BKpTCSGIrDqBOa8vw4DyIsnG2PpAMdl1BLJZWG1CWGtTS4mV6agCvZZGMoKt6AjV8CV3DUVZ55OZqhPnU5rlEni6QHKuUtUH9kIQAuuYJ1mFQYX1+gDX5Jb9L4477/INIKYkFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ro2nkE57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3qjtgtW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ro2nkE57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3qjtgtW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CB991400025;
	Wed, 11 Mar 2026 13:52:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 11 Mar 2026 13:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773251566; x=1773337966; bh=FIGnk9URtX
	XVT5683I8i5IupBnjyTPAVSvVpfX/xC+g=; b=Ro2nkE57ztBKH8Vl/0P2JbUw/t
	e5RFRMvPlO9WmOE4wEsK/KOKAf6xfhHqSkdP185Dd5xmW59r2bfHoyfAOd1ynikZ
	vtSb1fVjne5+rh0CF+/npgPseNOVIiuULx5ybploJopk0mfa+FF1F5DDCgubR/MY
	3Iu603eYtxi8qjrrbdbEQO2aEdXKDoR8FXjp09iTQ4+gpm5elc/gwJuf0aEZzlWL
	5TATNoUYIGbWVgQsQb/AqDAHHzBEL/Vr24T5HtnixeMPtFG2936JRsG+zpX4Wbmu
	6JjV73XxcIMhQJRjof4lqFP8rRD0ZDgfx/SNC/XsgQrVbSKQUsCTaUSHb1Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773251566; x=1773337966; bh=FIGnk9URtXXVT5683I8i5IupBnjyTPAVSvV
	pfX/xC+g=; b=c3qjtgtWO8UigHCYbwcpPunNCrJOJoan5i3e/gPX3tCnzWQWDdU
	Orq/GVhBEcYOf1AQuZJskcKnwVav6QAuJ1Zj6+KKgmAKBlpzbpO0dsHeEJUVWOOW
	NmjNeYh4J9PXrmxP/KQnY1s5IpHUHLVR/qcAvx16+2mz45KEEIpeIf+EZfDKKkJd
	UaLBCjLfObW8uNB/fiqIxf9iWoVaIoHjEcYYykUQVdQaw1ICvjs3E6xpZM3FdOjW
	R6seWyGLVraFR3/yTBEQ4LtT47b+aZBQaiJ/f3hb9UpxZuxMyikGw0CB1RE6xFW4
	Sejau89hV8QxOqX8nQA0yCQoQqYGaLKtguw==
X-ME-Sender: <xms:7auxabIHTPE_ZeRzK-rHkc0CZTl2JJbmZ2STH5Jw1CKNqDNLZeRFug>
    <xme:7auxaWkqMzJgb7MmNkT3MwJupgKeDu8Of1EQH7SwrDxR9Oruq50fNl_BUm9ohcAL_
    aMEyTYxfMmxZBPJLzWhytKdyqP2cqSvAcoyIq5Ep_UrN77yhlyqRA>
X-ME-Received: <xmr:7auxaRFtLbP7T9fA2OjDquXAbLC-Io4VnUOXceBBtF6K3eMvyF0NTiUgI_KkoUCRsRaSzRJOQX16MAQG3PVJ3fmWJlxTLpIEYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:7auxaeE5y0xtpv2McrMYj7WLqgQ3-fiZDknCUI5infViej46dsCgoA>
    <xmx:7auxaWNGVSwLl4-xbEQWN4ZiDss_Mm0gpo77osrc4Kk8IT7qHht3Wg>
    <xmx:7auxaVFrYUWFMZLAHSeni7-YozI3NIIUMYPoHFOXKCThI6K6yRGzHQ>
    <xmx:7auxaVOBZKvd7cUdtZncuVTx75yEoEQOZuZBRjBvhyXTLIBb87i-OQ>
    <xmx:7quxaemRDbbxz-OyaxFUeC7rY4Ph7jMuzAjjppziN1ioR6Znr_jqRf0f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:52:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
In-Reply-To: <20260309230134.758107-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Tue, 10 Mar 2026 00:01:34 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
	<20260309230134.758107-1-pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 10:52:44 -0700
Message-ID: <xmqqwlzip82b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Replace old style 'test -f' and 'test -d' with helpers
> 'test_path_is_file' and 'test_path_is_dir' respectively,
> which make debugging a failing test easier by loudly
> reporting what expectation was not met.

Well explained.

> The instances were found with:
>
> 	git grep "test -[efd]" t/

People seem to add the above to their test-path helper patches, but
unless the coverage of the work is fairly thorough and you want to
say "all the similar issues should be found with this command and I
addressed all of them", I do not see much point saying how you found
one of them and addressed it.

You could have used "git grep -e <pattern> -- t/\*.sh", or you could
have been working to fix something in t9200 and noticed these while
you were doing something else to the file.

I do not see it as too huge a deal and it is probably not a cause to
send in another iteration once it is already written, though.

> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t9200-git-cvsexportcommit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index a44eabf0d8..4507e8e6db 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
>  rm -rf "$CVSROOT" "$CVSWORK"
>  
>  cvs init &&
> -test -d "$CVSROOT" &&
> +test_path_is_dir "$CVSROOT" &&
>  cvs -Q co -d "$CVSWORK" . &&
>  echo >empty &&
>  git add empty &&

Our test-path helpers should work even outside test_expect_*
functions, so this is not wrong per-se, but it somehow looks a bit
unusual.  A related clean-up would be to wrap the CVS initialization
part inside another "do we even have a working CVS installation to
make it worth our time testing 'git cvsexportcommit' command?"
check, i.e.,

	if ! cvs init || ! test -d "$CVSROOT" || ! cvs -Q co -d "$CVSWORK" .
        then
		skip_all="cvs repository set-up fails"
		test_done
	fi

and then move the git initialization part to its own test, e.g.,

	test_expect_success 'git setup' '
		echo >empty &&
		git add empty &&
		git commit -q -a -m Initial
	'

> @@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
>  	git commit -m "Added attic_gremlin" &&
>  	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
>  	(cd "$CVSWORK" && cvs -Q update -d) &&
> -	test -f "$CVSWORK/attic_gremlin"
> +	test_path_is_file "$CVSWORK/attic_gremlin"
>  '

OK.

>  
>  # the state of the CVS sandbox may be indeterminate for ' space'
