Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915531F3B8A
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756525800; cv=none; b=r9ORn+4h/Otitbe2qLRFUhmeZnCQm/hq6AezlNrjgq6vGJpwHkIiblxSmn1Nw0pwYVRuQ2G3rJqHii3p7f8QMDmeJwRh3OUMXhKYb/e38CXe3mGshBnChhHfT/D7nLxLDNtWkIrT9uaD65KOY4/nmuHGfHsv9WSvPxDxvg2K+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756525800; c=relaxed/simple;
	bh=oZyFyvmSWJ5+pRWVnAT/4R/EulUaiK0nMLnvXil0kAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbKUD3mDU9KN2koicjlIEwS9jNTZFfHJhnru1KZe/mbuVAO1FiC3cFPP8dr437nQgd0EmgaT3zhMz0fNSv4OioLYzeff499rVdifeQXTV7MzkMAV0H0ach1blvE2+dmiA2fFXj+gnAwMavboXgrGh5Q/2BxTGNvVsR0gCoLPXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHUU8cW6; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHUU8cW6"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-892196f0471so914880241.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756525797; x=1757130597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZyFyvmSWJ5+pRWVnAT/4R/EulUaiK0nMLnvXil0kAw=;
        b=dHUU8cW6TDBtQLoM3tVyF6BhWVQR0hqSNdI9E7FB8O3Eqm7Vri0gW2NUUky8tzUdU/
         FkOk4VPOQAWoKDRNyZw7JkpLME8soCT45AF7Y+CMCKetnJViDuNigtqmRvyQ4LM0e2O9
         8srnzr4G1kjN84+TzfTNqKCvwbJyXkjR5wcNEC6tbUWavAvmESRwo8f7kaYVBwMQhzbD
         HR+6zuTjLX3+836OzCQm+2yjnlebJv5CKKr8b6oB7eKqv1hffmu+yh5XZEzSXZ6YLOt8
         IxwDd0LL+HeQbOXwmULRIcwvBhHCo9Dol2PvQZP7Aysf6rt+5riYomSO3FQg25/z1Z4n
         8kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756525797; x=1757130597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZyFyvmSWJ5+pRWVnAT/4R/EulUaiK0nMLnvXil0kAw=;
        b=ky24q3QFmV66wicDW65XgISNSRLbe+x4fUFXMae2ZkWQ5Nt7uUQmEsFBEZaUpaUvY/
         jdFW4JEn0cLnl3GWrrS+/sPsM02vJuGKPTdb/XK+1EmvzsDMuTodumhoKcoibEF9lgd3
         wDa34v59UMAMt+nygZqczq2uvhpV0jUmno3gWPviNmedkhEF8iHVglaxroPHgfQHnndx
         IJVwn5Qyo8fZ9VMzjZHPCEcDsiWo3cRyKYa9cMV/Y5CPo33rDJjl07Z0zrqIxhia0tMN
         gee2ChjJUBhbVZQrOfDndVBkyhcrFp+GCUuZUovwF2zir3qf0i302cGt4j+N7Q54LMqg
         4TrA==
X-Forwarded-Encrypted: i=1; AJvYcCXaTMbGEZmnF2/qStWh+1fVFS1a10zMU8n1v/yrMjSI990UN1TuaR3hGWsalKdDknd1Yug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQ+OsjtYsg1KWtew3drvmON7tV1OFWnXaEEmdxYL9KuJSUy2q
	T0U7ECOvq9aU+OorfEIHZrJJBRqzpDOU4X17V1uI/7AppbGUXf0mEtt5LUugekguC/ANjKP5M+N
	l0Q3TwmGAdgkUks1OkdbEzQ5EgKa4syc=
X-Gm-Gg: ASbGncsMzSi56s4L5IRIRG576vqNjhtegDuiSKQVvKA8YnpaOEXbjP8nB4zB8BmWUR5
	24iI+toA1iSX7rUwyoLSEAMcZhKZpLFq7n0CCC+xkW8wps5JLEW81zLCwWrJYAbdgmd/vrrE7SP
	afAyH/au6GqNWkywKIMTe0OEeaH6nfSKOlM5spNjxcsAjsfIclSa5/dJPx4Hdyui004JB/G++io
	Iuyy6I3JY7GN2pnPRL+VyBh5k+2pIU5bBLxQxgoXp4C6Ik8Yw==
X-Google-Smtp-Source: AGHT+IFxAkQJPIBhonqHlhsVP+VIpvuTuxyxxJscU+27qmTdXczB4hRo9Aq6IWsI1wY5Eg5MXypIv/+VL9W2HKTl0mA=
X-Received: by 2002:a05:6102:598e:b0:523:e248:c315 with SMTP id
 ada2fe7eead31-52b19a5e348mr226299137.13.1756525797272; Fri, 29 Aug 2025
 20:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
 <CALnO6CBbEB=94YsZn8vtjcwYENuMhMdg_wb2RbQunVCxnf53jQ@mail.gmail.com>
 <0548f4b2-6c36-4958-8725-5c9ac91e31e8@crinan.ddns.net> <xmqqa53inl7y.fsf@gitster.g>
In-Reply-To: <xmqqa53inl7y.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 30 Aug 2025 09:19:46 +0530
X-Gm-Features: Ac12FXwycrwqr1gQswj1ccTHY8V9dmU7ScsJGr3p21jvYqooYg-uQTAcSz70wPo
Message-ID: <CAPSxiM9g_dtxwavPUgyUHjn1qw9yc02=95NyWLyzAudCER80wg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Thanks all for this.
