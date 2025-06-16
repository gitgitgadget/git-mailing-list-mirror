Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE54A0C
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111717; cv=none; b=FWziFu9VBLpPeg4posNIe8SgW4kt7Lt1elzINGiH3Lx39uWQEc5zk5bOa3NlkmqaYsswAbnAP6tmXilJNU66jHYu4zc5KG/r3FJy2tzqcQQ0/1X4ekKq3yMbZ3/GY8NB4cEXAsbTfWo+xGC+/z5lLjGoWmBQt7IDso4kwjmCBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111717; c=relaxed/simple;
	bh=I/AGyOiOcqkB24f9Z33D2OMws4dOUmbtBeCPk+AdfYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ymyg+P5Ga1Kub4IpzjWHoU2Q58ESGkzpHaV2vyFbZhL38MzqaZt+wMEryTavW8/3315B1I72OGP5pSrFdmX/lGhQA9NrlTYIifnROu+OnUxYp9J/lIxIgoQGFPz+9dccJFeWbNHGkkP8NaWK9zQUjpUOA5+vb7d9TNPyDa/R84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImKvyG42; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImKvyG42"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54e98f73850so4834537e87.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750111714; x=1750716514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqadHbnUMnnuSsfKxGuh1M4ilGht7tbfhZovBaLFMXQ=;
        b=ImKvyG42luDvZgos6kKg+/67VjiaYqIETQykIm3t+EZVF4i8yFtyMOR0tSVq6TKw2h
         9MRXW8MjjydBp9Gcu43IhFp/fWqzYAGhWbJjUSlMIvCxvnMAs6uw0f+gDZ3TU8Ohnoj+
         +yLa/DvR5EnKt+AcbMUqJfuCpM6nBe4aN1VYsEMP1GfgKMKnVrScDGfHwLY2FOmzhepP
         EclWhPak4DeGWjhYq5HQo8TOiTxLhINSj+U5zx6KBJDpetk4Z3W35YRIEg5tmCDvvHHO
         1ELYjEvjVsWsPWOei8wmS97sbwcijSjWDNECk36jYdkZ08WCd68jJANRxlNT0CF3la7v
         oYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750111714; x=1750716514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqadHbnUMnnuSsfKxGuh1M4ilGht7tbfhZovBaLFMXQ=;
        b=vz80Dy6YozIqhnz9Pbo7zsfqD6KFR/0i91UYOjuOiYtxGHURtcWNNU4FJ9zIOghxTS
         Je+fNUxB8PBXHDXuIXAq2Gjk+6P2xvvxuP8ZzKaxd9Z2nuVclo3W0cilChdcm0ljzyKd
         r8V7fWsEv1aquJ14E/Ic1xHVlNjPnXUSvo04GJ0foTWhg2C08SJeyTRNz44vsz1zSzR6
         ZKrw414IvAd4wXTJrg35TldD325dc+UbGLDmQCoezWsUnlX+a6V4v+7klzvaOoCNIcLF
         q9Ppubirr5Wd4uLUzNeBmaYEO3rpgBl+FTUckZrdYj/B9zsJcqTKhiZ6RX3d76TuT47H
         r/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXsrf8ieYNldHTPoIOIQhXTmwS38KA4QoTbjBcDOPDxJyYtbCjavCyoSTEvLDRD/FUz3sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKm+hUihEX1KnpH8H5UxwJqAu1JwBUAh+thl7/7MsNiX7tJ9ur
	kEFLyvlYiAO8HGO1+7IOpHRN34TgCSWjiyPL39mrLpkWDwUX2Q4I3pFo
X-Gm-Gg: ASbGncsZzBuyjlBVqbdHpurVMx0oMtwFs/wvqn1oMR9KNKCDLu7l0gCx06JzFaCUAQ+
	vEqNRC4dR36V+H2LDlbcwPAlJaeHZhB66nltRzjQaW/aq69zFqgKofQAkoRRfqWwnAPsyD07SR+
	BoeKRpdE6Xy/L5IpvpTDgAC6e/FVOqaw6pqVqoF1eRN6oxBVSgTjq5Au3XkFuEiSlwsc2KOr4uK
	UpRQuZ5AphMefheTCypezSvMBTbLfONYOyEuGdCfwUcYcTfeiig1rbljvTlqOxwsELJ7RYFB1pI
	R+TvBM9ZAMuSUvgACPIeNzZu0lzIfDJBj5Cmj6xzX5Mz2OOgxcRSBAaJHg==
X-Google-Smtp-Source: AGHT+IFtiYib9U0107Rh+6KQ/Cma3TboGv0UMudt3g/kUL8YicQqo7Yp+PdXiBkcO/0YS9AqLwAI9A==
X-Received: by 2002:a05:6512:158f:b0:553:a3e7:812e with SMTP id 2adb3069b0e04-553b6ea69a5mr2881223e87.20.1750111713654;
        Mon, 16 Jun 2025 15:08:33 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1c12e2sm1669746e87.153.2025.06.16.15.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 15:08:33 -0700 (PDT)
Message-ID: <66fd343a-1351-4350-83eb-c797e47b7693@gmail.com>
Date: Mon, 16 Jun 2025 22:08:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] meson.build: correct setting of GIT_EXEC_PATH
Content-Language: en-US
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 'GIT Mailing-list ' <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-5-ramsay@ramsayjones.plus.com>
From: irecca.kun@gmail.com
In-Reply-To: <20250513191739.1513460-5-ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This completely breaks meson builds with 'libexecdir' set. Git can not find any helper tools because 'git_exec_path' is set incorrectly.

It supposed to be:

--- meson.build
+++ meson.build
@@ -1597,7 +1597,7 @@
  git_exec_path = 'libexec/git-core'
  libexec = get_option('libexecdir')
  if libexec != 'libexec' and libexec != '.'
-  git_exec_path = libexec
+  git_exec_path = libexec / 'git-core'
  endif
  
  if get_option('runtime_prefix')

