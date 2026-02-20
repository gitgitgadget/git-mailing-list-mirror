Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565C1BC2A
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606140; cv=none; b=TKKPlkXKabgUxQocunITJY+TqaQIJkPWNUhdo4IKzz+ZfrzO6Z2Y1nOP2kccJstX20Z0JbjGmdK6h7MTyTOdcflGI6hS1Ff23cOQCn0aWH3vV3tp6Bjec6flTZl/MjwL52JEJjQHd+Q0u3kPB/mSIQ5WdHYJGDJsKbZJ49769R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606140; c=relaxed/simple;
	bh=i/tD4kCHHrpRuCPlBIGWDdGNv+mP/z/jPjOxXhsXT6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U240ma+Ep/1Ck/Vtf81JFa31nUjH4WuwHDdORez3wo07//Oh4iFBDYCnvJjl4E0UUFnizg/Fbkje9CxKoX09nAuJRdyHgagBWGJNuF1xB2OhAnldA733PFiJYz0wO1Mi8p304oze/pR5AUUEuVJ/J5jBmTLvZVwBpqpXaM+yhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hztGx8SF; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hztGx8SF"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12758ce1e8dso320878c88.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771606137; x=1772210937; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/tD4kCHHrpRuCPlBIGWDdGNv+mP/z/jPjOxXhsXT6U=;
        b=hztGx8SFHxizmjuZb1ZuVfeHsMzeaCfDQekM0IteATyGssNmwyVUZX2mzSgsj5BmkM
         RIaH32QjOQKyq/Tsh6H7hMru4IuWHSgRemlxor7AURJKLENXfbHzyX4UCFdfJQdAAG7d
         Y8+oBlQgFem+WK3QpLjLmBihHT7Ff20xVdLevaenVBRU3s0ReAnVTuPPjlr8JB6m5Dcu
         G7LrfVlVksyfL14uwCOf8gWPz4ij6nWAprJDsP0hF8YjtVHO+FG5fTWdz2hxzvO09z5z
         f9AUiGMERy+HFQrSnUUoRYd1KtYuidi+R8sV6+LB5DIuW5v7hHYDYKpKeGXg5uhqZXyQ
         zrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606137; x=1772210937;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i/tD4kCHHrpRuCPlBIGWDdGNv+mP/z/jPjOxXhsXT6U=;
        b=VjohrGe1u9DT+K/BJcQzTQF5fAXi35qqwvOa8OJPXijgG+DOKgvBbyzwJ3cAXNCfEO
         3/83HrcaNguBQZ7asvNbyg4yaD5Uszks8mXXt1EhcaOH2kMF+K3tvOGIE14ScjAtBoxV
         /JkaZMu0HXFJT9ADz3OfZW/N5NUIiu/078pARt3fbh7tZYqxKcv57z4cDddPQaNu+jXE
         D0qCp+btwdON1HusDt01yxdurhiaZHB77KtIvS1IQdj3Tm8dTluFHxfRQe6zJWoiFlZN
         Q9pmaLm5vTqwefEP1qP3DKL4E9kdSYhpMRSFg5WOBJsSULO4Zni4E0DakFPdBjsTdcXS
         BCIw==
X-Forwarded-Encrypted: i=1; AJvYcCViBQ9ORVgTTTFGV3zGoY5fe79lQAHdNbzTta+vdWRh+EYawM+Lj1eUKjjG91INK+1xlmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1a6GaJSyW/1g7APShXgCFoirW7qICMypO+N0fvCymLtxS1sam
	vkZHN0V/PPw7lYDPRDPkPhjjopLbpPzlVVmoehsImjAuGGI6Sp6pnK1t
X-Gm-Gg: AZuq6aK3g0tCR8CQM+/nUDAjHsiUYdyJpOLnLK8ZPcBZusuNjcoMdBURtT8zePMcA2O
	qCY3in94YZ5cIjRpQ4cWzq6NKiyHdjXBo/zPI4+/9iumSktP8MzAT+7SU352KaCsa3iCbNFTAI/
	E/Om9O4UqDb2H742uSXeNjKdeTcGNPAH8DHsmERZG52sEvOZS9Mkdye+mZlQKqAXG0KY7fUp0zR
	OIU/6+NHCEjmseYgcUgsDFc1/D9naWoPHLVhBCTrWR4avDFXmxTZvEztcSwyqjJCpByKtGriB31
	acDTkTsU8zfGTwU1PA+rexkxDLv2K3T/Wiz+YfIdMS5hAlLV/vlLNS2GQ4D0krSa6S9mvyIFnfX
	qy0tF/yS4l8b3gKjdv3nFSeVytn2A3D7Z9cXYqthf7n5ljXRKCZrytcTFDT8SyP6vaSR19gdnxt
	Inzebo
X-Received: by 2002:a05:7022:6894:b0:119:e569:fb9a with SMTP id a92af1059eb24-1276acdb3cdmr93902c88.9.1771606137378;
        Fri, 20 Feb 2026 08:48:57 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm23935287c88.9.2026.02.20.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:48:57 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Ed Maste <emaste@freebsd.org>
Cc: Chris Torek <chris.torek@gmail.com>,  George Hu
 <integral@archlinux.org>,  git@vger.kernel.org,  Junio C Hamano
 <gitster@pobox.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on
 Linux
In-Reply-To: <CAPyFy2Dj6z9OuYFF9Tpn98mrd3Hs6BD75B73B+jkqp9aVM8X_w@mail.gmail.com>
References: <20260213124656.218396-1-integral@archlinux.org>
	<CAPx1GvfsnZiUkkXJSAtt4HECT6f+zb1+vtiT+UikcAq0WuFR8Q@mail.gmail.com>
	<e2a5c920-7f15-4ea8-9390-cf42ac33082d@archlinux.org>
	<CAPx1GvcdFN5gn97xxuNLRBy2sV2gK3Wm56Pw3tQGENN8_+BKnw@mail.gmail.com>
	<CAPyFy2Dj6z9OuYFF9Tpn98mrd3Hs6BD75B73B+jkqp9aVM8X_w@mail.gmail.com>
Date: Fri, 20 Feb 2026 08:48:55 -0800
Message-ID: <87o6ljtl6w.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ed Maste <emaste@freebsd.org> writes:

> On Sat, 14 Feb 2026 at 11:50, Chris Torek <chris.torek@gmail.com> wrote:
>>
>> Ah, more importantly, FreeBSD's sendfile only operates on sockets.
>
> True. If benchmarking shows this is profitable then we'd want to use
> copy_file_range(2) on FreeBSD.

We use copy_file_range in GNU Coreutils. Note that it has quite a few
issues [1], including a recent one affecting files larger than INT_MAX
bytes [2][3].

Coreutils has Gnulib to work around this stuff, and the performance
improvement is meaningful for 'cp'. Based on earlier messages in this
thread, I am not sure if it is worth dealing with in this case.

Collin

[1] https://lwn.net/Articles/789527/
[2] https://sourceware.org/PR33245
[3] https://bugs.gnu.org/79139
