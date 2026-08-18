Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7F37A839
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083968; cv=none; b=RsN57g6ckDDw3TYgoe5mkJsAWvrwkuinxvZMmZrUDuGeXTdy1OkWwFKC7L7slqUmJks5g36TVmgmbNiVNqMsRrHb1GHr+08Ul8JwF71Gmk5aGNFU89UTpt/8mnONWvU3AwHrWBi00dz82t9yX0lEmoUTluRQ/ZxVli80Cn+sVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083968; c=relaxed/simple;
	bh=l2lqn3KEvqyrbkpuoRtn5hI/zBHMpJwahuZYpVF+dP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0wD/vc2P+go336qODdBxauEHZNNIOKXd338boai9uFZDujxSNSjD7NDO082njpI0//+cmUrgOKFDNqDq0QBTPda/dUmjsaAyR7KrcsINyaOKLHDWLAygt4cBRZzRJE7k1MlAxlxx2bVmwO9XoeL7wdHjmIcqwbIc1ZLYKBbdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mUS012qX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JU6ozbqP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mUS012qX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JU6ozbqP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1EEF1400130;
	Tue, 18 Aug 2026 16:12:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 16:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787083964; x=1787170364; bh=eCb7rmBlFZ
	oNIz3hoOx2yCT0LI9bU7yXNYgwJAEndSA=; b=mUS012qXsSJ2yFp31LJQxdQtT8
	0kQlL0jya+Mfebcr4oO4QLi3MED//N6o5qHocbf9Ar+HVF0kr7aotpDcd+jZglPC
	LI63NscZeYv8684jtHacNDzpR+kwyf8a66VciIQR8AsayC4q3z/BaGhAVsBB0WyF
	xqcDyvQjzliF4rmNmgLUoMF8i+EZIY5123XtFcKR0krldhBsVzTSSFwWKkX6ZHK+
	DVCF9YPRfKobm3mrGzq02/ug8LwG2IW2qM/vsAcBt3E5LeATTm0scqjRjR7ts8Sm
	CIe1JqkLawya9HNiMiViPt6r5V+Caz0JVzQxJ1CSd/sMiQRHyUZHkBrN/8KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787083964; x=1787170364; bh=eCb7rmBlFZoNIz3hoOx2yCT0LI9bU7yXNYg
	wJAEndSA=; b=JU6ozbqPp+Q7psNnUdqmf3R45w+sRMOdAWNeO2mQp+ypsNsh8Jw
	WWQ59aTOXGHqAPIkGpdPcnP3jf91pA/GgHczbkC01Zk2MLtR70MoxaboHGLQyFeu
	7YdvH7T4mP1+UZjFjrbCzrWmAV+MVEv7AaCB8EIHRe/3wcymxpZjoU9LpDivVZ5z
	4PrBen3d+D9OfLADY0ZNGCnL8qUdbHItJBsZ4g/svNdjiSP9qifWUV+CxsvcQZnY
	DU5erA6CGGd20b9PeNy+T7/L5SUYQhQUFhGcjHojOOb/LEXqUqFX4rTkyRgZFf4J
	zd4PxuWqHRcHUar1rKcTPJqGpNJ8Sf0FrKQ==
X-ME-Sender: <xms:vLyEar3rFon6B6g39UHZ1IfYi-7YSCdVuAleqAlP4L0fxt4xd5TjPQ>
    <xme:vLyEatxuOybB9fPYa6ItRjN4yQ5MMYxegJFeNyn8YBNEj01f-549zXOaAwOYhj-e5
    cekHiq6rCrD6XoYbAR6XdOeNF67d-8NMupilqRMoMv26pFHBcRxUg>
X-ME-Received: <xmr:vLyEals2e_BT_1PG-i938QdGHSqZE-lSQ1ckBpyA7Was591qUFshRwch1y5LAml2olLScR-22bMX0BToVw9r4YWT2MphHm2RuQ>
X-ME-Proxy-Cause: dmFkZTFxKqGxojR1Bh/7/iMap+Qf9vBsltK0ZmTGvY2RMulVKbJJp5KctNNO+cQAZPPFIC
    tsiS0A35gy5Nkaa400njJSyGiFM2TYp8TgULFDK37+y4j1xIHSSIU/V2R/qdWiqnU4K9Sz
    gMxu3TN+TlVgt9dw6Si/luckwemuvpAWz6wGInXWeNeOpBROkKdmJtLar+FcHVFRhYBzGZ
    N3q2y5XbT1piHOJ9+8to1rwQAPBzKAqcPPh/gYcQBGAjI3ANPP8g/LuyrBaWfxXHFW0Nnt
    aEAzEb+gr5O+a9lXW12PGlp3jRDp6Riy8QDoBpt/IQHgKQB1fnHNFjDgsmpUnumbGDyoVy
    ANor1myOuhvc9g8FS4rM1XFqC8+oEkPZlCltdfTcDaZ5n5qxtXgEox4/+fK5e95KLS6Lu7
    gndUDuogBKIkazB3j23Tt8FSUhTG/fpfkOfh3hhzxJdeMP/ZMTKhNRtGoRyliCtrLSTFME
    DFjHr81Ihz4kTkXZA35WBuUBoUgZwnXEzdaDcgh/j6Ja1lIP4njw9XiCAja57bq/0pRpfm
    TjMeR5h0zDB+2kfuAAlnY4L6yivk6HkQT0K5lUzYlQ/tr27cn+FmMDHCNY1xwO+xrQQn+L
    i92KleUujz0Z5gE+IgOVFeGKiR0//XJDm7BEO7pAgHKCETStgZcEd716jVug
X-ME-Proxy: <xmx:vLyEanxWHQF2wSxlU9KB67vwhpi6NQQW0XFoLbJKs0b3cKDGj9QeWw>
    <xmx:vLyEagAK930AdoXHtbn_L9yltqCHBXeMVRsOSTTa-N-515Yinj9kLg>
    <xmx:vLyEatdgW1xAiKDNtRIyt8bZpsRtmOaD-FY8AXGmHppWj7w281VEQQ>
    <xmx:vLyEaincJTKz8kk8Ze2SJxExEFl1idfRxDfl0r99npq4a4gUlFAxRw>
    <xmx:vLyEamnedeizEchEHA7hrBIUbg3R1FRhcfXv5zsNGYP03eRHlWCDPsHw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 16:12:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH v5] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260818193710.56955-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Tue, 18 Aug 2026 15:37:10 -0400")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260818193710.56955-1-ggordon@gitlab.com>
Date: Tue, 18 Aug 2026 13:12:42 -0700
Message-ID: <xmqqo6ezw5l1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

> +http.sslVerifyStatus::
> +	Whether to check the revocation status of the server
> +	certificate using the stapled OCSP response supplied during
> +	the TLS handshake ("OCSP stapling"). Defaults to false.
> ++
> +This is fail-closed: if the server staples no response, verification
> +fails. Set it per remote, e.g.
> +`http.https://example.com/.sslVerifyStatus`, rather than globally.

I do not see us describe a knob or setting that can stop the
operation depending on some condition as "fail-closed".  Can we
rephrase this for regular human beings?  Perhaps

	Whether to refuse connecting to the server when its
	certificate has been revoked.  Default to false, allowing
	connection even when its certificate is not known to be
	still valid.

or something like that might be a good starting point.  After all,
the "check revocation and/or validity" is *not* the primary
objective from the end-user's point of view.  Ensuring that they do
not talk to suspicious servers is.

Thanks.
