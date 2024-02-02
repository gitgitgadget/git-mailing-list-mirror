Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C301474D1
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896388; cv=none; b=ftjZHEl1uThrPUSTrwGw4vK0xO4pSAvBUPMNKBEOZ401WPsA694Bu8Ma3lxhLA5mxHuhPKRNaASeijA/Wu5oeXSSemmp31bmkXgfY2OiC06uynszkUTRK/p5Hwk/c6+tkZqJsgYB7p5QREdhktqABNsQ9eGajpcNUSvUZor++Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896388; c=relaxed/simple;
	bh=bAhlUJrCsfK5hUNmNT03kgCDEHOWtKq0na4lk/dL5EA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oD3H/BLkvn6iqgMlhudpj51io5BaWO8mkMe3WeL/ETO2+wWeNr9ZBaoLObkADsqhKOEEW3n+lLJh+9bkr2qBZrgCznT0DyGy7s2U+v4OHfhxcjUqczEfEOcEK86YICkuBZWa1R7zeeHx4vlc6CLGeYHw+Iou+ihuC2HFqdSk72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BotmKMo+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BotmKMo+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so2625758a12.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706896386; x=1707501186; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS7FEpkJHCLxcIG4cpBh1/TgFPzTEp0JRYPUiC9kcKM=;
        b=BotmKMo+xP7X12iKWFpS5YRZN8zCTkze34FbVdOrESmb24JwwiTwPAJbhFVPB1XPyq
         B8e+v/OcLgFrPPQCxfJr7oPabO1BHOmQMeVNj7RkUklXcY23bM6PUrXN9u/ZzRKdld4K
         HLV5E0HSmoHOrPEH/kgnMKBw/G1E5RK2Ov3mgudE/owczXIsz4zHLrHoNhgVJ9szVuDp
         FfuSCTOHVT9oZJtJlua2cBcvYpoW72g//yKSXcKMbJy5MFWlz8uuHZHxmR0Va/p8hqTe
         3HcDKPQYGIzpLyXod1FpF4u1mWBOR1u/cYotMclIijto7/YpbDb73WcEd2T63Xv8ZU8E
         bopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896386; x=1707501186;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bS7FEpkJHCLxcIG4cpBh1/TgFPzTEp0JRYPUiC9kcKM=;
        b=kqdTS12WIWFrUQJiDtLSVTJaWQKtNPtp6SUbvO7nAOZYB7bEAy/lEuuxk088vu7o8a
         TT4jNxoG/at/1Afwi2keEezqIkOXkBwm5V9QfNV5pSDYYBfB7+XG1wE9UtJt/NzBxquI
         3JLqYUwj/uXKfZkv5Z+8b9by2J5cW7AYMBugiPNC4v1ZXGuL5Zjxxm1OvcQl2bWkL1sF
         aPQ3ZkX6v4ZnfxKmennLqqofPInWZesFqLStPyMhoxbRa/QcHKAkr43bCJA9PbQA+14U
         uTIWajPuKwExjrLTQQthCAnFrnl/Ox9pAu4rRodkn7QbhI/hEMK5Y/3tmdUu/ndHooe7
         ZXzw==
X-Gm-Message-State: AOJu0YzZg3MG5lRUdO9JgSUHzwrXWa40f9huOjX0hrTJ1TU1IKx4S6Wi
	mSBF4Qq91Kk4hGaCDRRvOIol0NFYTHOnvJ/dw+rpkr+VHnUDIH8mVgTh2FB+sBc=
X-Google-Smtp-Source: AGHT+IHMrGVXTqjZqC4W6hdhqmCISTfTlqxwvNXVGdil7RfYyfb0rS6lyp5Ib6PoBqJn7rZQItAaPw==
X-Received: by 2002:a17:90b:3c8b:b0:296:4169:767d with SMTP id pv11-20020a17090b3c8b00b002964169767dmr3405212pjb.18.1706896385844;
        Fri, 02 Feb 2024 09:53:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUvdbZ+DDaUQMVEwCZ301569aC5cFWTs+Lmzc6iTwWDOT0RUh987eI6gWQxjupT5Bg7KnOWXT7zH1Q=
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id gj8-20020a17090b108800b0029604b0b7d1sm308592pjb.15.2024.02.02.09.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 23:23:01 +0530
Message-Id: <CYUS9OD6A01I.1IQC872DESCQ0@gmail.com>
Cc: <git@vger.kernel.org>, <ps@pks.im>
Subject: Re: [PATCH v2 2/2] add-patch: classify '@' as a synonym for 'HEAD'
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240202150434.11256-1-shyamthakkar001@gmail.com>
 <20240202150434.11256-3-shyamthakkar001@gmail.com>
 <xmqqh6iqu73y.fsf@gitster.g> <xmqqv876sqwf.fsf@gitster.g>
In-Reply-To: <xmqqv876sqwf.fsf@gitster.g>

On Fri Feb 2, 2024 at 11:13 PM IST, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > You decided to use is_rev_head() instead of user_meant_head(), so
> > you'd need to update the above description to match, I think.
>
> Having said this, I have a slight fear that normal users would
> expect is_rev_head(X) to say "yes" for "master" when the current
> branch is "master", though.  is_head(X) would have the same
> downside.
Yeah, user_meant_head() looks like the better pick. I'll update it.
