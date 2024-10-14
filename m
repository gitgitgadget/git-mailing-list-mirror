Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE0139D0B
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923006; cv=none; b=h+zIzH0sY+XE/Z3H+mGhSsalkq9YbXYVdFxBIYnAMduczKTO7HchXpm714EA/RTkpvmJ2jJKr+3m577hN035PQU7yCWAdEe54ZWf8jBezjv62oaGJ/AFfgk9w13QhA2mL1HOoZMxU+y97ASGsnVjtcprq0YFHY7Cx+xWP5Hq4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923006; c=relaxed/simple;
	bh=uM8I5BMKTCIw76F5F/imSZj0e/W1Eswr5/PrMLkQYrI=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=DR9d42rwyl3Jl3FaFcDfbUZWeAUpVMYddbN1MGqnzklUmxcIRP2QRBOpGHBrJVw7nHAgDik7sbi2Gnpc/Ko8UqhkElMQKxvebQftpzZJtmnWSmqor3lv95BM+YFk5SlF3G2gBXdwOUp8rqHkzKiR38lxUIabM7cHcaHqqm1QXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b=NiJL5rah; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b="NiJL5rah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728923000; x=1729527800; i=lolligerhans@gmx.de;
	bh=uM8I5BMKTCIw76F5F/imSZj0e/W1Eswr5/PrMLkQYrI=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NiJL5rah1cnwcqSZ7UpVpJWbMaej27j1J1Mw9AHGRfnW5kO2SU+myMgfwFECRsru
	 oTvmPlprPoQrhjzywtYuoLlsPFQHhT+bK+cG76+8sXqhhxBHXLCSuqmv20kkOdTAE
	 h7VbyQBUhZgiZ4DxpCu4dQkTXjrhOrSh5rga5XTBVZknykiG9WkUMNF+VvseGXj9T
	 c68xN51wVXvzTrRSJ6hl+uOxe3isj1AdkNyh+2lnuwA3JwIB+fxYTVeUfBlMgkGNn
	 ERl3v2Fteoy+oU/V+eubbdzlra3gLna9v0tiDa0sXDwCArcaiqtnnol+oTlT4QYiW
	 BBI5793EL8pjP0UJqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [92.200.132.118] ([92.200.132.118]) by msvc-mesg-gmx126 (via
 HTTP); Mon, 14 Oct 2024 18:23:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-4806cd90-2a2b-4be8-a202-bb9f4f6b1732-1728922999672@msvc-mesg-gmx104>
From: lolligerhans@gmx.de
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: [Resolved] Bug: diff --color-moved={zebra,blocks,dimmed-zebra}
 fails to identify some individual moved line
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Mon, 14 Oct 2024 18:23:19 +0200
In-Reply-To: <6f6d6518-fa01-457f-a482-5e6ffbba3f2b@gmail.com>
References: <trinity-1a7c1cfa-3f79-4430-bf3d-776c526c242b-1728914461526@msvc-mesg-gmx102>
 <6f6d6518-fa01-457f-a482-5e6ffbba3f2b@gmail.com>
X-Priority: 3
X-Provags-ID: V03:K1:gsPtLK/8L+tEKOog3IqN/rhgfrHXvH1q0p/Cz6QslWd7K2sUbknvsftJkR5vkG2JCUyR+
 5wtR4EsWKNN7wovOdXN9adyDJsK912Ngh9o9RWvuPhOWD+vELczz10507osnaXBWNToX0OCBuDw7
 rsMgln62KkgUvwqZ9Pjv23zdCGtss6LH6tW23VohQOh86Yh/oNyjJ3zm0f8ZXnKqwr7o3e4NXI86
 P/X/DdT1N3e0vVgdzZeIQUlqU5NsRe5QPJ4HqWOSdh5HQ1cD42+Ydoby28autBwG0my1AMkSw8RO
 lQ=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RDXDJxKHegM=;iP9bFlCu9II54lTdCe8T8xRmGxI
 LlGL/lQUF1nVvItV1EXmxs/eOQPiFxiDp/RWKgiaxqsLZu4nS9LkZiwZaTBej6ws+EHI9/Fmk
 S8bJv+8IoM9j1SU+6cn/STOh+Ys96dMJnAswn/ErWGi68Xg8sRxsvXC/CLZc7U40Wtb2xAI82
 Gnz9Kx2wRq6E1rAKCLNmFEEzCIZpW9nJmXGPMH8dhGhQZpxbkhpnZPJhc8bWji5i8KOi2TsOl
 U/5neKouf1kxoYEPHxhRiSYQP4LnTDmUd5nZ5cxTb9H6ylaRvmWFCkLzXXej78jNrQ8rkDgZJ
 k9wZ//cNTanhUDxBb2wMME25MaYbo5L9kND7/Q9jYhOvXJpttOrmoh4SR9BQAnxXYltwdTrAA
 y2nYyvXUfA966MZpoKkL441N/PbQtmB9fNsaG3HcXAS+rL4R31booVta2pwNFcTUj9xFBsx7J
 fTZZi0Bwd+wpt7+IRvf6txoGDZAKIG0Y4nll4X9p2BvGvZm29m34C4/sX9pZemHBFiwNrD3QD
 8sKCovD9rd3dH2s4Jhh9wzU2zrMJEgniTwOFWA0gWZEIiNeDE6ypmkzrbOPpH64ljDPQSA6eb
 GpVF0iO5EhPM3WbxDqnfmEw3UHyesgR9xlo5F7X2OAO16dekEfYVz+Pk/NKR9fnEsbzKLupv+
 wa/Pwpyy1jMT7Rv6shb6ztuwsL20ieSW8WbHzxBh1Q==

My apologies, it appears the behaviour is as intended.

I confused the wording in the documentation, and proceeded to accidentally dance right around the 20 character limit trying it out.
