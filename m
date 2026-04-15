Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6773D47B4
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267261; cv=none; b=c99XWSphtAy12kZXqJv+rUS9y0AA1CQ6Y7oHoN1q5sYe0rMs7LkRgDFhgRn8r5w6HFrXhiumb+QMOVmhzIcgJGBB+/oP9ZedDm99zk0C0fjFE/B4HbwW8sG3QHN+GZxYFM/ZJ7iWZ6ngTS0CD8rsHGaCXuDrk1X8NbyIvApT0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267261; c=relaxed/simple;
	bh=e+oKEFbSNj6ck2l2RAVT4oddGRDKNlPuLtzn176wW0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIXAP3Ehb7MHMPE23/M1bIFLef4IRy7RDYUAfThL8J29K3Mb38kmRRJ/vE/Vh4iFXsv6x/5ir/J7QrO1zXVm5j4KsZQ4kfAeC0KQpD1DIeLlylsw8B2/i5wL1XObzbeE6mysFYA07EnvgAreyuN/mIp3GfoAttdQvziMiiMgxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih80ItY/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih80ItY/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e91b06006so5139981fa.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776267255; x=1776872055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+oKEFbSNj6ck2l2RAVT4oddGRDKNlPuLtzn176wW0M=;
        b=ih80ItY/rMvRVo7QbbnWtgc7vLa/w2m3jOi5DH3lXEPku/d0kRcXqsCdvUCQVPYOA1
         fupbzMDhkUt4jva8V9y6ig0ozVocemAGUrCsxpi4bZM5D7j7yw8RnRliMygQZrZgpPql
         G7p64fFtaeZDjaRECBuac6sZmprd33iYYRd9Tkny58T9GyOSpWUjF9/+1iVV0a5viMs3
         52sBx66SlvrSwNxh04H9NM+iIMbuOw2RZGzwgHYhc4GvpwGiYnvXgyYTtufmdB3rkLEh
         YbhhP5d9HJyuxr54rAZ8oQcDR+D7buFJXzalyREz0/nxVH+RXMPGlbyknBPFkmbKAFc0
         lqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267255; x=1776872055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+oKEFbSNj6ck2l2RAVT4oddGRDKNlPuLtzn176wW0M=;
        b=egBDjtdw2geVVH/rNzNl1iGp6dY3TiJaWut6G+ld1xe58zZJg5lQh4Tzgu5v5nSS4u
         yBDXeRCv1wIxVLhmQDnCSdR/SrBCRCUnykjSIImP+gtGgvyc2z9T219Ic0K71l7pKR3M
         JPyibhuf8v7kQIfr2UHc0wytbrD9T02DHwOVF/oFZjivNH1ngl5iZlgZjDhmNcYwVXQc
         gCP01zo3M6AczdQiSoMEgQbk1Zli/G8k1B93+le0X5SGWxn/fp3dHst/E/UQR2I01nLn
         mqbFCMqxNN2OkWLHTPfQ1X+MIUQ52zJYQwuCaAEfy1Ug+PaxXCn+YXg+h4q1nfaI6twv
         Xwsw==
X-Forwarded-Encrypted: i=1; AFNElJ8mHPqI8o3iJ4H2DULQM/878pRNO1lQvFRvnhyaJzf51ofaabR4WxPXMF0FqQVvloiu5hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcuBsQpLlwsDjgt2wnCUk1yQtOt92Y+Oj9rEVleB6K818Yi8z
	8FdQDKR6rtHNHxDnUg+fGTCnzJg+08fa3TsgmJCACp6qDrtKss4FboUWzezjKRPg
X-Gm-Gg: AeBDieuE9MyFF75Ly5em3OQpWSqJEH3bh6P4wxdLjN1A+hWUzQoSeTtuyaLdWHP4P2+
	0IgJmSm/8yvfQPTc7+042YkBJI6RT2GcnCExgiRrX9YgX09O7LP/FJ5IxWN3mloCDfxfNVPWypC
	cOgOfjRKdHnZmXm3+RIlMdG24EeQJJ6Qmp50ueJqnyVxT6dwvBktrgsZDPspUcXmziXBJo4f2ra
	udvcSAUNXrLahti/fnQ43ayvuxDv3EmonEHGTMUDftLMqVUMxoU9+W0CW6YmNSkVw+A2wugyqqP
	DbBAobghqWipr8g/n6nOijuamb2Q9Vwi/Yz8TAwQzinieJ5jst7hLfky6m5XpxpSv2pTvToFZXN
	XsUPm6f11FUtYfE5UC9cK8hEUYHJA218DwnXFTqsQLwPT6l+FM+8L6JKs8UM+MYIYYiv0akWCio
	17QgJpAB3p1GHHxBSjKtdhBnsFr8Ead32NuPkFW+GltMBDyyCiiCdH5kqOc7f6eX46JgXydYmaJ
	ZacujMEeU7cHUaqOJdth/cDkfs=
X-Received: by 2002:a05:651c:1994:b0:38d:e744:8677 with SMTP id 38308e7fff4ca-38e4bddb19fmr67856771fa.2.1776267254360;
        Wed, 15 Apr 2026 08:34:14 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e9e9b8641sm4825721fa.1.2026.04.15.08.34.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 08:34:13 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Wed, 15 Apr 2026 17:34:13 +0200
Message-ID: <20260415153413.1176-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <538fc297-d09c-43c1-8240-d1680fbec4cb@gmail.com>
References: <538fc297-d09c-43c1-8240-d1680fbec4cb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Normally the first test would setup some commits with test_commit() that
> creates a tag so you can just use "git reset --hard <tag>" to start your
> test from a known state. Unfortunately setup_stash() does not use
> test_commit() so there are no tags. It would be useful to fix that by
> adding a line that creates a tag so that future test authors do not face
> the same problem.

Sounds reasonable, but it's surprisingly easy to break the subsequent
tests.

My solution now will be to move these tests to last in the test file.


Harald
