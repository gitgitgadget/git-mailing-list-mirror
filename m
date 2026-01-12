Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772262EAB83
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234123; cv=none; b=m/REFqkuzKTqgxBj+7qUkwoJJJTPPSUqPKSC/tYgHw0Uo5QxWwWg+OZJec9PdI/N8qhueD68+cZJBOd23nJSAaaFx2mpnTdwUzNNAw32qIaPSaIeQ0kFADtHpTvtFdLUhiLoy+Sf9WxfYw5WxJA8WJNrK9qXn5wJy+cD3lvycxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234123; c=relaxed/simple;
	bh=ZSMbpBLSqAKkysiQH5R763AXHxbQ1Tyqb6MhMJ0D9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWF+gTEqgWtS9eVadHqEbfQopRi8+cJ5xYl9oMvluB3u63kgVSa8kmI0ncKeVVfyHAzR+syY3JHsNimjiN0hvB3xwGGIBpGK7MGrjc8gMGLMm+jawkASxFX5Urv5d92lk36C/IVi7s/q+IKGbJ6UCRdwbSDSTaMHUrcle3VzkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud+qM+DL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud+qM+DL"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso675893b3a.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768234122; x=1768838922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydo0mApLCBL6kTFEVOILU/w/vS2W9egiNjEvt5tlDlk=;
        b=Ud+qM+DLpt0DiN4dkJ6GGZJqk9GL9gjuEwpODD5XSdL5R0wTUUyML0eaMa4i7Gomog
         4ZTVyCKSqmecA3h54+NkTH8mkGDgz8rYfZt8eu9u6ZoDPiYhY4AkM3uUYpyqByZDkqfa
         2rF2qvxFBAfGZIiJzomzBciCtslVTNA70EYUyc3rNXYJGBdUmgkssQb+cD3XardRzE6P
         s5u3TVKV/P44dNJp34TC0jucbp0S1gRQpYQle6Z7r3bd1G1IjLhAYTXe4c60pgUCq/rn
         SjC9mrQz6zIDLSQ8dFBn/9bFqzgEGYWsc1pfmYwQos4/3BEU/+X4G5LApeU26N0PqMsX
         mW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234122; x=1768838922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ydo0mApLCBL6kTFEVOILU/w/vS2W9egiNjEvt5tlDlk=;
        b=ETmkgC55/r0uCy7IxYlJvWAOhieXnGii8pEGStHGTvp5V3QB11ghPNnNEhgigd4/Ob
         nm+9oKmEuswndZ2bqjcB5LGkoO7Ri5kWO28x8PdR7WHHGBWZFLH2hXdy5TnWqPvo9nH1
         xB3dDqw2UEr8R+4lbtIezHCSxYJvJhHRUFpC6/w9tfphHcdwerAqwyihddprXpdmN+Rm
         B9rzqW76/XJUIcjwhQS93i4c+SGOaQQzzEahtsM2oc6UUCN8MI8woR9gFlyAbJDbqbnk
         vhIMmYR6R5JakuTvawHjhTsaOX/akPnY2V9RU7bGwzU/3jIF/0Q/qRNaMy3/Z4e4UeYR
         Whbw==
X-Gm-Message-State: AOJu0Yx/ffbF5ZlVI9qFTEnkZ0ei2YS55D9HMNdseeHCwjy4cfMNSwYG
	ZsSksbZ06OgxYkyKcWCy8D2sgQ8lBIWWeUpsWVhLzb57xeFtkUOsgXo0
X-Gm-Gg: AY/fxX7z7SVHu3OCa6yEkp53HcEVIaU17H/WSrT0iubfTPzgAEjHKno4B7e2TLU7VSL
	7iDxOgeLF/HFdd7oDSbjtmdjNpBLkvbqM87RS74cjoND9yVpCCsTAfNKlBTvZyUprmeXGdUPjU+
	okAqgyQBLtrPIoNnaF6X2qf+O+Fq6NA52Jk+ceqdTdAv52WJuF7lS5PfKG/rsp/lmn8cQJJlemU
	aqJAR66O0f25Nuph93EXKD0UlmHVivI4kt4teDXElKo9JiSOrP4xt53WWRgKJaf260iXhwfUl26
	RUR+CU/yev6kwJyrhw823Wz7aM/s55ud+RJ+QxdPftKfW/VJ+jQedaPDKcT+pWgS1c3ck1E+nuc
	4gD9SC3wsiZKvIkcQA4rOgSSSRapK3JzDMV0710nV4ez+D9heB8XBUyJ0gusreLzxVCedo73H/T
	KMYO1xtslBsRBII/0iQ9O3ZlS+Hw0y3AfqwN6w/A2i4ZeGdQ==
X-Google-Smtp-Source: AGHT+IEzjUwS6bpzGQj1FpXWeZlapSfC+CuGZqRoFFM057/ouevEPdL1YWNfQF81g5l99VS11WMM5A==
X-Received: by 2002:a05:6a20:938e:b0:384:d0fc:f517 with SMTP id adf61e73a8af0-3898f9875f7mr17578215637.51.1768234121653;
        Mon, 12 Jan 2026 08:08:41 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc87f8sm177206655ad.77.2026.01.12.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:08:41 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH] doc: MyFirstContribution: fix missing dependencies and clarify build steps
Date: Mon, 12 Jan 2026 21:35:52 +0530
Message-ID: <20260112160828.350483-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALE2CrTuZkFm1R3Bb6gFmrN1trr88vdO_7Aw6ycBYvFpWMEEtA@mail.gmail.com>
References: <CALE2CrTuZkFm1R3Bb6gFmrN1trr88vdO_7Aw6ycBYvFpWMEEtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> One small thing I wondered about is the prove -j$(nproc) note. It
> might be worth mentioning that using all CPUs can make failures harder
> to read for beginners, so starting without it could be easier. Not a
> big deal, just a thought.

Actually, I included this mainly to make sure readers understand the purpose
of -j$(nproc) in the command. The motivation for adding the note came from 
my own experience, where I ran the tests with this and it saturated my system
resources and interfered with other important processes, which led me to
reduce the parallel job count.

As for the difficulty that beginners may face when reading failures,
my expectation was that users could either trace failures using the summary
shown at the end of the test run or adjust the level of parallelism based
on the note, rather than starting without parallelism altogether,
which can significantly increase test runtime.

Best,
Shreyansh
