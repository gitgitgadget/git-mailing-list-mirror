Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFA3988E0
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880710; cv=none; b=KsU087LAv2+opgaIs31n0stQlG+QL4dfyrdD604xyf+AkhZYFAC0MW5Gwbj8xozajKYIA+2aPYjxGdqMQxmtxeMnm6d/X1r7ovRlOeuUNfKHO+59dFQqHI6g4CRRkql/IlKqWJIlF7aQa5LwcLa52jx+T15NdAIs5sd3m3KU7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880710; c=relaxed/simple;
	bh=HItO5BTwSNA6nkEaPoYL9mditrZpm6RytLraZ0RsUoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsFQyuZDNEt0o42DLSsWUim9L/lI1U9TDrBNxWdgX8u0KrrheOw8D34aQk68BLHeObotr9SEt3GZsd4DnIfakRg4JvBFLlvca3QxbI7+mjuxNEWiagh/tlF0VYGCq6kMmpg0opXf7nv46hTeNGUNdRyy06HggYJTAIbaijy5SR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az5X88V3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az5X88V3"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e4a04f059so6615713e87.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880707; x=1777485507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HItO5BTwSNA6nkEaPoYL9mditrZpm6RytLraZ0RsUoU=;
        b=az5X88V3lBKiHR+4QT2n07OlwMZMc5jibvBhRNpfiTi6jCVy5g+OsAupliw6sLjkP9
         bJdb3lX6/bUqnJ42Qlts7eLAHdrc+MHc9iueNIGnGA2uyKP8L0tLs2D0fA+T26HREa28
         kVrcf6eZ9XHWd7ObSOZqU4V/mybjpN4eeHxzBY4WzdWmOrDxO+bOeAtqcWG4S232UQbc
         4YVvsQqfqT0DcTnoGwqoEI1zazKmlTZiPtJ6VmU9p5XDIqnpupx+xKdHd4uESwJ+Um5S
         jmdIpRnc56aCXddebgyNA9g8QXWhl20wqI5n0V0AIfgfG0rytIzUP/RZgsiY7DkNs+SO
         u1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880707; x=1777485507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HItO5BTwSNA6nkEaPoYL9mditrZpm6RytLraZ0RsUoU=;
        b=jhl0Am/j1XOQ600gKacvcPPkjsxs2N94icjrFONEDXOkAcyfxn029E96vuQre8xmfy
         yYHFP4dDc/Y1Xz3FcqYpLiueAtboxpBpwJKuvdVN6Rxdh3VFf4KJjqI1OZhXBW9E24Nw
         dCtTi6E0KTJezk2rwF29g8BakzDEu2Xoy3N9iMlN35CqBch1hglz+8cEqo6c3p+DJX3k
         2dCL8kBPAkHacZpOfTAGS3RQtvjKIGm2VtaMVQU3/RPdv7GlBoNQSppwjeranguzTSA6
         lzZQOE6vO6pprf8yCjHuReLmR/1z1Qm70fW6Jj4wLkHJ1XS2ghuuU0ZzGkeH+KAnKhFG
         LvuA==
X-Forwarded-Encrypted: i=1; AFNElJ/SiAjLIWZccCPHHqC1zU+Xyp8gCbpAl/0pwBJIiFQlTUl4y0dvFS9JC9XQ3iI1KuUaMDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhD9pBjBLVoUxRBzrgEXE5poVYoaxN8VSD9wVJXSpCyvlChPpk
	IwgzbgMB0BiP897YQq7OQ/jKJg16ml34tc97JYFKRAlXx0VEnwUeZRDkYCt/T5vL
X-Gm-Gg: AeBDieurdUFEN0k3PaF8cun7KDUe8ATVZehG1FPoUNb1wWiRgMwU+DJiHMohy5rUiIV
	fXdJYMZhJXYmnNkvULNS8Dm+kyTHZzzV7rRzFg4DI9BoiYsg9AMhU60cPHMWemP5INn8Ie1PSAA
	84hC7nHUiZZHbY8zodzr6iYcneZv29Y7qOd757hC6JSYkZ7C8JzCJkJ9hrhGMTJCYy27F3XVqty
	S+mV7UfrTXs/dXGhIyOeYRVogN/1bXT463IPVwBDfHNIdCWstKTAa1g72qoEW6s0sHZdYzwKRgC
	Jmaok/YEbT7kMKKiVUq/FSKo0D78oS1N+5uaZsE5FC5ZZ4uABE/EV43QG3yNXy9F6XEFotGCM+9
	hSOOQwVYaf5hXkprYI6GsyX8TVjYEUm072FxKxgvroR4zSE5t9OKfkz8EypO8hxMRngmHPxuIUj
	n6lZtnJpI01NhZXEtv07mjlszAFZzL7wi94VHS+EyaAsXoUhQyajYyI002OMQYJaOrBe/KOZasc
	HQLnJtkhaUfvROwI0cWj+yQFmY=
X-Received: by 2002:a05:6512:b99:b0:5a3:cc81:efdb with SMTP id 2adb3069b0e04-5a4172de867mr7255437e87.21.1776880707245;
        Wed, 22 Apr 2026 10:58:27 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc25csm4625276e87.26.2026.04.22.10.58.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Apr 2026 10:58:26 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Wed, 22 Apr 2026 19:58:25 +0200
Message-ID: <20260422175825.40701-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <09d1390e-8334-49e6-a0b5-42d298db4caa@gmail.com>
References: <09d1390e-8334-49e6-a0b5-42d298db4caa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

👍


Harald
