Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1556345740
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768056248; cv=none; b=AKW4T7WWrMicYeLDJObMQPs178iF6izb3UzRlBMwd6yVKq6sahplEE/6v3THUqbG5awPeNqQWvIMKW324ulajPJmYZNp9h7c+fnzRbBDvHM5S+Gd9PJSHd54z8dR7aeOFRh5clgb/WyYzeONj3gG7gfISH0CVyZ4buCb7DiEjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768056248; c=relaxed/simple;
	bh=iWcov4ByvQuv7QOr1c4127m+LOvHztbwqoWJ6y43lWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYM+ealCiN8rnpO3iWTip3C0LpPMAwsLR1km5aqpbzwbDKh4KRMqzDKnQgZKt13qzaNKy9V0P4fephYF/X3vXtjJ5MBpC8uOkqW2YWj2NtZuaX2zhr6iqkpE/choqreKYlEbCIbgEO5boWZIg7sRTi5MFJblgVtGeGzucXJ7EXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFq/F1ZG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFq/F1ZG"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so5193497e87.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768056245; x=1768661045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVWfpgAxQ5QSY+xpTOeRLHqUq1m3LpsNaMiNv3J1B2M=;
        b=AFq/F1ZGQqTprzEDZTaigjDYiO1EJ/8rVCDlCkt5IUXKtGOnGsiBQP5LqKsDMOLrBw
         A9KE5MLE5obsi4bq/Eua6KVus6u6+d/MVsD08K2ZzTRhT7gIZLnaf8v9K/y5mSRwgg05
         SipfeRp9yQHzMJ1eWMH1cls4Ych6OMsTzsrHfIWutnehqh8AXNHfa3tiPKrDBRdDDmCO
         UQ/7AJJx1oo4WqjqlNuBm/LYH/MF1eQbqeq8QVOqF4zok5V8koL3Pb/UjQWlLaukzBR/
         L5nIuAWRArpVaUoY0BSRAxj4wEmD96EG34gHAUrRn1VXsXegcsIZEwWpnkOYtHTpLxgh
         fcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768056245; x=1768661045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVWfpgAxQ5QSY+xpTOeRLHqUq1m3LpsNaMiNv3J1B2M=;
        b=m94aZdGCJvZ3OSqqvHfYyK1IgDW1g++KnCWlZlMSjDMTV7IVB1FC2o9HsSN+6acMiS
         8HtBzrIYxdmTZYpDZo+qg0v7vaxpb8wRiulzQAwJLtBGB7POjlG3Mf7Xlt2cpd/j84Eg
         N+ovYBBec8xd6V4TiBwmqMXpWUQUer3URftHOIUvO5kJ4MrSTUUYihY4zQ7WiA8QKrT1
         +mWme2UNS8vyEkF9wwx1YchYTsOBABuvrmUnLqgdNyCl1/ZehhrU57vtD2d4/f8oe7oM
         Upa1VMSqyTqQgAzjnaJS2sCGPdXZuf8oz6BxhCbnOnRHpLN4L7CagVoD6+dRff8OKNM6
         jSzA==
X-Gm-Message-State: AOJu0YxZ2MaqdUvFmebG+96TOJJ+i6rFCEbsRptVPSIqjtXxi1B8BxBO
	bHaUBeUI3vQCcMiic2mtyPxVGWMgaDDUPsBWEOLGeh9lGENt/cVZx/xw
X-Gm-Gg: AY/fxX7jIqMMyJARmqgEHzS1eE5FR55GqXwZSrDoQhb/xMe6qgBJtj2WpKdQwEwAcuC
	hSz80+WBAR8LaFRUzfqoTcFycfiiaHlqVNhmhju/MaOvZM3WDrTPQZTX2d4ZMt9J8b5saY//R83
	aEum3VhzKpTCjTdW4EybFFasJwwT0AF4NZ/s/2flNrdqBye6diQ6EP/MInhrWuByEFIxancEXnF
	jLHGAXQgqieYDL7uJq2FuanDWZZvFeQ04l0TaM1Uhyxyn7ydqhA7DaMr0EyQZiTSd9LvdiHaq40
	W9z3T7AaXJ/bUD2jQbymn5d9T10GO4wvbfp8NF2vAArTBdOklqi3S+5WY3XnwJpRnvap6YSJdcc
	1E71KBmCTd0i5xRepGtOJVwsrEHzVd3MCVfy1C3WmjgqtoGgKyGl9hyBEBuKR3CMEtYS7eaWDp8
	uPSs+Q09iZ8PD2gL7mF/As0u8AcO2Oku8QaRwbN765DP5co6IcUX17+27J12Ux+BtC3G7QG+s=
X-Google-Smtp-Source: AGHT+IHsNADGd+2kKv9JyMoK5tTHcsKxdefdrxmi6xzX/3We26/DzsNhMcr+u9HuHtzkRi2K5lVklg==
X-Received: by 2002:a05:6512:3083:b0:598:853e:4866 with SMTP id 2adb3069b0e04-59b6f0421b0mr4635344e87.51.1768056244559;
        Sat, 10 Jan 2026 06:44:04 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6bebfa94sm3066604e87.55.2026.01.10.06.44.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 06:44:04 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Sat, 10 Jan 2026 15:44:03 +0100
Message-Id: <20260110144403.16387-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260110110629.18501-1-haraldnordgren@gmail.com>
References: <20260110110629.18501-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why is this variable called "push_sti"?  Calling the return value of
> stat_tracking_info() "sti" was klumsy but understandable.  It would
> have been much easier to follow the code if the variable were named
> after what it _means_ in this particular caller's code flow, like
> "cmp_fetch" (comparison on the fetching side, by convention negative
> signals an error, and zero signals 'the same').  Perhaps rename "sti"
> and "push_sti" at the same time to make them more symmetric?

I renamed to 'push_cmp_fetch' and 'push_cmp_fetch' now. I think on my first
reading I misunderstood your comment.

> Other than this minor nit, this step looks nicely done (and the
> previous one is also good).

Thanks a lot!

Harald
