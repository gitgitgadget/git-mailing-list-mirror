Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC1279333
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225912; cv=none; b=PUZD4XX1pOqYruWaj9LSGIQpSWqZlxVCCWPc829N+VK8OUfsb0kKAiJDhtYhx/x9GuFlilcx+jUEr+QwWyFV9pglu3B7CBCNLVhQW5ra3ownZH4UMxg2+waXxskXqgHtz+YwnpzTWVMOgi2J1EEXdysfS9wZzQ3PD3eApnSZIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225912; c=relaxed/simple;
	bh=QkTxV25N8JM9TayqytS1expADUWQZPVZFX18eWDBvy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmdVZ6tA0mlRFGWu1O3qOTbl2MMD9ofTli2OFGqbrf5IkIkzSKb4plqdqxPoLHzyZ6AI/6doW1JSPItvYo/dQ6suz0ZCefNxkfEzGOUn+6N0mKCj2Axnf4sP78xflUPtqME8GHv1CpXqBIWkEDnC3MfwOgjpnNacI/1gXyinVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzO5txCr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzO5txCr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7396f13b750so7264262b3a.1
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744225910; x=1744830710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKppio1em0hUS5O+BO14W1K5rmexztUwlkPFuOkRpuw=;
        b=DzO5txCrMKHEUhraViZwjwWaHIzefOlRLMY+Wx+mK84qZwKp5I/2db0xXTI5AgjUq0
         R3q5Bsxfk6Xa4Po51NyEvaFDpFaQD7BLLxrlUcCDANwPInBw1hufunv2rdkxFRuADmrV
         leeAN0PBgGEnCgz18rCtlrwVZf2MD2edYDNZRnJMh0fhNiBbUJ0mhjQe5g2x9gl3n+Pi
         Xb8hAX/fOGaSkvIuwUPgqvYR7C5pijw690dSaK5YdsDfnbb1mdXmkQl/neZ9ntOAJdBc
         DdZHSTgksUdG4RXHiOO6hgSs3/mWzqmnjzFcc0zJr3rjWSFqB5zlqrajzZ06+eoKNIqt
         QLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225910; x=1744830710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKppio1em0hUS5O+BO14W1K5rmexztUwlkPFuOkRpuw=;
        b=brfZhrjoJR74ge1P/krCNAQQxS144Z3viaSsPmBqB5Lw3SNv8FEJXE3GKAo5vsCsKw
         kPDzKxnj3Y95tsssebco0v4ZifUEqyKYJU6q1hu6Jq8vDR8IhdTOvcB/maLM6A8zebK2
         JESUNI/94RsN0DflgrBvlAOTIk8xDLEPCLwIaQOWWXHZe6ZDsmjS+iS9qMV9pg+SmXMN
         VlqXT6NVFywAj5G11GrHy4ut9LXICFPjyNbtyeOexoBV3sVu7AK9pIj40SaGJidVpZme
         cHo8RbejBvQcU8ro6ojNwmFEK6uvaroC+Oo7KGbe3fSeccuAbKZYodJJZ3Z140JyEnwn
         jagw==
X-Gm-Message-State: AOJu0YyNxptsfGftyHCHHLbt1oeTnJztL1zN2p7YtzTFXjZNtxrDyMbT
	a0RTqoObUU/Y80piWcu2k3GRUOP8ufj0FHIQEleo5bzdei0fztFp
X-Gm-Gg: ASbGncsKgt07w5GiKBBGt4A0q1DMDtqPLXxQ9RbYeDJp23kHFce8+KJbqM7WwwyqU0L
	ZIvFiJEPq3uKWPwyIf7oVV+B3Aak6IgUxlfCH8UAZs69nM43LmKpBllnr9DedjCQ9XOP28esrEy
	3sAhsEMkU2M1PfrrSs7ngYVPA7Wuy7ajWzblGQEdGaWKcEfRPPKtHaIhdNgyOzXtJpiUUnEVsGV
	0sZgyo7a/pZehtAEIGbFwIhYf9ISYbUVxDV2dTzM9mpH+1TYMWfECHpS0+i5GsGk3Lu2FxN273r
	22hitsKYayYz4rrwP4sjXlI9Y8dxJa10mhpcv4JbjIcn0ktkjwD3pfYlpDAAxjDFi1OUVds=
X-Google-Smtp-Source: AGHT+IGxycMLBhSZOxEU8iKRGkHiJ+ThyNtWHBdu/vKMM2jrKy72IIpxSxN+b6g73DiK+sjvd23jYg==
X-Received: by 2002:a05:6a00:1404:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-73bbee4fd32mr57403b3a.9.1744225909704;
        Wed, 09 Apr 2025 12:11:49 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c3b:674d:f69c:9806:a3f:9fca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4f768sm1772146b3a.142.2025.04.09.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:11:49 -0700 (PDT)
From: Subhaditya Nath <sn03.general@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	sn03.general@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH] t7422: fix extra printf argument, eliminate loops
Date: Thu, 10 Apr 2025 00:41:10 +0530
Message-ID: <20250409191139.29644-1-sn03.general@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <xmqqr021qkeh.fsf@gitster.g>
References: <xmqqr021qkeh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed Apr 9, 2025 at 11:36 PM IST, Junio C Hamano wrote:
> The other one in the example in this thread could lose the for loop
> by doing
>
>    printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" \
>          $(test_seq 2000)
>
> but for uniformity with other parts that cannot lose "for" loop, I
> would not recommend going in that direction.

Interesting. I didn't know printf could be used like so.

The patch I sent earlier can also be re-written to lose the loop by
simply passing the output of test_seq via 'sed p' to print each number
twice!

