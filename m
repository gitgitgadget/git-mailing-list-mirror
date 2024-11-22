Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F91E0090
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298735; cv=none; b=cB965CvCek7awxB29pWjkn1zGV4RBgc4Q6Zg/Bb6d05nnOesrRIaj3rzOO79TJZgylaqXpIZ69+nb2MKfHxMl/XvEAGC/v/qL2VOwzm6yLoWdL/zumdbo/L4dnv+NSdmXfHxGafe3S7SPXndnCD1EL4ZstZlHpWI3+WVEfHl5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298735; c=relaxed/simple;
	bh=w9trPN5jo/nt8ZYJK7Lw6h/O6Dd6gvy4a5qUYdpVI6Q=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dTj7TR5TMTiwwEuIHcZ/vv+jkTSQttQc0Cp8gCaGorLyqbRA+ptkqQwWq87OQHYcZTkdVzViHkl2Vg588pG7MxmpyMILts6XY2b4tu2Wt7gEKVykUa0M2C7M81SM84b4RMhaR0QE0qMk2rq5koDpsEBM2FtEoOCIjI+PtDZR6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsFDGda8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsFDGda8"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e381c19246fso4109444276.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732298733; x=1732903533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K26mP0wRJMeRSuSBhPV+aREIcPdVQKpdOSQX08PAgQQ=;
        b=NsFDGda87usxVU15Q9VMTGdrhEZH1GMHusuN2CTPozz4ekgJQRo4+P46UtaU4CPcPs
         8ifb8BxSXWbq1yCGcdbw7fZuM6PbMs+3XQEjbAApR4uOSocIjHkJfyjj0cio6M8Gdt4U
         RdkadXcyGpxKcFjeuK8CCJeyMz2Hu++OLb1jvz1ldGbXeeo536Rv7GEFWnmVUSXMMhsE
         Nr6F1dCMz1LOS/JP/6l/mqAhutcR/Y13GPsLNlFDeVc28NFnLTln/kZypE34blWme2F2
         OZQZ924JLx+6mMVxRQKpKfsyG5jkyoT8UJmn6XMbJXhrBns+omEdzU5+qKnDDN9jGaIR
         cw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298733; x=1732903533;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K26mP0wRJMeRSuSBhPV+aREIcPdVQKpdOSQX08PAgQQ=;
        b=HWQqjRGPxt3q8d2IJD4jAYL35DR2MWsQ0H6sAQu0vcrlqyRGh3vuH1wUdSmjrf7j/a
         pJwyEXfTgMoBAtf9WcbIHzUx+2I41SfHnTsNSnQP7Xa+hhROpVrlmEu59bJXW/DnnV2j
         Ysou9Oi2ssCqg1CxlJ7FFqjWeeXonCfAlN5c5AdTE4+LiZE9Dmo/hGbIRdj7qQaAscDO
         Hp27Ook1zaypHvTwp2RQkNM3y8Chg7v/Oovwv/8ieoqC4ssEE4qjr1UC+gBmI4BVEa1M
         w4qqSqYdrK6JDZ+XQfpY+7bVB/xqn8suHPvAdymwpNoqnxbWMfZNgYQcZuV/4kjGvv8X
         wnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxiBQy92axyiBxMc1NioybtikPZnjY/T+VNpy++TSU81nF/FcW0a5ygflLgX0hiL1Mno0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08Ttpyok5GX5aTZLz0LGT7t3Vi/nvwdQNxPPJ23KpgLgTEZDC
	WpC0RfQiZX05vez8U9ubEZy6fOYDEKc3jYBtjRDFWDeQ0ff2qxHALP65rE4WdNon8RBc02chc/v
	rYmwEepAhU49X3iTo9Oxup56IPBNJBA==
X-Google-Smtp-Source: AGHT+IHlhRzGx2vrdaG0dmgLvn7Ih3yZJQEMfKBH7sfZ/my0FhOb3Cm4VJ5n5g0MgZjtcQggrk/YYdokUU/gcHB2Afsh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:570a:a451:c8a3:c7d1])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d80d:0:b0:e38:14f9:cd0f with
 SMTP id 3f1490d57ef6-e38f8bd8497mr2332276.6.1732298732793; Fri, 22 Nov 2024
 10:05:32 -0800 (PST)
Date: Fri, 22 Nov 2024 10:05:30 -0800
In-Reply-To: <xmqqiksgas54.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122180530.530499-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, 
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, johannes.schindelin@gmx.de, 
	peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, 
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> I wonder if we do even better if we reverse all 8 bits instead of
> swapping nybbles (if we were to do so, it might be more efficient to
> shift in from the right instead of left end of the base and hash
> accumulators in the loop and then swap the whole resulting word at
> the end).
> 
> Thanks for a fun read.

Ah, yes, reversing is better than swapping nybbles (the least
significant 2 bits have more entropy than the next-least significant
2 bits). When writing this, I didn't think of shifting in from the
right (if I had thought of that, I would have indeed reversed the bits
instead).
