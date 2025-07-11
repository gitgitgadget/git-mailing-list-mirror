Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4522154A
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272250; cv=none; b=Dq/kn6Q76+x4pwsIZzpJLkR4a7zgkYAC0URRtBBG8ng0Y0j2HO25tgg4Xmv005kG35f+xCKku9W2b18APCXBKqqdQMpZK+HzEEB+Rxy22KR9eAMok64VtUHRAb/35Ijc5PuRbwAUUTxW+DTe0VBh8wRl/aH1vW9g+lLPt5j7geM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272250; c=relaxed/simple;
	bh=8MrLa726bCVY4LduOgwMjI4ec52L4LeLqn9xckkQTQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3VaR6CJQfVU2mtea2qdWmPVs/EoK8cqPNddojcDgKKVuKY6j3kQ3eARRQflqxXHujUg+dSKK3jhH44Jor+U51gYKHv2Ezzf6LKJIXPPi+V2UegnVLP5ZIjEoPhTo+Wfx/ZyiQMJvQJkQy+Pz0+/AE/dpK6atq6SIQp0nBj4zZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwuTbHpY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwuTbHpY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167b30so24494045ad.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752272248; x=1752877048; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xa6Rx33P9RpEjVz6OopZBzJBqK0HsMtpOcFsUTvKKLw=;
        b=LwuTbHpYtRpUYO38ZlGOyrZjg7EBFTG9UWL1kwzDVNKlIvaEq4soVHsa+/2hJTNTAK
         5p0YcxSRcEbCAMtZmhEcd3zIT9vjo4Zwd8hexu1uwq2ydLMBwv6Uj3Af8gMoo26ICFrc
         Dqq0zt+DhxNFrHzHTEgVS9bmUPyRdvQFqFvfeOGFyFFULoer5HdrUR10X9JEFo+4BF/Q
         lEryart02qQu0PKhDNHsD4pbSKVbT8qD5BgZxLe7P1TFlL5XGnHxGdGuKGrr5lNE30Rd
         +OtLQpn9orqq/Gz3/dCkGjJfKPV4hYFJWhj31+ekqnsGXUuH3OKAloCKGQ7AmRM7AfnJ
         KiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752272248; x=1752877048;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa6Rx33P9RpEjVz6OopZBzJBqK0HsMtpOcFsUTvKKLw=;
        b=oMM7vxFpdJQHz2RCaOF7oSB/Nwn5r3Wb3xJSyzoww+SjDp12rHOVPGFpamD4h4MZ5n
         zpF+8nGQwBYFLFFNhPeM25j+8G9JTDXsHWLxE7x8sSRbcBNmx9o0Alui5onWuQIw0RNM
         EcPAjjWASWgiAuvWBsaWnARvaS2plGc6UIEe3sh27iid2mNk0Yk88TRwQdF336Ghp4r/
         eE3ZcHZUKrosXT/yIJyNDsTaKl5qN3qy9o8Ura6TC30+vFauW2e2fa8h5JfHWqlpiVVk
         J9c56EcklVJrkh1Mo0bRzlvNN10JcxICBuDcEsd8wvaZ5qfzKcdGoD/YzlxI9wHPLgwi
         d7cg==
X-Forwarded-Encrypted: i=1; AJvYcCX/oUVoqvJddLiP3qA0ig+9oScAmic3S/Uth4Mh/tAdvOGpv7NkQ5mJvJbE7fkxrcWth+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmpcDkEta51J8ozl+RKpCZYCkd+XcOy+5bZ7Suwioyy40z2wz
	ChT/iLcLH4Y30/Ignmujz/0CBsIIBWnqIc4qLESfFjfUYgl3G5zagr51
X-Gm-Gg: ASbGncvokthHUiby5YKMSxlLK5JPKVHkExwa9Z9+WCbo/VRhkUsvF99D2i+1BST321k
	+FCuu0xl/w192MCZah8mk6VuqUZwmnWqhOLgncSQZ/spg+sAdbjPDTKV8H9xx3pBxVciqA7n+fO
	b9RQu28D0t/2W6gBKm/zjB15VsN89WweCf3nB6vgVPIzzUI+pE7IQA9bzvhNHSiK7MfDGvmlG1S
	gK7UMKP+NLrvWUutYNF74XVF2mwJ/fnK1vsfQb+u8XxaCJljsKPGpWlFpmtkxmM4zinL6qfUA/0
	JqjSkW9jn8NOvJtcdXqp8Kr6+hvOaVE65RQ00V4AU8oHAkU29xWmHvK/3q2yMiywtneJcIVv0lw
	/NQs=
X-Google-Smtp-Source: AGHT+IE66PgfFIeKkClhTjz7aaZbh/EAddvRMBPTmuvEp/zKYuujMMm+PJB2n/1rJ+xXsMC7LkpTAg==
X-Received: by 2002:a17:903:2c8:b0:237:d25b:8f07 with SMTP id d9443c01a7336-23dee0d7c54mr71503365ad.44.1752272248090;
        Fri, 11 Jul 2025 15:17:28 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::39a0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433190dsm59420215ad.143.2025.07.11.15.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:17:27 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Carlo Arenas <carenas@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Justin Tobler
 <jltobler@gmail.com>,  git@vger.kernel.org,  Junio C Hamano
 <gitster@pobox.com>,  Taylor Blau <me@ttaylorr.com>,  semtlenori@gmail.com
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
In-Reply-To: <CAPUEsphkzaibm2FMBoj-9nbFch7UgRvyvmzErmno0z+2k5X+OA@mail.gmail.com>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
	<20250710221641.857081-2-sandals@crustytoothpaste.net>
	<r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
	<875xfypsom.fsf@gmail.com>
	<idgdx2au3zgpowozspvu6ttvehybtwwuqf5kwqga4yok7uo2uj@wno7evyjg6pq>
	<aHGCRLGHEB0m_cXZ@fruit.crustytoothpaste.net>
	<CAPUEsphkzaibm2FMBoj-9nbFch7UgRvyvmzErmno0z+2k5X+OA@mail.gmail.com>
Date: Fri, 11 Jul 2025 15:17:26 -0700
Message-ID: <87cya6xthl.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlo Arenas <carenas@gmail.com> writes:

>> I don't want to implement language tag parsing here since we don't need
>> to do that.  I would like to do the simple thing to prevent commonly
>> used locales that don't represent actual language tags from being
>> included and not overengineer this design
>
> I think that your design of filtering C and POSIX accomplishes that,
> even if it might seem like hardcoding those two values is a little dirty.

Thanks for correcting me regarding language tag length Carlo.

I guess I am fine with filtering out "C" and "POSIX" now. Not perfect,
but I think everyone agrees that we don't want to maintain a database of
language tags just for this.

Collin
