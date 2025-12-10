Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938E31B111
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393761; cv=none; b=I3CSJEPc1A7hU2kF+6CfxuKIpqZ0pItvl9eIoIVSUP4Y/yLFdeaZaD0dXenEi0+YEpwBtuU6+PaujDnUS2q7dlD7k8daA/2Ru2HYjMP3s4EdYNwdcFfg7aVgroKIpujddqZ61WD2ceaVnxgeYZ5TQmgGMJ3XxvlMLuW+6McE4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393761; c=relaxed/simple;
	bh=VnuxrH28B+yAgo4e46Jp8cDFCoPBy+3Y95iOtmGEgj4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iNLDzNWQoGkf76t5d4DrbvpgkzY9DvKfa26hzTY54YOTroFq+0PgAwBNxiZofRiL81MExw6xjhAkDOIRgyTRTKoWyfvShnHE9OdIwAZGpHP1ZCa+Xf6N9FFdynQgyCBN3mBhb3YyYucDzbPQe4otJRHWLTvHwLspBGoS5XO4AkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG7c0oHz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG7c0oHz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29586626fbeso3001665ad.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765393759; x=1765998559; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS25PmNLhAFweeK6Hi2J2oETvMyuzPq86DBEIHUZP5Q=;
        b=bG7c0oHzTO6KKk0j/N/YH8/jIC09bQWMR/KY/nNNBDGBAGg3JJPaR96Kz+vKeDiGvO
         dT/HnXUpD0CxhDVPBbFQrK1EAtKOdgYSxJM99+Y4Obp7DhHulh30Nk4CGGWX4Dtx5OLJ
         W3tCpA1MbFm9bLQmr2Ior53Rwhk6DlB6SFzLsSnFnzG+9FIlEbtwuXCfjjIxRH3H9bBm
         3sGLIp0vDQhQoQPBRBbtSlFuK9YGFdfPjHFWoPbGqHMLzmxj4WT94go474Y/j9g63jGE
         vlgcamhadA1yrjSzWCL2YRUSMO/dmdaYw18R6CkhBZ52cDw6dbjKGkb13vNJSrBr9RV/
         VrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393759; x=1765998559;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eS25PmNLhAFweeK6Hi2J2oETvMyuzPq86DBEIHUZP5Q=;
        b=Fvn+czM8c8VOwzjUZxn9QRJTSdvAPM5cFGGXFJ2wLRJrNAopWHVPhZZhYxpWxz/fl3
         5Ti/9xjO4ez7/tRKAXiD6wMXaAGzgxH2iLLsPLpEwA+5g+ZqpFa7QmjrNlg4iw7Ep2L0
         ya/SZJgSFSIYAqqT+gv+pBGVSUpBZg6UUj/cATiYuogQu8yxFoQ+bg9kc9tO+ooNFbG4
         WbiDj5s1i1n4DGPRQLmw/UZNTnIsuXDfcwzJBNfGr0VRPQ717knSTTMFKeF8407qrh0L
         Kipcs16aLT4SMa9ItEF0oVsxo6e92htl0zA9pvjNezgnk0nsqNmbnvC19Fh9b2ioEGZe
         5yZw==
X-Forwarded-Encrypted: i=1; AJvYcCWu+mfqUJYHTpSD2H0zKOeizNIqytunarSCKbydlrDub/1t7xq6SFP+xdNmJnVkz9A/qls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/DD6VD7kTki+JsI/oF6HXbytS0Lu9xPbwjl0tvI3NwzZHYnS
	MwDMkIUmoqqyGf7d3dMmOwgecYmMON10pWBi1os9VSJRxuz27yPbXFX5Nh5IdkJn
X-Gm-Gg: AY/fxX5Fdfs0hEjdYGobAZckkz6yOIngwtOffTgr/BQB/O3NRvjNKPhW0LxuKLmiHR5
	CChdSAnG1JGE9BBerRlAg7J+oRcqTFrzFyVjcaypDYY1jo68M5qGoz6n2/0R5EBa6HTejGShDpN
	1JMYAhG18dd+siiQ1i1Lu2RiquXhMH5V4QbRRDiqRAZgkZfX7lyUhLMyeikHvLCxc1Vg0mJ/uju
	fFnDryNq81Jn3KcEkacUImNGEcvOqlp6B1d2r/WV+drKMXuNF7BAGxYD5xcuO/MrvaxjTTEt4KY
	pTRxspwqJ2a2AfYgyem9Y1mMY/xv6GKAECJf/+bLSqWj2+3kqN+O8bQFnQVMdds2wn9kHNtY+OF
	g9lEVF5i77x93kW6u1rEXvjqdQmh9yWeAMqNz0EnaY4AE9uK5xTKOy7McrU6OG+oKxthrpAUZ2h
	Gm+Hvq2CEGEdOPCUqaiFX0xjvZARNfc6n6mlry6zbCfTAjZQ4FaPz6wA==
X-Google-Smtp-Source: AGHT+IEaozE8MnMSpZEvvG+m09pFmT7K28VpyMPDO75GgfFHLGWxwRPt7JDEQhJL1hG1enaQZQsSTg==
X-Received: by 2002:a05:7301:1601:b0:2a4:3593:645e with SMTP id 5a478bee46e88-2ac05475671mr2256528eec.14.1765393758864;
        Wed, 10 Dec 2025 11:09:18 -0800 (PST)
Received: from smtpclient.apple ([177.118.148.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190acd01sm496352eec.1.2025.12.10.11.09.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:09:18 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue stucture
 output
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqikeegz8q.fsf@gitster.g>
Date: Wed, 10 Dec 2025 16:09:05 -0300
Cc: Justin Tobler <jltobler@gmail.com>,
 git@vger.kernel.org,
 ps@pks.im
Content-Transfer-Encoding: 7bit
Message-Id: <DF127A2A-AC63-4CB8-A405-7932D2A79E2C@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com> <xmqqikeegz8q.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> This part has both textual and semantic conflicts with Lucas's "-z
> is a synonym for --format=nul" topic.

My only change in this test was:

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 36a71a144e..df7d4ea524 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -101,6 +101,13 @@ test_expect_success 'keyvalue and nul format' '
 		tr "\n=" "\0\n" <expect >expect_nul &&
 		git repo structure --format=nul >out 2>err &&

+		test_cmp expect_nul out &&
+		test_line_count = 0 err &&
+
+		# "-z", as a synonym to "--format=nul", participates in the
+		# usual "last one wins" rule.
+		git repo structure --format=table -z >out 2>err &&
+
 		test_cmp expect_nul out &&
 		test_line_count = 0 err
 	)

Given that Justin moved the --format=nul test to
`test_expect_success 'empty repository'`, it should be ok to move
my change together with it. I did it here and everything seems to
be working.
