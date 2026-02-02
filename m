Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C62D8365
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059109; cv=none; b=IaeEkyyN9O+l0CYrQHp6JSl8bgcsLayfB4mWeyQCJbc7VGmtNuyRVEhJG4dEAUz1o52KQgJTu20YWieXeRo1op+Tn1qYEp5Bg+HIuUsbcicdCv5xYUI4safwtEwYruZ5p5UPi6AGLrT93UIoGNmLozDeqahnWI5+4NUWf1I8sds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059109; c=relaxed/simple;
	bh=+w7d7+nxaVZM3fiZxj2M9U0KDiSqHxREzxOXjCSM8yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URZU9tUVMoNGa11ssxIFOm6CZK0SCjdqZ2RMye6WDU7Z0bM3leHJYQmrmMMviRCTzacUBHkO+Onm4ESTFAlNQEfx2MYqca8MUJ3os9q+7gRdoxjK2bNvKtaV1hOt/UNApctbOsgo7CHgpkZqWbIFQj9nG/8auvnMv9VKZHoP6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Td5uMqnh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td5uMqnh"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f47610542so2710231b3a.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770059107; x=1770663907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzMCKnGfSQpmChM1+/YcvuvYSadsYbrz3yDlF1D5tSM=;
        b=Td5uMqnhUfRYolXuoW4UFFclQu0kuRodAzHYeMWuUcgYdwi5qbaaeRCB+Vdx+Xjjcm
         7UvDDUKNqxTtNh3Ps0zlhBYPpJlocSrEK6wSohzCK47npPlifRl0ttnFWZjMVCyv6J9i
         7ypfARH5cBS/Y1e6z8i9zhCyMIuZdbyXpZbPkzMH3ykxUFOBPKQSSSZEQdrfJF11X9Vj
         uLA0538A5JTRW9Iv1U3j0rgxvFsq3rVu2RXcSka6Sa+2CR7PUrqNNqLDYAap16m38lOH
         b9RGVXeaiyAQLIxbE/Pso/8HRSRh/g/Q4I1domOdutbnIS121hAsLmI7B7JXXBduQcen
         ezWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770059107; x=1770663907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzMCKnGfSQpmChM1+/YcvuvYSadsYbrz3yDlF1D5tSM=;
        b=AUCGCTFb+C6Mw5K3a0Z2aO1XwX/InbK7g5qNjO9Nw8agNZJPHnz6GThdJhqebpYVVn
         FY8ueUzI4//moeGtktj25rmuUz3ychubEm/jpTwMj9EsMpEn6Yw0Ton/pDJ2CIDrc044
         2+r42jNh5DjJ9hjjVtGgQCbt5oPHFkGJEp+x1YC4KzqPFM+Xg9sQRg9Z5DJeji5kQFBc
         ZD9IabyhpB47AuJPLeLhgy4d/I+qUs2IVuUHFs9ykgwcWRjSk75B+Od2nT5G5ozUSk8q
         zHkHfk0YV7HinD3bwcvzB/s7+m/fYzjCwRGsAxX6t+3BlOorqfpcJlakq4WgpcLAxu44
         FBYQ==
X-Gm-Message-State: AOJu0YzxaYhz68p8hdelvGavXByXQHooNhdnmYVDZDn4Kn6cfQ6U9Bm8
	iVS5NVsTkxqj+EhAV8NUdVNS1X6DBXw3KYMvuXgHJN0OTKoUPA82OPL3kJAXhg==
X-Gm-Gg: AZuq6aJLlzrv7GcXSD1SjEGy6aO1fIyUzZiCzWMN4ZS8I9AFVXJOZjsdMA95ShtvLoz
	keNU3pvinDRU/H0eG5T2XuN1pc91cIhj1193SyatntzC/RfOAvL9JvYJMFNS96uuDFjtJXpuMlm
	8oxOSRWZFacIDAymJwpUuWPtLPrBzIL7sDb+CqKiVgZti0KidrSWp1akuTS+fUVEWPDheEdqgFL
	Lm5FX6TAzJcu9LnFKE49UnsyiL0X/+u2ft/IM36Q/C6lmtXp4ZspEbud7ggXnz4bhdJwdXXF2lb
	SPQucRprG6IiyG4Mh49QIWdD5A87a6TjKLKWhuTsUBYFFIAcUlruYeHgHHM/DGVFdg2rjSHPEPP
	0zlQRWX4NH2YvbI6/No0XVMyqW/ldO/KgrUthewQ9Yc0VgzXi9QvTKIxHKwSy7W1YzjHliYCAnL
	vn5qxZSjbaPXvDxTy/MvC1vObo7QGL0DVklwkKpvS6yYYoeg==
X-Received: by 2002:a05:6a00:9503:b0:81f:3bfa:f0da with SMTP id d2e1a72fcca58-823ab6c06f1mr11712851b3a.29.1770059107436;
        Mon, 02 Feb 2026 11:05:07 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:da6f:d14f:dda8:8d6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd8b7sm15227590b3a.31.2026.02.02.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:05:07 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Tue,  3 Feb 2026 00:33:15 +0530
Message-ID: <20260202190458.81443-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZT6ReeaPvJiNh967Sn2p3K8sQKEOOMJ+6-7ZdFO+wr8mg@mail.gmail.com>
References: <CAOLa=ZT6ReeaPvJiNh967Sn2p3K8sQKEOOMJ+6-7ZdFO+wr8mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > wt-status.c uses the global the_hash_algo even though a repository
> > instance is already available via struct repository *r.
> >
> > Replace uses of the_hash_algo with the hash algorithm stored in the
> > associated repository (r->hash_algo).
> >
> > This removes another dependency on global state and keeps wt-status
> > consistent with local repository usage.
> >
> 
> One final question is, does this mean we can remove
> `USE_THE_REPOSITORY_VARIABLE` after these changes? If not, why?

We cannot remove `USE_THE_REPOSITORY_VARIABLE` yet, because the changes done only
remove the direct use of the_hash_algo and the_repository,
but 'USE_THE_REPOSITORY_VARIABLE' is for all the global variables
that are still in use.

In particular wt-status.c still relies on the following globals,

* core_apply_sparse_checkout, this is already being addressed in an
ongoing patch series [1], so I intentionally did not modify it.

* comment_line_str and DEFAULT_ABBREV, these both still are used in
wt-status.c but they dont have any local instance in wt-status.c,
or in any other form.

Removing these would require a wider refactoring (adding in struct wt_status,
adding helper functions etc) and I believe is better handled as a separate patch series.

Though I require some guidance on the preferred approach for handling
comment_line_str and DEFAULT_ABBREV going forward.

Thanks for reviewing.

Best,
Shreyansh

[1]- https://lore.kernel.org/git/5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com/t/#u
