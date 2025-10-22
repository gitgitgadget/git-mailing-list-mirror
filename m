Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B722E0406
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161041; cv=none; b=qeBA41MKOlDdQ3kZplpUmk2Mr4yvkPke6SWx/tC92Zj+l/gbLGMISG4jqX+HFrlvZ5lnwxdPZcz9GLDPQpiM20I0hAnV+ikrpN4fvnM2Qqw5sXwN8Oj2iqNguaveXggORBDyFHQCQLLzxDb3BI+3xJ8T4Dt58t7SEYvwR4tkGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161041; c=relaxed/simple;
	bh=GBfJ6QtM2gzCyhIXpxo+XBrCIEwwag8QIbIuNdu0DOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qjE0GVTy4CGb7/8jdsJ1cHkCbe1KgSDMc0m3FSJW8uI6WlzBS3vDjGR8PzTxRzfrFr5QW5Q6BZEmUqt0GDiclitzo7SqvQoKYy5dtNgpiiyh+3vWRym1Z6IkOi3rk1VsV1sWCwAYBzJ028svK6RvQmZDwhRKAcYKk4rUzcYC3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSyMGRH4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSyMGRH4"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b550eff972eso4898323a12.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161040; x=1761765840; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBfJ6QtM2gzCyhIXpxo+XBrCIEwwag8QIbIuNdu0DOY=;
        b=DSyMGRH4YjGnnd4ySgBBHj47Jv1AzQujajE0OsmrW9BHa9TxbbpODuqh//90a++nnf
         JPRjmc9IWJth4d6zfHnohQVwI7BFkupQsUrVQ/9yH6c59dTAl02gZPJC30T0DGJeCuXo
         ZlUdfofNNvvya3Qb2Zx6iqbt2jMyx9ubjdVC3kdpkkCFXisaOG92aFBEXQZujxhMNhKp
         5arJVtjTNcYuoUQ8EoU413hqARLYwYQNex+LwmrvB1UCpRQWcg7dIQEDhgHSK5lGBdbE
         tp9ISfAbgX7L9FQcWku00FrVIghf1iqdIvrz24CjB+aH4VW9pKqJ0Gyvj5A41vlEKMKG
         avOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161040; x=1761765840;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBfJ6QtM2gzCyhIXpxo+XBrCIEwwag8QIbIuNdu0DOY=;
        b=FjVNDf27jYOSPRr2hRt2YZAIDFmQ9ZW1vj4rJIDDR5arsF1tDokZsc8tnS7FlbqZrf
         kLjJrOjBBhMdDLdtO1PfNJFyxrcgiewoI/4FK1atYTj0h8SLyQegbW3XQY8wK5pgOHxd
         jQBoUJxj2VvwFPti+GU2wSc9p1K8vL93CIWhHZ84wKWU/+QYNyyjZRSulu79ANgTXDZw
         pKlxhft80CUWb3/ufLQIyEB83bctTBkT/pHPf9i22dU12sNTon91D161LZbdH4sre1+r
         IZu3CvT54Bpcd6V8Kge/DneqZ0A/NqpeQ0cAJ5saj/Vg3JDpQbV8/MdBrPNfoRXR7CF3
         b5GA==
X-Gm-Message-State: AOJu0YzTZ09+nuMpoFRyq3X0FqJ6F39PMjuhZkjzVzyvAnxn4V653cT4
	q3Kmn5QGxN49P6uu/kzH2lKCdLQkV2toTWRleP2YccJ7pSd4azEd3dxH
X-Gm-Gg: ASbGncvTy8JYehzMiTsBHcA674bWPdtgh9PBeGQbx9aPuS/LKa42z5djiwEHab+L7m4
	Hgi2QOiKxtN9i1PwFLcJVm4nOhoTd7g4YqwJ5Xhq/JWldU2fjuzo7Zl3Rs87+TgWCjGyRTlLLf3
	Ooeu/XgDmheCpJVwybdEpcG0z3W5m/fxPj+pvBqh9hOaeofzCMZrzixA1kGFkT0WWXUfKPlAWKt
	Cd0ITxZ+vTSmflvs8wJ5LMP8Nf5jgqXjyBpcA6Et3q163TVG5lV3PvCBgnnBMDoZZ6X187RxE8c
	+Mk/zEdDNHPH/m0XnEBzLwlHVQfNdH+M34s2L6K2lzZ2SxVuHER2Sg870Lr+gTdv8fH2lGBHqK6
	WPH6TgvCmMPjhm6P8//4nmEMzo+/3G5/vQg4FqdhOLpLr6ZOEnJszFt6UFB3gfin67EJQbhh3GD
	Xy6VZLfAe+SzMeuJE2K10wNksgJhqhnyHucKzfdxN03R4F
X-Google-Smtp-Source: AGHT+IHc2VNs3AEYCLd9Ob/77kNWRslhOCtG8m13dl/0kvX3nzCbgP48Kd3gf1oi0pH8PY3LvVDawQ==
X-Received: by 2002:a17:902:db0b:b0:24c:cc32:788b with SMTP id d9443c01a7336-290c9c8a77dmr271892545ad.3.1761161039637;
        Wed, 22 Oct 2025 12:23:59 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6fdsm145675265ad.118.2025.10.22.12.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 12:23:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v6 0/7] builtin/repo: introduce structure subcommand
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
Date: Wed, 22 Oct 2025 16:23:44 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 sunshine@sunshineco.com,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <64D5752D-AAEB-4559-A5FD-EA7BDEF16553@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


Hi, Justin!

Nice to see this happening. I'm really happy to see `git repo` getting
new features, and I think that these new features will be very useful
especially for people who research on free/open source software.

Sorry for only review this today, I've been busy finishing my master's
and I didn't have enough time to see your work here. Can you please CC
me in the next versions?
