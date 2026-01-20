Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4173D4103
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950712; cv=none; b=RbA3Q0xt5rdQit0D/ldK7fpPi1OGpfi/ydvAXaL3bQYM5epWZVTIrDYRwEuMrz52f2kNWC42SovvXg8dtbWzsw+6brz/EDZXRJR1iXH/PmVUnzdlkL0MZxOCHX18ZIlcfViy733/CEkh8IRTXcLEuBji7xmPJ+tGLdM4ItOBtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950712; c=relaxed/simple;
	bh=b2t8O83VamncbqC47GjgQex1eeYUyaYjt6nIl9P7mgI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Z5fv0Y13SD2M/4+72xo5EwXTaEpaZEYJQUhQWuNOptkUvcKDV6N8XxDQHvDGWyQuDGjKCWB9NUp+csk8DcQzknhf+2NHWBkPfD5i1amwFok9vGKmwe7gtMoynX3WDWPPC40Ke9XeOv8TXkDfjwFe9V4rUOGradYnVAphaTbJ7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5NmquKI; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5NmquKI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae255ac8bdso10686000eec.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768950710; x=1769555510; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlRoc2VJ4Z7Zb+Oo7g89g/t15stCNpijmt/mCwNBDIo=;
        b=O5NmquKIYNPOKykvVfjGUG+vzE3517nOOc6QDytTmnCiKPxazcgr+eBQKIjMuv9QKE
         Ua0kpa3GnHqMML88/dOoS89uiDd7kkBqlOaOV/0nal2wMoiqrEkZdnkHfyECZKSQ/dFD
         +51zulY0v2WtaQsCLJlJ7INYyfPTJuboSoXe2gTMYn5vHoVXUh0EzOy+k8c7vBrUGzLv
         zaKn3WLRY493h3PUV3aTHDkYDaGbxvppc+kFmWodXe1flnCJ8Dn/1JCbzP3SUtIvAP+t
         WqyGUIj4U0tB1DyiHeIfWnz59Y+WHgKO87uf3Z2rK8ywMHZA+GncdUsTX4gA+LZ5U0xn
         g79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768950710; x=1769555510;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlRoc2VJ4Z7Zb+Oo7g89g/t15stCNpijmt/mCwNBDIo=;
        b=ElSM1ovYPyZ9DpICc4M0KsCM2r+hQC+ZKBI+Rh2k+L2PO9zIDTClo88KYarkmq02JK
         mptnTNA5R4VsXzPU015zHF1bMCuvKPBYY1RDdmxcA6IiZ29wrF9u1MP9FR4YetLzAiQv
         bi/vrZwZq+A2sMDm09ZVG81+puusEdKKUk7BOyhGgissUJnfKe+bA63JjWTJwWRARv7x
         CRM2O6cM1u3BKayHLoiota/BsQsOQmUA3z36Sf6IF+1T8Vfvi3bipihtAbVExP+i5pgk
         BAPMTL6fkjvevHxpiZdoZYGtPpijGqbAlQnWOjeYM7cspp4wtBmEbfMjPcfg4DNZUKFs
         ALwA==
X-Gm-Message-State: AOJu0Yx4/nHl4IEbEi/TPEtukKElw7TZ66GiYa+3HKSRhEim3yOMwRH8
	n2gzIeCgEoe4CoJPVJufsFgsp4CWKYyQ+a7Wd9dpNkA4774pUWsFIw3R
X-Gm-Gg: AZuq6aKnDHqhcb3LFD5r8LNfeb7EGLgTwTBzQfWt5r49pDnVy7CE+4dyEIN0XKv4+7E
	yo583Ewu35wkJ36TvHLJIFjpZHCJogtXGXX6ga2X+fNjbXO7H1kelRyO6a879eEEAygF7AkNd4f
	Ybryn1+FiSreqR4oG7CuI0ntk6Cn06VOq3pOtJiN065OLoVPyVCvwgJpv3cAnemw48NwWft4KO2
	30Li7C60dwdn9lIEM/u8dHYPjaEYZf7/8Ffcyrz5p6ewPvpiQi+fMoRI0WowUpTZVxfJr5fU240
	vBFbSLfI3U62ArL/gQU31XfWItCqpJ2bbIolr+Xy8yK5PGb1Z4RAyZA/HGKqLYhsoZAuQaADoNk
	Rp9Tpe6GfXaxz1jf8mW0n0FR6mJztUEG6kTInfrMKuvukKfiYmrEus9SdJZlUDxj0jsrTJjUeXW
	+5gDHqFQ74AuahvzgP/KdaFAdEqwBp2nsmxBWqrS1iFMkCm0xbvKjUsnM5oyPuaMMCTFOFeeU=
X-Received: by 2002:a05:7300:2146:b0:2ae:6146:37a8 with SMTP id 5a478bee46e88-2b6b3eed5e4mr15070903eec.2.1768950709407;
        Tue, 20 Jan 2026 15:11:49 -0800 (PST)
Received: from smtpclient.apple (201-1-211-91.dsl.telesp.net.br. [201.1.211.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm18963588eec.3.2026.01.20.15.11.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 15:11:49 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4 2/2] repo: add new flag --keys to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aW8bOfVLcG58t-Uk@pks.im>
Date: Tue, 20 Jan 2026 20:11:35 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 avila.jn@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <2B17A803-F1E0-4A9D-B0B7-2C62DA3939A2@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-3-lucasseikioshiro@gmail.com> <aW8bOfVLcG58t-Uk@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> Tiny nit: we also tend to terminate the last enum value with a comma.
> The reason here is that it makes it easier to add new values going
> forward while only having to change one line.

Sure, I forgot to add it. 

> You also have to adapt `cmd_repo_structure()` to handle this new vaule.
> Otherwise it would `BUG()`. I guess the most reasonable change here
> would be to treat "lines" and "keyvalue" as equivalent?

Nice catch! I don't know if it makes sense. If we change that in
structure, we'll also need to also change in info, making the name
"keyvalue" useless. Another solution: change the current "keyvalues" by
"lines" in those three cases. Maybe it makes more sense than the name
"keyvalue".

> Thanks!

Thanks again, Patrick!

