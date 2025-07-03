Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED1225D6
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522182; cv=none; b=JHzlVrzjP8vnlUFVsWI0pbQ2hlJGR/4qLK9ZRJdZWs9vgpx6T+KlgoMb7oP5HPprpBMwNpcwHbnyGF99mfrMApE+cGGSEhW1CPOobb2U6ZnX+yQhMN9mqxvKDAAVHGYjv8UIRrkN3ToDykI9AUfJLXLyXmO4FGRInKVn8+yscno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522182; c=relaxed/simple;
	bh=Ox2/Uo79ySnGXxHy2+FmtLfY2wv/4EGDuhQ9+crM/eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9cgOy4tyZUzzAExs8XUuSiYvDrNCd4K7hVIJTY/t6AfwwlWeS5G/Zm21nCm5I7ub6BvpncevHrYou/DYY+6AsjoV1D3IfRGxOOgpQYMz5lVQviCMYCFTzqvZPIOwTDX+E747suAb0lZ3ejlB0i9/UgpDUV/B74zLwPBNb6vjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8Z8J8nn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8Z8J8nn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236470b2dceso45267155ad.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751522180; x=1752126980; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTAuwopnvnT5fIjZ3jQJe92Y7AUUKCmwQbhaWCZzYXk=;
        b=W8Z8J8nnfyYYtDN/X8w6SWThjGEHht9FlHdknnQV16d+jIp2R4YEj2OQkuII+9pPSV
         7QMrbb6+GlCFDYwG63CG+7KSrEMhCRdmA7CnIPt7ie9u41NOFfSQIWnTNAiNwqX6AFCE
         XGyVdV4MDvhy8+LBRH+IR2zKzq4BTopO+Sfv2282Y3snm3AkRb6I1oMjnwImdNYfrjBj
         +tle8fdWnruLQX/LEPnLRLKR65+qWvGjUNkmi95VKZQnDYAPymHiaS+K+ZrdPA+5adje
         0KbTEXrX95Vt5+yp+Gja3MYChcGj5f9gc6boIIUfu8E6YLunrohOs1WgtOuvdROllZC3
         4jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751522180; x=1752126980;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTAuwopnvnT5fIjZ3jQJe92Y7AUUKCmwQbhaWCZzYXk=;
        b=ROKnXlF8X5gQbvk6ybaLszqE7yL9kyPylBy0M9/OLUicY8AZlCFOfFMmu/2uxSOUPm
         SMEDtD+mDrse+Bk9/6P3ybo2tpO/HmrLwNa1e19z7ePsKFQS8GcI+7KpmbaDM5OD1BNc
         JxSnMBpEryI1v2KUtCATtlgIdajP+eSL1BEMjxRf1yUXHzBCSGQS8zB+fuPuI7a1yemq
         cIOOuv+DZrEkX6A1Jsvw6a/GIvR3OfZ29wuoweiVeZ/zM5Toli7wyoVVYk/DOksBbXqd
         lWHhu+ELIyf0rd+hxQHnNGC6ipuvBKf+W9pmTHj5WLuuFTN7eVU4dqXf+sGQrDHFtr/O
         e3DA==
X-Forwarded-Encrypted: i=1; AJvYcCW7OlGfmsYLnFbcqaF9chki2cO4gSGl7UPyjvcc+AzM1WWHjdf9N4hIvvtv799yZPowmhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6b4DN3ODCyrpS33Ix7uGm2jqi9vQUlg2P+Vh9ZkBIUm6SfoG
	sYDg/oHDvEON1kvt5I2ikuJTXi6MInvUzW6kScQIzuqvnGTkDD/NgUTu
X-Gm-Gg: ASbGncunO7hEkGLfI8nPyy5aRfgYkoL30HD9wIdXNqSRQODnboDZ11thWknHsam6okz
	pU+1Z08tw6xArSI6aougfJZEXiwxWq76TiRjGzLKXCyYjGXykuT404gNmje3ISzViz8MpeBnirT
	8TCzZHxq09/++Mrport/rrAE/zOMb+4RJPgBvyTIVJ1Kr4XQPH8dRjSAYVUGDxy7c8UzHh3SazH
	S+7DQ3hHtYnIsBA9P6SVsf8o96YCnnS0pnnVvSGdbbsOuwUCZTeN+NpUT8lb0C4ssAlQN0fcZs0
	DJaysIyhhsFSnTZztGRfwn4SxbuJSSPfyB4uyjGkwAKmjtRKZtsLxB+p86BqvVJIBKwAMlEqcij
	cIGhrD3tMi2KM9dh4C5sbysrfpuU=
X-Google-Smtp-Source: AGHT+IEkdZ10B9VW3JH9CWnnQdaMBr64NYMDOXCFh0Em+IGbgJ62NaMqyV6VW/hcite8qa9RvgFdcg==
X-Received: by 2002:a17:903:2b05:b0:235:779:edf0 with SMTP id d9443c01a7336-23c6e5e23f1mr66432405ad.50.1751522179588;
        Wed, 02 Jul 2025 22:56:19 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e3205b3dsm14280980a12.78.2025.07.02.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 22:56:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
In-Reply-To: <aGYSjf5H_ZBaVVJm@pks.im> (Patrick Steinhardt's message of "Thu,
	3 Jul 2025 07:18:05 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com>
	<CAOLa=ZTwvOiCnYK18GTEUkcW0-YLHkJ=MBggdzOYsbTT+OHPwQ@mail.gmail.com>
	<aGYSjf5H_ZBaVVJm@pks.im>
Date: Wed, 02 Jul 2025 22:56:18 -0700
Message-ID: <xmqqsejdbywt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Even more importantly though, a numeric offset would be invalidated by a
> concurrent write in case that write ends up inserting a ref in the range
> of commits you intend to skip now.

That argument cuts both ways, no?  You have shown up to some ref
which you remember in the last cycle, and then while you are
planning to formulate another query with --skip-until naming that
ref, somebody removes that ref, then what happens?  Or somebody
inserts a new ref that sorts earlier than the ref you stopped at the
last time.

