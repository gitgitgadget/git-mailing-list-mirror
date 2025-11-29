Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9891B81D3
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764377404; cv=none; b=n40Es/I7W4cQTlvXNWhiyL0V7NvrL3COl3mdpeHTq2tD/vYeruohoWknQI6PV7axDsNGbsPUrrNrGFxuEAcrtwVCC/DRG7ZZT5uIG9AxcsNqhCV+gr45bf8u/2Xd072gwFIwV9Kav2WpB6rFi6I9msd5+Gdi2HfR2rgB+VLN4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764377404; c=relaxed/simple;
	bh=MPT7ZGIJd+e4f/1u2QSm1RPgIezca+SR0IUZYFc//6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TG+DmkoGpApizDa+kXlm1vEGvukjQBlWb1KEs2+DHAkhZTCE3ViOpJPY3TqmfErQH4Ejn10nbpMARXOwovkzAn2+hjhpYZIU8G2wVETXQsHSTXGNfA9D2xdKq7idqAPHWbAyGNb74VPkDWFFSvRHPPhNbd5UiItQkg07gm8gpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2lhZuZN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2lhZuZN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso1700979a12.3
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764377403; x=1764982203; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPT7ZGIJd+e4f/1u2QSm1RPgIezca+SR0IUZYFc//6c=;
        b=A2lhZuZNtGTlfgey+40VudY3lA0ESw0x5oii1iB7ZnmALAJZ0MkWAMT7STOP0qVRAT
         7XxpwMhCeDDO7grMkb1rj+6JvUSrpGA+LCUiZfKp1AdJ/itXnNgXEyt4uyly88Dcl07m
         qP4TXqMIV24jlG3lC/RCwzMN8+dbEYjZfXvWCGdUl0urlYZp7mx9xfM0bTsOVIwyDSqz
         L5js3VkqmvFEmdD6tycmpYhqp4vUmZiQWQl9vVETnVa4sZbFaOxwifQ8ym69XLOW4INn
         A3NDOXvICCXPXSrX58Fi/T4lMOi6h2W6CBrF9gw+FsrWDVvz3UG6GT4/wUBZGUB/2OyC
         7GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764377403; x=1764982203;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPT7ZGIJd+e4f/1u2QSm1RPgIezca+SR0IUZYFc//6c=;
        b=C3QjBqYB3VBZS7tSloNVBfF3szhpj9AN5aNiUqymap0lNpmSKkQnhkeoz8SHaZSgO+
         tePKgz7aTsTDO8vaW0OT0qMElokNPathAgTqqpNElEzFHLp09lkj+/Avf41tsBAYyv/A
         8F99Zdv1bANVoCBP5Uy3pKh990ZqqPc6AaokUS0anWOAYD+R2XZDxADyU2L3HyNiMqEw
         Ju3LENUnlFrwgKKrJDP3gDdkDCWgpJVAR2XaxtMZVpg47bfgctf79mQmP3WmIm+wfKr7
         pEJVwJILC30FZdXWQZ5Vo0C6DEdbkpGGWygK8Lr1WxyU0cRqC1V+4qt1yUDSB8G8Gbd6
         jqTA==
X-Forwarded-Encrypted: i=1; AJvYcCXY4Z2ntZjJCSaRwyLw4kohk5sVwP883A8k6VIMVDJ7liO6Xns/hK8zLi8BttftUAVADDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mHdbmXC4cilN6gaL57V/mjz+QeYcKJptTLVs2R040KLNgmbj
	Htdwa9Thbwx73B1+MHaWEogWiBbP5EC0AYkQzygflZ6TS5uVbasLwL+1JC5d84Elmk+Py6w+heG
	eApACXz8np+l+UGc6xPwxGDyiwKcY4A==
X-Gm-Gg: ASbGncsXjWNkm52eEn4I/Ozgco3O9mFj5ESUce58d4p5giJtX3cCobls6W3m1vqfyHe
	Wu2c1NHzUre3Yz/5mAnsxtajTGWcGtYgB2JnLDnWrz3Bd2I8b4rkVszVVl8WiHSrRwumiUgMoWe
	r3IFfvqSrJmz2FktV49XxSJIUpsxhDctFGnCo/w8JkvhEphPmbJW5SUYRYgUhh9goZnV8enlVxm
	kVv1wJ5oKMSd9YT7U+QJOY6Gpnipz+l7A3gusyJcxvWiuV6rJ0jxpR1MSBhOL7bDE2mDXWTuNTH
	/VoKdv9cQJyXSefEhx1Cth0h/5bnf6lDw1HV4TiJyk94N7CZvMV90+1QH1UxaWh+tAT+mQ9pqKZ
	lwmgfNR6nA3tuZziIoc+JRjndbv0wxKtmN0wjUxD0
X-Google-Smtp-Source: AGHT+IFHlptWaBx3YJsQHjejkTDeUoTu/T7WzbFPkrAOJzoBoR6gRm3kajAG2UH/i0yBk8jfhysdFKwOKHkhUDGdGeQ=
X-Received: by 2002:a05:7301:550a:b0:2a4:3594:72f3 with SMTP id
 5a478bee46e88-2a7192d6efemr14002268eec.34.1764377402885; Fri, 28 Nov 2025
 16:50:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=S_8JufSGCOBjCQJ6R1Lq-GumJXTPzWGv2JCZK2SPw_XuGPA@mail.gmail.com>
 <aSo2n2dhEoZd3nZW@fruit.crustytoothpaste.net> <CAB=S_8JFLYsGe7fs7UjCfFfTJGMqpikZavztU6ZiW4KS21A+MQ@mail.gmail.com>
 <CAB=S_8+omhdW9Mx3kr=McZvoC-GbftWmsBVLQuRH=0CmChq85Q@mail.gmail.com>
In-Reply-To: <CAB=S_8+omhdW9Mx3kr=McZvoC-GbftWmsBVLQuRH=0CmChq85Q@mail.gmail.com>
From: Justin Su <injustsu@gmail.com>
Date: Fri, 28 Nov 2025 19:49:26 -0500
X-Gm-Features: AWmQ_bmxWZo1OGko24xEPtvKNmX_NCqivxKMcZnTUMgP61i6Ff_zGLxg2_Med2M
Message-ID: <CAB=S_8++iZZtPXm_Fp9ZuBJ_zKN1c3SWy1qMghbx+qop4y7OCQ@mail.gmail.com>
Subject: Re: SIGSEGV when running git fetch
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Justin Su <injustsu@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After installing Git 2.52.0 from the Ubuntu PPA, I can no longer
reproduce the crash.
