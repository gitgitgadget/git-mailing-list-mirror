Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26D30CDB1
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298525; cv=none; b=aqsozwN3TDUJzi6amQhm8BMk2jWMJE9a5bNmiZdxDRsP6IC13f+1kFByYS1GWrTmaa2H/uw7pKsEqbjLtR7LixVqg0zPA5+GRK9lRXEIXOtTuoITZZpL8XigGjaSrUxi7GBhYFmur0Y3dCLfPFip5DjkeRGzbJIPsNChDZ/Sa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298525; c=relaxed/simple;
	bh=qnWSryuhGOW0Ya6LxVGiDNFuFThc3CLL9bnrvp34Qn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7bfHIHmXjryWYtcJYpgHm7g1DXb1DHkWyL94Q5ythYehrWuVz3vvWI1cegLRsG2UvBebPj4bG+UEo5ZhmcjJxrcq8q9skOmgg5YBLwzrPlnfouLgtdRx/ZkG2Ebcv/GKD6Q6MaNNkS8ndunQUNrumxX7AxAp7UVZJZq81Z1d5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O481WalJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O481WalJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso2834703a12.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768298523; x=1768903323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+mtGnYVhilotIccl0kp/MebdMWgMYwgPj0GdaEVMuE=;
        b=O481WalJGBWyOD4yH4WtE7V0JCadLvX1EjMyy7w00GupuqNNt7oS7Ae7NuI6DPtHZx
         apsMXvpM79VZyn7yAMFdGx71z5GOma+tbFNbU6jbm3ZniEH57Ij3oH5c9yqRVEYTru+/
         V02SkFETbpYgXjxLMoZLIbcUGnEtUfgv83AmGIZ3/wwUawU0IAbYLwTTV8uXRdT3uB2/
         kTkRhw4bWdkCM5/sLln2z4MG8PvMqoQMVghBaWzgMnixL8WEBubl0h499chH8F2vECTM
         J1OznoQbHiXb4XExCJJMOFAWopjFiy+hON+mWnmwtz6C28h0wGVFCqD7uG3Bo5TkJf8g
         khUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298523; x=1768903323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+mtGnYVhilotIccl0kp/MebdMWgMYwgPj0GdaEVMuE=;
        b=okpDdVsY0N+T+gy+DeDiPAmAct+gf70FJKUMp22jKGIEk0NvP75h0Vo+oxD4OPB5CI
         Nb7+mQM9E64avdZXzHM/Ppvk929pBAu2LGKfwGscubC9cnBvUCuBrv4+EZbXpgaWegzg
         o1lN31ENZ4UNqBXSKqdPc6ImyqC16EjXvtyRHWxOM/chZKUeMlu0RzMyREEPcuG3Wb/D
         7YJz5thlYMs9ERuGWNt3vO1cX6rmTlLytwYxrsXJyZ2w6N6CrsWL72n2HPA50WnQ7ymz
         maoPVnOU3CJTpNQVbQkNjWMSOYKHPVMJkgh0O9yjZngJhnxva5yXmgG4GPh0dTr2G6ml
         KJug==
X-Gm-Message-State: AOJu0YzNr6CW3QxFE1vDaH2CsaeJ5j9m22eknTu+E1mQNs8MvnFrxOCP
	7t63rvnoJvhLZUcPY4AxFYR9imzJx3s0zpTXYiPEh7V10tYTI92Aiweo
