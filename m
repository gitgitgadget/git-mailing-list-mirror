Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AB2869E
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840005; cv=none; b=TJWv7C9+2DLo2ibBPDZd+GSKX5GaUqrclw/HsEzcHjW26btYwllckG2nVr8GEekTg9k1LIBqOF42JiUOy87abiESUjGj8Q6m6oNNmOjQbJRyXq0R5RkYwL+r1UsE+1i2io5sQpEzf62xOJdO8TH7Z2LeOXFrmq3uRroNYy8vIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840005; c=relaxed/simple;
	bh=fO6C7SyaLyTUCjtq28aCgHaFhLcLEZzu1mIoM2US3X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS/AGL/HL50mLUHjF255KvnWpODxauhGZrdhNMs4FKMviiej/mN/d8aZehFRiNa/XoCQ4eyu+coVFjjRwXze8Ps0Z0x4hSEQp+Gdw7qe+SiQA94U7yye09Ct7pEy4BrQI4dQk6tVyKPheL2zAY3BYYgvd2J2mKbBzOLD0aeCiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJlwi5GV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJlwi5GV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b421b70f986so2532954a12.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840003; x=1755444803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fO6C7SyaLyTUCjtq28aCgHaFhLcLEZzu1mIoM2US3X4=;
        b=iJlwi5GVYhaYdKBUYZ5tXwKkdA5qjL+jIwQPpodWPsRTnkc9txswDaGm/bewe84fO6
         +UnN21fD770xLtPn4qLE6ypzcEN5LHrkucuxXkGQgMNiUCEc3bQ0xvYSZ8YlQutwxQ4H
         yR81aqwhQz/P7L7icsg19EcGlwLB3R8dySVER3Itj+q9rGnZMYk4q3LXTxqKGqNqMyG2
         rH9KEabUZjC1Mk1FH3AFxyxejsxR0CwWRMoCVT6k3v63ckQ7tQnaRT9F7KnEdZb1TPUD
         iaUN3HQ7jDFIPPGRwbRVKqtUMIc1s4QJMw3dM4sVBOuGXdJwakeJhTJjeZNIK8XpoGpJ
         N8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840003; x=1755444803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO6C7SyaLyTUCjtq28aCgHaFhLcLEZzu1mIoM2US3X4=;
        b=uTx3XmA1pqNYD+nEe+lOrv+H6MTKBH4/6UbUvGYuolV8tW94TsqJDDF1hoA+VWJcea
         gk3P0z2lSgvoM2b50jmrU3fPFbvA5tvBVTO2Itn9eJT1g1Zd7yM6N8hdQmABPAYsaCpU
         AVosCtw9HD67s1wFl0euSRM6OocRa4fhntwo1gCZW1UcvSGuMn3gUE5N0dsSLkiaimNz
         +XQiIQZv8d9O5eAP0cI1L6FdQ1kY9c/boOZh0d4QwwLB3aQyndwNnbuJQKyOcL2brONL
         jzLZdajtmnd7u1XIhALmR30peq1up3+JqrEH4kOIJf5fcAr7mhe6lbBNdiAB5ijVvtHM
         LQhA==
X-Gm-Message-State: AOJu0Yy/yMM3pqZ6hrSvJbcZFJcB/4IoXv9jvzJPli/dEnDQSGZeLb3W
	4msFRzmBQneRFFV0ghLerV3qV5vwpsUtEp/YyvpbgRN1awAfe//aQXIznXIbj3T5NysWiGWGm1B
	EChkb7cXc0INTfoxtuO920n6vgIMfsrwfYpp/
X-Gm-Gg: ASbGncvjb3oTEt5GTBdLVuQQoVlKjTCyWzP5sG8dKultSMrUjk6q9rzEmh/MWhdxFkV
	74AK2qnYdT/KGCgdbOoH2riBMrIRR6h/EkbUPs5xN9FHuJ6zMae9zvm9n9isKjaw0+s/6d/7W1Q
	QicWSpm9sogDrkh5DbPp/sm3LywsD5nZC0D52Eid3mYXcw23kH6NWb3jpPqfxTx2E0WIPB+1vJk
	4CNmN+irp5ZfpZuRK7uiEWS
X-Google-Smtp-Source: AGHT+IELhqdEbV83B3p6/xVR4uQEf9j7I460M+mD+AQY2Ck7pQuLk+b5UCUCy53RDZRXs23nZNjDKkkoTKjhiN7Mjk4=
X-Received: by 2002:a17:90b:3851:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-32183b44d6fmr12012412a91.22.1754840003094; Sun, 10 Aug 2025
 08:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
In-Reply-To: <cover.1753804956.git.ayu.chandekar@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sun, 10 Aug 2025 21:03:12 +0530
X-Gm-Features: Ac12FXygsYHQp9KK4RhvgL_hJJcb-figVT4egyl8Pqz-19n_wJSTIfBBytlW5ZY
Message-ID: <CAE7as+atKMV30Bi961bZCDCq7zqyJMmNeq9nK9J6ywurLHU-bg@mail.gmail.com>
Subject: Re: [GSOC PATCH 0/2] builtin/fmt-merge-msg: remove dependency on
 global variables and 'the_repository'
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, shyamthakkar001@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Just an update, I'm still working on this patch series.

Thanks,
Ayush
