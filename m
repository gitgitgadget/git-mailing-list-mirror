Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B043CEC1
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460464; cv=none; b=RhrJMb35zbQe57MwyPUyTIodwsmERDzjIQuzkfw76aeD5zF5aOzZIa/IQVpwvrnMihnPCqNEdaV60dPUi8FK7ilHSeEbydaMx48YakcYMhG8Msdqu9/NeqMPYCHhZmMsE2Q1Or328nVnX7M5jcvLv7VmjtU2hC6KNRH8Qfshp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460464; c=relaxed/simple;
	bh=njhKyWiGESvVcYFUrzOU+ozJjuX8dwvwwAb3/hovpvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRZM62RSLjktu/wmSuIWQrLey6uNaZenswTW5GfP40YxmWranbS024izxw/weEvBXGmy6CSU3rQDifj8whIRQw90lZAF9iB6tzsu5Ps4m93KCUYozmhp+xtPLh1zBEPEAxP/ie1TGNFVs9AT0JfSzPUmWhRumhBYwSYg0HX91j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oVOc1O4H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oVOc1O4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783460461;
	bh=njhKyWiGESvVcYFUrzOU+ozJjuX8dwvwwAb3/hovpvI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=oVOc1O4H8u91bVlsX2ejJjtGziSNS8r7IaRFAo5zjdeIsblmqK/rlRS5zqzwGLZ+c
	 bFi0hnV6cyrnYU0puJtPGD+ulAlmPSLGiBxWc3FlLDYa7hYpbAqgbGRtesBZbkWNOY
	 sBJmq48AEgelnSwQNL5mgrqqVIWifPDNz0lIJjv8KHUuiDg0ysVRW/F1B1LkkLLatV
	 2xsCg/zsP3RN+QlwoGOCD65p3NimAqFS8Zbd3vUQ+7KcovoUr8UayGneMhExEzu450
	 CorJTY53OXz7jSigNZR2DgsEByfbpusIdCMHWDz8zzISSpGX8J0blX9IR7gXXE1W/8
	 C9HTstC6JOt0xri9GuYZEVbdWjz1AQTdbxczT1sXnWIuxoO9djOxFPeknrMR0wDECc
	 7X7h2EkG68LQ28MFYNDQ+8mP5qglx09lRrTzsQaZjw2U2kfqSrvQi7YyqwDqRDPXJ9
	 8Aa69g5zhhMrpqD6rt7GePUXKlhyebLI3WOhA0CSMCqHx2Bjiyj
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9470:51ef:86dd:bc22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B798E200B0;
	Tue,  7 Jul 2026 21:41:01 +0000 (UTC)
Date: Tue, 7 Jul 2026 21:41:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/7] hash: make git_hash_discard() idempotent
Message-ID: <ak1yazHtP_OazDaO@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050700.GD1288294@coredump.intra.peff.net>
 <xmqqqzle7osz.fsf@gitster.g>
 <20260707201808.GD11780@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BHMe+p1g9zFPdg+Q"
Content-Disposition: inline
In-Reply-To: <20260707201808.GD11780@coredump.intra.peff.net>
User-Agent: Mutt/2.4.0 (2026-06-19)

--BHMe+p1g9zFPdg+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-07 at 20:18:08, Jeff King wrote:
> On Tue, Jul 07, 2026 at 09:22:04AM -0700, Junio C Hamano wrote:
> > But the change nevertheless looks mostly good except for one "hmph".
> > When _init() is called, active gets turned on automatically, and
> > either _discard() or _final() turns it off.  Only _discard() is
> > protected from getting called multiple times.  Is this because
> > it is already a no-op to call _final() multiple times?
>=20
> No, it's a bug to call _final() multiple times. See my response
> elsewhere in the thread.

This is almost always the case in hash function libraries.  Let me
explain why.

A context for SHA-256 contains the 8 32-bit words in the state, a bit or
byte counter (as a 64-bit quantity or two 32-bit quantities), and a
64-byte buffer for unprocessed bytes=E2=80=94and that's it.  When finalizin=
g a
hash, you must always pad with a 0x80 byte and then optionally some zero
bytes, plus a 64-bit counter of bits in the message.  That may result in
one or two iterations of the hash to process the remaining bytes and the
padding, and that almost always updates the state words in the context
in place.  (SHA-1 functions identically but for the state size.)

So if you call the final function multiple times, you're not computing
the final value the second time, but instead trying to re-pad and
re-compute the final hash value, which results in a _different_,
incorrect value.  In SHA-256, this is a valid hash value for a different
message (which is the original message with the padding and length
tacked on and is effectively a length-extension attack), but in hashes
that don't allow length-extension attacks, such as SHA-3 and BLAKE2,
what you get is simply corrupt data.

So most hash function libraries that allocate memory are going to free
it in the final function because you can't really call final multiple
times and get a sensible response.  If you want to do that, then you
need to clone the context and call final on each context once.

Our Rust code makes calling final a second time impossible because
finalization takes `self`, not `&mut self`, so the object is _moved_
into the final method and you no longer have access to it after that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--BHMe+p1g9zFPdg+Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpNcmwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxxBVKg773GmgPgK3Q6VJCIoWdUg5/CeTFBwdTwxgksS
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIrOAQDafJ8Jsb2JRtrseu+VBV0io8ag
8zQuXb4AEr/kbK3tXQD/d3s0WI+/EYxsMIykhDKA7I5Jq7GwQyZZEDwxo+QnGgE=
=qXhP
-----END PGP SIGNATURE-----

--BHMe+p1g9zFPdg+Q--
