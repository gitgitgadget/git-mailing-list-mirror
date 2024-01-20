Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3715D0
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705783430; cv=none; b=d6mZSPsWcUrodOQyrA4+Jly27AwLbhy2b6e8RIhjtXdbf9KguYwnxBZ75GtMzlXsgcUhHrf1k4GVsrvA3uDqaUkAydkSfHt1Mo5PQgAfV6XyCcLNBDB8MHPiRtQdR7N90bXTUavXO7dLHYEKg/LIlpbz0ybppoVMz2iPB+LmMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705783430; c=relaxed/simple;
	bh=rvA0XTcUIZorbXtGTAmXugiVV+jOdMXXPuxYUZ7lvQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kfQftwxteUoLNW3uFg7th95PzZldcIGf/D4/ozz0+/qAN/2EqHypJOX+wW1CkCU0DYbY3vybeC73GzejpTvKewP8D+Xf+od0rRKwp/g7oeHugfOT/u1Uya2HIyZA32VWKSxhN2s1cphfUFliYir4FRNLOBYaDotXFaXEJnJbLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bn0Jrp6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bn0Jrp6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc26605c3aaso2128444276.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705783428; x=1706388228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvA0XTcUIZorbXtGTAmXugiVV+jOdMXXPuxYUZ7lvQE=;
        b=4bn0Jrp6U+tJXXiNP9xve4IB6Do3638qeXF4DE24h8+dUfM4CzGB3KPjMIWpOYS8c3
         cOSeDS8I9MyAmuu4c1G9IlEyQ0tT21i/Mc5CpJVKceQJt2nvQOoh/hOSBuM8x9A2+PUv
         m/dBgeePjLjk5deAjUYCopZ19IcKG6WI91sVik+tU4/3PaNeLNm/zQtZwOTCaf5UmI10
         npzysPEi9W/rgvM4LD+894u7AfOP42j2uHkoehhSiQW+lzaOitcIGdgO1SetSZgYFk0r
         7ZEM0zFEUNHvfupXhq+Iabmk9qL2sqzzj10pwMZtEa9wmVpzPbn2cJFl3pkDs+DtGTlG
         PjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705783428; x=1706388228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvA0XTcUIZorbXtGTAmXugiVV+jOdMXXPuxYUZ7lvQE=;
        b=LUmX/lO45X1AL2uImvwTgQs1SosuUmiDZOj5+4PBh54AQ0KPzgAxDTQDYGsSyByU86
         UzlFzony9dcJL2yX7rQqYo18wFSzaAYhMo+usKjoFKnGTfmaMnNsJPhJ13pCsl/l1Q61
         skDmj2JWcLL3OxwfA44gJ05N1Sp1WZIOefLDQk+Ftql0LP1CzSCxDJKnTAtL6gNGk2XZ
         9RsbT33z83azlcZnltVEihmNDN0hOIXi4hRXqUBWI2X3O4m9IKPhSsMUgrw4XLpF2/4w
         FeXjS9UvveBEq7EQVIC+tHj54mzdg0JzuSAurKXN3aQcUkBnE717uDLN+/C0v7xTl3Ez
         s9jA==
X-Gm-Message-State: AOJu0YyWShOqOII9AVCOW/gVkztoMAjUAjbPNuiL/rE7UHFGOB6lLqBE
	G1uXiMDMI5wRl/hzZ1HcSeN5G1MyVjdl8wKANmu30dLLWeadrGXUgoLpopV2H3IfidH5X4baCoK
	Zvg==
X-Google-Smtp-Source: AGHT+IGHy+KE5AcKEBICwxE+LUn9ahPxAg72SV0fFCnz4CTTxe4vM0j8zT48McZV2C3BV9ZUXZCVL61D3nQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2489:b0:dc2:4e03:6bb8 with SMTP id
 ds9-20020a056902248900b00dc24e036bb8mr161389ybb.12.1705783428034; Sat, 20 Jan
 2024 12:43:48 -0800 (PST)
Date: Sat, 20 Jan 2024 12:43:46 -0800
In-Reply-To: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
Message-ID: <owly1qabhh19.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 0/6] support remote archive via stateless transport
From: Linus Arver <linusa@google.com>
To: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"

Jiang Xin <worldhello.net@gmail.com> writes:

This v5 looks good code-wise. I've made small suggestions to make the
commit messages better, but they are just nits and you are free to
ignore them.

If you choose to reroll one more time, one additional thing you could do
is to use the word "protocol_v2" in all commit messages because that's
how that term looks like in the code (unless the "protocol-v2" string is
already the standard term used elsewhere).

Thanks.
