Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1D273808
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370015; cv=none; b=SLunjB+BXxxVasC/gG8mTGHYjABaX1pK7qo9DOrJg02B5kvfHciJUI0dX0U5v/7PEeVgUR+ytXn/bL1HDfejhvC9bC5Bh1KvZAOWJzK79xjZSkTgvffbDi1Yc97Cns0U1/JLTD1NuR4rlI4CeinKf4YA2iByvBwvESu7qLZXArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370015; c=relaxed/simple;
	bh=dAWBLKhRhDUq2IlqatKthoVNbJ3Smi4KtS7Pm8x+3A8=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=AOAPM0pNTSTNMBezeL1O/InkPIa24JmqZsxGzzL4ZMD9MJGVogxXxjebNw0MAKYIs5RdB2WDzb4rs/sVRwacMUiYGeJqJ3cKi5c0p8Wiz/d4qSmrjfKvXtUUywOIdfMAst+fjK3PJFOHx7ayX443kPPzAhLzPz5d189GWJFGxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtZhIgIA; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtZhIgIA"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2363616a1a6so25453645ad.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751370013; x=1751974813; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmoP9Rc9k6bRkS/AErUS6OO3r9dJeTrBDRKjllt6YEc=;
        b=EtZhIgIAVcFDu/l9jfuxdBKmlKQ+gkOxLoa9v+fYNb0X+sGExBgdOdGUem4QO5mUgd
         mhN2mNfdjT9hQSpKfU6ZiM6DSGdhKRJbU6k9CFlUt2PPRWUrrkwzM4rvTDviWlLQZqiM
         7xJrPmZ+KALGwj0J0bv+MHfVOZoPRMbfPKVzCph2MVB/1HHA+po3kl3tY3MXnC6bqgZI
         ucVei2rf9aYnOaUml2+tgAtsuX4kt+mUm267dnI9nVn+uUqlcXF5RsZhqVAkUhovwxtA
         xhNP1NUfRfLvnX50OVSCb1tbn9Ll78snh2Mh4UR5vUuOz8NOCfkRLGnHopJIBY4h9Idb
         BnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370013; x=1751974813;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmoP9Rc9k6bRkS/AErUS6OO3r9dJeTrBDRKjllt6YEc=;
        b=p+74huvmAJHKfoYWsGiZ7fVCJkDwzcW6wqeqfkLhH+fVs8B5zJlHHmqj1nh/IhG1g2
         3bpQo0XJrQuuyrUgk282QNYirEhaDyErlw2f9mtg8a0vuyiRvLOncG8imGRkdd2jK6sG
         4s+nQe0EUTpd5jFRCQ84OVboI9O3g1G2gi6M31vlDV64o+XKMDRi4TVgmZxaw0dAXC6f
         EOAeNrDzYMpUt0eGx4vhXXR59U3NDUdxn2FTUHzfhoHLIy/uFrXxOax9CeolJdRnR9/5
         bcgTboGhu4aO5SDJbE93PCkC8VDQwZ/M6OBR63Z/ubhBhj45uo6AEvI7DkcECWoTutum
         iCTg==
X-Gm-Message-State: AOJu0YzHCAktH5SgrgNT+F4IffvfQ5GRfeyP8LrX0YGtuJZFVcJ9uzMZ
	xmu5xisQRPKGCKH5WSkVpQz/s6yKP8JOKdrLtxDT43aCVlrPndxvzZuJTzP7DspE
X-Gm-Gg: ASbGnctxRW8eQBQiiqzVue6XHxxYypMh0m/lTOGrhyXBWvHtbzT3hN+m3M6FoHelnL3
	ZNYmC/DdPOqUcqBmXez0FGF4bpwgR48enrqyNtqqyme5ffvgU4yU/XU/mTAoztcbTslHtkKH8ii
	43VkDyHnUQysm5zjRGOuy/RKWZbFsntK0rjZzJcGz3Yu676t074B0HPPZj5QKhIl6DaUd1UfxGj
	CM/0+oAnd4Pe0TnRrD6nR5EgemTh+9zX3BrtTmlDjYuAg1h2AQzW7QX8kJoXlDvAMEPC8g16TNu
	CCv0+PA6lW+zJxj5AWXBCez2VA1mfothTDQBjd3xCqhQVKES8rby1X30PBZZ9p5GlUbVrKGZf5v
	dl7ZDQksf4f0kkeazlgJ1mZJGWuiTLGgVIy7/kG4tydFCFddvPwVzNvG4ktjWgRk=
X-Google-Smtp-Source: AGHT+IHfe/2FpKxzsNEZ//PZnHryeATMmMpra1teWCJ8zNQnE9yhEzDELD2YSGFzvd8rEvBdPheydg==
X-Received: by 2002:a17:903:22cb:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23ac3dec2damr227386555ad.6.1751370013473;
        Tue, 01 Jul 2025 04:40:13 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b2esm108299775ad.211.2025.07.01.04.40.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jul 2025 04:40:13 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
Date: Tue, 1 Jul 2025 19:40:01 +0800
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g> <aGOhY2YuJZNG8ovj@szeder.dev>
To: git@vger.kernel.org
In-Reply-To: <aGOhY2YuJZNG8ovj@szeder.dev>
Message-Id: <BBAAC895-B24B-47DB-87DA-2276B645830A@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>=20
> On Fri, Jun 27, 2025 at 06:50:22AM -0700, Junio C Hamano wrote:
>> Totally outside the topic, but I wonder if we can further optimize
>> by adding an early rejection using .nowildcard_len?  Instead of
>> allowing a wildcarded "dir/*" pathspec element from disabling the
>> Bloom filter altogether, we could say "dir/ is not possibly altered,
>> so there may be dir/A, dir/B, etc., in the directory, nothing that
>> would match dir/* wildcard would have been modified", couldn't we?
>=20
> Indeed, that's what I demonstrated back in:
>=20
>  =
https://public-inbox.org/git/20200529085038.26008-35-szeder.dev@gmail.com/=


That's interesting. Though I find the bloom part of code changed and I =
can't
reuse your patch.

Have you ever considered to optimize other kind of pathspec magic? I am
not perfectly sure whether it is feasible to use the same trick (using =
bloom filter on dir/ path)
on patchspec magic except PATHSPEC_EXCLUDE.

Thanks,
Lidong

