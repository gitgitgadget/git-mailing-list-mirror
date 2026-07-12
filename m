Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA7248F73
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783848896; cv=none; b=Yz3wYKYZVTc1EzILxu3wNo2bMMQeXCxg0GDm+wFtAX+O3nljIvWhbExvMSalDIU/hIIhRtJSJdpDtDnPpoFIAJam/VtRSOYrq6+8ws90+RfygyASm+znArmdY57q7GbiowujAT9G7RbYWFys27zH/8RtHVoysiOHUQo0rzjnaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783848896; c=relaxed/simple;
	bh=m4Gra3CyTQke5wTDET/81Ri0ZI/1jNK1nQqwn7GBl24=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=O+Rd4HL8DC9wOiPGSXqNK60d7qWwAepuYAH2Be3hkLpEzDWmNtv8KAjFGy4sCUrmavxxzHDsESNwMEI7YboBtNSiKLTVdMwmwppTp1qSqu/sLRY6oqSd5+SR+n6bjUOxVmalNJymr4J8BqiKwvF2w3XemW3h+gopi0A2lC0BOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/w21bqD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/w21bqD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b7612475so17982255e9.3
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783848894; x=1784453694; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m4Gra3CyTQke5wTDET/81Ri0ZI/1jNK1nQqwn7GBl24=;
        b=Z/w21bqDu9TQLhB2I7er7bx0BpDrC365KGkp/tH4KlaQhYRK79734yu113TqLI+YjH
         7oRWVRWNhpeJIr5kniZDBfHlf2AbSNIjlsgudrsi89QlG69B+Tlc0rYw0aTDMpNM1u5b
         CrmnwRm/0teIH+J26Ejhh8ESwvAANMj7pp7WBSM9vAdotEpo80/P0vJHTlBLQMJXV2s0
         aOS0Jz7/YfqdKaCiiSjk4poN1JAaSoeust56kG8Uiwmqjssg1wYs2Qwb0vFQkWZ9TWKH
         bd972yDzRYZqDp4a1EFbhWbh4dG9GD7JKSJeZzS6HzdDSic26Ig5T3cU7aFkQ3TXiA27
         PGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783848894; x=1784453694;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4Gra3CyTQke5wTDET/81Ri0ZI/1jNK1nQqwn7GBl24=;
        b=VlSaL3ZnmbUh2/qR67OPl1YjeA5OO2wLQvzgQFFkjxbBkPe0OswS/M0c5tGQkJtBpq
         RIfZlFeDb4eunQwXOMFdQdyjpxvAcF9b1+6wabDGXyVSdqMSfJ2bxe2vVou+mby7PtPQ
         m3IDt9Gze4A5wsSNWDbb80WqI3Pef7Hn1ew23L0VaDdr4iUS7sfF1ueLSbS2HTYWMIwu
         UZZY4CqVxhTi8ECwQn+Eqcnd2IpRnNplI3NDcKENkK9FH5ALyuFwANroEiA2KRMyoavs
         mSvB3MgLPOdt8zQQKBbzt+EgFtAs7kZYtoIxGHq9HS31c/tcuifTtJotqpKZILAJgAD9
         o9yg==
X-Forwarded-Encrypted: i=1; AHgh+RqB2Su1sAj/BPaynpyp1Y//cXjhmBlG2MXi4p7jMBW3m00QZOCKXRL6ux2ZVRcty7C8huo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFRVt4Ur+qwEHMRfhVRIovDIXrpXUz8KpGxBmf20ZMh6fXk1a
	Uj6f1jJMVsVYl96Hs+bAAfeFq6/mzwYOzZsK2b1bNyN15KlQufXB+ohj
X-Gm-Gg: AfdE7cmzgaax3WnNBgoiytE481akauzLGk+EeY/oHduhVT2+/2lJ3CgKADKuHDGH6Va
	23cA79koms7TNREVoatdzxbKj4HMKRmG/bVM8re4aT7sukc//01zTZTUPIkGNPG9lsJuQqD8Raf
	rD1205wGTsApljhwZZsyg166/svC5M2CGOBup4m80KDVKO84X8XC75InR8CVGbqbspvlEQNZvr5
	txbVEnFKBZNoecK22FIbGckkcezGZkuXJkiZPxec+NTmwmTd6cUK/1hLA5vExX2Uc1rqVlIw3S/
	XV6UnnAo6ZTua74MyiPCvBFTVvV5QavbydovR5Xa23DKCSwnEgzcWuK7RwLFXsVRjlExOk5hACJ
	qxR36HAMMnoAYsEQzTkDIkaNXlF8ZhwveRxk4olRGttWSEtBgirqjPaNTA/f+S9xNq4V62oeGCT
	6D/yHKeG8+mhTa8VCgJJAGJitpw0LSBP+iL6QwqxVNNhnCQdgMs0pjWsfomxABQ9zeus7wifm/W
	UvLFiS0RQvq8sE67spmxz1+l5oVKZCXntrUDwFKmcIGZV2GaFZ0Pzyt9XmfOsNlNb6XOtI+Gxor
	eNX/1VBjMFQt3tSOP0VV8kb/6KPawy2qor3M8+J326MiEy/27OUOyFLg5eI1HxP7ug+pE2IPy77
	Ls/NZ
X-Received: by 2002:a05:600c:198f:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-493f882933fmr47168945e9.28.1783848893870;
        Sun, 12 Jul 2026 02:34:53 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm70365101f8f.30.2026.07.12.02.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 02:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 11:34:52 +0200
Message-Id: <DJWHNO2F6ZCW.2V35W5FFY0K3T@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>,
 <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>
Subject: Re: [PATCH v9 0/9] migrate more variables into repo_config_values
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
 <DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com> <xmqqo6gd9qyr.fsf@gitster.g>
In-Reply-To: <xmqqo6gd9qyr.fsf@gitster.g>

On Sat Jul 11, 2026 at 11:06 PM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>>> ...
>> Hi!
>>
>> I missed a base-commit to easily apply this locally, could we
>> add one?
>>
>> Thanks!
>> Pablo
>
> FYI, a topic that is in 'seen' can be extracted from my tree by
> inspecting "git log --oneline origin/master..origin/seen" and
> finding the commit that merges the series.

I hadn't thought of that.

Thanks, -Pablo

