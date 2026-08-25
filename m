Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0E3321C2
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674776; cv=none; b=sp9F3Nxb35tDwPm2UDyg/IcUfLH+N/ejWrtGjLOZmCTCwzi2pP06Hi05jA9X4bOmN71BYaC6MVns3h8O7eiIKlQRWkmMsUaW1M/4y0JYXPzWBDJcm2PWCXm1GNHy1TALMZntd0JetFvmo8NWOEP1x5wbB68MCRP9U+NbIehBCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674776; c=relaxed/simple;
	bh=q30/sl1w+556LlTTLb2TQtU5dc/phZU2a0uxAQId8bA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCA6Hk4b7ENlFehIB/9OYkal4UMNRxTM9uI3sGsuQOMZPolPmhHXfn7fRmbx/zmTrIjxil5TH1Z1R/T+xSn4sGCez8IE+82cJSKdl4uWT+NPxR03IQk890GdlHjPVlGS+zxFbbY0tUg0rNtfytBtbwHYKGv7b335ZS1GXzE9vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=llN0IK87; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZE6bGo1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="llN0IK87";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZE6bGo1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAB3C7A00BA;
	Tue, 25 Aug 2026 12:19:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 12:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787674773; x=1787761173; bh=eNQbi0Lt4b
	ud3Bt0Sspquo8VJvGuxDzNVW4lFhxSsYc=; b=llN0IK87szVAWnlIhQUsjrNttD
	BF5KKou74LA3iIQoGmOv1MnigKgObB3PcTcpRTE+AlKefNuhnKPSZaxMlTwjaPq+
	5uV8TNrqhOPOrh6lNDj08cMSY/CLTGab/ps/yYvxtY8nm/+TVjsib+sJDxu32a47
	M777+yP+A+AkBUeSNygHrK5oSjFuDhA7vlnr6Z9nen/q5my8TyVNv19M6eoP6Q3s
	pVZvIoCWiECVKcbPRqqHOuh5tudHQ7D9fdjWgKB53XvvIQ9UWBoQOEcXv8DzdvwE
	6EHCWbZufgkdUeZgoe/9DeEaHbpl2R33rtynWogjDfwH1IvNvj1SrgbAHFeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787674773; x=1787761173; bh=eNQbi0Lt4bud3Bt0Sspquo8VJvGuxDzNVW4
	lFhxSsYc=; b=aZE6bGo12x9uJpPAOaBF+dxmNYxHJGzBdVop8s2so/OAtnoAkQ0
	kGHvYORoacpdOuJWvuU7gt29HKv815zn7mXWC3OvgqpDZU0TErnoCmfJUDLrDFap
	MMtA9rkEwYQ24epJ7tqLrdujdxqkAfoAZ7iWNYTajW71x4kPpUE2+CDulB1+/YX9
	QuTpOfJptcH3fOJIx6FyfNjm9dcP4BckRSd/BayZGbcP9003iNmXLCKdjK42Jz/e
	J9TpHDVdjvJ9+Z4wqihChvvaz+AbEZR2sc9r/iAOWCw0VLE1dauDz8X+4HC1yr3g
	TSmyoHbYPDegWM/AH5i9qP4IphSDlqNUQLg==
X-ME-Sender: <xms:lcCNamJTWLuJ8vKsEO9sfUiDWV2SpcknGDIOLCgKgKUKIMU7QfGEpg>
    <xme:lcCNalmEr6vVE2qvgcwmizJ6qNJzX7_VAI9l1hWcHf4HnlV9MeXarlZdGAlp0O2d7
    TdCHylgC4Hgf7EluLe7W6j1ueLuhMATRqPtbHf-k1gkXc-vS6bQKw>
