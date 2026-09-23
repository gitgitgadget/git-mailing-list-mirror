Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477185326B4
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169698; cv=none; b=L1L/Ea3i1kAHTUiZ4ywZlgAWSCQPpllfDhEgG9qNgzCGvRa3Y+rvMTb8khfPpu565ZCRgBMyDAjhMZPCW41b7T96ojYb3ElatZQWF9DFtvytLd4d95t71Fj7rvPvoXzbFpl9KXwsDpnEFhCFNJhsfMhOh9pZ1Oq4UkT1Jqrx9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169698; c=relaxed/simple;
	bh=lnL39EG9PA93RxVGPsbVzym9Itoe3IaCvaXLNgM0ns0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWEncN1044bK1dQiSgYFCf7nwT0gz55meLxyPvx7fYalYe+4WcFGnr8XlyK/r1JfRw0rgHXQRbJbVAelS9tZ04ZrwqYWpece9UyLTuFfQUIgE8cvJJ5W0GjtulXRyvFpMZX8kFRI2aF5iImUHtO+yxeytezhjFNBDS+5JmGMtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6v4XFSz; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6v4XFSz"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aab226e7c8so1656380a12.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169686; x=1790774486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lnL39EG9PA93RxVGPsbVzym9Itoe3IaCvaXLNgM0ns0=;
        b=r6v4XFSzxdAkgSj12XbGKDrrEQrzThgRbefQdNbKsqUkv+9xqDoYJ2SiYxGkKoYC7V
         wSJI/To+ZyHkzGTCa9blzFHcAQ/jSlzS57RfH1vGWXQeJhD5/VhgFY+ld3u32VZoTeMB
         iMOPGVqGibaCXU24epnoVWIiobedeiiibp9Fa12MP/g/qLxUiK/eAlX9cDHCMTlDyen2
         mPBkwFWGdBpOk0UHH2qIDvEQ4fwHDjhkzcjj2V0flVmc6BvzL2orlC8ogK4SNmXhKQ4+
         QIHWv79PykJSlOt645GC619gtY24n3YWE6/83CMq79n2mMooMgrAgQy3BeAML8M5rYsd
         QENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169686; x=1790774486;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnL39EG9PA93RxVGPsbVzym9Itoe3IaCvaXLNgM0ns0=;
        b=vs7ahtRVpW35dEBP7APs0koMOLSwUKySDBRHDPVWCQHcHFmoUDYm9Pr/xijiR3o6AT
         oqBWRWL4zi2QZpqFA5Czxxbevjrbu72Ilbz8Mpj1NwrVATGkrCBkOKklcGj5UPYFVTLK
         MBz6lck6Vc7QWhS31xeSYS59aNo4zHxUjJ7USE5EhoWV6a96PR89Ui2pVfJ8dFpPEprC
         qZiphZH1PEWeGExnXzBY+trjWwfKZJXSTptLyZpJ1Ix1XMwe5rdnfVwHI8H3NVBZ9jO1
         EewaWLZ1QsBxZ0XnVTdvuxWDfDcVqviBwCcnDPHSDdZ+sMBhzwcvt+LX1tGiNQtTDYP5
         KU5Q==
X-Gm-Message-State: AFuF++ntQpBZyWSfRiSLJ8uzkEkZNPq0eS/Ate/LGNomujjXicq4nFTy
	W9TIjB9iIFriwkvq9y9W6gXsTHM+NLN7VEI15grbK4kVnajsDLvs0uzH/t/G8Lw/
X-Gm-Gg: AYBFou2kcM82s28wKvvbyFwyeef4XMyEP7KNicrRx1T5fjWbqaHhceO5T4ql/5gv9pI
	Hcbd1C6/9dABHPXs6wxkBHp1/WpYUPZeEV3UAiI4y13Z7Vku4/pn9hRcEMFFaIUiG0H5XLeY/ua
	VrXJ0o220ubhBsBHMlxBh6/yxl8OBYZiQ7NKLYeUDzrRj+s5D3hOqWdjQSEzMVLtk3YZLyboW75
	2d0teXUQTWyi1ThxjJNRkH0KoPhuiywkuAMmuno03BZjKNdcXVytCJvb703nKjFpE6yHUMGnfoK
	sT0WcZyDXlWO48wv47K1l4YVsQm+VBWZMWZRAQFTpwhil8MXGNHsCchDXiAUczJTXyfQaO6KU8C
	ZQqS5TQTmIFHtupaP/yNSQrZfDYLEhNzESCRPNHoKSY+/h2DmaW8nmIusLJbtsZhD/0I/QlCxSF
	UkDC48Kv9KBCmgH/19WZrh1p+xZaueGg6U5TFaHEq5f3n3c5Iv2Lur2hIlSvg637Scp8DlICXvn
	xw+URRifCvaU2T9LAndrr4MuY5VIL6n3GfCZ9waRqQnqlO6o3b1ckwzuQ5EialfDVozCaMqeHTm
	Ku0zgLVtjsKTVPh46VyJzA==
X-Received: by 2002:a05:6402:5d0:b0:6aa:97bb:7ca4 with SMTP id 4fb4d7f45d1cf-6aab3b87c7cmr2607199a12.41.1790169685569;
        Wed, 23 Sep 2026 06:21:25 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5aasm1726153a12.9.2026.09.23.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:25 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/2] fetch: make submodule fetch errors configurable
Date: Wed, 23 Sep 2026 16:21:15 +0300
Message-ID: <20260923132116.134736-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
References: <20260716140956.1023740-1-paulius.zaleckas@gmail.com> <20260810150844.4003918-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Another gentle ping -- this is still sitting in "seen" marked "Needs
review" a month after my last ping, with no comments in between.

Ramsay, Jean-Noël: since you reviewed earlier rounds, would either of
you have a few minutes to look at v6? Happy to send a v7 if there's
anything left to address.

Thanks.
