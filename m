Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41782211A05
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368066; cv=none; b=df7US8TXOSaDDNlfGKE9nAQJRS/OL+gJxHosd7PN7XpG1Nc2x6SHHIS4i23Zb7BX5FtLK0Lg+vBTFveZmW4BeJVEP6TVXi9QOmfIH/SH1VajCb2wirXkVxq6oY86wNjI6jH9QqTHbwnHSZc3ileRnwwT4kW1LUhSCuf1L4jxKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368066; c=relaxed/simple;
	bh=+a2pOp7XorMalJglDrJKblLxxT9pxwXgCqQ7sVAtoZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q7T0tRKsUp3GiNzA+Gj55qH1JEDUrxbhTn0e2CmGs34cQ/jCMCpM7gjE55wQzu1ylTECy0SHAVxW7LyIEIo8bBNZmApTVkqDlOwnclP33xz6EYJzftKayIAHGpwkKf+hi67jRSr3UNRve/LF/OcNSvspGentu/SHPJtZH9cEpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPzpAWMs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPzpAWMs"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8ff3ef84d7so1693268276.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 21:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754368064; x=1754972864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LG4Gt2T8jnHr74m/xys60X8Fcey4t7qq4PpZxnkWN7s=;
        b=PPzpAWMspmLKL2Nmirh9CU56A0zDEug48TaB7B0gy9C2fOOZPVzjRG/lmtecdguIgD
         k9eW/sYiu/OaNnGoaVYOzfw6SKrMPuJVZnG98kXDbm4a0Yn0V0G6YMuPw0dnOcuHBlK5
         yPFNI/0CHy/rXaODZCxK4OzsZcIIgsRcAEQqMQ4kPcKEeM9B52EFZU0I1aTdgu+62V4L
         1imNEXpZm8bxLuoHiOeZBZhZsqUkFA0Y13evx3C3APmDXrDfB3RQQ/GLLqQ7SHRis8Jk
         mWSYfZua8zHBxSunUpjTOPYNif4ZmGndGxNMXaUZU6AMPh/z1dtSOWa3mQDvURJoRMXM
         90+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754368064; x=1754972864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LG4Gt2T8jnHr74m/xys60X8Fcey4t7qq4PpZxnkWN7s=;
        b=JgltvxvYpqOEjLq94nenjuZCzi8HbBpwotahLLB1MBxMH+U3E6zhkGuyzeAba5mI7W
         Msy0DsSMbeStsN+KacueUkhlxEDEpS5xz7TJrbAvwxPEx3jVs55glrz4aq1rGgJ2DlMW
         zDfy3CQothp96s9s57eZgagVI3ksOEH6ANTSTpjI6ClVBh7zd+E5R6Ny1zTpm3QeU/53
         86IVtmKGm4DRkiLXiJuIDraPrmjb6866QqK1bNmnYRMZMpXExow6bvYcYS+zr6d8YPUk
         ntRGan7XG2IFhJsyzK+Ca/bYWBxyqKB/XvPD9GwCRS61rpBlC4y1yxKbPDwiEKJnja/N
         otxg==
X-Forwarded-Encrypted: i=1; AJvYcCVT55dtmVJbpIwpLHjWwkElapPcYLutaVC5TuJUgq9xqND68l8IEaLo8qgIldHxWwgJpWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtX8txu12vP51chpq8NffPQoU4qJ0xi+x5ZuYEw0rgfTnphl+0
	XxJEYrJM1ksVNlR4XJoclK1CUbXRGAv34vHc9DRCOqtSvLVzExyqcwspWd+3Rg==
X-Gm-Gg: ASbGncuUfrP/JcbXlXp/FFKgRvdIQg8nbkpYtL3JcOeRJ+pd3u7zXOV5Yq1/j/UY9MW
	5xNlHoxwLpt7Ko2CLiTzQdttlYohZW7UC1rc1pOER9/QynfGlCB0yiqJopS3Ss4KZ3cHQ1LUuTC
	RtQOOwDRrg/OCPLnhHesflHCnaGCLIhj9AXCia4/cvHKZE7Q8PAl9ugdsT5Wp7W6RxOmnSqiuLD
	DB5WOSIYdeslHtAVe7k1OjCGidvoNcCivpYJHLIGB1dNl1r85h6yFtsnhLVscltBWIYT9fHzVzN
	kkiP4Aa9QCDUn9B/1lbMuh7W9UyXmPsxZ2SNKf4CV5q45K6YkuNgP4EwYL8Pvxo6wpH44cWCMg8
	Waj+0SEXNFVNNghhYVw7y4swsjA==
X-Google-Smtp-Source: AGHT+IGip2aPpUlyiDmWetMibeEQ5NigMCEQr2cdDMjSUz4pSjjw7BFtZ1NTxtoOHWactnqRAqd+bw==
X-Received: by 2002:a05:6902:4385:b0:e81:8219:a9dd with SMTP id 3f1490d57ef6-e8fee00a4edmr13643627276.17.1754368063966;
        Mon, 04 Aug 2025 21:27:43 -0700 (PDT)
Received: from [172.16.1.5] ([96.79.203.1])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd37525b5sm4377336276.17.2025.08.04.21.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 21:27:43 -0700 (PDT)
Message-ID: <ad426013-bca4-4243-9e80-7d002f0eb808@gmail.com>
Date: Mon, 4 Aug 2025 21:27:42 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] commit-graph: remove reliance on global state
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/25 1:17 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series is another step on our long road towards not having
> global state. In addition to that, as commit-graphs are part of the
> object database layer, this is also another step towards pluggable
> object databases.

Thanks for carefully working through this code full of bad patterns
and fixing not just the bare minimum to get it working. Each change
was sufficiently motivated and carefully done. LGTM.

Thanks,
-Stolee
