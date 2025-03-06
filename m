Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18220EEAB
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219480; cv=none; b=q893WhQX9xlayAdzAijhv8tNpSBWFpWF520uszmGD2zXO8br645zkypvu4BAbMBlDyu6HWxav/hnprbvyhdt8srKCww5lycaU0Hx68rq/g4VJ8S3w+Uurwr6jaqJr5ZNZ+eXmQXrCT3NKi1j1dNhYRNmBokhQNU2hinwO+YiLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219480; c=relaxed/simple;
	bh=ItEeqptW8UKxqaYhYyGDXtA8/5AGyadIVuAqjwfu0O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLm1WwPh5ou93ZVXcQKh/oKn87JIjFg6U79wuWmUV3zD56EGW6xGT8kp1IeM639BcfJxkJn1Vq602QYo9l3FwYheiykjkvhDoew3uN/uuD3MFEH08dePQVRIFPVROS49eCfIbdG82ZdwShVrNM7h0YutL7ZDkkIMbtST08TmxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB0oGSmC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB0oGSmC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22337bc9ac3so658535ad.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 16:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741219478; x=1741824278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ItEeqptW8UKxqaYhYyGDXtA8/5AGyadIVuAqjwfu0O8=;
        b=DB0oGSmCwHoob6uouUqpkdyOXRzAyV0GnoKwu1ASvAd2YEDrSI0hSrKOsZHrPlaqP3
         HKqg2qdtDbmELEIL0IAdu1ctw4LBtIMeZnVQ/ROd+mDh4SwATtjrhW0ZLxI/J03czgs8
         l5u7Rlcd9vF8ECrnmvAgRXXkqpJg6x4nnoRbF4xZXMb+4KmmZhxp6aTqH2JMQzau33m9
         2aADH/Jc0AptKaLFf1bglLFhbjYtf89GXG7Z2vWdDUlle0JgOZgsfMi6Ik15NTUWkslx
         GXMN5gBiPp1KRrcaMyBnHBoQg5yWdsd+tb/gvBpAPvna2VOSC0uEHausLyTdeeZFVoW5
         AxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219478; x=1741824278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItEeqptW8UKxqaYhYyGDXtA8/5AGyadIVuAqjwfu0O8=;
        b=bfy/CQC/3nPxgo5Hqlv1J16b/L27eWFafADSbFgwAvS87rC4TiK4KEWsdLvH+r/WhG
         bFAkiJaojWxgaSimIqaKJWCSkdcQrC2iMYt37EfRYVTO0pKXWmIZvlrZlVfek5K7dcQ5
         A+tbABKGxoLdDsq/0bJTGo3zaPjWn4oPHY056Mr3RyOEXGfek3L7G52K1uG5iaxjXErv
         RarDmyYKYCzEmyAmQ2HDKD8PfQBfh5tlAFkusp1G7PboMCB612fvAiQxsUUclFOlcTSq
         47n+u8ySzWJ5QxxZokxsrt/HeBybEE1z+0roLGVA5u/RTNZdsy5YirCeYMKm/J/sIoRR
         kjTw==
X-Forwarded-Encrypted: i=1; AJvYcCWVrBNAHf/QlY89IP93nn+FVPrnl+6qocHE2Ul41h/sRhcNKTRx/HwyhYrhLkS09eDa+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYrl06Cuga12o/C98+4p83TXDyQdMTTMduIH1M6iHhpLqjMWM
	HwpZKiVxHANZraQK1/NAcXXOnAWSMX52kuWMlag9G71UzcBaRTXbvnjSKjdbTNnjbWGudvcFoQw
	vJ7BHv/8An4vG/gN0ooJ/xDz0ouc=
X-Gm-Gg: ASbGncsADVCC/MlVoxfNrTvi66sBUN0cvGwd9rbyW5NnUrrFCcgOEYhidl+ZNDZhRIg
	i+Cdo+NBOdYAFEFOHerqcs1+6wEirSAYKZ16beg/yrhWbhZTQVM3bKC/F4qeRuq98xkcUma4v5y
	UO+N6VukmhT9wrrchcYiUwKkQm
X-Google-Smtp-Source: AGHT+IF1y32OSaeHiEL2wTJ0e5C+v/nkSqKZre/SmgzT3/qUreazYu1kS/8iFYUfjeDpMeUe6gCX3fBKbJrCgHERHE4=
X-Received: by 2002:a17:90b:17cc:b0:2fc:350d:9ee7 with SMTP id
 98e67ed59e1d1-2ff49775ba1mr8646510a91.11.1741219478196; Wed, 05 Mar 2025
 16:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com>
 <Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net> <xmqq1pvbks3i.fsf@gitster.g>
 <CABEd3j-36C_LUOetg0qLofrby9M1Hixkh4o7sQkkyyWuTqHQvQ@mail.gmail.com> <xmqqsenrjaka.fsf@gitster.g>
In-Reply-To: <xmqqsenrjaka.fsf@gitster.g>
From: Oleg Taranenko <olegtaranenko@gmail.com>
Date: Thu, 6 Mar 2025 01:04:21 +0100
X-Gm-Features: AQ5f1Jr8YucU0mtiHc6GH2NVsIEKe3LiQOlDRQeiyzTselWAmM4HmvI-RlkvhMI
Message-ID: <CABEd3j9WqykwmNF_z-eeKcdFRAjYpKkFnciVBwpYLnteS62yZA@mail.gmail.com>
Subject: Re: Suggestion: Enhance git init with Language-Specific Templates
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Tech Kenya <techkenya@protonmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 00:56, Junio C Hamano <gitster@pobox.com> wrote:

> I was referring to .git/info because of the .git/info/excludes file.

.git/info/excludes is a great feature, but it often needs to persist
ignored structure, for example, in case of creating a zillion small
projects/repos for the learning process.
