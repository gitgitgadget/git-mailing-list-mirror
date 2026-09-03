Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6E4FB9B3
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458785; cv=none; b=C1l8EqTYYJ5IJW6LlPiH6VTsOgs898VcLqUNF5m5+K2O5RDr+N1MtC1HKJvomsnM/kIvcqqwoUtzjMkXj3wmP6DRGCiorfrdp7tKYKssuqq+zUsgf5Ef1Mvsbse66B2QxbhMalGPo9s6zcSi0h1grz/Ns+szuCFGm3pJhcmkkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458785; c=relaxed/simple;
	bh=AxBTwNeuu0Cwhr3gRll8vQtUUxXPSGzD8LmEeAyDcOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kZ4pkuxgNkCd2m4h5qJGRQ7Y4eXfDafHjpwtGdwLghPSsCHXZLl97gAsvnNnt6EcNCzJ0trx48sxCPOeYIRmEsbwU0a71mHpFn6VFZUulLYl3PiuCmO4NXpLph+6qkjVNfFLQ6a4rWoueszk1iwnWd2sfOzYIIEhNDZhbLN15TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=LA13K4tu; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="LA13K4tu"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbSG24wzpzMlP3;
	Thu, 03 Sep 2026 20:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788458778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxBTwNeuu0Cwhr3gRll8vQtUUxXPSGzD8LmEeAyDcOY=;
	b=LA13K4tuOfGijNQhZyiRVaNKA8G3psxOUnppIyr9FTkOb68IgUpDiMZxRdCGaPsKiBXjbN
	POWgkhxFy1u82QEZpC30o0sNH07Ni8+8o9/3dzF5xHWoL2auXGo5l3qikZgI+VSz74JOEW
	DYol/4cGGD7Pbka6HAFEAiDkvmZZOQJHgZtuzmGTvyDmQeRmdZz+ZJ/dCvQxyKY+VxR0rv
	fxg/7EsBD3OkUxfi607dxyENn9TVklxEBHGhs4Yc/+W3DmckBivugnH8/0WxdGnkePYPuU
	zkbFTvVLSBnpyskg0caY9ouv2UIOXS7V7SpwKuT4af6Lm6ALBAUrXp4MpjourQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 0/2] dir: fix pathspec prefixes with exclusions
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
Date: Thu, 3 Sep 2026 20:06:06 +0200
Cc: Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4F31FE9-901E-46EE-B4B5-DDE0FDA8F4EE@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
To: git@vger.kernel.org

I just found [1], which is related to this patch series. I didn=E2=80=99t =
review the discussion in detail yet, will follow up.

[1]: https://lore.kernel.org/git/xmqqv78qw3hc.fsf@gitster.g/T/#t=
