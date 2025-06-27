Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FA2EA162
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047762; cv=none; b=gFG1Ruq+jMdcLcjtVINCKD4uH8flgir0mlwcEswjUyREXd+CDG+8qXq/4uq2LaQFo1k8RFitjRq9bd+l58SWmeArgTJKtIoWwKh5oaNBvv31eDV12w2W8O3yqZ7o0vrJY4LmcUUiHZMclDiWeHhcK8IcvM78VYDC94rPVsfmsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047762; c=relaxed/simple;
	bh=RVWQmsf86NkhWAbyziUf7If5LGfr1gmKPV7apNaQdm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHSG08FkgAhgiF32ze+s1H8ZEdvO6ERyD6mAkne5rBwXiJETIiq0GbiVXY3aDgaW046Ms7BGBKM6c4aXwfhJD+2d2hBJQKxdHZ1zk7q5spByRIh3BxUdgAfsISC8gTrYeVGYyFNcFI6xA9NWZ23Ltm/xFVpRqbbpnDMwyjt24fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpBVqszV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpBVqszV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c3d06de3so251206b3a.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751047758; x=1751652558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szo6VxxZVtV+OKQOxb+/0ZBnXQM4vgL/BbNX4NhsyQI=;
        b=OpBVqszViDIXGHKfvKzSzmdRBUbDWkWd7KNCIwuQmhWrBjsfnKrujgBT2LgJ1PHrNV
         O9sPv7ghL7N02n2dQKBjAMm3VrIEHp8xqGvI+RYb7kvAzakwZWf0fs/a9kBLZEKB7GQv
         kUGyWsIagbTZz81rRYqIkVtSbocXhpKUoOjyeMgqw/1TSzbQ0Iean9g0Zc0hiOKc6NVb
         h1zdLJtbRePPZoiiJhg8KTSqsge8AaZKmjUEvGrmoTCOV9FC/nuAHEHAngXOkIJ/LKvf
         HCtgNDXOOwgQFJHiSE3cqYbUZ+9AOdXeU3WfVPzThwolcj8fAH+2MJyW54yoPZoBEHno
         pbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751047758; x=1751652558;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szo6VxxZVtV+OKQOxb+/0ZBnXQM4vgL/BbNX4NhsyQI=;
        b=hxKZE6VlHq1Uky9vEC3hPr8VZzQi4W6oIa/gDjRh1D85H88HFHb+pkCJ72Xvs0E75U
         ZTdsRA+Mspe3AcJq9qCklL+03Uy4Bnvr+xD8CskyioYcNaDR4sMT/3iwMvmUHIxmCTvM
         BguBChiwgjBgnl++/JWEfDGYwifP4mpwvwVtuD+/auor+Qrt+KxTllQVm3asFMUgZeXU
         D8bMxfWS2hQCduo9IBZPfSABUbcH7tbOGFn/td3FdkC59unqlH6S0PX7zkatXi7sjKTZ
         7Wz0kdGReZHtXDILBB180lhNgqL6lVEBKFiHHTDNUQg2x3sW2+QCnF2fUv+RXFVuy/Oc
         07IQ==
X-Gm-Message-State: AOJu0YyrnvuIhE4PI+aSegsBptRncniLCjT86pU4tU58OEnG3oNmcYiL
	74pd28gEAjSXz4EHubpA1+CrBRVUPJ45FsorT4o/nE2xZfYox+F4OewQmD5qGA==
X-Gm-Gg: ASbGncsSgWcKrMyBN+piPCrGvpS/CA5kTrlVfx6IEE0ug92kQS1PElI88l3d98Lgb0s
	ZpVfzsoV2EJtootCzPL1gU6BpfAWr6ImosAQ1znQ0Of8lnc0MipHfTkzOO2DinhvXRFPf2ojGFC
	ymma4M+Q+Otr8yQNzCq+a9Vqshrr0ODcHcuTRxn0oG7c4grc137SP6KyZP8mHyr2RctIjf4+hQs
	7uRjxcvCGZEemhw+5ouKSoWkHfdoDVtSlOuYT7ZBewDdMJT0mVe/fyV0q/Wm8gNzpQUMAstLXrQ
	jYvWX025Xm/vMBkLXct71pn2Np2SD9xv0wIv4PE68cwA5w+dh7qXccyFXDUgj/VH+UuzU5Em4ZI
	AxKE9Q6P8Y7Dt4jKWihzwyrLjsNA=
X-Google-Smtp-Source: AGHT+IG4plpFcR2nen9m3f2irA3ikwBYRqwixE5HkRwGsNvrgMBe0rTm+HyZkPsWeozeg5VUr7F2mQ==
X-Received: by 2002:a17:903:2451:b0:235:5a9:9769 with SMTP id d9443c01a7336-23ac4605d87mr60830405ad.25.1751047758453;
        Fri, 27 Jun 2025 11:09:18 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c1d3csm22051535ad.207.2025.06.27.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:09:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
In-Reply-To: <4A56A595-55B1-4EEB-9B9E-3E9F7A9A74D4@smail.nju.edu.cn> (Lidong
	Yan's message of "Fri, 27 Jun 2025 22:24:10 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
	<xmqqy0td8fa9.fsf@gitster.g>
	<4A56A595-55B1-4EEB-9B9E-3E9F7A9A74D4@smail.nju.edu.cn>
Date: Fri, 27 Jun 2025 11:09:17 -0700
Message-ID: <xmqqbjq983aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <502024330056@smail.nju.edu.cn> writes:

>> You'd need to check in forbid_bloom_filters() that none of the
>> pathspec items have magic (other than literal), not just the first
>> one, no?
>
> Yeah, I never notice that. I would add checks in forbid_bloom_filters().
> And add test to ensure we don’t use bloom filter if any pathspec item is
> not literal.

Sounds great.  I was wondering why your tests did not catch it.

>> Totally outside the topic, but I wonder if we can further optimize
>> by adding an early rejection using .nowildcard_len?  Instead of
>> allowing a wildcarded "dir/*" pathspec element from disabling the
>> Bloom filter altogether, we could say "dir/ is not possibly altered,
>> so there may be dir/A, dir/B, etc., in the directory, nothing that
>> would match dir/* wildcard would have been modified", couldn't we?
>
> I think it's feasible. In that case, we would need to add a condition
> .nowildcard_len > 0 to forbid_bloom_filter. I'm happy to write a new
> patch to address this issue.

Let's leave it outside the topic and concentrate on the problem at
hand first.

