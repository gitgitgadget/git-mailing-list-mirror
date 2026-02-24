Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2A33A70F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967468; cv=none; b=ma2z6jobhvaVeszyD00pQMom9RVC++ekKZ349DbrvZmYuYR5OMGJt37haFDoN7kslWSErLnym0SHHYxpByw6Fj2UniA3DzvVDHMmYJRGQSy8mxo2RzprMN9tIhNY+a0YcKiZFzL231jtxvWf8SJoAVIxUgGVQCUutzzqVUXQJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967468; c=relaxed/simple;
	bh=YmpbC8qVJcF0Oaza/61H0sfjdyXqG0+WNfsZ37b7Rlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rk2Z5EMNM6cqLurhtiDZECSwLnf8m5Hb3DtzsvYFaz2Qs94X4GVtGPr0UPYTBk+50MV53vwD7E8V5+qWFpL1nhqmoES9Pdf9bidoOyVz+GZ0SXn07mA5+e8WgTIptMxC0zRrwFDcLeal5YTbPGLFDWEdBcpAJYxEGGq5zHLVogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YPYeQRrw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OikQYW3v; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YPYeQRrw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OikQYW3v"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60A567A0185;
	Tue, 24 Feb 2026 16:11:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 24 Feb 2026 16:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771967466; x=1772053866; bh=hn/5U8ifH4
	n/HWIyRgViDjllLUzB4ArMvO37H/PkO2A=; b=YPYeQRrwm8uNeboei467iIOoeu
	jF3Wg1ACi+XOK28hp7BlH6shqFDxwC/TOgnbMJWaG9e+8J6C4gREWN20rEChdfN5
	53QgNYOnbt8g7cJ7HtmEbfRlPLLPfmdhVbKeA8Sg8X8peEcCOUwSV4BXRbHJov7k
	MulKkUAsXncFw3J5Rd7FdsnaQ3exzwaAQiNu5C+3eqwY6R3XT0DdB+kQ5bhzBrMv
	cqTbqrl72nXd0xvM54H6w3Lk+I76zwVqk6gUta7mUOLTCTd/KTHFanE/le8B/aoY
	9sYbnTwqZDtOKdC/oZapuJqVbCzuljpBgYPPOyxK/GOi448kIYL8PDD3512g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771967466; x=1772053866; bh=hn/5U8ifH4n/HWIyRgViDjllLUzB4ArMvO3
	7H/PkO2A=; b=OikQYW3vWcqpEz+hvHUIjg9XuDDTX3zJU0WNUWizaLAvfNFbHp/
	Cb0+oq4dR21T1XDi37AUGjYWq6599KHYmiyPxz2Rom/B/ZkZYVPlHrFLboDR3G2C
	NQsXtp8rXIKXWvzJLOe3ZXxq72GwYQfLmHyO23x3Y/jpbWjUhjt5kYZkkeq/y2tT
	OC6vMDhWjtRnLfXUfcorIqMfekgDed/fggwf58i0CAmd1zqMjSjU/4/9TjolhhoB
	9+KeY+0wzJzhvRzHfGxq+DCz/3rAaa6C7evmbqqeZvrexpkGCIR9D7V/NqfvmRvK
	RbT6SpHTLoOTYn1/j79V1DIPYUlFR/mKc0g==
X-ME-Sender: <xms:6hOeaRh82D5w58TjvnuoxtEExqYCbxBm21Pd_Tazmg48kmdkvZS35g>
    <xme:6hOeac5M95KTrbAothFkQsbI7L6PB8Jj7g864Tj8FR_tFxdDzKG8C06QGZDHN6Ubx
    WTpA7wuyrEgp7A0KOUZjlkrFsfz3sUzfW0GlgJFyKquDEPMMXLCJQ>
X-ME-Received: <xmr:6hOeaZZaR9cBcSbtJXsvgakliNhKmsXe38zq675OvbK8cAXFpRpwrD7B8TmRLeD7QXI-gD-rtjANayVVmMKuY-SM6i4Iu9bIoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhiphhorghklhgvhiesihgvvg
    drvghmrghilhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6hOeaR6AreDbzaSL5MA_v8wBQNYORPuc9IUXwIDFLU-vv7-dEfeCeQ>
    <xmx:6hOeacA9uN8_CAhFbFHK94F1iGQXsJlZtmksqab7Yw8up_mp0mh_Yw>
    <xmx:6hOeaXck6Tnjy9u0jc7UIx_eygHy7l0aTjnsp_MgsIGiXfYI-gMvpw>
    <xmx:6hOeabK49ETOhLhkXCm_i0Anetgsjty6LIAVwuyiAim1TMBKhp3LEQ>
    <xmx:6hOeaYQfxbVFClQkSNCl0--y1Xl-rHABoeBB0Y7SuZY8GRji9PyRsqfZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 16:11:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  philipoakley@iee.email
Subject: Re: [PATCH] send-email: validate charset name in 8bit encoding prompt
In-Reply-To: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 24 Feb 2026 20:03:52 +0530")
References: <20260220145126.131651-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 24 Feb 2026 13:11:04 -0800
Message-ID: <xmqqbjhdg847.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> +			if ($warn_invalid) {
> +				if (find_encoding($resp))
> +					return $resp;
> +				else
> +					printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
> +			} else
> +				return $resp;

This is not C but Perl.

 git-send-email.perl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git i/git-send-email.perl w/git-send-email.perl
index dc4e5418d3..15387ac377 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -1008,12 +1008,14 @@ sub ask {
 		}
 		if (!defined $valid_re or $resp =~ /$valid_re/) {
 			if ($warn_invalid) {
-				if (find_encoding($resp))
+				if (find_encoding($resp)) {
 					return $resp;
-				else
+				} else {
 					printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
-			} else
+				}
+			} else {
 				return $resp;
+			}
 		}
 		if ($confirm_only) {
 			my $yesno = $term->readline(
