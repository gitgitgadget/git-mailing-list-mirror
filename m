Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9023E0C41
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648272; cv=none; b=uaQCtT49Fonj0wts4WHi7OpNjzQd0npbk+zcPkQXv1yG3LJHj3BTf2WmwYUVQWGfhM8MiCa5RxvkscsB3OZwmn8TJDbjHy93XNYmCuHlS/NaEIZHU2RGw46CbKqUcYp96qeVijaj+sbI3TktyYZcBsC2ar0GuyQZ3lb4Smth8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648272; c=relaxed/simple;
	bh=Rp0OpXEcEpmAQuWChHqSd1AGV3napctSEJe9rP9Q1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdqkJMMV7xQ1A2KTYK95stSeqOmjWzDh5oHl6z7euYEoxwGwhNqXWZBdT5+AnJ4FaYZB/VWy1vv63qkt7U2G0eSKxLUpboDyn+OFF+qmRoNNa5wToWMwY1o8wpTyDJZ16ovGS448hHDbEquesvzRuvJnhfOxh7HAtCmnbyghURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqQrS9Pl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqQrS9Pl"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-827546f228aso5100015b3a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648270; x=1773253070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp0OpXEcEpmAQuWChHqSd1AGV3napctSEJe9rP9Q1Uc=;
        b=eqQrS9PlaLh9ZqBCu91yYGYfYZsVDeypgCmQxmwGFhoDHQzlqMeQbpFf6FYepUrh+t
         itxNGvRyuPH8Oll4ZUU/2SzrcnGKvjQctMOYgTdWd7dpTz4vkmZ7t4jF8K/YKs7xe09w
         WRxapWN59Lr0FNXlNVEmXuCqBJ1J7mNpe8t22ytUNsv41cO30er2ayICZ8UV3ElUVhnB
         lPKG3JHCLXwJB5pGN29z8JPlDwtTAOHeNQqRngTJbDrif1+1DGKvQO+eS1KpE/xSwx3/
         9SfoG8FJL/pNgopufm9CckKPe+lgU1ZUmg6K9ArL3p1cvrpA+PiB3FHKYSqqMxYkqXgF
         sDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648270; x=1773253070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp0OpXEcEpmAQuWChHqSd1AGV3napctSEJe9rP9Q1Uc=;
        b=Iq1EcQBNWPDI1fd/vo5gW3ijmYWuCiuPOVWs5bHpZh93a1rOR56X16KB8Ah6lgUudD
         SlEiYJwOFCI44TEEWxHDVm5wxUn8+pBW3S7Ltgqsv8OKi9iRFmL9rwLFCGzUYMV3fnYr
         0nG5Pr3JJnEgRcOHvcO1BGo2+JU2OAjpPVt/a7SH8GWgXgQLY/5dQqTc28ziRhrimul0
         9Y01zwltoI/OTQrzcAkzgDLzef2g1Wx6x3TPNqlnDC32qDwHbuK/M2+zwV/8tSnG7JzJ
         chPVe1uYtfx8qeLhMfWjF2L+QLUTjMsaY9q0KHCOn7Ead/utdlD2wsuz1G4O3aH1RFw7
         YdoQ==
X-Gm-Message-State: AOJu0Yy4GI0rB5WMjYp/Vpj9nPbX7Xr/zwWzvJs/q7peJGHoD/MZiCHR
	BqJNSvjh4oBPAhhv9vkDJEGx0hjSH3NbcCTfDjalhBqw+G3ggMJoPqOhvjhvMQ==
X-Gm-Gg: ATEYQzxQ39TTk6VfRtfRmK2Q/JmH1h+/VZ7eetxJKBC3K4wJsTzpLXgW4o+j2LQJGrS
	zwXVYUSVb8gPGhSiI9u/R+8zkhctARHzHQVYAWdw7NKScMtyMOiDkJNWGEk7gO6Ip826Gu8F8Ce
	kUcqazEApLk4CMt6fKXLx18qcHI8E1dHF3OUJWyW4EOLdNt1pgkW0yA4Eq3WAY+O5VeFLpW+hUZ
	qL2Ucd3I4E2DkSRkDcRpuq8QZ9RT2zq3lazbZT4I0HvbZY45l20MPG9fXXu1ReIPaJyH6e+U1gH
	yEfGXu9eJRSxnUz1Wf7haI8kjLDtpM0xdrlmGUN1aF477xfhPwp69T3VdW6AgfgZe32KZtyOh21
	H0JkIqixY5uiW6/DYhHA/HcHGtOnKMVs19dmctIUnJjLlFqTtuk1FxLiBNCQQI1MhnrDd5Bbi+/
	b9Z39Atkj5J+2RqmfgXJPYF6jHbU4QrOfgASRV5rXlXZAwS8oxVNtcU/dp5LI/phXO7qKgFOeQy
	LelL1lb5w==
X-Received: by 2002:a05:6a00:1944:b0:827:370b:2695 with SMTP id d2e1a72fcca58-82972b63832mr2586090b3a.29.1772648270443;
        Wed, 04 Mar 2026 10:17:50 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c7aesm23607467b3a.21.2026.03.04.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:50 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 06/10] fsmonitor: deduplicate settings logic for Unix platforms
Date: Wed,  4 Mar 2026 11:17:49 -0700
Message-ID: <20260304181749.25711-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafihm4MVoVOaD2l@pks.im>
References: <aafihm4MVoVOaD2l@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> It's a bit weird that the only change to the Makefile here is to change
> how we wire up fsm-ipc even though it's fsm-settings that this commit
> cares about. Should this change be moved into the preceding commit?

Moved. The Makefile fsm-ipc change is now in the IPC rename commit
(patch 5). The settings commit has no Makefile changes since
fsm-settings already used FSMONITOR_OS_SETTINGS.

> Same here, it's not clear to me where those while-at-it changes are
> coming from and whether we need them here. I'd rather drop them.

Dropped. Both renames are now pure renames with no content changes.

> I think it might make sense to introduce the `fsmonitor_os` variable in
> the preceding commit already.

Done, fsmonitor_os is introduced in the IPC rename commit now.

> We could avoid the flip-flopping of the code here.

Yeah, with fsmonitor_os in the IPC commit, the settings commit just
flips fsm-settings from fsmonitor_backend to fsmonitor_os. No more
flip-flopping.
