Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC13F0747
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589946; cv=none; b=ovfaAg2xhrLtaahHalAVXEFDqWwxvJhYoCA/w8mezn7ydVi8aHVoEttKa5fKiRMM7uJ7NusSBC+LpDkgL4zNx4Mb8ISzaal9oYAdvIg/DWTZxduVMvVX1vG/+ZpFHZl4n3F6vHgFdBArMscefMNU/cEb0nSl997E+9Y7tAs1Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589946; c=relaxed/simple;
	bh=A5TPoceuZkK4ebGSqHrKq8pIqeQEb/+zDhlwsWJUf4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLwbSHzzy3tqYkC5r4BwK1x5HwU6/x8uwb/3otrMI87Jzs9h5wNaHucQrgZNmzpoX7FgdzVyNBW/nobfmw0njv7Uc1ok83kFtOjkztVr7zv3mb+clRFTYX3duq7+PyRDoc3oZ3jkhVXMvMZvxIF/IMz3Ryo6s77NO/iD5nLwIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ipe3zS/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0qn8PgL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ipe3zS/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0qn8PgL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 78EE71D00065;
	Thu,  9 Jul 2026 05:39:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jul 2026 05:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783589944; x=1783676344; bh=Seyd/PEY/g
	AGqH/g8dq9lNro5YUOENI5GgcE4fj8u+U=; b=ipe3zS/q9OTJ+oI9OVSokh2Vgl
	q5qnMLyGclOZHrhLSbO4Lkcyfq1EZ4c8XPJ3Zbmf4vBqVVkIO8eLi8q51tkTHmt7
	hw+w7EjHx5k3dv481kQoSFmNau7N9KqqUzIy1+E+T6kA3xB1381FaJgyS5aI0F4P
	jfuKbSHNUm+vwj+U4lXHmvCIUJDNwuWzkrjhJ4208T5ZHtYtwQSS7R+cSO80xluW
	mgXN4ZWksm3GLSVYd0ZecfEgL/W8Pacn3PMsDT4kTv5NkOTWBksJQqRIaSV8fkew
	pkLh2nwq5BQ17K6zOLEpGTMNWarSf3QsvBNxSVK555S72coLME4cECEpc3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783589944; x=1783676344; bh=Seyd/PEY/gAGqH/g8dq9lNro5YUOENI5Ggc
	E4fj8u+U=; b=I0qn8PgL9Me7Z7qt30arJeOCe2bH7FNrkQ/FcM7Fdqs3qDBkcna
	YvY0/FcVr1VzmjBY0NxkIJaNW09evz5e4hAIzN8ZE9TM6AP8YhVL62wF1vvOSzZh
	iglPp0QotUTvs4vlVEQAigfSWcPpqHCxmorXEONzspfKTN3hvIRA80s32SeDgYcz
	B26yumHQZmdEZKKCIH46o0t+HejKp4fpKKnkAmCIRiKGHb1OJy+/fVv6QN2REjAD
	CCwGArW/+QnyjYCa3xbSW9sSBpEw7Oc3SRdPJfnAZykwOu4DvEIGkhtwMGpBOfoZ
	Hqz6WkLIzEaqSPLclI+EM8gicYp+HN8Oa0A==
X-ME-Sender: <xms:OGxPaiQbL5GF8qKa-_jAQ1KXIeVQKkvmNaRncgQmI6zzlOijecoeMQ>
    <xme:OGxPavPdchINmwlywchWehtrzJUj38c3iyYTns5Y54Kj7_PHZkXq5Csjfzs1Nwbxg
    aLezdC5VAPxVynVB0mavczKRyMnycvHwEr-CdY9VrA_9YfUStRHhw>
X-ME-Received: <xmr:OGxPatPa0pgAWifMVTV-1okBYwmff0MPJ5isUExJTBtPg8Ya5tKp0BOGVvexJJYFCWfBbWiH0rSHg5GTJmWF_4UwPofhzrgUFGjUHDe8Ow>
X-ME-Proxy-Cause: dmFkZTGOksP55TLb5CHg9URKxxuvY7lH+GhlwrLgHsXqB8dwyukKEnjEj+gcaOiTl1B2WH
    LFnhZR9I91NnvKOP8+89jTgXKAcvDSBUqEDlIDSp25rBT0yeVMWpiYkMXPFnvC0UHmdVgG
    fccZXeys19ofZnCc7dC9ooZ8YMaALHMiC0FzhZufoN5oDI62RrxpEyBZECSYtxA4Qr1Wbv
    K/6RT2lfQU4VmBPeDrvlcSaLzIoi+3DO7qJ8q0dNeNlJslknbfJNre3ZuM/FNTFf9IR3RZ
    avgibVN73JEVvgSwlb6QwLJxeO8GZ1inVGAoZk6TYqApqZms/6gQ4Z2t+pGbVNH3/8xKXy
    LRL1CGdhujjIRZ/XQDoq3hVJcqeQLo8xvFcieC8IDvyhAIxFAG37IpPfndn02sN1+DPGor
    Rb0L0KA0YZtVtibw+eG8uU9Y1lGgAHIKS3yYft+p9bBflb7I0Lj8MJPBZbqsA+OjRcEdkL
    g/UVSLXQr4SKdfcPZI/yEUwyfHrPIgcsp5YkV+i7sLa75j0w1KObK1SEJytloMMXGBRz5X
    mtmHP9460XQYF/3LU77kCrr5Ugx1VS9w9vKiyHf2H8ZAmSlCDs1jLoBmvn6QRIqHeKkezG
    SApDM8asCKb8u2awcZjnRki1MRvWdghLjTXBe7OOnVhOG6EE74sSV0CaaU7g
X-ME-Proxy: <xmx:OGxPantBrx8ZvAHaoDByXvixDqWlyIs21m8WACPYxo1vi5Ljufqvrw>
    <xmx:OGxPavXeOGQtYPbhykZNAA24cEO7Qc7No_hgC5Fu7HPKMsbsmaEVNg>
    <xmx:OGxPanuN9M5kR4Dmy32l6Brk-MzSiGGThjZv7-NtgAvxmWiLt2zk8g>
    <xmx:OGxPajXJc1r9kBcj0q3-LXK48n2UpkqmzrWZP_RtNs3TGNc_vdvsoA>
    <xmx:OGxPavNV08Hra-yTEOPnKeI9IUzz9AVNNGVkb45uh_rU4_IyJVJwRZK8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 05:39:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d45c2a87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 09:39:00 +0000 (UTC)
Date: Thu, 9 Jul 2026 11:38:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 03/11] object-file: embed transaction flush logic in
 commit function
Message-ID: <ak9sKf2miKK_PAIf@pks.im>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
 <20260708235925.3992097-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708235925.3992097-4-jltobler@gmail.com>

On Wed, Jul 08, 2026 at 06:59:17PM -0500, Justin Tobler wrote:
> When a "files" transaction is committed,
> `flush_loose_object_transaction()` is invoked to handle performing a
> hardware flush along with migrating the temporary object directory into
> the primary and configuring the repository ODB source accordingly. The
> function name here is a bit misleading because the helper is doing a bit
> more than just "flushing" the transaction contents. Also, in a
> subsequent commit, the transaction temporary directory is used to stage
> packfiles and not just loose objects anymore.
> 
> Lift the helper function logic directly into
> `odb_transaction_files_commit()` to more accurately signal to readers
> the operation being performed.

This line break makes my eyes bleed.

Patrick
