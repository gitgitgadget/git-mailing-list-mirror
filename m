Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4973AEF51
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937008; cv=none; b=ZQ0hAiRA5wQH28Y6cmftpQS7XBhZDDkLRhRwasrSChZ/bL6WqJ7IJ7HWbb7jcMh9tgQI23wCFhjr6DQxkd3gz8FcDKos7VltN3MjfQadKS2Zi3G85520W2hjmQluR/RrYCoZVDoNjSRqlKPeMtEE7vGqGHfFun64QoPXM3NMOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937008; c=relaxed/simple;
	bh=NcM60cCkMlQqU7rYu7h662jdQ6AJ6r+Sx7lsySiOKQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozvZWh5q8mXeAUcIQt5jphoVuWGD6WQnaW59AU5W5bc2AsRGbQEdyl2BUR4pxFNTbpYfERTjO4EZ083Z7FFbE9IoKt72ejOA82lvLe9nl9OyBD4xjakJle0QjVjruDOErN98pUM/MJsPAuzpp6TvGoioDOj/kfGJwhca/Dht7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=eiHLDLTs; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="eiHLDLTs"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so110238966b.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788937003; x=1789541803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w6i1v8cwQjhQgN9f3OU2vo8yaqx+Q0lat6YweWeQ9JY=;
        b=eiHLDLTsX5JAtRxhM05fjSWtgqb3o79Vf9dQf0+mrD5h7u2ULtB+2WrMdcBjsuwxCo
         Lt7Pvd/pFwadhSLKDQXNbxvOZ5N5IBWCzfKy7dAh7vBOojO4LAk8EHK/YcWgHLtnMylA
         dgv0ms4eDZaLmNZ1/aCkbRMQBCnKS0Prl2DAl11h2+cfN62Ak0yg579Ca/faxkgkSq+/
         rmkHdFHQJqoVbkowea21wYNzvQIPH1xe/qZsQjxJ48Wu42HjVDdBzM9lhYvTl8x4mMmE
         xHmGdCm2dprOn661S3zqSdvP585nnZB7iVcCqyJd0rsUNaPEkQctaqhCGFnWGM4PfDO3
         Ppgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788937003; x=1789541803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w6i1v8cwQjhQgN9f3OU2vo8yaqx+Q0lat6YweWeQ9JY=;
        b=H2D2ZqzEnTMPsULTCpLlpL5gDfzSrk17Pu44TtdTMzMzzAGRpp6QYCek6ZTFrAQNcN
         tT/3p8nboEGQLbMchsrilS9rdbmCWGjPaPA99G/r1n5JfMDcSo+27JoRYJZYrTrKj0IL
         rpXx5KBpsa2/L6LI3dZg86yuFfkCJz1Al/eXVYC/9DgGQCXulmfq6xWmhw/oNHdDRX42
         sYhi7Lw9cTQ0omZu0iZlJZXKM29vQHzTA4ClVKH9AOG+A8wCAf2E0AxvRHy7oCTDm/fX
         FGN+G2kXENH3mSPEVUvSPIfJphUjM+PlgE6yZ2ZyjhZ/k7ebvmjVA9YZ5lTKSdyFZg38
         +Q5A==
X-Gm-Message-State: AFuF++mmCcwFwuzvWHS4djzhwKqrtaRd5Sdm3dohiLt1t939//dDmeW6
	7Tols0RvkUV3DlK7F9UK4MWO35tD0+SCYxELAA/7L1l3CAkYy1bv9yU5WaVFF8edzaIKT2pcc+T
	8IPBKsJaiyHo9K1o=
X-Gm-Gg: AYBFou2qAv+yRGanB/rDpSZutA0dy9KPcUYzrRFum2Db6Dirac4aEWQFWUfugdR4dc1
	T8KSKiYaNoeSM6p7tiAVxyDPZTLEf24iNXJ3y+QUhLTe75gPUteXkvx7MEF/yhT5reOY3zy5VNV
	yRxrkj+3etK9IJnaZZ47i/AyteT5K0vIL0x7Dot+ndKWD7EKig/+bFDXoqL+BYp4w+JrtNSMMUr
	ltVCgCYvufn/1KDgirjHtB/Ta0xanXaIcXEJjD0uaawLMoKGi5ouTucxUKAkiFokLIPmaMT3CeY
	wvnRL02oBhK46umU+ZOhXovialp38GQYKXyhFAt8XcFsNIUZMCzuOD57gQU0Jp/qpktf6YAK08c
	8dYRwgfBQW9SOUReGhzzMQAr6uwEh3EGpZKAybNRNEAk6hJF6Q14MfNYvPuTVkKOT1GCIuQ34VT
	INRSIkMmymi7kPbQWvLfUY+Cz1kNubN3bN6iP/lA==
X-Received: by 2002:a17:906:9f8c:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c292af1f9c8mr294968766b.10.1788937002941;
        Tue, 08 Sep 2026 23:56:42 -0700 (PDT)
Received: from ownbook ([45.85.105.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca940sm556672966b.18.2026.09.08.23.56.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 23:56:42 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Wed,  9 Sep 2026 09:56:39 +0300
Message-ID: <20260909065639.47316-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqjyowz9oq.fsf@gitster.g>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g> <20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g> <xmqq33vn5hsq.fsf@gitster.g> <20260906165052.21780-1-f@lex.la> <xmqqjyowz9oq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> It is only true for those who conciously disable the gc, isn't it?

No. The fallback is not about expiry, it is reached when the
remote-tracking ref has no reflog, and a plain clone leaves it that
way: after "git clone --no-local" on the files backend, "git reflog
exists refs/remotes/origin/main" returns 1, with core.logAllRefUpdates
at its default and gc untouched. The same source cloned with
--ref-format=reftable gets one entry.

Nothing expires on a calendar either. Entries go when "git reflog
expire" runs, and "git gc --auto" decides by loose object count
(gc.auto, 6700), so a quiet repository expires nothing.

> Doesn't it force a behaviour that would happen only to those people
> who deliberately choose to ignore cutoff and who are willing to spend
> cycles to go back to the beginning of history, to all users,
> including those who do not make such customization, no?

Measured that. One repository, 20000 entries in the local branch's
reflog, remote-tracking ref without a reflog, both values reject the
push so only the work differs. Median of 7 runs:

  entries spread over 200 days      zero 0.325s   90 days 0.069s
  after "git reflog expire --all"   zero 0.070s   90 days 0.069s
  20000 entries inside 90 days      zero 0.319s   90 days 0.321s

The expire run left 5 of the 20000, since all but five are 100 to 200
days old here. So the cost lands only on a repository that still holds
entries older than 90 days, which is the one where gc has not run.

In that repository, when the matching entry is one of the old ones, the
same walk is what decides: zero accepts in 0.322s, 90 days rejects in
0.086s.

With no match it is 0.26s of extra work for the same answer.
