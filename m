Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4F199BC
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739738472; cv=none; b=GqA28n5ggzAL8Fo9MmOXAIcLdsBNn2VYnIMaEM4/yLSxps8fZCQBe2PNPOXpnlKpOZytDjyaXY2f9U25QWtY+TNGXE5svTfVxak8yg43ftEQjqeSYPGDoEq1nXoRQ5xM90b2q5tzF7GHpMSWGmrotFPYC2TP3TMwPRqKgig0jgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739738472; c=relaxed/simple;
	bh=5BUd6GflfVAy4TzyKX9pecF+XzE23HipU3zvgZpCyoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZFb2xViavph4RcDvJXoV05IUsLZklyIlwHd7Gc+QQiV2UT/yuJQOc7Rq414Jhb6B6UYdg21gXv4vj/m1tTgOnJukc1vbXN7GIIcX2o335znb/jz04La1Bkg1UAXvzZy0+5LSY+r4cB0mhiWeM9nek3Gz4dNJSVtzumLCyPMAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VihahEPk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VihahEPk"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc050e6a9dso750974a12.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 12:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739738469; x=1740343269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5BUd6GflfVAy4TzyKX9pecF+XzE23HipU3zvgZpCyoM=;
        b=VihahEPkKgj1Dc9kOcWqP8dbaL3BPJSTlVmypb5dAqkwSY3RBgx2TqwBbvetS9MHM9
         lWGdKiJ5NLoUJwInjroZKYqNxdO4hoIHj7VHx/IB7UE/mn0MloTBlXXWd+ItTxzpnntd
         /Zpc+NsSnPWpymIgORNR5AblIyC+Sa7uFyxZXG8tywT+K0oj6qeAtpaZ47q3G00jvvpl
         EL86fvEc1RzLNgQcXaSGlqh7VyDjCNkQZ0XjFQu6uuCkG3Flu5tqJd54AVKxt8Um5lHP
         dHqhOpTWdTim+HHCuVF13Yv1cFX4mjRVvpeyYsfWkDWMzahBJht9r0CgI1B5wVAvTyGW
         drZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739738469; x=1740343269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BUd6GflfVAy4TzyKX9pecF+XzE23HipU3zvgZpCyoM=;
        b=bCORRG+H8waoKCxSsLUPFY9GxWj8EmLYtpT4ElW9pM+yR31Et8LsM5v41Sl5E1i93m
         aQ6/tD+prxfWvOq36mjjXDZQiviw1CjpM7pyhKSECdjzX0DzPP7WAccDR+JXcYcWQnTC
         wTpk7JzAWYzquA6O/VZgN+zmkT46OMHddb0jkPmIlH1A4BWtbO2M7aPcuiYdypOIUUui
         FYodqzJh+l4ZxFQwWVJmrcMnmsQXnVCP3qlnzfTCVvvR/iivjfZSnYHWXJ0+jKFnKRrL
         dOzrm5N+c70kwKshYb+M0nn2y/fkpKVVJXtiYL3qm37cN1SukboZhfyzZ3dHXX4Bvb3H
         etJw==
X-Forwarded-Encrypted: i=1; AJvYcCUx3WoLppv82C8WilJJ1L0N2xKmJYGfdFsk2/pXj8FVPHd9jVx+rX3T5HlymDGoFRlntCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpcNDINAXlRlVxOGOmw7u0D1azrKWiB01EWZI2EScCnTYHO+7
	xuCSVg6RNoFqIIlBhJYQfZrtDdNmPxob7wJTx468KiJtFJRybqBTkg7R2RgNJEVBqWGXXx3uSq7
	1ZOVbknK0nV3EYT1cHH/kcpP/JB677BOR
X-Gm-Gg: ASbGncucx/1pFGH9gWD8ebf2tT1f75mEbYUbHcqKuP0cefbLD1QGaOoeO2c4lfytFpF
	x0qcbvrZgKe9NdzAWU5M9wixRzPlqSQwDzDa0RMBFfZa41uRePqCmOwtP9qXemi+wiPZI4ecNtl
	L9NmTWvRXxPPRl2Agh32S7tOmObZpUv8U=
X-Google-Smtp-Source: AGHT+IGG28zGmGFfx8lGlhDmSuZUQud4ca2JWMYFSIGR+ZAh7zW6gUBQpAph4KO72h5mI2jF+4xlupMOpp1NUjXKbWM=
X-Received: by 2002:a17:907:1c8b:b0:ab7:63fa:e4a2 with SMTP id
 a640c23a62f3a-abb709319bemr232226866b.1.1739738469229; Sun, 16 Feb 2025
 12:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com> <xmqq5xldoaj6.fsf@gitster.g>
In-Reply-To: <xmqq5xldoaj6.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sun, 16 Feb 2025 20:40:27 +0000
X-Gm-Features: AWEUYZk0z8OrqB7YOTH33ehuXe-jTb9oWyHJT8JoIxZhoqmH2d98Ej3XwbEuuBM
Message-ID: <CAGJzqs=iu9mMpGzb7pO54dFSQGnTs+LWV_voRFp+XcZWDJFg8g@mail.gmail.com>
Subject: Re: [PATCH] doc: use 'title' consistently
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> We may want to update "git rebase" documentation to match what
> happens in this patch at the same time, especially because it is its
> interactive mode that "git rebase --help" uses "subject" to refer to
> each commit's title.

Good idea. I'll prepare patch v2.
