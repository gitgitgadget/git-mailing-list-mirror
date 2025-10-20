Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88F1DF985
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760921984; cv=none; b=kEPVjUwkI5FM3YHZ1ajXzrQdUUXwF2pCDtk4xtbQXD89f/9NMWtsYL6LQbOydKWfwYFyafBP3eGqoMKSkn7AkY+eK//9jR1IY3hQquUZ2JOisHMFv+i2n6TIQUITeFdtiwhBZ1inM+5M1hp8s/yYUMXLvzWmUgjzquJJFgu06Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760921984; c=relaxed/simple;
	bh=UAVcAXaM1YmtIHYIfJDPvPNftHKVgmMdbIo3rf8vExw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=WwakAOFcUcNU9S6NcY33MXzuhPV9Xkrk13rU9MsYIPSX6zzaAGEqh257XC8ocaSUQ4IwcaIuQfgxFhv9XoUXoRUJTE50xjHfnrSuy7XuyQP9bMj/jSfNd2hDSRNYvXzmDGCsGsbbzx3cBN8OxLsv/wCifBZRxDPEKvmS6o1sre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klJLMOYa; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klJLMOYa"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcab6fso36168157b3.0
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760921982; x=1761526782; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAVcAXaM1YmtIHYIfJDPvPNftHKVgmMdbIo3rf8vExw=;
        b=klJLMOYaGguntQJCo2+VIo+00zTN+e7mqVTobvVHNQ9Isfd0ezvaDPGyO4Ru3yZzDS
         WvtIAbvYqi5SRtiDH+3CrNOVdf+J98DId4SG1XKP1zQdylQD8p9tvr7ruIVODXwjs2Bq
         cXV0scMv7HjWXRobRKP6EGbwwwdythvH81Swl6JpRirnmRbeXqprEaRFPCUgzll1q61E
         wBRjrAZR5Sv/Y1Digdd/wHmb+ZF7OC3MQ1a48s8esHG7pdrx8r2bLZQgO/NPwh0pNYMp
         XGx6x1EXNk4yvtLzbL2NFN/hh67kQA9cKGc8H+u73Q8TOM7IrA/bix84JD2CWyhPRvzv
         Juaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760921982; x=1761526782;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAVcAXaM1YmtIHYIfJDPvPNftHKVgmMdbIo3rf8vExw=;
        b=e7l6BPBy21wxOGO9vZa+i6B/lOM7CBP+4oA2NSd+C87oitrbQJ4/0dBZboXW7LVk/h
         dkJGmKiCZw0f1tpsJL+dXvqJeCkBneJIUhSqJA0bb5QJZilpMGd50CNE6QTPR3760lED
         KQ1q2CeHXgFpE54Eedo+s4Fp2HxX34kAhk2uSazh92GxMcuh6NvCMHAVT+0d/j9ph4mO
         NUcJZtG3inT2qnJcGsfyi12IHWiklZw3YEbS6PCs14eK6txQEI7lqTNoWLVnRWN2OdQm
         a6xv8WaIIxdfb5UpfJ3U6q88NZ8tZq4GoQlfOkS2gISp8rQxUvCV/wMHgJZKP+rXz/Qr
         GU+w==
X-Gm-Message-State: AOJu0YzAUDo7kkYAJAVqe0jimuDrv5MB9osGPz4H7py9FRyFn79wpG2z
	mLWJm1vxN+4FXkwXsCg/N+ZQgQCcGJDOZPltJAnZ3UrePKfwz/nQRWY0Yxrhtw==
X-Gm-Gg: ASbGncv5JsnoYTzZs29rUYgpxHcN5VKnZResHYY6vHTqZr6fsIRCahbBrTNq3f+XDfC
	/IDf1g0uMFL9tAwRgMaoAg7J0GUPju3brjzPPB4PKtgWF/8iaQ1at3CBmiwssO1zHNdUtJ69min
	GkE4FnIgnGxmQoxLSOODe4dT5nk8CY6GHlNV/FQ53rZddhMq+gNLEGvbsDyh0PYFhOyGLysK0D1
	hPRT0GYOkfKkmtClMO5FL2mFvjTv/4OCeiCjTVoDJh67in/i99bP4I2EiQ+mqnp+l+nnLjshBK4
	9JzHLHhrGQmT9BErypjZ+e4+jtSUpsoSlqDRI8yQWkaZtQzzqqU/RpuQxC6fNgc9C2qaA8Jon3+
	74z9Gjoy8h9+PotDXKoc8z+X+wn4TO9dkX1/C5dnhT45RFT8UGeAqPwOQbixcHWGC+xe45nKGdL
	FOgoc8JRdlO13nuYd1SFQuW/AnuMoVD28c5EpeTIMaBdo029xhjg==
X-Google-Smtp-Source: AGHT+IHFMrhOTAuuoLLzclf5eJQANKC+XeD/38eD3LywDNo3w4Yw4h8wxi2+S6PiAf7ovmOA6bkKcA==
X-Received: by 2002:a05:690e:1289:b0:63e:17d8:d96f with SMTP id 956f58d0204a3-63e17d8dc72mr9178040d50.30.1760921981755;
        Sun, 19 Oct 2025 17:59:41 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:b8e0:19d9:4bc8:fca2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784641f9dfdsm17815957b3.10.2025.10.19.17.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 17:59:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: No config option for `git diff --stat` to always show the full file path and name (without .../ abbreviations)
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>
Cc: git <git@vger.kernel.org>
Date: Sun, 19 Oct 2025 20:59:30 -0400
Message-Id: <01CB27C0-3378-4455-9779-33D8192BD4B1@gmail.com>
References: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
X-Mailer: iPhone Mail (21F90)


> Le 19 oct. 2025 =C3=A0 14:50, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=
=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 <dilyan.palauzov@aegee.org> a =C3=A9crit :=


[snip]

> The reason is that I can then copy the file path (e.g. with the mouse) fro=
m the git --stat output and open it immediately with less or emacs.

You might be interested in git-jump in the contrib area.=
