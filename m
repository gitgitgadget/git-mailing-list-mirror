Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3A18DB01
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418365; cv=none; b=uhNaLSMLJlHuc99xpb12QY0nLHRPnEy7Rg1MLLrGe56dz5NjKJBsVvZwubAmuQ6uKE31l95AMBmQNEStBwCRnyD9huC6fMad3qJtqpROjkyA+YcS0QDkfOF4o0FDNC8es7qFHXCVwdk9vvPO86D78Xog0vXjlHilwgwK03Ou82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418365; c=relaxed/simple;
	bh=bWWXlfqDSWtWuLJmKNLTfKs/9TOT2IcGB9GzW5Z3i8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A7k+bdT1mkevnUyG/VIUwr9PPsLoAm3J5YfPaezSVRSgSEGIJh5q7NnOWC10IppbJ9L4oYmovwuaEdEsKR7gWkjDPcDx2z2VO3xJVk3I2NJrTgxz5AA3WZ88ofVCgfGp6kc6sQURGpV06s60lBz7q1Fns9/u20WJgwn+fPhFhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bfEyTSS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdR+BtIS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bfEyTSS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdR+BtIS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4AF54EC031D;
	Thu, 25 Jun 2026 16:12:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 25 Jun 2026 16:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782418363; x=1782504763; bh=XvIGzrVYnY
	59ZcNFReTAhGLUqkr8v/rSxsPnGsSRUYk=; b=bfEyTSS/u0NKUuydcetXU+PH2C
	bQPRSPc3DomujX7AVQ+0bCz0Ur9DZGgGTegTSLhfSHLzMPTZTijWbn6jYBmtGvJz
	8z5tIheYAAA1w1AMATcs1ECiP8RTrqbwXK6dEHAnrHT9WPZXL9IUebv+h0IKDWVc
	p2RY6ih+JAxVLEJnp7q0IniN3bfASi/amb5OnoTmiJRyOVGpEVbSaJVFfeEEXMV9
	QPwjlAhs399E2MCw5rYNqCyqpENYzRV4vQs1IWQnT+MFCvAYO7YKceiAEwBcpQS1
	Bx0Rq9CO5TyRpiS9oAFlH4EiQxcBJhlLdqfx58PhvXNUc7HhpTTLQWaFMLzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782418363; x=1782504763; bh=XvIGzrVYnY59ZcNFReTAhGLUqkr8v/rSxsP
	nGsSRUYk=; b=HdR+BtISbxt1H7NafhQOnpGUYmoFHmsuJ8NReOgoe4YtSBvirij
	3u67d2u63KG1TyGuiF+1bb8KAzQxbjs0PgFSyT5FK2inj+Rdq+JwCvLRlovsWEz5
	rFEEjLT/JarN8+s2mYCZFdbjWfgC9p1idCL3qqyjxEpK7vK/q6yRDArDWWFjQUnE
	PdGaunDS8H9l0SK0DAbQ3wanoota3qi6EBBva1rC2Vb8KRr7cTJv1S0C1lLngj+D
	rj0lnOKC4CCUuNosTdrlSE/bmYGYibJNhQrfYyPYCyEbv+PpxkcvLYU9sEKPdbF6
	I8tIMhutegclTqbYxiTk48a8NLVm9Eb1L3g==
X-ME-Sender: <xms:u4s9aoGT019MJphlwVYBTjj6pEdjCIrIiCSx6XsnuUu6EIcLa0qM6g>
    <xme:u4s9aoOatNeNNDdyTFs8jNIsR10KwNv1gxMz4lSGrFA1-FAqSJpkerA4dt48CQeoQ
    8de1ZT_PzONU0ca7YioiNg0plIUg4mqATFAQuu3jodUUjD69MQNYso>
X-ME-Received: <xmr:u4s9aqcOjshx4jSTHJ1MkHkeLkethZb8C1c6b37R_lyxBcbZqYAas656xcALHf_KMyINtD1R6a0jlWY6BfifSt9SkHRhqJwQq7UMW24>
X-ME-Proxy-Cause: dmFkZTEAg8vRifYAF3AxJ3p4MrFK6Qcz13YBKyLeLhWJBZPvoPPOiXLcfOyV8mR0T8I5/9
    GaGgdGQA7UWTvMLi3E18jNdKT5sOkSaMW/T/fDrm61d6v/Qh35+lcecbBfww8l1ZdpG6/j
    WB55zP6JJxpVOx9vgwx9RWe+hcaLk9NuU1LUTWxdrzyHe84AdzgLOjJd2bA3fW++wTD9Z8
    ZI2prSNeR8U8EFexAkGvGrQS4H2FXVj7EzO9KzF1QyQTPTBs1ssZmpdXYHuOX2/w/DIvwg
    Qp04dhoubK6xUw/UdVVUrQWQHok8QsIkuxZiRkr/b741fQDeNeDsvBBVi0QZvJ5Vl2i5eL
    GXaFS4Slh0vTW6u1P7ClSN2c6w8LGQvB8zu/r0OjXOp/wD1KI4PCIzwwxJE21AfhFnr+qA
    a+WD23ZH0XpcJMpNX8wvNjSyMRtZg2egxUp8JYWoTTTSYR6cpa/Owv1fy9BxHRHmmHfUIf
    QNVUhcPYZsUhRjnuEELHeSxz4aGjoiAf+tHlKc5n3aPbHoRJhi3/IqfP5QavT7vNi2hrgR
    H4lW4MSIByTgavteqIM+xwdxFij53VOY7Z/iJuOnhjiYOttajwOp/8syCyuihqrqCcVVzF
    QukxdDKq6cXJ/rfLJVWS8efSYJVjW5g4YJU5HR/XViPsWyrT2x4YUWOO/OUQ
X-ME-Proxy: <xmx:u4s9altxO9_bJC1R45TjFkM7wj6Ca2UDNX7R5ZyAgEwJ2AgaMj0fBg>
    <xmx:u4s9arnCIBPzsVtLcS9OOH1S49vLkEUCoNkJH5DgErG1Ye_flvGeAg>
    <xmx:u4s9anx4bYim4YxGlavBEKMmnvdfpn_fcF3JwT1na2XD9KKRjsM1wQ>
    <xmx:u4s9atP8ZGFoWFoyZk-CZUcGQQnBTTAn8yCDl1pPa655jk2aq8uYlg>
    <xmx:u4s9akH4-9ZRiED5Gnz_R7iE0w4sFSRO5Gp4CouEMGBlCYrgl9P8OkLz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:12:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re* [PATCH] history: close COMMIT_EDITMSG before launching the
 editor
In-Reply-To: <xmqqh5mqfkpv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	25 Jun 2026 13:06:52 -0700")
References: <pull.2158.git.1782412427801.gitgitgadget@gmail.com>
	<xmqqh5mqfkpv.fsf@gitster.g>
Date: Thu, 25 Jun 2026 13:12:41 -0700
Message-ID: <xmqqcxxefkg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

Of course, this should be ...

> +	fwrite(out.buf, 1, out.len, s.fp);

...

	fwrite(out->buf, 1, out->len, s.fp);

