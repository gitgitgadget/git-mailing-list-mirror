Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C72C17B6
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105823; cv=none; b=Cwmr9A0Gkad++xx+b0HQi/n1W3gzCruAepDxA6iosBXBUtJ9y/SRJ3+h5d/La8yui4Fuu+T948pb+MuouEf6+sZ4ClI6d48sCGJ1vLpkujQf6OrN77GQGcx9cnYKPGAOy/YZO7UQB9bYN9xSVKMpktccWr6I0LlcTX91GtIF3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105823; c=relaxed/simple;
	bh=r5bLgs4+px2htPq8gWM0pxmb+XfKvvn2s76ltEpSqv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+NuUFEFzB6euYsdd4iaUSypdvP5o3ceiO1piKzMJB9MC2Al0dbb+wNjZoK+sSHSIMKJIqTAlRnjT1IiUejzy3nicYmoZaDj9GHk/LYXQFupHl+8GMor4WBAbrx0Klot+1VYP6DKmzGT1JJuud+H/AVr97YdMnDyDlDgts1BYfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2E8VTNK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2E8VTNK"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so11872422b3a.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767105820; x=1767710620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5bLgs4+px2htPq8gWM0pxmb+XfKvvn2s76ltEpSqv0=;
        b=M2E8VTNKQyVG48e11c+mkXsPxU4o6sGfURVn+WjDRBxHHSFdEugR+qfrZ1d1R94Joe
         EwdR4wCV+ld+Om7+duGx3x6Kmp7lz54ifPgACxEwys174B7YpSYS+tFpQXA2EaKtCEci
         Ea8n3PGs5xSsIw4CqOdu05hgD6lKl160UDbs3dyX5qDR5fBwWuV3l7ZjyzytFSLH1VgV
         eLujHKoLjvqfiq5+CKuURqJy0Fji3+yj83wj0hOZQbu8qSu353X33aAs6oIpae2B+nBw
         3YBpFc6tV4MXCAnpVXjne7yLgQTkr63QZ91Pzo/QO8jmA3nYLhh8i3z0pXl1qxHKCpc3
         jV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767105820; x=1767710620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5bLgs4+px2htPq8gWM0pxmb+XfKvvn2s76ltEpSqv0=;
        b=t5Op1mzfIeQ2XJ7iwo+WeDD/j9zwQSAmmx/F9b22l+ScUwOiqt8j/+n2ew3hvCWdDi
         zr2llUoW9lXcEoF1n2ZpKV+4Sa8aVjAeRFWDmZA6G/P2f4V8yowaQbvr1vPo0d0Sm2Gg
         DiaOvWSH9oAApx02sy+VzvfbBtaMxfgrzQ8gPgtISJuOsqp59sQmv6kw/MgUxORXqrca
         VH7Hsx6N+5kgx5VDimB77KH+4nowsa6DJcPjs3ChuQ6T+/ZVdJBpqwWwnno305BILNKp
         YUC4lQlon7XC5plLZPzYferN1eE5OdOFyLJQl1RUk6xSRrv3jHyQSaySSWIJl3u7ANd2
         iG9Q==
X-Gm-Message-State: AOJu0Yz+LO7EAdihwqcHkZ7AG8kRR2OZcrixwZb+6Feqaiz6ztdJff7v
	qz5+wCzhWiM3OLNRUldc1TgK+nQpE60DL0uT/ixUcYSxZqsNZV+IkT6mpBUom4pN
X-Gm-Gg: AY/fxX67tHxQVRw8lsWt0bSbduTN1zsgE/CudHm7b4xplxAo2Ejl1soPoIlkfDhUi7C
	WjANJKfI0x6lxguwpesJFTDupWt/TnZNOVxPruJCeqggwcIlsJiCIbtVDlDtrYfs1ZWgdGTxupt
	DHS5ZJHnbSzNXYIcedhB0Hwxu1xEpOxzMJzmrQGJqQkKnGcCuMIt2oTG+NumePH2NWjvpBAxnB1
	retGXcT5wHPYpb74TRXnXWOBxsniNQi+C9TOlWAvBw8wXuzQIMkYi9Ne/RVvRo93Piw+Y6kJD4M
	LsHq7/yUb8IAULuOJOcAGzMv06q9Lk1eCWzlnD54jbXRtx4EbKFQJqfNPIxPGN+5C8y1kpbl6MO
	9EqkA9bKZpbUjUUxTFuW/tosL3spssxIdYrU0EYuAUY23wTo2Bq9OIDpF94xFTGjn/42FHa+z4U
	T8CIVU9uXPTDa5+5Z1p1VQI87WzhMB6+Xa
X-Google-Smtp-Source: AGHT+IHgWkhnOcWfxunhq9M180ATyZ3kL1C4/86GgMDwHLOC+Mb0C2mJlagCQ1gGHRIyixv3ZRIcVg==
X-Received: by 2002:a05:6a21:33a9:b0:366:14ac:e1e3 with SMTP id adf61e73a8af0-376ab5da545mr33478157637.73.1767105819975;
        Tue, 30 Dec 2025 06:43:39 -0800 (PST)
Received: from Fedora-Gink ([2405:201:c005:b959:acb7:a699:c03a:f9fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7ffsm33462389a91.1.2025.12.30.06.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:43:39 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #09)
Date: Tue, 30 Dec 2025 20:13:29 +0530
Message-ID: <20251230144329.14869-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqa4z0f5dq.fsf@gitster.g>
References: <xmqqa4z0f5dq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch [1] was about to be queued,
I might have missed if something had changed

but I thought an email would be appropriate here.

1-https://lore.kernel.org/git/xmqqldiplvyd.fsf@gitster.g/T/#mc3a7dc4cbe02d23e52bf938c800f579b49174a0b

Thank you

- Jayatheerth