X-Gm-Gg: AY/fxX7azg8sZKtWbO1eHRgJxEDhIAoy0h23yo7Dqs0iH+w2BsMIOB0rmaGFd9I2Ple
	UJE5UCMyjANHXAEUMdwbNhCqWPjz3quvL0PMwC8iBT5t2ug0FHilQqiVmB8GmHiEyLceMcZdLjf
	kaP1+WETELW4/CyX2MA2u2f0+2LM233WJeGOTUVSGfErQQiSb/8TZ9RI0Ut8+dlN+Xt6aIbTiZt
	MVqQrKRP1+qtZOWuMW5VKnIelp5Kr1ir/N/kQT83V7DeXBsZxexCGsajthMm9LFdFKMqLC3OyUT
	SLc8xkdKcMByL1uiIFrdDHBk7paA1AKdmU24Mvtuv4xtIcnisY06ybvUj+SuJyOjfbrVOapande
	FBWmQwsJGYDtFyiLXIFlqaoEKkZC3an3uT0MU9RocRVkcyiOjkhQ0fpKAJXlAM6eNDjYKv8TDxL
	Cls/k8vJWd4SIpSxxdReFXWusH/5CBIzXWNwKlLetCcsmMeh+OIhUn2mSU
X-Google-Smtp-Source: AGHT+IEGrrceh5QJayVHvc+gyeN6jEJJvr7WpT1/9AJx4RVfhYLV3oWa3TlUw3ee/8yzeALSm3iGyQ==
X-Received: by 2002:a17:90b:1c07:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-34f68cdda94mr20469052a91.26.1768298522838;
        Tue, 13 Jan 2026 02:02:02 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:6844:3666:14b5:9421])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64b3esm19534687a91.10.2026.01.13.02.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:02:02 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.i,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: Re: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit code in tests
Date: Tue, 13 Jan 2026 15:23:55 +0530
Message-ID: <20260113100145.436591-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqpl7fnetj.fsf@gitster.g>
References: <xmqqpl7fnetj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Sun, Jan 11, 2026 at 02:50:37PM -0800, Junio C Hamano wrote:
> >> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >> >  	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> >> >  	0012command=fetch
> >> > -	$(echo "object-format=$(test_oid algo)" | packetize)
> >> > +	$(echo "object-format=$(<oid_algo)" | packetize)
> >>
> >> The construct $(<file) is bashism, that does not work if your shell
> >> is not bash, isn't it?  If you used a variable, e.g.,
> >>
> >> 	$(echo "object-format=$oid_algo" | packetize)
> >>
> >> that would make the result more portable.
> >
> > There's no need for the echo at all as this can also be written as:
> >
> >     packetize "object-format=$oid_algo"
>
> Yeah, I failed to realize that this is a(n unnecessarily) convoluted
> use of command substitution inside HERE-DOC.  What mushroom were we
> on when we originally wrote this crap, I have to wonder ;-)?
>
> Thanks for spotting it.

I tried using packetize directly inside the here-doc but it was throwing
the error,

	fatal: protocol error: bad line length character

this is probably because packetize is creating an extra newline in here-doc
which includes unnecessary extra bytes which is throwing off the v2 protocol,
and this is why I think echo was initially used there convolutedly.

I think a much better approach, is to use test-tool pkt-line pack,
which I believe handles the formatting issues internally,
thus making sure the requirements for the v2 protocol are followed.

Additionally, this solves the git exit code suppressing issue as well.

Below is the revised patch let me know what do you think.

Best,
Shreyansh

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 t/t5500-fetch-pack.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..62cf0e1ff7 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -892,15 +892,20 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	test_commit other &&
 	git commit-graph write --reachable &&
 	git config core.commitGraph true &&
-
-	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
-	0012command=fetch
-	$(echo "object-format=$(test_oid algo)" | packetize)
-	00010013deepen-since 1
-	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse main)" | packetize)
+	oid_algo=$(test_oid algo) &&
+	oid_other=$(git rev-parse other) &&
+	oid_main=$(git rev-parse main) &&
+
+	test-tool pkt-line pack >input <<-EOF &&
+	command=fetch
+	object-format=$oid_algo
+	0001
+	deepen-since 1
+	want $oid_other
+	have $oid_main
 	0000
 	EOF
+	GIT_PROTOCOL=version=2 git upload-pack . <input >/dev/null
 	)
 '
 
-- 
2.43.0

