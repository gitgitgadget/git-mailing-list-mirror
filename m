Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603231799F
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330887; cv=none; b=HNUyrOHXe0bRYZUPe7d1eyxBMqNfeVUGcWVB+iglal7PtdQiOR4fZb947sZTy+gdyt/HfRw9vURn1yZg+ixnkYHiiLkPWDtni51Sfv/GtMerN2y6QqzGnDaaidNUuCFlxsZlnuWLLcuoIVuaO5+zyXdaLo6jD7zUQSa7ZcBmB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330887; c=relaxed/simple;
	bh=XvxpLLurtaVEfgHTJXgLK62LWD9lmstINUOiy8Xobr0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ekooZG7NQXAVZ5oalKXB8SJ0VRf+PABW9TIS0y1eivifgYO8nkDOCLRWz310T/zfzXdT1tyI5bjd75sTA276B0JFuAVf/wVqTZ4yrwTRio2223p+DBakX2z2wGiyt51ADDmu6mVLZWv84rr6t33IHf2AE7kzvhvejbegYoF1SWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaHAIcr1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaHAIcr1"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-236377f00easo9282475ad.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750330885; x=1750935685; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvxpLLurtaVEfgHTJXgLK62LWD9lmstINUOiy8Xobr0=;
        b=KaHAIcr1ILwPNt1qY8aw7lVuuRCK9oUOIfBn8Iruhi8X6XsuJfyNDaWVtVXR73r6o0
         LybGe6KcSzUd7Ly3mv3Y1cPuGZ+6vohoarNy63XCThVYY2CDr/m/thAnjbZznOgrWs1m
         IQKwvrD/c6H4qTcOaCuOjX2kCTDr/vZRE7kfaAygjoUSvb2NHJgtM0kogoBPb/yk4haY
         cCUhQtG4BXyCUVzOOrg/zVaBrppe2rxG96cW3ZLs7NIIsrwkKiXKZ69nwehB54MDChgX
         tkRHeaqHiTfdbO588keFZfHumGYxFUWkERaSddwtc8eXMxo0Y8xyH3s5nqwsqIYlHd5m
         xbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750330885; x=1750935685;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvxpLLurtaVEfgHTJXgLK62LWD9lmstINUOiy8Xobr0=;
        b=ujHB8JAE5QdKT2RkOQOpHQQGYqUqqNsDDx4bBeNFwdTd8Gajl9+FCx9ltYX9T90bmc
         GHzGD9qMBjy9Hrf/Po16ICABdFPTAcCkyFkBLryImT0Szat0vcWFhoZaI9G5CpTyORtw
         lv0PfJ6CFPMDWHjXESQ1hBKLcYnwEjubVVYZMKvgJWcQbea6/CGkADxOhIs9olmbHtc8
         +Bo8bOOUtGQ9XGu3qTnlMSsKhTeV+dIHvty66Pb6qOPDM3U65bj1snVCXDyGsWSf4BLY
         ClRmHDZB/xo/mjAnbRtBd4uV1wOLPtdDepri2x2JJ+Eh6E0UemXjxh5OFZMY0CFEhLq2
         pSjg==
X-Forwarded-Encrypted: i=1; AJvYcCXOWIhN62gPhMjVjjZugkrCirQCo4K/cVO3nB2r0sE9g4KXzaTQC02R09OqtEglLqhaAAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjm7EYQI5G2srM5pv7uYloE0urnWUmp3eSS7HmQnsPs6erXbE
	wYv0N39K0TdNQzn54oT1HWThdDc73w1gdzyL948oL0PxX06pX0aKkgz0QgU0iSzu4JIW1g==
X-Gm-Gg: ASbGncvRLjbtEfY095Zy7kpGWaETVWGDNJPolI5NEPh+Kb8qGKYBiu3YhAVJd9d2KLJ
	MzwbSxVGVU8e2z2nWsBuqrRYP/xXZceaHGekoPo7GCLgO1JQTUzuckuT/4VxS3kmi+3vx3WuN+S
	bh0D8pevDPImqWOUi8jrz3t632tJU5lY9PDfsmgjwzNh+N7ea5v8xNF+wFTw/GPaFISpWqzkWaO
	t2XUfOk7QdqKxI21sbziLPY+meqzyNYBwo6oPVtC5iGk3MKZ902bfAiLR7OyV3SXMxyJ1xW1gTh
	YZeTnHVZO2JJpV3TgI31wJTIZ4y8WiHDgkfEnhEwqTB1mhvn/3aUqAtBe1jb/CiUYlb9E7+qBdK
	x2v/rrv5uE4YFMLsI0gEf6XYE3sI1vMNnmHvjwAIcZ6CwhHiaDWcbztNgUx/fDwUsPQ==
X-Google-Smtp-Source: AGHT+IFqtReJUOVQ/Lqee4L+MNv+KG0KosnYewx28yEFOu1TSvkGoIv/d8lsLPgPnLRViyGasm+w3Q==
X-Received: by 2002:a17:903:32c6:b0:235:ecf2:393 with SMTP id d9443c01a7336-2366b17744bmr344585255ad.53.1750330884876;
        Thu, 19 Jun 2025 04:01:24 -0700 (PDT)
Received: from smtpclient.apple (n058152119137.netvigator.com. [58.152.119.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d82sm116860945ad.146.2025.06.19.04.01.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:01:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC PATCH 1/2] fetch-prune: optimize dangling-ref reporting
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250619040033.GB1801319@coredump.intra.peff.net>
Date: Thu, 19 Jun 2025 19:01:10 +0800
Cc: Phil Hord <phil.hord@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B83B89F8-8129-445C-B4F5-43C86512C114@gmail.com>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <20250618211024.2332525-2-phil.hord@gmail.com>
 <20250619040033.GB1801319@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Jeff King <peff@peff.net> writes=EF=BC=9A
> ...we are ultimately relying on refs_warn_dangling_symrefs(), so we'd
> have to update its interface. And we also reuse the list (here, after
> your patch, but already in remote.c) to pass to refs_delete_refs(). So
> probably not worth it.

This patch only adds sorting code to prune_refs(), and as far as I can =
tell,
prune_refs() is only called once during git fetch. So I was just =
wondering,
would it be problematic if we moved the string_list_sort() into
refs_warn_dangling_symref() instead? And if it turns out to be safe, =
could
we perhaps even use strset in refs_warn_dangling_symref()?=
