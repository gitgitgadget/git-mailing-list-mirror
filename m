Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D91DDA1E
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253327; cv=none; b=WxX3kpuwoOqddorzwUO9HCrVom4odV6oxc2hTkBlGO9mOhV+aa1kGySOcH63d3hCkN+W+76Q89FyVuWVB1QsvBNxh3+vLDjc7w7NC8fdY1oJjPvsrPRqln8s5FiWIw8aF45S4Zos4AYzC6EBwmULOd9+LNlinEdAWFytTFzfXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253327; c=relaxed/simple;
	bh=qzRZYxn3s6vLdV2p3QateUM5qEoiteJfmeSq/gJyuaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmX0SoXnis6KNRtLtp5gLSsd8eYiBl5AXMRJ/lLEwjscmrc0zIGZlcaDQetg1iat2ec4mkZGPwl8Ck4qx6HKrjgsMzGHz9xc6/PYw2Y9XV/vsxdZyXqphqs/p3w71XDmHpHIHOGIypW05S25iwFBpseBhPaBFRdQdS11R0PMr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHXqqngz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHXqqngz"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3133559b3a.2
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752253325; x=1752858125; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6leK0VXB6FlJ42wCUguuks8IZB852KLIdi7el2mFR8=;
        b=MHXqqngzHMkoGH3UK2Hguuj4QhByv0rDlCi/1CF6IgkbeyHtAoNro2LhIvcWNF41/k
         zbg2LXsejf/k5cy4X++zOl9ajFolrAkx3ZLB7pFEkX0hC3nufj7/A5yxhJp7rnG1WWhg
         eyiN8+6KRZthpyzsRRICyT22XeJc+5gLOIbBqYkrNx0LfnFeaPvySgwEoju/jZmsvq6o
         8ATuWs5Sj+nEsdm3KFwXxtVm2k2X4evz9nU5kC3Po/sCS3KFDX/HCdmbnckScCdhMNBB
         KvgT2xOIaMSO47I9FAFleetR8o3ILNl6ZN1FvIkB8BPZbyRU8iD8IScqnCAhrIyvU2Du
         NMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253325; x=1752858125;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6leK0VXB6FlJ42wCUguuks8IZB852KLIdi7el2mFR8=;
        b=YxZOG0u7yBjvQJZIzNby6HqhVc4LUPj8ypWjba0bgCytEK6G0rnVduwkPfiZ7AXtr3
         tp90/BVlHtGkfhL9/KIWceryey1zcxsdbqKZe+ecfAUV1PzcfVbnEYWIUgsHdutNg30g
         cgG23Gb617DsLLA4vN9/S4jhg17uNYTmRoRtEmfiD5JvTguAXXVTlZHnMSVje2+urMY3
         DfR2ftx98DekICXcnqyniauwtfEqnIL0BDDtoDnQU4XcQiKLAtZAfaoeW54fu2tVbHDK
         FgoeGRGEX5fyJ8Bma/mKo+BRsJHi+EdROjjLDCbpj7brq5LBZS7WVROmgRaAlsAtiy/+
         uUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEO/Gl2VqXntXZR+I0Pw+H0iNg83GJxWQwJrSlnbgmsIFTXhkedzRGCe7QEt5PTG6bow8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKKJLytELktJq3J1WR4ToLX/Das9JkSkw6AIvIFGO3xf1QG3+
	kbIePGSH3ym0/bf5AUz6j76Bvn1uG7ccXEZYhrXrjayzBsaRcIhVlCRq
X-Gm-Gg: ASbGncvfHJOgyOvbgAzbSV5BnTtYERhOrfObN8nxfZ6W0vMjb8v4QsPAJEWztEs+bRJ
	/Rm/JbP19bhNgcVRxlxrR9lU4wi8KT8RLesanfitbehHOtQtvH8NCi/eDmRRhOhplYpXxJ/Stjp
	YGNQSG0CR1s/AntE1CTKOjJ6xPMPGF4fiLP5tteiNTkOSYwGY2frdLKKSQdTSzf3oNoqEE5d9rs
	RU3Tk/uQhX3358IBv9ghO+3evUovpFjMz2Dbm1t3IfQ1czPMo0+VMwQk5ZIr+Lu0lCZR/S1aDD5
	vK4uuWLTkvfnM05yAt6dOGFLGsZ1ytY5qLX9Tm5TY5NRWcJXI+kL8FVJ1PK1jZitEFJNW/lpBcQ
	NET4=
X-Google-Smtp-Source: AGHT+IFHExqa/7oEqIOoY0FSebQIXZhaIX0h55iAAviD4eXj/rmhwpMshU2x2S2BeBBK8BXCj5vdgQ==
X-Received: by 2002:a05:6a00:21c6:b0:74a:d1ac:dd48 with SMTP id d2e1a72fcca58-74ee343387cmr5170564b3a.23.1752253323600;
        Fri, 11 Jul 2025 10:02:03 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::39a0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd598csm6357736b3a.17.2025.07.11.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:02:03 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Junio C Hamano <gitster@pobox.com>,  Taylor Blau <me@ttaylorr.com>,  Yi
 EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
In-Reply-To: <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
	<20250710221641.857081-2-sandals@crustytoothpaste.net>
	<r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
Date: Fri, 11 Jul 2025 10:02:01 -0700
Message-ID: <875xfypsom.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> From my understanding, each language is expected to be defined in the
> following form:
>
>   language[_territory][.codeset][@modifier]
>
> When we parse the list of languages we only care about the
> `language[_territory]` part though.
>
> From looking at ISO 639 language codes, only codes with two or three
> characters are valid. If we wanted to be a bit more strict, we could
> check the length of the language code (everything before the first '_')
> and filter out anything outside of those limits. This would naturally
> filter out "C" and "POSIX" without having to mention them explicitly.
>
> Not sure if being more strict adds much more value here in practice
> though. So it may be fine to keep it as-is. :)

Filtering out anything that isn't 2-3 letters seems like a good
heuristic to me.

It seems better than only filtering out "C" and "POSIX" and allowing
anything else. And it keeps us from having to keep a list of updated BCP
47 language tags.

Collin
