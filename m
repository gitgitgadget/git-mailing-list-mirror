Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB415E5B1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712096785; cv=none; b=AkUbICU1UP7G8UjVppm4H7OOoa9sYMNW5QWra53Os8snnD03v5MCM7/VyW26Pupo8UI3Z4Zfg9U1xwXU3iHQyNCWrtfIMg5p/D/baPkct4Lq/wS5srm7TJv43ILzsO7buT6s6Q6PGH9lyLxbu4shFVBp3X3kAhwqccQWK31WwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712096785; c=relaxed/simple;
	bh=vRYL+HpRYXqhWZj9hmnkJKWO2LtfJOnnAcsuimdQWoQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dCt4BCi5kK6ZpacKe67lPM+Uwl/IwTVQlXgDgbaMaQEgan4m7Rx3u8GpDTiQKH0hWR/9UXRfR52b8/X+Wdk2YVj+38c1G8dVUpbSAD5Jl9JyyPlM8iJSzQuAzlFNMJrFvc3B4A0ENuUqYFpblury3RVGbyTVfGfkhsYs4XBU2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlJ2C5Et; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlJ2C5Et"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso5838486a12.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712096783; x=1712701583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6bvVTnIrbbRSK2r26ShBHpBseqh3tYHuyQusVVGHBw=;
        b=MlJ2C5EtYoNAEkQ5sEptrnyGsMQXi+EfDZH4LGN8eR+CfjGIdmXxqpfd1yQIJeCJbf
         QmDwrlKUqX71zblQCppdySUpNCj7VNn/85QU2n1JzjKweOxKXj1Ydhp8uFsPXgHr1CWg
         gp8zJw/WR86gbuljjndV1oHXXqSapHFiubIU57fKryVYMdHgjzlgsxFUfhVidT+VlDwN
         TqC5lg5zSAcIc3OaXUbt50JoTARwnghE/TrLTl7SO9QNqrnvZ1dPJNL/0pOP4bQ61+k4
         p855qPpDlEwK+V+01nnQ3ahoDJtxxQkuyq81D1x78sIRWUC0Tqridxm9VRgTIshdL8Ed
         NcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712096783; x=1712701583;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6bvVTnIrbbRSK2r26ShBHpBseqh3tYHuyQusVVGHBw=;
        b=oUG15+HIpENzgl5iYGL/MaWu6m9sF0JjJWWwxKIHyULI1pnDXD0ROuEQ5m02QWHLeL
         mgp+dEU9lwufUMnJb04IPQYWmmxB4b1oa57g+hb62IgEnaiC9PJ/nMIZP6ZeAljNb/3t
         C1e30zAQ8QYLAPnRRbmM4Y3ZrdyL9rnBB5dV6MdufQPkTvDs9CR+zAdgzyiXoTHJ7WFJ
         yE2mi7q1jpBrXr7suzGCyFCpALbZXA+6N4crtldvYNmg9GyfR/aY1stPzdEe+XfRWgt6
         hWWSgnSDQnvc3AnTUq/BJDQDyO5SlG/1DP5f+4FTpY/RNDJLA/G7DPzaGY9BkcyQ/ZR5
         3Wmw==
X-Forwarded-Encrypted: i=1; AJvYcCUiKJB1VcbpxVDPvpzU/FrrU9BI3eBrC+nQXDQbyJhNE9gzDUy8yrJU4DCK6RsrIdr8zTvZszHJHdgxZJmhZKYL51Sk
X-Gm-Message-State: AOJu0YyB8k/xyJzj2EIWco+l5iCTNGExnjK/OglGoqNIQIEy2KhpbRnu
	fWNG53y3Mn9SjL3koXAmqbsJS+vbmh6A1ePYHtiVV13vzFU1xsDHT1dobY90NNsIcgKfItlPSVZ
	kLKWPmU+VoaIALQ==
X-Google-Smtp-Source: AGHT+IGroz7vFF59DJ4eUm8AepTMq0edMv7skY2HKW3ztlgn6Q+K1JGNYtKlgowyMGv3u+03maRK6olcBBliJ7U=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a65:4081:0:b0:5dc:5111:d8b1 with SMTP id
 t1-20020a654081000000b005dc5111d8b1mr53161pgp.5.1712096783336; Tue, 02 Apr
 2024 15:26:23 -0700 (PDT)
Date: Tue,  2 Apr 2024 22:26:19 +0000
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240402222619.2212650-1-calvinwan@google.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
From: Calvin Wan <calvinwan@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Matthew John Cheetham <mjcheetham@outlook.com>, 
	M Hickford <mirth.hickford@gmail.com>, Jackson Toeniskoetter <jackdt@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

While I personally do not know the specifics of how Git authentication
works at Google, I am passing this series along to the team that does
own Git authentication (adding Jackson to this reply).

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> Right now, HTTP authentication in Git is mostly limited to approaches
> that require a username and password or are Kerberos (GSSAPI).  In
> addition, we effectively require that libcurl (or, for other software,
> such as Git LFS, using the credential helper, that HTTP library) knows
> how to implement the authentication scheme.
> 
> However, this poses two sets of problems.  First, some sites, such as
> Azure DevOps, want to use Bearer authentication, which we don't support.
> This is implemented using `http.extraHeader`, which is not a secure way
> to store credentials, since our credential helper protocol does not
> support this functionality.

My first thought was if using `http.extraHeader` is insecure as you
claim and we use that internally, then how do we ensure that it is
secure? Or are you claiming that using `http.extraHeader` out of the box
without an additional security layer is insecure?

Thanks,
Calvin
