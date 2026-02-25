Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1713D332F
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033666; cv=none; b=fbV/6n18DpimncWMwX0Fe54/jwr5qXQ3LDgjauCavr+/GcmGWFgH2wxbZAzCMzyW+VAhRTVsUTXh1r0Sa+yvVndbvne4aRWB21ca2Brf+nyBYYWBqi8kQPchYC6BSNSFZl4QvRJRhHHZHTUiIGWwhGKwWBIVZh/OBQa/9MILocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033666; c=relaxed/simple;
	bh=YtOr07Hkd9NHXWTwXJRx++7RP5+6R8bspT4+Auhykm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO5LduORnMnWIwGhGsiuXgoneZPhep6q9MshviE6H/ml0j5KRvajze2AoKXc2GjjwqQJE0LREHqf0GQCyPLNvNXRO8CyetEJIThr9NCguSJ7ZWzw/za3iTCAVos5hNKKOeFZ2E0Rujv+xteokrc47pvqHVpG2lJTu0b+N2s/2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGYdNMFU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGYdNMFU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ade574f05eso2653395ad.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 07:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772033665; x=1772638465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9llF6m+oFPKKa2e1OL/VS5/CJON6Ie+GWWpIJVVfRk=;
        b=FGYdNMFUsQD5WZCzRA7DMj7w2gDAgzqy9WMYbDNU/GeOmvdDvjMgoJ+VNQdujjB2pB
         yUMtmmZcunQmCgmxqVkaGnDKMIcW++izQVz5XpunVKTCfCcui2jNFtljjai+jgOC1OnY
         Oy3Fv0H7HrB4j1vzsDHApjfHDTXwkdsrDzgb2kMzSqsWT63YZfsjtO7n8fBJGWERUFRs
         Z/FY0ueX2cACiHQOZwH7ky5XKid/diM4fHVq+Bcqdw34lky5YMPPGRcnzIet+9m0479q
         vxa3RXfgsn6nXXJM9mtOgIB4a6gPzwV1AQVqTddjSr8dBDT3RbPZ03r4ipkzjRAzSVqK
         IOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033665; x=1772638465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9llF6m+oFPKKa2e1OL/VS5/CJON6Ie+GWWpIJVVfRk=;
        b=irFHOR+42PuSJHrumsVhZHcdNJNU98qS098k7MUQB5rMxw/k1h1RNjGZbzRhDOkQou
         T/Cc2Yaakci+Yp7SHTlxBEyqXqCOkxKeRrGJiqnxNX3TNj6N4CH3022SaRKoBOhLxFft
         IEin/P04DpFurVJsY+Z0dUfsX8JDLpUTnYwhnGQqWkt5WhcTRFTQZba3pORfXUPp3cIR
         9mhxpYghRwUecc0fdPVyLk1wpiLw57nzRZOcM3WHMxouwKSAGTZCwjzBAn2ulz8G0dOO
         r/DAhLzJwcuWe7exoIIuFOMSFZ/N0fol2BbmUNTLGPBjXoBtygsNPN+U8jZ0T+zzu65I
         UFqw==
X-Forwarded-Encrypted: i=1; AJvYcCU4MppfMrVEPCkwWOBfmcqG2l0FGBp7aDjJ17jf3IdH3zoY6rtZ5AOs/lP20miQR32Z2rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIW2B16Yu/Dv6xsbnXyToTp6CAxJ9ZIilXXF4kTsLMARUlLbe
	tqdxwSgowflOisLx5Pg5FsBQHdG0wIwj1vmgKm3pSmpxEGPhQ48/RWuy
X-Gm-Gg: ATEYQzwQn2/pLP89edF+Q7OtJwKbEB6cojcmT+gwN7+DswVHlTOK6HHqs278Az9oeQG
	GU3c0OoZjCbTicz/USX9qQAeEpQt0fYuZ2QNeSP/6Nb1RAaNUtRf6xiiF9uIzJr/Nqzfjsz/Go5
	8drQ0YXgs/Hrj56smiPUJEqEstGvJ9tKKk52rYUyMvBZvvAaeYLqW8kpY7VLcux+5ibZLzAW6sw
	rs0oTEismXepHVJjIIDKmKL8TKdRlANboHYR2P/4RKrNRZGcSmfHbs56tL1KPGZGvGRSpSe+puI
	cYMeIDLGI1V2akHDVcMlx8Bi8Yme8ZRt+ghKNZAty0oSTcqBCVqhk1y2wqrNWBjHIpihjdPhRjz
	m8V+mZi6DNLBz1CxnJiU35qpCdROo5ALkHwLWIUUZPHqpOogpDTt1mOF4lbUsjb01h8K0b0uTwv
	eJYn4IiqhEsV+kxsesE11vhKb6BRsYHbKY1hdUugxzTqOxdhOoljmXZz7mNKY3OdcELEd7AjNol
	v7jPHKhnnDV/7XG2hZ8oGvMV0SoOn3ib+VPjL4ajbSauDsYfzWe+qdL616W5JLD6wj9+0no/fWM
	Xg5PBIk=
X-Received: by 2002:a17:902:ec81:b0:2aa:d29f:1441 with SMTP id d9443c01a7336-2ad743fe16dmr166318865ad.2.1772033664810;
        Wed, 25 Feb 2026 07:34:24 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1975:95cb:38f7:a991:455:152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm144364085ad.80.2026.02.25.07.34.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 07:34:24 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	lucasseikioshiro@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 21:04:14 +0530
Message-ID: <20260225153414.7461-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqjyw1cziy.fsf@gitster.g>
References: <xmqqjyw1cziy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for clarifying what I left unsaid.  Very much appreciated.

Hi, after reading that part I realised how pointless my mail was,
so sorry about that.
