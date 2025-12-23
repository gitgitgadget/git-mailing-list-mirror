Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C222B8CB
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498969; cv=none; b=CuGpHKWSePZzdHYdJYsrlqeHGYOy1aF8D7GOTkHdLk/ax3St0tfvaEupODrHlSMrb3uVYR1x+Rfv6T6uVRJ4Ccvb6kWe7geye9nSSyy1fgL9gdC87wp/R90HOEeNRn33LjGlxN9GtCatvguyajYCYF1G2wFhLdSpz1gym2kO8cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498969; c=relaxed/simple;
	bh=i79j9u/FV9AesjqfSclaTeMKkm4P9rKeR4sl5ksLmBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKGPZuEYYwqudzKXAK5ZJuAYVQLcScU2JNu74xNC3A9hyHrN/Pgcm9Nf1EeOKXkItCemQkG4e6jKVNUBRRGpc5cs5Q1adyYwfZhxSJSWo9BBd8f1A1qMcwbM7VYt+WeM1yYjoyBIAvjcTZGCo0q2iMzY06+gbUFF2WCF5oht7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irWTvQUw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irWTvQUw"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37fdb95971eso36185711fa.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766498966; x=1767103766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tlYEnl0ad0HEylM+T2HPsQjwNb5Z8+Uzevm7gnS568=;
        b=irWTvQUwPBTJ183yk17n13qEIEU6zEBNene6vLaZXYEzp0mtELjEJhQ5XFbFfTFvWM
         j1t4QsJByohNsztyRBZS4BrP4/Udtzc6vGZzc/hI8pKdEspoHnK2u86LrbHZBJB2YWA8
         9EmEt1eruwk22wiJ/r0O+87tM40Y7qkrABxo4PQirMGrTKQm/pw8C5jZWLzE7cHoy3m2
         5jRy0+AeJ9BOxUfeYGwNWlN4+xryHm3DVhxhIRa8DlPAJYeLCHH14m+EYxFvmf6Da6Uf
         dLjdME2tMcCtEi4emB4umSyxt2DXLRIbstZ076txxeaQtYjR3pVoULic1gE+7hnbnRIp
         QZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766498966; x=1767103766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tlYEnl0ad0HEylM+T2HPsQjwNb5Z8+Uzevm7gnS568=;
        b=Y7DoSwNg1SEuYnI7NnLDOmLv5VIj8KtkzR1H0l66yK4AodHLIbBiUiJDDgRb7W8HQT
         GTWm2B6sbtVytHcP1WWlFHy4K9ZcU7GAaR0iZ/elM4U5UDPS5zbW+nFkpyikDDXwFiPG
         fzTM9MLQKjX4FEuq8BGA7lhj7o7141h2bZCaMpa7LH5BrnVSMdy/jSmBBJJPBorSnXFe
         20m1nz4klsfeXnO4lyggxD90giW2zzb2lJzrluQvAPtJZHSh8jtzr7zxZKo1Z+PxQaHa
         Gk8Md0LaSDnBfbY5vynFnIvqX71RLcIpWUPtYZs8YAyIbTYTecHj4+Yy9I0+q3PN+uSZ
         Ramg==
X-Gm-Message-State: AOJu0Yx7gXjsyOucZxuprXBO3zxdSLB9gqtOI+cL8/GZUq16CiehjR7C
	ZZA7z5YIjty/sjqzT7Wk1TK7vBcmz5EP73sH9jcJ5+hTkpeW1JU/UdOg
X-Gm-Gg: AY/fxX68UruVrtVKlI6jCEDUTOtRfO6IeBxpwI1wBhyBOc1AwSPXrjVnAOFJTqjQb1Y
	vQndx7z9vjFTJZru2w2fDHp5lBowqp/yLHi7BHKCRlCjq1bTaFZ1DY1CiR00FW7Je2TzGZeQ4nV
	IoVLmHZGJ4IFQoq3rXW1jRQS6YLRmnjIiluSp+T6GLF1sueVs1weQn6wGvu4ks+5bpAHfciJHBr
	cCb7cqBcY6yDj0RrDy8Hs4F67F0B0JsJeyH3+jd4DUOfigzvqlT81Rg7UArX8zLoC3OKSh/fXDX
	PylcbSXPecJ52LJEYs9IsH2Ps4S4bRyVXQBLeSE8KTOGqoBC4QcD0USL9fyQO0wW46p8FIdZy7Y
	5VKn9eZyAwUtq/G2N2bczx3/+dPpkIm2unV3VP02AExNB69XuLTY+ylvhoI88CcZk9Oh602WkZM
	Z8yqEi+gHsiBR7E6VLzgOlrMw6nDVHd8zXA2ZsX35vsp2XKLGlVOg/74E9j0Cw/iIxE1+jQnc6n
	NkLET2L/g==
X-Google-Smtp-Source: AGHT+IE8VVB2w3x0lkCE5wMu5U+0ah4dnLy+0EMHMOgHeZM3uwVMIqZmFQvHEIVpnjIOs9dosxEjtg==
X-Received: by 2002:a05:651c:41c6:b0:37e:884f:b6b4 with SMTP id 38308e7fff4ca-381216725e5mr47402701fa.26.1766498965747;
        Tue, 23 Dec 2025 06:09:25 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38122693ad3sm32732971fa.49.2025.12.23.06.09.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 06:09:25 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Tue, 23 Dec 2025 15:09:24 +0100
Message-Id: <20251223140924.69410-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqtsxhpblq.fsf@gitster.g>
References: <xmqqtsxhpblq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If a project uses the same remote repository to maintain its
> maintenance and development tracks, their HEAD might point at the
> 'main' (used for development), but some of your branches you used to
> work on fixes that can later be merged to the maintenance track, it
> is likely that you'll fork from their 'maint', and while you keep
> polishing your fixes, you may push your 'fix' branch to their 'fix'
> branch.  Comparing your 'fix' with their 'fix' is what we already
> do, and it gives two thirds of what you need, but the missing
> comparison is with their 'maint', not with their HEAD that points at
> their 'main'.

That's a fair point. I am used to trunk-based development, but I recognize
that there are other paradigms out there.

One possibly solution could be to make this adjustable in repo-wide config
(maybe 'repo.settings.defaultBranch=maint') and when unset it compares to
'refs/remotes/upstream/HEAD'?
