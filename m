Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DB3D2FF7
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856004; cv=none; b=pgIY7Dy1xLp30XhOYPrmhsZEjmy4rx2R4Q0xk17l5+9tyect+GkDv98FY80ZbzOTMwzTOEaUGwnMgZ5/Tgpp03Ty95GDVzTqUuKkFd09REXGm3Q2hJRh78yBWlCnh33/qe/1swZ0LBJAWQgaX+mwwaeHBQpuCaPLyU5wKckNydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856004; c=relaxed/simple;
	bh=mzM7fui0Sm1gE8bffFXRsPRM0cdAdBKNlCZCCFchDqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVJs/V012hFzjog+h4kY1fYryZ46En66OsQy2GvrRUzZ4kAQYnu7zO/6ejwZpcwLi3QWFeGUYYuClQNKieACuFoN7vHJfJH2kxkT3wnYDV09+Ww1+Z/OOPfAzhA6YSc/aTfIuNG58ghsVlGfbKw7nItkkFMY0586pHb0YugxBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lSgakyS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obC0+d5p; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lSgakyS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obC0+d5p"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 97238EC000C;
	Tue,  8 Sep 2026 04:26:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Sep 2026 04:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788856001; x=1788942401; bh=mzM7fui0Sm
	1gE8bffFXRsPRM0cdAdBKNlCZCCFchDqI=; b=lSgakyS3xcaLAirBPa8XXdohR+
	of6F7BmL6asihHP/AusjubhXvUVzS3xuN1BfyZffBwJ1hfIaw0LQe7jPEm0bzkQS
	m/8nIJDEpJiEaIvekmvRJRdjygkcLSjN2Vx5zgOwru19j8UKBSgDQkhshXUSD9pi
	75Nhp6pVknzCV+72D0J8JzOr3eN9q08EgIcw2MOLP/9dBXslUP2l0u1NbQO/yCNk
	MAzoQWyOHJIk3p1mynGDHxTp3QVjgVA2aTLjFidbuoOQ4iA/MKfKTbYRT+1XpnUg
	NvAhzw6wtsSK0BRB2X5vrtBY4togdSj7Q2gQiUOpMfXgxsS5FQue/I1X8yYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788856001; x=1788942401; bh=mzM7fui0Sm1gE8bffFXRsPRM0cdAdBKNlCZ
	CCFchDqI=; b=obC0+d5pe6+opGsQ4CDxPJj2Lp0S5TtysfGEKL2DkoOYgUsZwMn
	tDbOnVlqeeAHmHdk34PYLRXf/1xUwNoQeaFbF3BBqQuhfpd21Z23riFCDv/K6irt
	OBzONai7omKS+XiJVfjFo98jjNXhVMEfEEYmeJJyBm2jMvu19PEll2VrduT/WHTM
	QeswOtY4Rukkeyr9zSlIkH1HuSz/aajGWUDDeY6SZ5DWBn/2WTkD3in076nwXbCN
	bkAxWHbXNf4CJm/HPZpwNo+D0tFAmmHkgaEj6dBGi7AXA13iqSiobKbPYJckG/kb
	YOe1GqWel6xplIIgLbR2EBL8Kzu1AF+/w6Q==
X-ME-Sender: <xms:wcafanfd7Gww_Yg3IE7u2NEGUafxyyH4mI7DLVkbtpWVB2K3xBTaug>
    <xme:wcafakotWT3O5xnM_EA9ekOEm8moh_urydOXRyOkhVuQUCJz4Xl2tQriO_k4gt6k1
    FMxJUF22hYppEIho02PY4tCE_puPdtN4xLknr5cigswobj08JV9W-8>
X-ME-Received: <xmr:wcafat7MXl41e-EIhDys5uFiCoEHXkvASPbyHYQwNCer1hvZmy611hIBBAGte03Tj6nDuQU>
X-ME-Proxy-Cause: dmFkZTFuVYK1O+NrxZgm/F3nEaAh8GD4b/ZgcD0qFVD3d5m6juhGc/JEI9jfzrjzSmLNMG
    RV3KvGHEGh0Y+uob1iSXvOhVZ2d3n/8W6pvz8BUiUziLtR3UEfJAX5ZCeRux/TmsikJqAd
    b/PoKgmZ+BBIW0HiWCgvCvTD98pl+F8roj0xCaMhQUhCsxeH8Yq997ij3ltnxUyEK8I6P7
    5aUcgFAUmkyLsINzjWtDE24U9IOTym2FIo8a7aVr1kbc4agV9wUt91837q1O0dX4DH8ypq
    QY3kTJGwLhTK6uMempl9A/4jOu1kvfO4ckkkDglzX/Vd9+u5nUmmdRrOLFoMuVwGybmAjK
    GCcE6zAblGdHMExhsjHjAyRDqbM6R5dCYPOfRM4dWzLHs5O1njuwjD0YBXM19Ik6F8imyN
    cBvT5z/xW2FfO0Ed1OK2B9n56lmZAFIJKuHxSECoDT4Id1Lmg1u9yPIybhvAtRhzzuYGgL
    8g3uaqqnj3CcfrAS+H3yiXsbbT0tAcbSbGJ8g9aRIvLVrfT8vJibE6NZFjsJ8rnMutsjUu
    V0U80uyVdVWQ0w9oh2iesDdz0EOxKQm9kcwcsl+lr1gsNjWon87tMs0Ul6MIBMo06tZPjX
    ecAyKEJxtbLTmQRsRpoHUWZd18HRxemYmkp3jddcYqTpwqQPaYTrH4vF3/ng
X-ME-Proxy: <xmx:wcafaioy36O4HUbXAJfoJV943jMSNZ5bZirWGQOvLg8Ic7t_ddxPfg>
    <xmx:wcafaniTM2JcMOs6XcIk2lt8p_dcjAHPBmHwY14e8hlqeY5JCo222w>
    <xmx:wcafakIbpTPEIQaJPAt6e12Eb5pm5kfR1srkr5kfobS1Ku45xj38vA>
    <xmx:wcafavDwdB7Go-QJIPl1cnsOEwx7hMpRDgKljNwVdvZL_7DnrSVxyA>
    <xmx:wcafakwIN9eHtF0MLp1ampjZ5xkigfd7kllplLdNnF_388FUQJqHuR73>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 04:26:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ecdccc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Sep 2026 08:26:38 +0000 (UTC)
Date: Tue, 8 Sep 2026 10:26:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH 1/3] imap-send: prepare for OpenSSL 4.1
Message-ID: <ap_GvB8Lonkn0nEy@pks.im>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
 <20260907211210.2621693-2-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907211210.2621693-2-dev+git@drbeat.li>

On Mon, Sep 07, 2026 at 11:12:08PM +0200, Beat Bolli wrote:
> OpenSSL master (to be v4.1 after the release) renamed the function
> ASN1_STRING_length() to ASN1_STRING_get_length(). Map the new name to
> the old one if we're compiling with a pre-4.1 version.

I can see [1] that the new functions indeed exist now. But it doesn't
say anything about the old functions, they still exist and don't seem to
be deprecated. So why do we even have to switch to the new function?

Patrick

[1]: https://docs.openssl.org/master/man3/ASN1_STRING_length/
