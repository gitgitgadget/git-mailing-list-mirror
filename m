Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DACF86275
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219998; cv=none; b=IRI2CVJpRU3zbey9JeAYHFU62pKKzXJAywiHgCCqBt3qRAnDy4ov88JXO2GhiOWXkvJi5PRKoEyrEEzpT6Ly7zE9VF039cRusEvL20E1JacRH+UhEhHxNpsJFAuk3ehQF/IgX64kCmO8XyWcKk11Q2/xeFsXTL6F415WO7PgsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219998; c=relaxed/simple;
	bh=13fAmCUcehTwLTLJ//jIGq/QTXYNDvn/nQNtEId640Q=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=WsLyYh8eYN54NfG3aFyXpi5u+X3W4xuPg9T1en1NOb2nlXzzJ1KPNemLoWV1c7oJt/ldctuhtARXqY9iUreRA8mj61xVSnOq4zmaFk2BhC0fHNdOgRgG14es9v66Xna8zYaoNgH42SirQycVuNRA03no7p5COrgiQAfHmTjXeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGZHJKSI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGZHJKSI"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512f892500cso838334e87.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 07:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709219995; x=1709824795; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VcFyK4cuMYjesFlGJY5REibnJvF1mRSN/oUlZ27uDcs=;
        b=gGZHJKSIL0G80bYFuCKSR5K/d1bdVMna37Udb8IXOT17B4OC+xjfr/LwAmMf7CuDm2
         w0L0KoouISchj0Kfv1nsbZpxg9pO6hM3cPhnOWdqVV2Nd6s1Bj20Kh9sHGKnroMc6dOu
         lhJ57CAWA1cC3Mj2tPvUH3pzAL24P2tcUpkDz9uKhpQ7XLwo0OjXkMJIOUduZIVCq3ex
         jY8yMoGU1PSmnYcRPrEiRW2h1K5nRR/t2UY7t2RtkyX9Xhdg+l6ruCADqkYUl0709/rx
         WCfNJX6PqlJ9x+WaCIidFRGFP2gTs+EvV7vD+JBS7p83gu0Ar7Vk2HX0Ap87Qd0vWdEA
         +DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219995; x=1709824795;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcFyK4cuMYjesFlGJY5REibnJvF1mRSN/oUlZ27uDcs=;
        b=njUUfQ6a6yQ8hFMxFI8lzqVuaxRwY+qBtvcyqMv/zdXLRzPPQ9v9/2mYe4tpx/S0ny
         C1v2iCdkiPtOMMHD7mBU6KXVV3lt8Co7YpgWgrvmr5KfV4xdHSneOyXP/UIgow9Clb6D
         rGLF81OfqNBeB47nBqNGYNdlh+k9Okksx8ZxNqkBN8epxOSjLp56kQli8OWYKdUJYFOK
         vHPA5bt/3WtJsnpGaP/z/T7gkRaCXShDz8RO1AScUhXR5SCg50UNTS6ryFtPh+ZUZNcO
         fRguM69ZBimaPa69LkCUoISaaGZfgyznQfeZWoELb6hRECJDFzexNDGvDhjWtPxhM5Cn
         dSew==
X-Gm-Message-State: AOJu0YwdwmCOD2qZjRUmJnv5qhIZ5gUtN3L9h33Quj08qvK0AxP/Cawh
	ExxqTPDd6vfLaBwlh5rVEgYofoKDrJ5ol/Y/11T1Va8JvfmJudxUJvavDgHh
X-Google-Smtp-Source: AGHT+IExObUqpp+NkTVC0wzXp3cEVF4rSUCSnU7eppXVMfurbq8Ou5Dz5BO8ybEeLfwIwc4ELWHyOw==
X-Received: by 2002:a05:6512:527:b0:512:f6d3:9998 with SMTP id o7-20020a056512052700b00512f6d39998mr1715040lfc.17.1709219994666;
        Thu, 29 Feb 2024 07:19:54 -0800 (PST)
Received: from DESKTOP-T29D115 ([39.49.142.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b00412b775e979sm2411673wmq.2.2024.02.29.07.19.53
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 29 Feb 2024 07:19:54 -0800 (PST)
Message-ID: <65e0a09a.050a0220.55e42.a428@mx.google.com>
Date: Thu, 29 Feb 2024 07:19:54 -0800 (PST)
X-Google-Original-Date: 29 Feb 2024 20:19:55 +0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: larryclassicestimation@gmail.com
To: git@vger.kernel.org
Subject: New Construction Project
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,=0D=0A=0D=0AWe are an estimating firm and offer our services t=
o GC's and Sub Contractors. We perform commercial and residential=
 estimates & takeoffs. We are using  professional software to per=
form takeoffs.=0D=0A=0D=0AIf you have any job for an estimate ple=
ase send over plans after reviewing the drawings we will give you=
 a best price as compared to market price. You may also ask us fo=
r sample estimates.=0D=0A=0D=0AThanks.=0D=0A=0D=0ARegards,=0D=0AL=
arry=0D=0AEstimating Dept=0D=0Aclassic estimation