X-ME-Received: <xmr:lcCNakFYLS_0G5is8s_Sc2e_60Q_xK5l17QLvzkex8Aq8gAn3T1Yzg48x3IxueEc-UT14vEAbqgOhMs3J0tUVN94QTd_dslNKw>
X-ME-Proxy-Cause: dmFkZTF3tKLUxJ5eeBEGXHsaXQRiZWgUTLkeDQNC24txiLAIXZ5V4le6WH+ABXyrs2Ly5o
    0Ep5e3Krn9+HobyCWPW3uGn0OyaqyUfkw+HAxSnWcE7mEMWDR19CWiJnbR6r5Uh3iolcqx
    zVKMvMhrtn3uq5oDx6XTn1Jc2hmziWpqr4rZQ2Osw/A/CSnBP0r9KtQZu3CXYHp/7KswgP
    JbUUwDHZb2/hxQydekW4qTLBG0rFnPMjvSqMfup2+3H6mDAPxzLpQpCut8lfF9vQNx2Pep
    kn8lLMsJzhmI4zTAp7CJJSRwPF1gi1o2MrNHFnDkmw5Gg+TEt02vBl2LStwMkozv90+SFb
    xuhqHv2xGCQ+cQJ6bmEbQVCdCa36GAxnUt4+nwO6DDYFXFRfypEcfmbb00ReyQ/0oA/IbH
    4MQK0WRyzTpuo4lXbAF2iezHWgcTvzN217fJvyfyqaVmOdjGLSt67eTQoWAPKsZqni9sZp
    yb6YuSljx1wQbAP+ft7HDGwhXUWCDdAmlfuhTeRtaFTom/S8RunNzVqtQrqVUQV1uEUPjN
    j8reuVT/ug0UK8cGsU32r2awKLkC78o22ElyjtMhl/o0yURNTtXvsBCO3n7URx5uSeBzZ5
    85hROa+cCrNa9i74d/WsCk+YsSqYD2dbr61Z1rmcrn4oHjTym6NwIPgOkddw
X-ME-Proxy: <xmx:lcCNalF9T3ZZiWMvzwPkAPhYdInDjq9JMXPFFLiMEe2fccGOIHeGTg>
    <xmx:lcCNahOdfPnCMAkY-z9FYvWUei4_kOGhf99v6e_xgaaFDZxxWfti9g>
    <xmx:lcCNakF0Q4GvkT9i0_y1A1cs7tq5urm5u-kWxu8u4rGKkgYbucpvHg>
    <xmx:lcCNaoPv6Zumdod7miTeJTrpFFBH77fM22x_99es_4JpwvS_-Dei-A>
    <xmx:lcCNasw1hD1As83eY8KUY2hkbYsoTjfIZ3TLXQi6gwBjJA1nXylJNN6w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 12:19:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] object-name: use hexval
In-Reply-To: <20260729233215.398654-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:14 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-6-sandals@crustytoothpaste.net>
Date: Tue, 25 Aug 2026 09:19:31 -0700
Message-ID: <xmqqcxv6npf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We've open-coded a different implementation of parsing hex values here
> when we already have a perfectly good one in hexval.  This
> implementation will almost certainly be slower because it isn't
> table-driven, unlike the other one, and since it's not constant time it
> has no other advantages either.  To tidy things up and prepare for
> future work, switch to hexval in this case.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  object-name.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/object-name.c b/object-name.c
> index 83efba0ba6..d2d81b3511 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -236,17 +236,10 @@ static int parse_oid_prefix(const char *name, int len,
>  {
>  	for (int i = 0; i < len; i++) {
>  		unsigned char c = name[i];
> -		unsigned char val;
> -		if (c >= '0' && c <= '9') {
> -			val = c - '0';
> -		} else if (c >= 'a' && c <= 'f') {
> -			val = c - 'a' + 10;
> -		} else if (c >= 'A' && c <='F') {
> -			val = c - 'A' + 10;
> -			c -= 'A' - 'a';
> -		} else {
> +		int val = hexval(c, HEX_KIND_OID);
> +
> +		if (val < 0)
>  			return -1;
> -		}
>  
>  		if (hex_out)
>  			hex_out[i] = c;

When hex_out[] is given by the caller, they used to get a downcased
version of object name.  After your planned transition to forbid
uppercase hex, they will get an error, which is exactly as you
intend.

However, during transition, they will *not* get an error (as
KIND_OID is still KIND_MIXED before the transition), and they will
see the hex_out[] filled with object names in the original case,
without canonicalization that the original code gave them.

While seemingly harmless, because repo_for_each_abbrev() doesn't
seem to malfunction on uppercase string metadata for
disambiguation), we may want to mention that this changes API
contract (until we forbid uppercase input altogether).
